using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using ExpenseApp.DAL;

namespace ExpenseApp.BLL
{
    public class Expense
    {
        public static int Create(int empId, int compId, decimal amt, string curr, decimal convAmt,
            string cat, string desc, DateTime date)
        {
            DataTable dt = DB.GetData("sp_CreateExpense", new[] {
                new SqlParameter("@EmployeeId", empId),
                new SqlParameter("@CompanyId", compId),
                new SqlParameter("@Amount", amt),
                new SqlParameter("@Currency", curr),
                new SqlParameter("@ConvertedAmount", convAmt),
                new SqlParameter("@Category", cat),
                new SqlParameter("@Description", desc),
                new SqlParameter("@Date", date)
            });
            return dt.Rows.Count > 0 ? System.Convert.ToInt32(dt.Rows[0][0]) : 0;
        }

        public static DataTable GetList(int userId, int role, int compId)
        {
            return DB.GetData("sp_GetUserExpenses", new[] {
                new SqlParameter("@UserId", userId),
                new SqlParameter("@Role", role),
                new SqlParameter("@CompanyId", compId)
            });
        }

        public static DataTable GetPending(int approverId)
        {
            return DB.GetData("sp_GetPendingApprovals", new[] {
                new SqlParameter("@ApproverId", approverId)
            });
        }

        public static void Approve(int expId, int appId, int status, string comment)
        {
            DB.Execute("sp_ProcessApproval", new[] {
                new SqlParameter("@ExpenseId", expId),
                new SqlParameter("@ApproverId", appId),
                new SqlParameter("@Status", status),
                new SqlParameter("@Comments", comment ?? "")
            });
        }

        public static DataRow GetStats(int userId, int role, int compId)
        {
            DataTable dt = DB.GetData("sp_GetDashboardStats", new[] {
                new SqlParameter("@UserId", userId),
                new SqlParameter("@Role", role),
                new SqlParameter("@CompanyId", compId)
            });
            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        public static decimal ConvertCurrency(decimal amt, string from, string to)
        {
            var rates = new Dictionary<string, decimal> {
                {"USD", 1.0m}, {"INR", 82m}, {"GBP", 0.79m}, {"EUR", 0.92m}, {"CAD", 1.35m}, {"AUD", 1.52m}
            };
            if (from == to) return amt;
            if (!rates.ContainsKey(from) || !rates.ContainsKey(to)) return amt;
            return (amt / rates[from]) * rates[to];
        }
    }
}