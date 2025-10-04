using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ExpenseApp.DAL
{
    public class DB
    {
        private static string conn = ConfigurationManager.ConnectionStrings["ExpenseDB"].ConnectionString;

        public static DataTable GetData(string sp, SqlParameter[] p = null)
        {
            using (SqlConnection con = new SqlConnection(conn))
            {
                using (SqlCommand cmd = new SqlCommand(sp, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (p != null) cmd.Parameters.AddRange(p);
                    DataTable dt = new DataTable();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    return dt;
                }
            }
        }

        public static void Execute(string sp, SqlParameter[] p = null)
        {
            using (SqlConnection con = new SqlConnection(conn))
            {
                using (SqlCommand cmd = new SqlCommand(sp, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (p != null) cmd.Parameters.AddRange(p);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}