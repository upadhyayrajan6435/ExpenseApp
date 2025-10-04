using System;
using System.Data;
using System.Data.SqlClient;
using ExpenseApp.DAL;

namespace ExpenseApp.BLL
{
    public class User
    {
        public static DataTable GetAll(int compId)
        {
            return DB.GetData("sp_GetCompanyUsers", new[] {
                new SqlParameter("@CompanyId", compId)
            });
        }

        public static void Create(string email, string pwd, string name, int role, int compId, int? mgrId)
        {
            string hash = BCrypt.Net.BCrypt.HashPassword(pwd);
            DB.Execute("sp_CreateUser", new[] {
                new SqlParameter("@Email", email),
                new SqlParameter("@PasswordHash", hash),
                new SqlParameter("@Name", name),
                new SqlParameter("@Role", role),
                new SqlParameter("@CompanyId", compId),
                new SqlParameter("@ManagerId", (object)mgrId ?? DBNull.Value)
            });
        }

        public static void UpdateRole(int userId, int role)
        {
            DB.Execute("sp_UpdateUserRole", new[] {
                new SqlParameter("@UserId", userId),
                new SqlParameter("@Role", role)
            });
        }

        public static void Delete(int userId)
        {
            DB.Execute("sp_DeleteUser", new[] {
                new SqlParameter("@UserId", userId)
            });
        }

        public static void UpdateManager(int userId, int? managerId)
        {
            DB.Execute("sp_UpdateUserManager", new[] {
                new SqlParameter("@UserId", userId),
                new SqlParameter("@ManagerId", (object)managerId ?? DBNull.Value)
            });
        }
    }
}