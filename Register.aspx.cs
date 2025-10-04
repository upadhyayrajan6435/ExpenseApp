using System;
using System.Data;
using System.Web.UI;
using ExpenseApp.BLL;
using ExpenseApp.Utilities;

namespace ExpenseApp
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(ddlCountry.SelectedValue))
                {
                    pnlError.Visible = true;
                    lblError.Text = "Please select a country";
                    return;
                }

                string[] data = ddlCountry.SelectedValue.Split('|');
                string country = data[0];
                string currency = data[1];

                DataRow user = Auth.Register(txtEmail.Text.Trim(), txtPassword.Text,
                    txtName.Text.Trim(), country, currency);

                if (user != null)
                {
                    S.Set(user);
                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    pnlError.Visible = true;
                    lblError.Text = "Registration failed";
                }
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error: " + ex.Message;
            }
        }
    }
}