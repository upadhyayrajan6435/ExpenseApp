<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApprovalSettings.aspx.cs" Inherits="ExpenseApp.ApprovalSettings" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Approval Settings - Expense Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="~/ExpenseApp.css" rel="stylesheet" />
    <style>
        /* Form Labels */
        .form-group label {
            font-weight: 400 !important;
        }

        .form-group label i {
            margin-right: 8px;
            color: var(--primary-gold);
        }

        /* ✅ DROPDOWN FIX - Simplified and Working */
        select.form-control,
        select {
            color: #212529 !important;
            background-color: #FFFFFF !important;
            border: 1px solid #ced4da;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            line-height: 1.5;
            border-radius: 0.25rem;
            height: calc(1.5em + 0.75rem + 2px);
            -webkit-appearance: menulist;
            -moz-appearance: menulist;
            appearance: menulist;
        }

        /* Force option text to be visible */
        select.form-control option,
        select option {
            color: #212529;
            background-color: #FFFFFF;
            padding: 8px;
        }

        /* Card styling */
        .card {
            border-left: 4px solid var(--primary-gold);
            margin-bottom: 25px;
        }

        .card-header h5 {
            margin: 0;
        }

        /* Primary Button - OUTLINE STYLE */
        .btn-primary {
            background: transparent !important;
            border: 2px solid var(--primary-gold) !important;
            color: var(--primary-gold) !important;
            padding: 10px 24px;
            font-weight: 600;
            font-size: 0.9rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: var(--primary-gold) !important;
            color: var(--dark-bg) !important;
            transform: translateY(-2px);
        }

        /* Success Button - OUTLINE STYLE */
        .btn-success {
            background: transparent !important;
            border: 2px solid #10B981 !important;
            color: #10B981 !important;
            padding: 10px 24px;
            font-weight: 600;
            font-size: 0.9rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            background: #10B981 !important;
            color: white !important;
            transform: translateY(-2px);
        }

        /* Secondary button - OUTLINE STYLE */
        .btn-secondary {
            background: transparent !important;
            border: 2px solid #6c757d !important;
            color: #6c757d !important;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: #6c757d !important;
            color: white !important;
            transform: translateY(-2px);
        }

        /* Danger Button - OUTLINE STYLE */
        .btn-danger {
            background: transparent !important;
            border: 2px solid #EF4444 !important;
            color: #EF4444 !important;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            background: #EF4444 !important;
            color: white !important;
            transform: translateY(-1px);
        }

        /* Table Styling */
        .table {
            margin-bottom: 0;
            color: var(--text-primary);
        }

        .table thead th {
            background: linear-gradient(135deg, var(--dark-bg), #2a2a2a);
            color: var(--primary-gold);
            border: none;
            font-weight: 600;
            padding: 16px;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            border-bottom: 2px solid var(--primary-gold);
        }

        .table tbody tr {
            border-bottom: 1px solid var(--border-light);
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(197, 165, 114, 0.08);
        }

        .table tbody td {
            padding: 16px;
            vertical-align: middle;
            color: var(--text-primary);
            font-size: 0.9rem;
        }

        /* Help text */
        small.text-muted {
            color: var(--text-secondary) !important;
            font-size: 0.85rem;
        }

        hr {
            border-top: 2px solid var(--border-light);
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container-fluid">
                <span class="navbar-brand">
                    <i class="fas fa-chart-line"></i>
                    EXPENSE PRO
                </span>
                <div class="ml-auto">
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-outline-light btn-sm" OnClick="btnBack_Click">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </asp:LinkButton>
                </div>
            </div>
        </nav>

        <div class="container-fluid mt-4 mb-5">
            <!-- Page Title -->
            <div class="mb-4">
                <h3 class="section-title">Approval Settings</h3>
            </div>

            <!-- Success Message -->
            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show">
                <i class="fas fa-check-circle"></i>
                <asp:Label ID="lblSuccess" runat="server"></asp:Label>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </asp:Panel>

            <!-- Error Message -->
            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible fade show">
                <i class="fas fa-exclamation-circle"></i>
                <asp:Label ID="lblError" runat="server"></asp:Label>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </asp:Panel>

            <!-- Approval Rules Card -->
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-gavel"></i> Approval Rules</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label><i class="fas fa-tag"></i> Rule Name *</label>
                                <asp:TextBox ID="txtRuleName" runat="server" CssClass="form-control" 
                                    placeholder="e.g., Finance Approval Rule"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label><i class="fas fa-filter"></i> Rule Type *</label>
                                <asp:DropDownList ID="ddlRuleType" runat="server" CssClass="form-control" 
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlRuleType_SelectedIndexChanged">
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
                                    <label><i class="fas fa-percent"></i> Approval Percentage Threshold (%) *</label>
                                    <asp:TextBox ID="txtPercentage" runat="server" CssClass="form-control" 
                                        TextMode="Number" placeholder="e.g., 60" Text="60"></asp:TextBox>
                                    <small class="text-muted">If this % of approvers approve, expense is auto-approved</small>
                                </div>
                            </asp:Panel>
                        </div>
                        <div class="col-md-6">
                            <asp:Panel ID="pnlSpecific" runat="server" Visible="false">
                                <div class="form-group">
                                    <label><i class="fas fa-user-check"></i> Specific Approver *</label>
                                    <asp:DropDownList ID="ddlSpecificApprover" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="">Select Approver</asp:ListItem>
                                    </asp:DropDownList>
                                    <small class="text-muted">If this person approves, expense is auto-approved</small>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>

                    <asp:Button ID="btnSaveRule" runat="server" Text="Save Rule" 
                        CssClass="btn btn-primary" OnClick="btnSaveRule_Click" />
                    
                    <hr />
                    
                    <h6 class="mb-3"><i class="fas fa-list"></i> Current Active Rule:</h6>
                    <div class="table-responsive">
                        <asp:GridView ID="gvRules" runat="server" CssClass="table table-hover"
                            AutoGenerateColumns="false" EmptyDataText="No rules configured"
                            OnRowCommand="gvRules_RowCommand" GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="RuleName" HeaderText="Rule Name" />
                                <asp:BoundField DataField="RuleType" HeaderText="Type" />
                                <asp:BoundField DataField="PercentageThreshold" HeaderText="Threshold %" />
                                <asp:BoundField DataField="SpecificApproverName" HeaderText="Specific Approver" />
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDeleteRule" runat="server" Text="Delete"
                                            CssClass="btn btn-sm btn-danger"
                                            CommandName="DeleteRule" CommandArgument='<%# Eval("RuleId") %>'
                                            OnClientClick="return confirm('Delete this rule?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="text-center py-5">
                                    <i class="fas fa-gavel fa-3x text-gold" style="opacity: 0.2;"></i>
                                    <h6 class="mt-3 text-muted">No rules configured</h6>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <!-- Workflow Steps Card -->
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-stream"></i> Approval Workflow Steps</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label><i class="fas fa-tasks"></i> Step Name *</label>
                                <asp:TextBox ID="txtStepName" runat="server" CssClass="form-control" 
                                    placeholder="e.g., Finance Approval"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label><i class="fas fa-sort-numeric-up"></i> Step Order *</label>
                                <asp:TextBox ID="txtStepOrder" runat="server" CssClass="form-control" 
                                    TextMode="Number" placeholder="e.g., 1"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label><i class="fas fa-user-shield"></i> Required Role *</label>
                                <asp:DropDownList ID="ddlRequiredRole" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="1">Manager</asp:ListItem>
                                    <asp:ListItem Value="0">Admin</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>

                    <asp:Button ID="btnAddStep" runat="server" Text="Add Step" 
                        CssClass="btn btn-success" OnClick="btnAddStep_Click" />
                    
                    <hr />
                    
                    <h6 class="mb-3"><i class="fas fa-list"></i> Current Workflow Steps:</h6>
                    <div class="table-responsive">
                        <asp:GridView ID="gvSteps" runat="server" CssClass="table table-hover" 
                            AutoGenerateColumns="false" EmptyDataText="No workflow steps configured"
                            OnRowCommand="gvSteps_RowCommand" GridLines="None">
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
                            <EmptyDataTemplate>
                                <div class="text-center py-5">
                                    <i class="fas fa-stream fa-3x text-gold" style="opacity: 0.2;"></i>
                                    <h6 class="mt-3 text-muted">No workflow steps configured</h6>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Ensure dropdown text visibility after page load
        $(document).ready(function () {
            $('select.form-control').each(function () {
                $(this).css({
                    'color': '#212529',
                    'background-color': '#FFFFFF'
                });
            });
        });
    </script>
</body>
</html>