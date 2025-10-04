<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="ExpenseApp.UserManagement" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <style>
        body { background-color: #f4f6f9; padding: 20px; }
        .card { border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .table { margin-bottom: 0; }
        .action-buttons { white-space: nowrap; }
        @media (max-width: 768px) {
            .table { font-size: 12px; }
            .btn-sm { font-size: 11px; padding: 3px 8px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="mb-3">
                <h2><i class="fas fa-users"></i> User Management</h2>
                <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-secondary" OnClick="btnBack_Click">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </asp:LinkButton>
                <asp:Button ID="btnShowAdd" runat="server" Text="+ Add New User" 
                    CssClass="btn btn-primary ml-2" OnClick="btnShowAdd_Click" />
            </div>

            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible">
                <i class="fas fa-check-circle"></i>
                <asp:Label ID="lblSuccess" runat="server"></asp:Label>
            </asp:Panel>

            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible">
                <i class="fas fa-exclamation-circle"></i>
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Add User Form -->
            <asp:Panel ID="pnlAdd" runat="server" Visible="false" CssClass="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-user-plus"></i> Add New User</h5>
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
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-list"></i> Company Users</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <asp:GridView ID="gvUsers" runat="server" CssClass="table table-hover" 
                            AutoGenerateColumns="false" EmptyDataText="No users found"
                            OnRowCommand="gvUsers_RowCommand" OnRowDataBound="gvUsers_RowDataBound">
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
                                            <asp:Button ID="btnUpdateManager" runat="server" Text="Update Mgr" 
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
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>