<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ExpenseApp.Register" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Register - Expense Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 50px 0;
        }
        .register-card { border-radius: 15px; box-shadow: 0 10px 40px rgba(0,0,0,0.3); }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card register-card">
                        <div class="card-body p-5">
                            <h2 class="text-center mb-2">Create Your Company</h2>
                            <h5 class="text-center text-muted mb-4">Sign up for new account</h5>

                            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger">
                                <asp:Label ID="lblError" runat="server"></asp:Label>
                            </asp:Panel>

                            <div class="form-group">
                                <label>Full Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control"
                                    placeholder="Enter full name"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                                    TextMode="Email" placeholder="Enter email"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Password</label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"
                                    TextMode="Password" placeholder="Enter password"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Country & Currency</label>
                                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">Select Country</asp:ListItem>
                                    <asp:ListItem Value="United States|USD">United States (USD)</asp:ListItem>
                                    <asp:ListItem Value="India|INR">India (INR)</asp:ListItem>
                                    <asp:ListItem Value="United Kingdom|GBP">United Kingdom (GBP)</asp:ListItem>
                                    <asp:ListItem Value="Canada|CAD">Canada (CAD)</asp:ListItem>
                                    <asp:ListItem Value="Australia|AUD">Australia (AUD)</asp:ListItem>
                                    <asp:ListItem Value="Germany|EUR">Germany (EUR)</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <asp:Button ID="btnRegister" runat="server" Text="Create Account"
                                CssClass="btn btn-primary btn-lg btn-block mt-4" OnClick="btnRegister_Click" />

                            <div class="text-center mt-3">
                                <a href="Login.aspx" class="text-primary">Already have an account? Login</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>