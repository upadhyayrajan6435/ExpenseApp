using System;
using System.Web.UI;
using ExpenseApp.BLL;
using ExpenseApp.Utilities;

namespace ExpenseApp
{
    public partial class CreateExpense : Page
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
                lblCurrency.Text = S.Currency;
                ddlCurrency.SelectedValue = S.Currency;
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(ddlCategory.SelectedValue))
                {
                    pnlError.Visible = true;
                    lblError.Text = "Please select a category";
                    return;
                }

                decimal amount = decimal.Parse(txtAmount.Text);
                string currency = ddlCurrency.SelectedValue;
                decimal converted = Expense.ConvertCurrency(amount, currency, S.Currency);

                int id = Expense.Create(
                    S.UserId,
                    S.CompanyId,
                    amount,
                    currency,
                    converted,
                    ddlCategory.SelectedValue,
                    txtDescription.Text.Trim(),
                    DateTime.Parse(txtDate.Text)
                );

                pnlSuccess.Visible = true;
                lblSuccess.Text = "Expense created successfully! ID: " + id;

                ClearForm();

                Response.AddHeader("REFRESH", "2;URL=Dashboard.aspx");
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error: " + ex.Message;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }

        private void ClearForm()
        {
            txtAmount.Text = "";
            txtDescription.Text = "";
            ddlCategory.SelectedIndex = 0;
            txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
}