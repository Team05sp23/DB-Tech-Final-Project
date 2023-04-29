using ADT_WebApplication.Pages.Client;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;
using System.Data;

namespace ADT_WebApplication.Pages.Visualizations
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;

        public string ErrorMessage { get; set; }
        public List<ClientInfo> listClient = new List<ClientInfo>();

        public IndexModel(ILogger<IndexModel> logger)
        {
            _logger = logger;
        }
        public void OnGet()
        {
            if (TempData["ErrorMessage"] != null)
            {
                ErrorMessage = TempData["ErrorMessage"].ToString();
            }
            try
            {
                String connectionstring = "Data Source=.\\sqlexpress;Initial Catalog=Final_ADT;Integrated Security=True";
                using (SqlConnection connection = new SqlConnection(connectionstring))
                {
                    connection.Open();
                    String sql = "SELECT T.TrackId AS Id, " +
             "T.TrackName, A.ArtistName, T.TrackDuration AS Length, T.TrackPopularity, " +
             "AL.AlbumName, AL.ReleaseDate, AL.TotalTracks, T.TrackNumber " +
             "FROM Track AS T " +
             "JOIN Album AS AL ON T.AlbumId = AL.AlbumId " +
             "JOIN Artist AS A ON AL.ArtistId = A.ArtistId " +
             "JOIN Artist_Track AS AT ON A.ArtistId = AT.ArtistId AND T.TrackId = AT.TrackId " +
             "ORDER BY Id;";

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.CommandType = CommandType.Text;
                        command.Parameters.Clear();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                ClientInfo clientInfo = new ClientInfo();
                                clientInfo.Id = reader.GetInt32(0);
                                clientInfo.TrackName = reader.GetString(1);
                                clientInfo.ArtistName = reader.GetString(2);
                                clientInfo.Length = TimeSpan.Parse(reader.GetString(3));
                                clientInfo.Popularity = reader.GetInt32(4);
                                clientInfo.AlbumName = reader.GetString(5);
                                clientInfo.ReleaseDate = reader.GetDateTime(6);
                                clientInfo.TotalTracks = reader.GetInt32(7);
                                clientInfo.TrackNumber = reader.GetInt32(8);
                                listClient.Add(clientInfo);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorMessage = "Exception: " + ex.ToString(); // Store the exception message
                Console.WriteLine(ErrorMessage);
                _logger.LogError("Exception: {Exception}", ex.ToString());
            }
        }
    }
}

