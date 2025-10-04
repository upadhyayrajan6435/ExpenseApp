<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ExpenseApp.Register" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register - Expense Management</title>
    
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
            padding: 30px 20px;
        }

        .register-container {
            width: 100%;
            max-width: 550px;
        }

        .register-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .register-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 30px;
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

        .register-header h1 {
            font-size: 26px;
            font-weight: 600;
            margin: 0 0 8px 0;
        }

        .register-header p {
            font-size: 14px;
            opacity: 0.95;
            margin: 0;
        }

        .register-body {
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

        .alert-success {
            background: #efe;
            color: #2a2;
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

        .form-label i {
            margin-right: 5px;
            color: #667eea;
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
            z-index: 2;
        }

        .form-control, .form-select {
            height: 50px;
            padding-left: 45px;
            padding-right: 15px;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 14px;
            transition: all 0.2s;
            background: #f9fafb;
        }

        .form-control:focus, .form-select:focus {
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
            z-index: 2;
        }

        .password-toggle:hover {
            color: #667eea;
        }

        .password-strength {
            height: 4px;
            background: #e5e7eb;
            border-radius: 2px;
            margin-top: 8px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: all 0.3s;
            border-radius: 2px;
        }

        .strength-weak { width: 33%; background: #ef4444; }
        .strength-medium { width: 66%; background: #f59e0b; }
        .strength-strong { width: 100%; background: #10b981; }

        .password-hint {
            font-size: 12px;
            color: #6b7280;
            margin-top: 5px;
        }

        .btn-register {
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

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-register:disabled {
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

        .login-section {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
        }

        .login-section p {
            color: #6b7280;
            font-size: 14px;
            margin: 0;
        }

        .login-link {
            color: #667eea;
            font-weight: 600;
            text-decoration: none;
        }

        .login-link:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .register-footer {
            text-align: center;
            margin-top: 20px;
            color: white;
            font-size: 13px;
        }

        .feature-list {
            background: #f9fafb;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }

        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            font-size: 13px;
            color: #6b7280;
        }

        .feature-item:last-child {
            margin-bottom: 0;
        }

        .feature-item i {
            color: #10b981;
            margin-right: 10px;
            font-size: 14px;
        }

        @media (max-width: 576px) {
            body {
                padding: 20px 15px;
            }
            .register-header {
                padding: 30px 20px;
            }
            .register-body {
                padding: 25px 20px;
            }
            .register-header h1 {
                font-size: 22px;
            }
            .form-control, .form-select {
                height: 48px;
                font-size: 14px;
            }
            .btn-register {
                height: 48px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-container">
            <div class="register-card">
                <div class="register-header">
                    <div class="logo-icon">
                        <i class="fas fa-building"></i>
                    </div>
                    <h1>Create Your Account</h1>
                    <p>Start managing expenses efficiently</p>
                </div>

                <div class="register-body">
                    <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i>
                        <asp:Label ID="lblError" runat="server"></asp:Label>
                    </asp:Panel>

                    <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <asp:Label ID="lblSuccess" runat="server"></asp:Label>
                    </asp:Panel>

                   
                    <!-- Full Name -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-user"></i> Full Name
                        </label>
                        <div class="input-wrapper">
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"
                                placeholder="Enter your full name"></asp:TextBox>
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-envelope"></i> Email Address
                        </label>
                        <div class="input-wrapper">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                                placeholder="Enter your email" TextMode="Email"></asp:TextBox>
                            <i class="fas fa-envelope input-icon"></i>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-lock"></i> Password
                        </label>
                        <div class="input-wrapper">
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"
                                placeholder="Create a strong password" TextMode="Password"
                                onkeyup="checkPasswordStrength(this.value)"></asp:TextBox>
                            <i class="fas fa-lock input-icon"></i>
                            <i class="fas fa-eye password-toggle" onclick="togglePassword()" id="toggleIcon"></i>
                        </div>
                        <div class="password-strength">
                            <div class="password-strength-bar" id="strengthBar"></div>
                        </div>
                        <div class="password-hint" id="strengthText">
                            Use 8+ characters with mix of letters, numbers & symbols
                        </div>
                    </div>

                    <!-- Country & Currency -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-globe"></i> Country & Currency
                        </label>
                        <div class="input-wrapper">
                            <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-select">
                                <asp:ListItem Value="">Select your country</asp:ListItem>
                                <asp:ListItem Value="United States|USD">🇺🇸 United States (USD)</asp:ListItem>
                                <asp:ListItem Value="India|INR">🇮🇳 India (INR)</asp:ListItem>
                                <asp:ListItem Value="United Kingdom|GBP">🇬🇧 United Kingdom (GBP)</asp:ListItem>
                                <asp:ListItem Value="Canada|CAD">🇨🇦 Canada (CAD)</asp:ListItem>
                                <asp:ListItem Value="Australia|AUD">🇦🇺 Australia (AUD)</asp:ListItem>
                                <asp:ListItem Value="Germany|EUR">🇩🇪 Germany (EUR)</asp:ListItem>
                                <asp:ListItem Value="France|EUR">🇫🇷 France (EUR)</asp:ListItem>
                                <asp:ListItem Value="Japan|JPY">🇯🇵 Japan (JPY)</asp:ListItem>
                                <asp:ListItem Value="Singapore|SGD">🇸🇬 Singapore (SGD)</asp:ListItem>
                            </asp:DropDownList>
                            <i class="fas fa-globe input-icon"></i>
                        </div>
                    </div>

                    <!-- Register Button -->
                    <asp:Button ID="btnRegister" runat="server" Text="Create Account"
                        CssClass="btn btn-register" OnClick="btnRegister_Click" />

                    <!-- Login Link -->
                    <div class="divider">
                        <span>Already have an account?</span>
                    </div>

                    <div class="login-section">
                        <p>
                            <a href="Login.aspx" class="login-link">Sign in to your account</a>
                        </p>
                    </div>
                </div>
            </div>

            <div class="register-footer">
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

        function checkPasswordStrength(password) {
            var strengthBar = document.getElementById('strengthBar');
            var strengthText = document.getElementById('strengthText');
            
            var strength = 0;
            if (password.length >= 8) strength++;
            if (password.match(/[a-z]+/)) strength++;
            if (password.match(/[A-Z]+/)) strength++;
            if (password.match(/[0-9]+/)) strength++;
            if (password.match(/[$@#&!]+/)) strength++;

            strengthBar.className = 'password-strength-bar';
            
            if (strength === 0) {
                strengthBar.className = 'password-strength-bar';
                strengthText.textContent = 'Use 8+ characters with mix of letters, numbers & symbols';
                strengthText.style.color = '#6b7280';
            } else if (strength <= 2) {
                strengthBar.className = 'password-strength-bar strength-weak';
                strengthText.textContent = 'Weak password - Add more characters';
                strengthText.style.color = '#ef4444';
            } else if (strength <= 4) {
                strengthBar.className = 'password-strength-bar strength-medium';
                strengthText.textContent = 'Medium strength - Add special characters';
                strengthText.style.color = '#f59e0b';
            } else {
                strengthBar.className = 'password-strength-bar strength-strong';
                strengthText.textContent = 'Strong password ✓';
                strengthText.style.color = '#10b981';
            }
        }
    </script>
</body>
</html>