using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExpenseApp.BLL;
using ExpenseApp.Utilities;

namespace ExpenseApp
{
    public partial class ApprovalSettings : Page
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
                LoadApprovers();
                LoadData();
            }
        }

        private void LoadData()
        {
            try
            {
                gvRules.DataSource = ApprovalRule.GetRules(S.CompanyId);
                gvRules.DataBind();

                gvSteps.DataSource = ApprovalRule.GetWorkflowSteps(S.CompanyId);
                gvSteps.DataBind();
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error loading data: " + ex.Message;
            }
        }

        private void LoadApprovers()
        {
            try
            {
                DataTable dt = BLL.User.GetAll(S.CompanyId);
                ddlSpecificApprover.Items.Clear();
                ddlSpecificApprover.Items.Add(new ListItem("Select Approver", ""));

                foreach (DataRow row in dt.Rows)
                {
                    int role = Convert.ToInt32(row["Role"]);
                    if (role == 0 || role == 1)
                    {
                        string roleName = role == 0 ? "Admin" : "Manager";
                        ddlSpecificApprover.Items.Add(new ListItem(
                            row["Name"].ToString() + " (" + roleName + ")",
                            row["UserId"].ToString()));
                    }
                }
            }
            catch { }
        }

        protected void ddlRuleType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string type = ddlRuleType.SelectedValue;
            pnlPercentage.Visible = type == "Percentage" || type == "Hybrid";
            pnlSpecific.Visible = type == "Specific" || type == "Hybrid";
        }

        protected void btnSaveRule_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtRuleName.Text.Trim()))
                {
                    pnlError.Visible = true;
                    lblError.Text = "Please enter rule name";
                    return;
                }

                if (string.IsNullOrEmpty(ddlRuleType.SelectedValue))
                {
                    pnlError.Visible = true;
                    lblError.Text = "Please select rule type";
                    return;
                }

                int? percentage = null;
                int? approverId = null;

                if (pnlPercentage.Visible && !string.IsNullOrEmpty(txtPercentage.Text))
                    percentage = Convert.ToInt32(txtPercentage.Text);

                if (pnlSpecific.Visible && !string.IsNullOrEmpty(ddlSpecificApprover.SelectedValue))
                    approverId = Convert.ToInt32(ddlSpecificApprover.SelectedValue);

                ApprovalRule.SaveRule(S.CompanyId, txtRuleName.Text.Trim(),
                    ddlRuleType.SelectedValue, percentage, approverId);

                pnlSuccess.Visible = true;
                lblSuccess.Text = "Approval rule saved successfully!";

                txtRuleName.Text = "";
                ddlRuleType.SelectedIndex = 0;
                txtPercentage.Text = "60";
                pnlPercentage.Visible = false;
                pnlSpecific.Visible = false;

                LoadData();
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error: " + ex.Message;
            }
        }

        protected void btnAddStep_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtStepName.Text.Trim()))
                {
                    pnlError.Visible = true;
                    lblError.Text = "Please enter step name";
                    return;
                }

                if (string.IsNullOrEmpty(txtStepOrder.Text))
                {
                    pnlError.Visible = true;
                    lblError.Text = "Please enter step order";
                    return;
                }

                ApprovalRule.SaveStep(S.CompanyId, txtStepName.Text.Trim(),
                    Convert.ToInt32(txtStepOrder.Text), Convert.ToInt32(ddlRequiredRole.SelectedValue));

                pnlSuccess.Visible = true;
                lblSuccess.Text = "Workflow step added successfully!";

                txtStepName.Text = "";
                txtStepOrder.Text = "";

                LoadData();
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error: " + ex.Message;
            }
        }

        protected void gvSteps_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteStep")
            {
                try
                {
                    ApprovalRule.DeleteStep(Convert.ToInt32(e.CommandArgument));
                    pnlSuccess.Visible = true;
                    lblSuccess.Text = "Step deleted successfully!";
                    LoadData();
                }
                catch (Exception ex)
                {
                    pnlError.Visible = true;
                    lblError.Text = "Error: " + ex.Message;
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }

        // Helper method for GridView - THIS WAS MISSING
        protected string GetRoleName(object role)
        {
            try
            {
                if (role == null || role == DBNull.Value)
                    return "N/A";

                int r = Convert.ToInt32(role);
                return r == 0 ? "Admin" : r == 1 ? "Manager" : "Any Role";
            }
            catch
            {
                return "N/A";
            }
        }
    }
}