using System;
using System.Data;
using System.Web.UI;
using ExpenseApp.BLL;
using ExpenseApp.Utilities;

namespace ExpenseApp
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!S.LoggedIn)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            lblUser.Text = S.Name;
            lblRole.Text = S.RoleName;
            lblCompany.Text = S.CompanyName;
            lblCurrency.Text = S.Currency;
            lblCurr.Text = S.Currency;

            // Show/hide based on role
            if (S.Role == 0 || S.Role == 1)
                phManager.Visible = true;
            if (S.Role == 0)
                phAdmin.Visible = true;

            // Load stats
            DataRow stats = Expense.GetStats(S.UserId, S.Role, S.CompanyId);
            if (stats != null)
            {
                lblTotal.Text = stats["Total"].ToString();
                lblPending.Text = stats["Pending"].ToString();
                lblApproved.Text = stats["Approved"].ToString();
                lblAmount.Text = Convert.ToDecimal(stats["Amount"]).ToString("N2");
            }

            // Load expenses
            DataTable dt = Expense.GetList(S.UserId, S.Role, S.CompanyId);
            gvExpenses.DataSource = dt;
            gvExpenses.DataBind();
        }

        protected string GetStatusClass(object status)
        {
            int s = Convert.ToInt32(status);
            return s == 0 ? "pending" : s == 1 ? "approved" : "rejected";
        }

        protected string GetStatusText(object status)
        {
            int s = Convert.ToInt32(status);
            return s == 0 ? "Pending" : s == 1 ? "Approved" : "Rejected";
        }

        protected void btnNewExpense_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateExpense.aspx");
        }

        protected void btnApprovals_Click(object sender, EventArgs e)
        {
            Response.Redirect("PendingApprovals.aspx");
        }

        protected void btnUsers_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserManagement.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            S.Clear();
            Response.Redirect("Login.aspx");
        }
        protected void btnSettings_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApprovalSettings.aspx");
        }
    }
}