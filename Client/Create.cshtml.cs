    using System;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.RazorPages;
    using Microsoft.Extensions.Logging;
    using System.Data.SqlClient;
    using System.Data;

    namespace ADT_WebApplication.Pages.Client
    {
        public class CreateModel : PageModel
        {
            private readonly ILogger<CreateModel> _logger;
            [BindProperty]
            public ClientInfo clientInfo { get; set; } = new ClientInfo();
            public string errorMessage = "";
            public string successMessage = "";

            public CreateModel(ILogger<CreateModel> logger)
            {
                _logger = logger;
            }

            public void OnGet()
            {
            }

            public IActionResult OnPost()
            {
                try
                {
                    clientInfo.ReleaseDate = clientInfo.ReleaseDate.Date;

                    String connectionstring = "Data Source=.\\sqlexpress;Initial Catalog=Final_ADT;Integrated Security=True";
                    using (SqlConnection connection = new SqlConnection(connectionstring))
                    {
                        connection.Open();

                        // Insert new artist
                        string artistSql = "INSERT INTO Artist (ArtistName) VALUES (@ArtistName); SELECT SCOPE_IDENTITY();";
                        int artistId;
                        using (SqlCommand artistCommand = new SqlCommand(artistSql, connection))
                        {
                            artistCommand.Parameters.AddWithValue("@ArtistName", clientInfo.ArtistName);
                            artistId = Convert.ToInt32(artistCommand.ExecuteScalar());
                        }

                        // Insert new album
                        string albumSql = "INSERT INTO Album (AlbumName, ReleaseDate, TotalTracks, AlbumDuration, ArtistId) VALUES (@AlbumName, @ReleaseDate, @TotalTracks, @Length, @ArtistId); SELECT SCOPE_IDENTITY();";
                        int albumId;
                        using (SqlCommand albumCommand = new SqlCommand(albumSql, connection))
                        {
                            albumCommand.Parameters.AddWithValue("@AlbumName", clientInfo.AlbumName);
                            albumCommand.Parameters.AddWithValue("@ReleaseDate", clientInfo.ReleaseDate);
                            albumCommand.Parameters.AddWithValue("@TotalTracks", clientInfo.TotalTracks);
                            TimeSpan lengthTimeSpan = TimeSpan.FromSeconds(clientInfo.LengthInSeconds);
                            string formattedLength = $"{lengthTimeSpan.TotalHours:00}:{lengthTimeSpan.Minutes:00}:{lengthTimeSpan.Seconds:00}";
                            albumCommand.Parameters.AddWithValue("@Length", formattedLength);
                            albumCommand.Parameters.AddWithValue("@ArtistId", artistId);
                            albumId = Convert.ToInt32(albumCommand.ExecuteScalar());
                        }

                        // Insert new track
                        string trackSql = "INSERT INTO Track (TrackName, TrackDuration, TrackPopularity, TrackNumber, AlbumId) VALUES (@TrackName, @Length, @Popularity, @TrackNumber, @AlbumId); SELECT SCOPE_IDENTITY();";
                        int trackId;
                        using (SqlCommand trackCommand = new SqlCommand(trackSql, connection))
                        {
                            trackCommand.Parameters.AddWithValue("@TrackName", clientInfo.TrackName);
                            TimeSpan trackLengthTimeSpan = TimeSpan.FromSeconds(clientInfo.LengthInSeconds);
                            string formattedTrackLength = $"{trackLengthTimeSpan.TotalHours:00}:{trackLengthTimeSpan.Minutes:00}:{trackLengthTimeSpan.Seconds:00}";

                            trackCommand.Parameters.AddWithValue("@Length", formattedTrackLength);
                            trackCommand.Parameters.AddWithValue("@TrackNumber", clientInfo.TrackNumber);
                            trackCommand.Parameters.AddWithValue("@Popularity", clientInfo.Popularity);
                            trackCommand.Parameters.AddWithValue("@AlbumId", albumId);
                            trackId = Convert.ToInt32(trackCommand.ExecuteScalar());
                        }

                        // Insert into Artist_Track
                        string artistTrackSql = "INSERT INTO Artist_Track (ArtistId, TrackId) VALUES (@ArtistId, @TrackId);";
                        using (SqlCommand artistTrackCommand = new SqlCommand(artistTrackSql, connection))
                        {
                            artistTrackCommand.Parameters.AddWithValue("@ArtistId", artistId);
                            artistTrackCommand.Parameters.AddWithValue("@TrackId", trackId);
                            artistTrackCommand.ExecuteNonQuery();
                        }

                        successMessage = "New track added successfully!";
                    }
                }
                catch (Exception ex)
                {
                    errorMessage = "Error: " + ex.Message;
                    _logger.LogError("Error: {Error}", ex.Message);
                }

                //return Page();
                return RedirectToPage("/Client/Index");
        }
        }
    }
