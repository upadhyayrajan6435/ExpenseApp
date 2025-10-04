using System;
using System.Data;
using System.Web.UI;
using ExpenseApp.BLL;
using ExpenseApp.Utilities;

namespace ExpenseApp
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && S.LoggedIn)
                Response.Redirect("Dashboard.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                DataRow user = Auth.Login(txtEmail.Text.Trim(), txtPassword.Text);
                if (user != null)
                {
                    S.Set(user);
                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    pnlError.Visible = true;
                    lblError.Text = "Invalid email or password";
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