using System;
using ADT_WebApplication.Pages.Client;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;
using System.Globalization;
using System.Collections.Generic;
using Microsoft.AspNetCore.Identity;

namespace ADT_WebApplication.Pages.Client
{
    public class EditModel : PageModel
    {
        public ClientInfo clientInfo =new ClientInfo();
        public string errorMessage = "";
        public string successMessage = "";

        //public ClientInfo clientInfo = new ClientInfo();

        public void OnGet()
        {
            String id = Request.Query["Id"];
            clientInfo.Id = Convert.ToInt32(id);
            try
            {
                string connectionString = "Data Source=.\\sqlexpress;Initial Catalog=Final_ADT;Integrated Security=True";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string sql = "SELECT t.TrackId, a.AlbumId, ar.ArtistId " +
                                      "FROM Track t " +
                                      "JOIN Album a ON t.AlbumId = a.AlbumId " +
                                      "JOIN Artist_Track at ON t.TrackId = at.TrackId " +
                                      "JOIN Artist ar ON at.ArtistId = ar.ArtistId " +
                                      "WHERE t.TrackId = @TrackId";
                    int trackId, albumId, artistId;
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@TrackId", clientInfo.Id);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                trackId = reader.GetInt32(0);
                                albumId = reader.GetInt32(1);
                                artistId = reader.GetInt32(2);
                            }
                            else
                            {
                                throw new Exception("Record not found");
                            }
                        }
                    }
                    string dataSql = "SELECT T.TrackName,A.ArtistName,T.TrackDuration AS Length,T.TrackPopularity AS Popularity, AL.AlbumName, AL.ReleaseDate, AL.TotalTracks, T.TrackNumber\r\nFROM \r\n    Track T\r\n    INNER JOIN Album AL ON T.AlbumId = AL.AlbumId\r\n    INNER JOIN Artist A ON AL.ArtistId = A.ArtistId\r\nWHERE\r\n    T.TrackId = @TrackId AND\r\n    AL.AlbumId = @AlbumId AND\r\n    A.ArtistId = @ArtistId";

