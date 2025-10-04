using System;
using System.Data;
using System.Web;

namespace ExpenseApp.Utilities
{
    public class S
    {
        public static void Set(DataRow u)
        {
            HttpContext.Current.Session["UserId"] = u["UserId"];
            HttpContext.Current.Session["Name"] = u["Name"];
            HttpContext.Current.Session["Role"] = u["Role"];
            HttpContext.Current.Session["CompanyId"] = u["CompanyId"];
            HttpContext.Current.Session["CompanyName"] = u["CompanyName"];
            HttpContext.Current.Session["Currency"] = u["CompanyCurrency"];
        }

        public static int UserId => Convert.ToInt32(HttpContext.Current.Session["UserId"] ?? 0);
        public static string Name => HttpContext.Current.Session["Name"]?.ToString() ?? "";
        public static int Role => Convert.ToInt32(HttpContext.Current.Session["Role"] ?? 2);
        public static int CompanyId => Convert.ToInt32(HttpContext.Current.Session["CompanyId"] ?? 0);
        public static string Currency => HttpContext.Current.Session["Currency"]?.ToString() ?? "USD";
        public static string CompanyName => HttpContext.Current.Session["CompanyName"]?.ToString() ?? "";
        public static bool LoggedIn => HttpContext.Current.Session["UserId"] != null;

        public static string RoleName
        {
            get
            {
                switch (Role)
                {
                    case 0: return "Admin";
                    case 1: return "Manager";
                    case 2: return "Employee";
                    default: return "";
                }
            }
        }

        public static void Clear()
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
        }
    }
}