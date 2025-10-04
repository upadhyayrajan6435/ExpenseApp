using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExpenseApp.BLL;
using ExpenseApp.Utilities;

namespace ExpenseApp
{
    public partial class PendingApprovals : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!S.LoggedIn)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (S.Role == 2)
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            try
            {
                DataTable dt = Expense.GetPending(S.UserId);

                if (dt.Rows.Count > 0)
                {
                    rptExpenses.DataSource = dt;
                    rptExpenses.DataBind();
                    pnlNoData.Visible = false;
                }
                else
                {
                    rptExpenses.DataSource = null;
                    rptExpenses.DataBind();
                    pnlNoData.Visible = true;
                }
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error loading approvals: " + ex.Message;
            }
        }

        protected void rptExpenses_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                int expenseId = Convert.ToInt32(e.CommandArgument);
                TextBox txtComment = e.Item.FindControl("txtComment") as TextBox;
                string comment = txtComment != null ? txtComment.Text : "";

                int status = e.CommandName == "Approve" ? 1 : 2;

                Expense.Approve(expenseId, S.UserId, status, comment);

                pnlSuccess.Visible = true;
                lblSuccess.Text = "Expense " + (status == 1 ? "approved" : "rejected") + " successfully!";

                LoadData();
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error: " + ex.Message;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }

        protected string GetProgressPercentage(object approved, object total)
        {
            try
            {
                int app = Convert.ToInt32(approved);
                int tot = Convert.ToInt32(total);
                if (tot == 0) return "0";
                return ((app * 100.0) / tot).ToString("0");
            }
            catch
            {
                return "0";
            }
        }
    }
}