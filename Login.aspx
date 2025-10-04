<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ExpenseApp.Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - Expense Management</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            width: 100%;
            max-width: 440px;
        }

        .login-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 45px 30px;
            text-align: center;
            color: white;
        }

        .logo-icon {
            width: 70px;
            height: 70px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
        }

        .logo-icon i {
            font-size: 35px;
            color: white;
        }

        .login-header h1 {
            font-size: 26px;
            font-weight: 600;
            margin: 0 0 8px 0;
        }

        .login-header p {
            font-size: 14px;
            opacity: 0.95;
            margin: 0;
        }

        .login-body {
            padding: 35px 30px;
        }

        .alert {
            border-radius: 10px;
            border: none;
            padding: 12px 15px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .alert-danger {
            background: #fee;
            color: #c33;
        }

        .alert i {
            margin-right: 8px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            color: #344054;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 8px;
            display: block;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 16px;
        }

        .form-control {
            height: 50px;
            padding-left: 45px;
            padding-right: 45px;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 14px;
            transition: all 0.2s;
            background: #f9fafb;
        }

        .form-control:focus {
            background: white;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #9ca3af;
            font-size: 16px;
        }

        .password-toggle:hover {
            color: #667eea;
        }

        .btn-login {
            height: 50px;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            width: 100%;
            transition: all 0.3s;
            margin-top: 10px;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-login:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .divider {
            text-align: center;
            margin: 25px 0;
            position: relative;
        }

        .divider::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
            background: #e5e7eb;
        }

        .divider span {
            background: white;
            padding: 0 12px;
            color: #9ca3af;
            font-size: 13px;
            position: relative;
        }

        .register-section {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
        }

        .register-section p {
            color: #6b7280;
            font-size: 14px;
            margin: 0;
        }

        .register-link {
            color: #667eea;
            font-weight: 600;
            text-decoration: none;
        }

        .register-link:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .login-footer {
            text-align: center;
            margin-top: 20px;
            color: white;
            font-size: 13px;
        }

        @media (max-width: 576px) {
            .login-header {
                padding: 35px 20px;
            }
            .login-body {
                padding: 25px 20px;
            }
            .login-header h1 {
                font-size: 22px;
            }
            .form-control {
                height: 48px;
                font-size: 14px;
            }
            .btn-login {
                height: 48px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="login-card">
                <div class="login-header">
                    <div class="logo-icon">
                        <i class="fas fa-wallet"></i>
                    </div>
                    <h1>Expense Management</h1>
                    <p>Sign in to continue to your account</p>
                </div>

                <div class="login-body">
                    <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i>
                        <asp:Label ID="lblError" runat="server"></asp:Label>
                    </asp:Panel>

                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <div class="input-wrapper">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                                placeholder="Enter your email" TextMode="Email"></asp:TextBox>
                            <i class="fas fa-envelope input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <div class="input-wrapper">
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"
                                placeholder="Enter your password" TextMode="Password"></asp:TextBox>
                            <i class="fas fa-lock input-icon"></i>
                            <i class="fas fa-eye password-toggle" onclick="togglePassword()" id="toggleIcon"></i>
                        </div>
                    </div>

                    <asp:Button ID="btnLogin" runat="server" Text="Sign In"
                        CssClass="btn btn-login" OnClick="btnLogin_Click" />

                    <div class="divider">
                        <span>New User?</span>
                    </div>

                    <div class="register-section">
                        <p>
                            Don't have an account? 
                            <a href="Register.aspx" class="register-link">Create Account</a>
                        </p>
                    </div>
                </div>
            </div>

            <div class="login-footer">
                &copy; 2025 Expense Management System
            </div>
        </div>
    </form>

    <script>
        function togglePassword() {
            var input = document.getElementById('<%= txtPassword.ClientID %>');
            var icon = document.getElementById('toggleIcon');
            if (input.type === 'password') {
                input.type = 'text';
                icon.className = 'fas fa-eye-slash password-toggle';
            } else {
                input.type = 'password';
                icon.className = 'fas fa-eye password-toggle';
            }
        }
    </script>
</body>
</html>