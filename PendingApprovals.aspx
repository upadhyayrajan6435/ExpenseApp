<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PendingApprovals.aspx.cs" Inherits="ExpenseApp.PendingApprovals" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pending Approvals</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <style>
        body { background-color: #f4f6f9; padding: 20px; }
        .card { border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 15px; }
        .expense-item { padding: 20px; border-bottom: 1px solid #eee; }
        .expense-item:last-child { border-bottom: none; }
        .workflow-badge { font-size: 12px; padding: 5px 10px; margin-left: 10px; }
        .approval-progress { margin-top: 10px; }
        @media (max-width: 768px) {
            .expense-item { padding: 15px; }
            .btn-sm { font-size: 12px; padding: 5px 10px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="mb-3">
                <h2><i class="fas fa-tasks"></i> Pending Approvals</h2>
                <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-secondary" OnClick="btnBack_Click">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </asp:LinkButton>
            </div>

            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show">
                <i class="fas fa-check-circle"></i>
                <asp:Label ID="lblSuccess" runat="server"></asp:Label>
            </asp:Panel>

            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible fade show">
                <i class="fas fa-exclamation-circle"></i>
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </asp:Panel>

            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-list"></i> Expenses Awaiting Your Approval</h5>
                </div>
                <div class="card-body p-0">
                    <asp:Repeater ID="rptExpenses" runat="server" OnItemCommand="rptExpenses_ItemCommand">
                        <ItemTemplate>
                            <div class="expense-item">
                                <div class="row">
                                    <div class="col-lg-8 col-md-7 mb-3 mb-md-0">
                                        <h5>
                                            <%# Eval("Description") %>
                                            <span class="badge badge-info workflow-badge">
                                                Step <%# Eval("StepOrder") %>: <%# Eval("StepName") %>
                                            </span>
                                        </h5>
                                        <p class="mb-1 text-muted">
                                            <i class="fas fa-user"></i> <strong>Employee:</strong> <%# Eval("EmployeeName") %> | 
                                            <i class="fas fa-tag"></i> <strong>Category:</strong> <%# Eval("Category") %>
                                        </p>
                                        <p class="mb-2 text-muted">
                                            <i class="fas fa-calendar"></i> <strong>Date:</strong> <%# Eval("Date", "{0:MMM dd, yyyy}") %> | 
                                            <i class="fas fa-dollar-sign"></i> <strong>Amount:</strong> <%# Eval("OriginalCurrency") %> <%# Eval("Amount", "{0:N2}") %>
                                        </p>
                                        <div class="approval-progress">
                                            <small class="text-muted">
                                                <i class="fas fa-chart-line"></i> Progress: 
                                                <strong><%# Eval("ApprovedCount") %>/<%# Eval("TotalApprovers") %></strong> approvers approved
                                            </small>
                                            <div class="progress" style="height: 5px; margin-top: 5px;">
                                                <div class="progress-bar bg-success" role="progressbar" 
                                                     style='width: <%# GetProgressPercentage(Eval("ApprovedCount"), Eval("TotalApprovers")) %>%'></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-5">
                                        <div class="form-group">
                                            <label><i class="fas fa-comment"></i> Comments (Optional)</label>
                                            <asp:TextBox ID="txtComment" runat="server" CssClass="form-control form-control-sm" 
                                                placeholder="Add your comments..." TextMode="MultiLine" Rows="2"></asp:TextBox>
                                        </div>
                                        <div class="text-right">
                                            <asp:Button ID="btnApprove" runat="server" Text="✓ Approve" 
                                                CssClass="btn btn-success btn-sm" 
                                                CommandName="Approve" CommandArgument='<%# Eval("ExpenseId") %>' />
                                            <asp:Button ID="btnReject" runat="server" Text="✗ Reject" 
                                                CssClass="btn btn-danger btn-sm ml-2" 
                                                CommandName="Reject" CommandArgument='<%# Eval("ExpenseId") %>' 
                                                OnClientClick="return confirm('Are you sure you want to reject this expense?');" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoData" runat="server" Visible="false" CssClass="p-5 text-center">
                        <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">No pending approvals</h5>
                        <p class="text-muted">You're all caught up!</p>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </form>
</body>
</html>