                    using (SqlCommand dataCommand = new SqlCommand(dataSql, connection))
                    {
                        dataCommand.Parameters.AddWithValue("@TrackId", trackId);
                        dataCommand.Parameters.AddWithValue("@AlbumId", albumId);
                        dataCommand.Parameters.AddWithValue("@ArtistId", artistId);
                        using (SqlDataReader reader = dataCommand.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                clientInfo.TrackName = reader.GetString(0);
                                clientInfo.ArtistName = reader.GetString(1);
                                clientInfo.Length = TimeSpan.Parse(reader.GetString(2));
                                clientInfo.Popularity = reader.GetInt32(3);
                                clientInfo.AlbumName = reader.GetString(4);
                                clientInfo.ReleaseDate = reader.GetDateTime(5);
                                clientInfo.TotalTracks = reader.GetInt32(6);
                                clientInfo.TrackNumber = reader.GetInt32(7);
                            }
                            else
                            {
                                throw new Exception("Record not found");
                            }
                        }
                    }
                }
            }

            catch (Exception ex)
            {
                errorMessage = $"Message: {ex.Message}\n";

                if (ex.InnerException != null)
                {
                    errorMessage += $"InnerException: {ex.InnerException.Message}\n";
                }

                errorMessage += $"StackTrace: {ex.StackTrace}";
            }
        }
        public IActionResult OnPost()
        {
            clientInfo.Id = int.Parse(Request.Form["id"]);
            clientInfo.TrackName = Request.Form["TrackName"];
            clientInfo.Length = TimeSpan.Parse(Request.Form["Length"]);
            clientInfo.Popularity = int.Parse(Request.Form["Popularity"]);
            clientInfo.TrackNumber = int.Parse(Request.Form["TrackNumber"]);
            clientInfo.AlbumName = Request.Form["AlbumName"];
            clientInfo.ReleaseDate = DateTime.Parse(Request.Form["ReleaseDate"]);
            clientInfo.TotalTracks = int.Parse(Request.Form["TotalTracks"]);
            clientInfo.ArtistName = Request.Form["ArtistName"];

            System.Diagnostics.Debug.WriteLine("OnPost called");

            try
            {
                string connectionString = "Data Source=.\\sqlexpress;Initial Catalog=Final_ADT;Integrated Security=True";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Updating Track Table
                    string tracksql = "UPDATE Track SET TrackName = @TrackName, TrackDuration = @TrackDuration, TrackPopularity = @TrackPopularity, TrackNumber = @TrackNumber WHERE TrackId = @TrackId";
                    using (SqlCommand updateTrackCommand = new SqlCommand(tracksql, connection))
                    {
                        System.Diagnostics.Debug.WriteLine(clientInfo);
                        if (string.IsNullOrEmpty(clientInfo.TrackName))
                        {
                            errorMessage = "TrackName cannot be null or empty.";
                            return Page();
                        }
                        System.Diagnostics.Debug.WriteLine("Updating Track: " + clientInfo.TrackName);
                        updateTrackCommand.Parameters.AddWithValue("@TrackName", clientInfo.TrackName);
                        updateTrackCommand.Parameters.AddWithValue("@TrackDuration", clientInfo.Length);
                        updateTrackCommand.Parameters.AddWithValue("@TrackPopularity", clientInfo.Popularity);
                        updateTrackCommand.Parameters.AddWithValue("@TrackNumber", clientInfo.TrackNumber);
                        updateTrackCommand.Parameters.AddWithValue("@TrackId", clientInfo.Id);
                        int affectedRows = updateTrackCommand.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine("Affected rows for Track update: " + affectedRows);

                        //updateTrackCommand.ExecuteNonQuery();
                    }

                    // Updating Album Table
                    string albumsql = "UPDATE Album SET AlbumName = @AlbumName, ReleaseDate = @ReleaseDate, TotalTracks = @TotalTracks WHERE AlbumId = (SELECT AlbumId FROM Track WHERE TrackId = @TrackId)";
                    using (SqlCommand albumUpdateCommand = new SqlCommand(albumsql, connection))
                    {
                        System.Diagnostics.Debug.WriteLine("Updating Album: " + clientInfo.AlbumName);
                        albumUpdateCommand.Parameters.AddWithValue("@AlbumName", clientInfo.AlbumName);
                        albumUpdateCommand.Parameters.AddWithValue("@ReleaseDate", clientInfo.ReleaseDate);
                        albumUpdateCommand.Parameters.AddWithValue("@TotalTracks", clientInfo.TotalTracks);
                        albumUpdateCommand.Parameters.AddWithValue("@TrackId", clientInfo.Id);
                        int affectedRows = albumUpdateCommand.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine("Affected rows for Track update: " + affectedRows);

                        //albumUpdateCommand.ExecuteNonQuery();
                    }

                    // Updating Artist Table
                    string artistsql = "UPDATE Artist SET ArtistName = @ArtistName WHERE ArtistId = (SELECT ArtistId FROM Artist_Track WHERE TrackId = @TrackId)";
                    using (SqlCommand artistUpdateCommand = new SqlCommand(artistsql, connection))
                    {
                        System.Diagnostics.Debug.WriteLine("Updating Artist: " + clientInfo.ArtistName);
                        artistUpdateCommand.Parameters.AddWithValue("@ArtistName", clientInfo.ArtistName);
                        artistUpdateCommand.Parameters.AddWithValue("@TrackId", clientInfo.Id);
                        //artistUpdateCommand.ExecuteNonQuery();
                        int affectedRows = artistUpdateCommand.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine("Affected rows for Track update: " + affectedRows);

                    }
                    successMessage = "New track added successfully!";
                }
            }
            catch (Exception ex)
            {
                errorMessage = $"Message: {ex.Message}\n";

                if (ex.InnerException != null)
                {
                    errorMessage += $"InnerException: {ex.InnerException.Message}\n";
                }

                errorMessage += $"StackTrace: {ex.StackTrace}";

                return Page();
            }
            System.Diagnostics.Debug.WriteLine("Error: " + errorMessage);

            successMessage = "Record successfully updated!";
            return RedirectToPage("/Client/Index");
        }
    }
}

