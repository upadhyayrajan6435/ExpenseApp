<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ExpenseApp.Dashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Dashboard - Expense Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { background-color: #f4f6f9; }
        .navbar { box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .stat-card { border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .stat-card h2 { font-size: 2.5rem; font-weight: bold; margin: 10px 0; }
        .action-btn { padding: 30px; text-align: center; border-radius: 10px; }
        .badge-pending { background-color: #ffc107; }
        .badge-approved { background-color: #28a745; }
        .badge-rejected { background-color: #dc3545; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container-fluid">
                <span class="navbar-brand">Expense Management</span>
                <div class="ml-auto">
                    <span class="text-white mr-3">
                        Welcome, <asp:Label ID="lblUser" runat="server"></asp:Label>
                    </span>
                    <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-outline-light btn-sm" OnClick="btnLogout_Click">
                        Logout
                    </asp:LinkButton>
                </div>
            </div>
        </nav>

        <div class="container-fluid mt-4">
            <!-- User Info -->
            <div class="alert alert-info">
                <strong>Role:</strong> <asp:Label ID="lblRole" runat="server"></asp:Label> | 
                <strong>Company:</strong> <asp:Label ID="lblCompany" runat="server"></asp:Label> | 
                <strong>Currency:</strong> <asp:Label ID="lblCurrency" runat="server"></asp:Label>
            </div>

            <!-- Quick Actions -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <asp:LinkButton ID="btnNewExpense" runat="server" CssClass="btn btn-primary btn-lg btn-block action-btn" OnClick="btnNewExpense_Click">
                        + New Expense
                    </asp:LinkButton>
                </div>
                <asp:PlaceHolder ID="phManager" runat="server" Visible="false">
                    <div class="col-md-3">
                        <asp:LinkButton ID="btnApprovals" runat="server" CssClass="btn btn-warning btn-lg btn-block action-btn" OnClick="btnApprovals_Click">
                            Pending Approvals
                        </asp:LinkButton>
                    </div>
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="phAdmin" runat="server" Visible="false">
    <div class="col-md-3">
        <asp:LinkButton ID="btnUsers" runat="server" CssClass="btn btn-info btn-lg btn-block action-btn" OnClick="btnUsers_Click">
            <i class="fas fa-users"></i> Manage Users
        </asp:LinkButton>
    </div>
    <div class="col-md-3">
        <asp:LinkButton ID="btnSettings" runat="server" CssClass="btn btn-secondary btn-lg btn-block action-btn" OnClick="btnSettings_Click">
            <i class="fas fa-cog"></i> Approval Settings
        </asp:LinkButton>
    </div>
</asp:PlaceHolder>
            </div>

            <!-- Statistics -->
            <div class="row">
                <div class="col-md-3">
                    <div class="card stat-card">
                        <div class="card-body text-center">
                            <h5 class="text-muted">Total Expenses</h5>
                            <h2 class="text-primary"><asp:Label ID="lblTotal" runat="server">0</asp:Label></h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stat-card">
                        <div class="card-body text-center">
                            <h5 class="text-muted">Pending</h5>
                            <h2 class="text-warning"><asp:Label ID="lblPending" runat="server">0</asp:Label></h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stat-card">
                        <div class="card-body text-center">
                            <h5 class="text-muted">Approved</h5>
                            <h2 class="text-success"><asp:Label ID="lblApproved" runat="server">0</asp:Label></h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stat-card">
                        <div class="card-body text-center">
                            <h5 class="text-muted">Total Amount</h5>
                            <h2 class="text-info">
                                <asp:Label ID="lblCurr" runat="server"></asp:Label>
                                <asp:Label ID="lblAmount" runat="server">0.00</asp:Label>
                            </h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Expenses -->
            <div class="row mt-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Recent Expenses</h5>
                        </div>
                        <div class="card-body">
                            <asp:GridView ID="gvExpenses" runat="server" CssClass="table table-hover" 
                                AutoGenerateColumns="false" EmptyDataText="No expenses found">
                                <Columns>
                                    <asp:BoundField DataField="EmployeeName" HeaderText="Employee" />
                                    <asp:BoundField DataField="Description" HeaderText="Description" />
                                    <asp:BoundField DataField="Category" HeaderText="Category" />
                                    <asp:TemplateField HeaderText="Amount">
                                        <ItemTemplate>
                                            <%# Eval("OriginalCurrency") %> <%# Eval("Amount", "{0:N2}") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Date">
                                        <ItemTemplate>
                                            <%# Eval("Date", "{0:MMM dd, yyyy}") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <span class='badge badge-<%# GetStatusClass(Eval("Status")) %>'>
                                                <%# GetStatusText(Eval("Status")) %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>