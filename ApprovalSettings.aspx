<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApprovalSettings.aspx.cs" Inherits="ExpenseApp.ApprovalSettings" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Approval Settings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <style>
        body { background-color: #f4f6f9; padding: 20px; }
        .card { border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 20px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="mb-3">
                <h2><i class="fas fa-cog"></i> Approval Settings</h2>
                <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-secondary" OnClick="btnBack_Click">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </asp:LinkButton>
            </div>

            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <asp:Label ID="lblSuccess" runat="server"></asp:Label>
            </asp:Panel>

            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Approval Rules -->
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-rules"></i> Approval Rules</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Rule Name *</label>
                                <asp:TextBox ID="txtRuleName" runat="server" CssClass="form-control" placeholder="e.g., Finance Approval Rule"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Rule Type *</label>
                                <asp:DropDownList ID="ddlRuleType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlRuleType_SelectedIndexChanged">
                                    <asp:ListItem Value="">Select Type</asp:ListItem>
                                    <asp:ListItem Value="Percentage">Percentage Based</asp:ListItem>
                                    <asp:ListItem Value="Specific">Specific Approver</asp:ListItem>
                                    <asp:ListItem Value="Hybrid">Hybrid (Percentage OR Specific)</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <asp:Panel ID="pnlPercentage" runat="server" Visible="false">
                                <div class="form-group">
                                    <label>Approval Percentage Threshold (%) *</label>
                                    <asp:TextBox ID="txtPercentage" runat="server" CssClass="form-control" 
                                        TextMode="Number" placeholder="e.g., 60" Text="60"></asp:TextBox>
                                    <small class="text-muted">If this % of approvers approve, expense is auto-approved</small>
                                </div>
                            </asp:Panel>
                        </div>
                        <div class="col-md-6">
                            <asp:Panel ID="pnlSpecific" runat="server" Visible="false">
                                <div class="form-group">
                                    <label>Specific Approver *</label>
                                    <asp:DropDownList ID="ddlSpecificApprover" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="">Select Approver</asp:ListItem>
                                    </asp:DropDownList>
                                    <small class="text-muted">If this person approves, expense is auto-approved</small>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    <asp:Button ID="btnSaveRule" runat="server" Text="Save Rule" CssClass="btn btn-primary" OnClick="btnSaveRule_Click" />
                    
                    <hr />
                    
                    <h6>Current Active Rule:</h6>
                    <asp:GridView ID="gvRules" runat="server" CssClass="table table-sm" AutoGenerateColumns="false" EmptyDataText="No rules configured">
                        <Columns>
                            <asp:BoundField DataField="RuleName" HeaderText="Rule Name" />
                            <asp:BoundField DataField="RuleType" HeaderText="Type" />
                            <asp:BoundField DataField="PercentageThreshold" HeaderText="Threshold %" />
                            <asp:BoundField DataField="SpecificApproverName" HeaderText="Specific Approver" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <!-- Workflow Steps -->
            <div class="card">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0"><i class="fas fa-stream"></i> Approval Workflow Steps</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Step Name *</label>
                                <asp:TextBox ID="txtStepName" runat="server" CssClass="form-control" placeholder="e.g., Finance Approval"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Step Order *</label>
                                <asp:TextBox ID="txtStepOrder" runat="server" CssClass="form-control" TextMode="Number" placeholder="e.g., 1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Required Role *</label>
                                <asp:DropDownList ID="ddlRequiredRole" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="1">Manager</asp:ListItem>
                                    <asp:ListItem Value="0">Admin</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <asp:Button ID="btnAddStep" runat="server" Text="Add Step" CssClass="btn btn-success" OnClick="btnAddStep_Click" />
                    
                    <hr />
                    
                    <h6>Current Workflow Steps:</h6>
                    <asp:GridView ID="gvSteps" runat="server" CssClass="table table-sm" 
                        AutoGenerateColumns="false" EmptyDataText="No workflow steps configured"
                        OnRowCommand="gvSteps_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="StepOrder" HeaderText="Order" />
                            <asp:BoundField DataField="StepName" HeaderText="Step Name" />
                            <asp:TemplateField HeaderText="Required Role">
                                <ItemTemplate>
                                    <%# GetRoleName(Eval("RequiredRole")) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:Button ID="btnDeleteStep" runat="server" Text="Delete" 
                                        CssClass="btn btn-sm btn-danger" 
                                        CommandName="DeleteStep" CommandArgument='<%# Eval("StepId") %>'
                                        OnClientClick="return confirm('Delete this step?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</body>
</html>