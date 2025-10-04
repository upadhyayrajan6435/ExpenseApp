using System;
using System.Data;
using System.Data.SqlClient;
using ExpenseApp.DAL;

namespace ExpenseApp.BLL
{
    public class Auth
    {
        public static DataRow Login(string email, string password)
        {
            DataTable dt = DB.GetData("sp_LoginUser", new[] { new SqlParameter("@Email", email) });
            if (dt.Rows.Count > 0)
            {
                string hash = dt.Rows[0]["PasswordHash"].ToString();
                if (BCrypt.Net.BCrypt.Verify(password, hash))
                    return dt.Rows[0];
            }
            return null;
        }

        public static DataRow Register(string email, string pwd, string name, string country, string currency)
        {
            string hash = BCrypt.Net.BCrypt.HashPassword(pwd);
            DataTable dt = DB.GetData("sp_RegisterUser", new[] {
                new SqlParameter("@Email", email),
                new SqlParameter("@PasswordHash", hash),
                new SqlParameter("@Name", name),
                new SqlParameter("@Country", country),
                new SqlParameter("@Currency", currency)
            });
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }
    }
}