<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="ExpenseApp.UserManagement" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Management - Expense Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="~/ExpenseApp.css" rel="stylesheet" />
    <style>
        /* Form Labels */
        .form-group label {
            font-weight: 400;
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

        /* Action Header matching dashboard */
        .action-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        /* Add User Button - OUTLINE STYLE */
        .btn-primary {
            background: transparent !important;
            border: 2px solid var(--primary-gold) !important;
            color: var(--primary-gold) !important;
            padding: 12px 28px;
            font-weight: 600;
            font-size: 0.95rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: var(--primary-gold) !important;
            border-color: var(--primary-gold) !important;
            color: var(--dark-bg) !important;
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(197, 165, 114, 0.4);
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
            border-color: #6c757d !important;
            color: white !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
        }

        /* Add User Panel matching dashboard card style */
        .add-user-card {
            margin-bottom: 25px;
            animation: slideDown 0.3s ease;
            border-left: 4px solid var(--primary-gold) !important;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Card styling */
        .card {
            border-left: 4px solid var(--primary-gold);
        }

        /* Table Styling matching dashboard */
        .table-container {
            overflow-x: auto;
        }

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
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .table tbody td {
            padding: 16px;
            vertical-align: middle;
            color: var(--text-primary);
            font-size: 0.9rem;
        }

        /* Updated Role Badges - OUTLINE STYLE ONLY */
        .badge-admin {
            background: transparent !important;
            border: 2px solid #8B5CF6 !important;
            color: #8B5CF6 !important;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .badge-manager {
            background: transparent !important;
            border: 2px solid #06B6D4 !important;
            color: #06B6D4 !important;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .badge-employee {
            background: transparent !important;
            border: 2px solid #F97316 !important;
            color: #F97316 !important;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        /* Action Buttons in Table */
        .action-buttons {
            display: flex;
            gap: 6px;
            align-items: center;
            flex-wrap: wrap;
        }

        .action-buttons select {
            min-width: 110px;
            font-size: 0.85rem !important;
            padding: 6px 10px;
            height: auto;
            border-radius: 6px;
            color: #212529 !important;
            background-color: #FFFFFF !important;
        }

        .action-buttons .btn-sm {
            padding: 6px 14px;
            font-size: 0.8rem;
            border-radius: 6px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        /* Info Button - OUTLINE STYLE */
        .btn-info {
            background: transparent !important;
            border: 2px solid #3B82F6 !important;
            color: #3B82F6 !important;
        }

        .btn-info:hover {
            background: #3B82F6 !important;
            border-color: #3B82F6 !important;
            color: white !important;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        /* Warning Button - OUTLINE STYLE */
        .btn-warning {
            background: transparent !important;
            border: 2px solid #F59E0B !important;
            color: #F59E0B !important;
        }

        .btn-warning:hover {
            background: #F59E0B !important;
            border-color: #F59E0B !important;
            color: white !important;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
        }

        /* Danger Button - OUTLINE STYLE */
        .btn-danger {
            background: transparent !important;
            border: 2px solid #EF4444 !important;
            color: #EF4444 !important;
        }

        .btn-danger:hover {
            background: #EF4444 !important;
            border-color: #EF4444 !important;
            color: white !important;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        /* Empty State */
        .empty-state {
            padding: 80px 20px;
            text-align: center;
        }

        .empty-state i {
            font-size: 5rem;
            color: var(--primary-gold);
            opacity: 0.2;
            margin-bottom: 25px;
        }

        .empty-state h5 {
            color: var(--text-primary);
            margin-bottom: 12px;
            font-weight: 600;
        }

        .empty-state p {
            color: var(--text-secondary);
            font-size: 0.95rem;
        }

        /* Icon colors in table */
        .text-gold {
            color: var(--primary-gold) !important;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .action-header {
                flex-direction: column;
                align-items: stretch;
            }

            .action-buttons {
                flex-direction: column;
                align-items: stretch;
            }

            .action-buttons select,
            .action-buttons .btn {
                width: 100%;
                margin-bottom: 5px;
            }

            .table {
                font-size: 0.85rem;
            }

            .table thead th,
            .table tbody td {
                padding: 12px 10px;
            }
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
            <!-- Page Title & Action -->
            <div class="action-header">
                <h3 class="section-title mb-0">User Management</h3>
                <asp:Button ID="btnShowAdd" runat="server" Text="+ Add New User" 
                    CssClass="btn btn-primary ml-2" OnClick="btnShowAdd_Click" />
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

            <!-- Add User Form -->
            <asp:Panel ID="pnlAdd" runat="server" Visible="false" CssClass="card add-user-card mb-4">
                <div class="card-header">
                    <h5><i class="fas fa-user-plus"></i> Add New User</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label><i class="fas fa-user"></i> Name *</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter full name"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label><i class="fas fa-envelope"></i> Email *</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Enter email"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label><i class="fas fa-lock"></i> Password *</label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label><i class="fas fa-user-tag"></i> Role *</label>
                                <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="2">Employee</asp:ListItem>
                                    <asp:ListItem Value="1">Manager</asp:ListItem>
                                    <asp:ListItem Value="0">Admin</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label><i class="fas fa-user-shield"></i> Manager (Optional)</label>
                                <asp:DropDownList ID="ddlManager" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">No Manager</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <asp:Button ID="btnAdd" runat="server" Text="Create User" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
                    <asp:Button ID="btnCancelAdd" runat="server" Text="Cancel" CssClass="btn btn-secondary ml-2" OnClick="btnCancelAdd_Click" />
                </div>
            </asp:Panel>

            <!-- Users List -->
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-users"></i> Company Users</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-container">
                        <asp:GridView ID="gvUsers" runat="server" CssClass="table table-hover" 
                            AutoGenerateColumns="false" EmptyDataText="No users found"
                            OnRowCommand="gvUsers_RowCommand" OnRowDataBound="gvUsers_RowDataBound"
                            GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="Name" HeaderText="Name" />
                                <asp:BoundField DataField="Email" HeaderText="Email" />
                                <asp:TemplateField HeaderText="Role">
                                    <ItemTemplate>
                                        <span class='badge badge-<%# GetRoleBadge(Eval("Role")) %>'>
                                            <%# GetRole(Eval("Role")) %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ManagerName" HeaderText="Manager" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hfUserId" runat="server" Value='<%# Eval("UserId") %>' />
                                        <asp:HiddenField ID="hfRole" runat="server" Value='<%# Eval("Role") %>' />
                                        
                                        <div class="action-buttons">
                                            <asp:DropDownList ID="ddlUserRole" runat="server" CssClass="form-control form-control-sm d-inline-block mr-1" style="width:110px;">
                                                <asp:ListItem Value="2">Employee</asp:ListItem>
                                                <asp:ListItem Value="1">Manager</asp:ListItem>
                                                <asp:ListItem Value="0">Admin</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:Button ID="btnUpdateRole" runat="server" Text="Update Role" 
                                                CssClass="btn btn-sm btn-info mr-1" 
                                                CommandName="UpdateRole" ToolTip="Update Role" />
                                            
                                            <asp:DropDownList ID="ddlUserManager" runat="server" CssClass="form-control form-control-sm d-inline-block mr-1" style="width:130px;">
                                            </asp:DropDownList>
                                            <asp:Button ID="btnUpdateManager" runat="server" Text="Update Manager" 
                                                CssClass="btn btn-sm btn-warning mr-1" 
                                                CommandName="UpdateManager" ToolTip="Update Manager" />
                                            
                                            <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                                                CssClass="btn btn-sm btn-danger" 
                                                CommandName="DeleteUser" 
                                                OnClientClick="return confirm('Are you sure you want to delete this user?');" 
                                                ToolTip="Delete User" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="empty-state">
                                    <i class="fas fa-users"></i>
                                    <h5>No Users Found</h5>
                                    <p>There are no users in the system yet. Click "Add New User" to get started.</p>
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
        $(document).ready(function() {
            $('select.form-control, select').each(function() {
                $(this).css({
                    'color': '#212529',
                    'background-color': '#FFFFFF'
                });
            });
        });
    </script>
</body>
</html>