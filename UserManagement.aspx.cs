using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExpenseApp.BLL;
using ExpenseApp.Utilities;

namespace ExpenseApp
{
    public partial class UserManagement : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!S.LoggedIn)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (S.Role != 0)
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadData();
                LoadManagers();
            }
        }

        private void LoadData()
        {
            try
            {
                DataTable dt = BLL.User.GetAll(S.CompanyId);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error loading users: " + ex.Message;
            }
        }

        protected void gvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                try
                {
                    HiddenField hfUserId = e.Row.FindControl("hfUserId") as HiddenField;
                    HiddenField hfRole = e.Row.FindControl("hfRole") as HiddenField;
                    DropDownList ddlUserRole = e.Row.FindControl("ddlUserRole") as DropDownList;
                    DropDownList ddlUserManager = e.Row.FindControl("ddlUserManager") as DropDownList;

                    if (hfRole != null && ddlUserRole != null)
                    {
                        ddlUserRole.SelectedValue = hfRole.Value;
                    }

                    if (ddlUserManager != null)
                    {
                        DataTable managers = BLL.User.GetAll(S.CompanyId);
                        ddlUserManager.Items.Clear();
                        ddlUserManager.Items.Add(new ListItem("No Manager", ""));

                        foreach (DataRow row in managers.Rows)
                        {
                            int role = Convert.ToInt32(row["Role"]);
                            string userId = row["UserId"].ToString();
                            string currentUserId = hfUserId != null ? hfUserId.Value : "";

                            if ((role == 0 || role == 1) && userId != currentUserId)
                            {
                                ddlUserManager.Items.Add(new ListItem(row["Name"].ToString(), userId));
                            }
                        }

                        DataRowView drv = (DataRowView)e.Row.DataItem;
                        string managerId = drv["ManagerId"]?.ToString() ?? "";
                        if (!string.IsNullOrEmpty(managerId))
                        {
                            ListItem item = ddlUserManager.Items.FindByValue(managerId);
                            if (item != null) item.Selected = true;
                        }
                    }
                }
                catch { }
            }
        }

        private void LoadManagers()
        {
            try
            {
                DataTable dt = BLL.User.GetAll(S.CompanyId);
                ddlManager.Items.Clear();
                ddlManager.Items.Add(new ListItem("No Manager", ""));

                foreach (DataRow row in dt.Rows)
                {
                    int role = Convert.ToInt32(row["Role"]);
                    if (role == 0 || role == 1)
                    {
                        ddlManager.Items.Add(new ListItem(row["Name"].ToString(), row["UserId"].ToString()));
                    }
                }
            }
            catch { }
        }

        protected void btnShowAdd_Click(object sender, EventArgs e)
        {
            pnlAdd.Visible = true;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                int? mgrId = string.IsNullOrEmpty(ddlManager.SelectedValue) ?
                    (int?)null : Convert.ToInt32(ddlManager.SelectedValue);

                BLL.User.Create(txtEmail.Text.Trim(), txtPassword.Text, txtName.Text.Trim(),
                    Convert.ToInt32(ddlRole.SelectedValue), S.CompanyId, mgrId);

                pnlSuccess.Visible = true;
                lblSuccess.Text = "User created successfully!";
                pnlAdd.Visible = false;

                ClearForm();
                LoadData();
                LoadManagers();
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error: " + ex.Message;
            }
        }

        protected void btnCancelAdd_Click(object sender, EventArgs e)
        {
            pnlAdd.Visible = false;
            ClearForm();
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                HiddenField hfUserId = row.FindControl("hfUserId") as HiddenField;

                if (hfUserId == null) return;

                int userId = Convert.ToInt32(hfUserId.Value);

                if (e.CommandName == "UpdateRole")
                {
                    DropDownList ddlUserRole = row.FindControl("ddlUserRole") as DropDownList;
                    if (ddlUserRole != null)
                    {
                        BLL.User.UpdateRole(userId, Convert.ToInt32(ddlUserRole.SelectedValue));
                        pnlSuccess.Visible = true;
                        lblSuccess.Text = "Role updated successfully!";
                        LoadData();
                    }
                }
                else if (e.CommandName == "UpdateManager")
                {
                    DropDownList ddlUserManager = row.FindControl("ddlUserManager") as DropDownList;
                    if (ddlUserManager != null)
                    {
                        int? managerId = string.IsNullOrEmpty(ddlUserManager.SelectedValue) ?
                            (int?)null : Convert.ToInt32(ddlUserManager.SelectedValue);

                        BLL.User.UpdateManager(userId, managerId);
                        pnlSuccess.Visible = true;
                        lblSuccess.Text = "Manager updated successfully!";
                        LoadData();
                    }
                }
                else if (e.CommandName == "DeleteUser")
                {
                    BLL.User.Delete(userId);
                    pnlSuccess.Visible = true;
                    lblSuccess.Text = "User deleted successfully!";
                    LoadData();
                    LoadManagers();
                }
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

        protected string GetRole(object role)
        {
            int r = Convert.ToInt32(role);
            return r == 0 ? "Admin" : r == 1 ? "Manager" : "Employee";
        }

        protected string GetRoleBadge(object role)
        {
            int r = Convert.ToInt32(role);
            return r == 0 ? "danger" : r == 1 ? "warning" : "info";
        }

        private void ClearForm()
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            ddlRole.SelectedIndex = 0;
            ddlManager.SelectedIndex = 0;
        }
    }
}