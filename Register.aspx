<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ExpenseApp.Register" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register - Expense Management</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    
    <style>
        :root {
            --primary-gold: #C5A572;
            --accent-gold: #D4AF37;
            --dark-primary: #2C2C2C;
            --dark-secondary: #3A3A3A;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #0a0a0a;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 20px;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated Gradient Background */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background: 
                radial-gradient(circle at 20% 50%, rgba(197, 165, 114, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(212, 175, 55, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 40% 20%, rgba(197, 165, 114, 0.1) 0%, transparent 50%),
                linear-gradient(135deg, #1a1a1a 0%, #0f0f0f 100%);
            animation: gradientShift 15s ease infinite;
            z-index: 0;
        }

        @keyframes gradientShift {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.8; }
        }

        /* Floating Particles */
        .particle {
            position: fixed;
            width: 3px;
            height: 3px;
            background: var(--primary-gold);
            border-radius: 50%;
            box-shadow: 0 0 10px var(--primary-gold);
            animation: rise 8s infinite ease-in;
            opacity: 0;
            z-index: 1;
        }

        @keyframes rise {
            0% {
                bottom: -10px;
                opacity: 0;
            }
            10%, 90% {
                opacity: 0.6;
            }
            100% {
                bottom: 110%;
                opacity: 0;
                transform: translateX(20px);
            }
        }

        .particle:nth-child(1) { left: 10%; animation-delay: 0s; }
        .particle:nth-child(2) { left: 25%; animation-delay: 1.5s; }
        .particle:nth-child(3) { left: 40%; animation-delay: 3s; }
        .particle:nth-child(4) { left: 55%; animation-delay: 4.5s; }
        .particle:nth-child(5) { left: 70%; animation-delay: 6s; }
        .particle:nth-child(6) { left: 85%; animation-delay: 2s; }

        /* Grid Lines */
        .grid {
            position: fixed;
            inset: 0;
            background-image: 
                linear-gradient(rgba(197, 165, 114, 0.02) 1px, transparent 1px),
                linear-gradient(90deg, rgba(197, 165, 114, 0.02) 1px, transparent 1px);
            background-size: 60px 60px;
            animation: gridMove 20s linear infinite;
            opacity: 0.5;
            z-index: 1;
            pointer-events: none;
        }

        @keyframes gridMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(60px, 60px); }
        }

        .register-container {
            width: 100%;
            max-width: 550px;
            position: relative;
            z-index: 10;
        }

        .register-card {
            background: rgba(26, 26, 26, 0.95);
            backdrop-filter: blur(30px) saturate(180%);
            border-radius: 24px;
            box-shadow: 
                0 8px 32px rgba(0, 0, 0, 0.5),
                0 0 80px rgba(197, 165, 114, 0.15),
                inset 0 1px 0 rgba(255, 255, 255, 0.05);
            overflow: hidden;
            border: 1px solid rgba(197, 165, 114, 0.15);
            animation: cardEntrance 0.8s cubic-bezier(0.34, 1.56, 0.64, 1);
            transform-style: preserve-3d;
        }

        @keyframes cardEntrance {
            0% {
                opacity: 0;
                transform: translateY(50px) scale(0.9) rotateX(10deg);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1) rotateX(0);
            }
        }

        /* Glowing Top Border */
        .register-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -50%;
            width: 200%;
            height: 3px;
            background: linear-gradient(
                90deg,
                transparent,
                var(--primary-gold),
                var(--accent-gold),
                var(--primary-gold),
                transparent
            );
            animation: borderGlow 3s linear infinite;
            z-index: 1;
        }

        @keyframes borderGlow {
            0% { transform: translateX(-50%); }
            100% { transform: translateX(50%); }
        }

        .register-header {
            background: linear-gradient(135deg, 
                rgba(197, 165, 114, 0.15) 0%, 
                rgba(212, 175, 55, 0.1) 100%
            );
            padding: 30px 30px;
            text-align: center;
            color: white;
            position: relative;
            overflow: hidden;
            border-bottom: 1px solid rgba(197, 165, 114, 0.2);
        }

        .register-header::after {
            content: '';
            position: absolute;
            inset: 0;
            background: 
                radial-gradient(circle at 30% 50%, rgba(197, 165, 114, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 70% 50%, rgba(212, 175, 55, 0.1) 0%, transparent 50%);
            animation: headerPulse 4s ease-in-out infinite;
            z-index: 0;
        }

        @keyframes headerPulse {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        .logo-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, 
                rgba(197, 165, 114, 0.25) 0%, 
                rgba(212, 175, 55, 0.15) 100%
            );
            border-radius: 16px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px;
            border: 2px solid rgba(197, 165, 114, 0.3);
            position: relative;
            z-index: 1;
            box-shadow: 
                0 10px 40px rgba(197, 165, 114, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        .logo-icon:hover {
            transform: scale(1.1) translateY(-5px);
            box-shadow: 
                0 20px 60px rgba(197, 165, 114, 0.5),
                inset 0 1px 0 rgba(255, 255, 255, 0.2);
        }

        .logo-icon i {
            font-size: 32px;
            background: linear-gradient(135deg, var(--primary-gold) 0%, var(--accent-gold) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            filter: drop-shadow(0 0 20px rgba(197, 165, 114, 0.5));
            animation: iconGlow 2s ease-in-out infinite;
        }

        @keyframes iconGlow {
            0%, 100% { filter: drop-shadow(0 0 10px rgba(197, 165, 114, 0.5)); }
            50% { filter: drop-shadow(0 0 25px rgba(197, 165, 114, 0.8)); }
        }

        .register-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 26px;
            font-weight: 900;
            margin: 0 0 6px 0;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
            z-index: 1;
            background: linear-gradient(135deg, #fff 0%, var(--primary-gold) 50%, var(--accent-gold) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: textShine 3s ease-in-out infinite;
        }

        @keyframes textShine {
            0%, 100% { filter: brightness(1); }
            50% { filter: brightness(1.3); }
        }

        .register-header p {
            font-size: 13px;
            color: rgba(255, 255, 255, 0.7);
            position: relative;
            z-index: 1;
            font-weight: 400;
        }

        .register-body {
            padding: 30px;
            background: rgba(0, 0, 0, 0.3);
        }

        .alert {
            border-radius: 12px;
            border: none;
            padding: 12px 16px;
            margin-bottom: 20px;
            font-size: 13px;
            border-left: 4px solid;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            animation: alertSlide 0.4s ease-out;
        }

        @keyframes alertSlide {
            0% {
                opacity: 0;
                transform: translateX(-20px);
            }
            100% {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .alert-danger {
            background: rgba(255, 50, 50, 0.15);
            color: #ff6b6b;
            border-left-color: #ff6b6b;
            backdrop-filter: blur(10px);
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.15);
            color: #10b981;
            border-left-color: #10b981;
            backdrop-filter: blur(10px);
        }

        .alert i {
            margin-right: 8px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-label {
            color: rgba(255, 255, 255, 0.9);
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 8px;
            display: block;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-label i {
            margin-right: 5px;
            color: var(--primary-gold);
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-gold);
            font-size: 16px;
            pointer-events: none;
            z-index: 2;
            transition: all 0.3s ease;
        }

        .form-control, .form-select {
            height: 50px;
            padding-left: 45px;
            padding-right: 45px;
            border: 2px solid rgba(197, 165, 114, 0.3);
            border-radius: 12px;
            font-size: 14px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: rgba(30, 30, 30, 0.8);
            backdrop-filter: blur(10px);
            font-weight: 500;
            color: #ffffff;
            width: 100%;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }

        .form-control:focus, .form-select:focus {
            background: rgba(40, 40, 40, 0.9);
            border-color: var(--primary-gold);
            box-shadow: 
                0 0 0 4px rgba(197, 165, 114, 0.15),
                0 8px 24px rgba(197, 165, 114, 0.2);
            outline: none;
            transform: translateY(-2px);
            color: #ffffff;
        }

        .form-control:focus + .input-icon {
            color: var(--accent-gold);
            transform: translateY(-50%) scale(1.1);
            filter: drop-shadow(0 0 8px var(--accent-gold));
        }

        .form-select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23C5A572' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            padding-right: 40px;
            cursor: pointer;
        }

        .form-select option {
            background: #1a1a1a;
            color: #ffffff;
        }

        .password-toggle {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: rgba(255, 255, 255, 0.5);
            font-size: 16px;
            z-index: 3;
            transition: all 0.3s ease;
        }

        .password-toggle:hover {
            color: var(--primary-gold);
            transform: translateY(-50%) scale(1.15);
        }

        .password-strength {
            height: 4px;
            background: rgba(255, 255, 255, 0.1);
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
            font-size: 11px;
            color: rgba(255, 255, 255, 0.6);
            margin-top: 6px;
        }

        .btn-register {
            height: 52px;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary-gold) 0%, var(--accent-gold) 100%);
            border: none;
            color: var(--dark-primary);
            width: 100%;
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            margin-top: 12px;
            text-transform: uppercase;
            letter-spacing: 2px;
            box-shadow: 
                0 8px 24px rgba(197, 165, 114, 0.4),
                inset 0 1px 0 rgba(255, 255, 255, 0.3);
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }

        .btn-register::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, var(--accent-gold) 0%, var(--primary-gold) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 0;
        }

        .btn-register:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 
                0 12px 40px rgba(197, 165, 114, 0.6),
                inset 0 1px 0 rgba(255, 255, 255, 0.4);
        }

        .btn-register:hover::before {
            opacity: 1;
        }

        .btn-register:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        .divider {
            text-align: center;
            margin: 20px 0;
            position: relative;
        }

        .divider::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(197, 165, 114, 0.3),
                transparent
            );
        }

        .divider span {
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            padding: 0 14px;
            color: rgba(255, 255, 255, 0.6);
            font-size: 12px;
            position: relative;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .login-section {
            text-align: center;
            padding-top: 18px;
            border-top: 1px solid rgba(197, 165, 114, 0.2);
        }

        .login-section p {
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
            margin: 0;
            font-weight: 500;
        }

        .login-link {
            color: var(--primary-gold);
            font-weight: 700;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
        }

        .login-link::before {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--primary-gold), var(--accent-gold));
            transition: width 0.3s ease;
        }

        .login-link:hover {
            color: var(--accent-gold);
            text-shadow: 0 0 10px rgba(197, 165, 114, 0.5);
        }

        .login-link:hover::before {
            width: 100%;
        }

        .register-footer {
            text-align: center;
            margin-top: 20px;
            color: rgba(255, 255, 255, 0.7);
            font-size: 13px;
            font-weight: 500;
            padding: 14px;
            background: rgba(197, 165, 114, 0.1);
            border-radius: 12px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(197, 165, 114, 0.2);
            position: relative;
            z-index: 10;
        }

        @media (max-width: 576px) {
            body {
                padding: 20px 15px;
            }

            .register-header {
                padding: 25px 25px;
            }

            .register-body {
                padding: 25px;
            }

            .register-header h1 {
                font-size: 22px;
                letter-spacing: 1.5px;
            }

            .logo-icon {
                width: 60px;
                height: 60px;
            }

            .logo-icon i {
                font-size: 28px;
            }

            .form-control, 
            .form-select,
            .btn-register {
                height: 48px;
            }

            .form-group {
                margin-bottom: 16px;
            }
        }

        @media (max-height: 800px) {
            .register-header {
                padding: 22px 25px;
            }

            .logo-icon {
                width: 60px;
                height: 60px;
                margin-bottom: 10px;
            }

            .logo-icon i {
                font-size: 28px;
            }

            .register-header h1 {
                font-size: 22px;
                margin-bottom: 4px;
            }

            .register-body {
                padding: 25px;
            }

            .form-group {
                margin-bottom: 14px;
            }

            .form-control,
            .form-select,
            .btn-register {
                height: 46px;
            }
        }
    </style>
</head>
<body>
    <!-- Background Effects -->
    <div class="grid"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>

    <form id="form1" runat="server">
        <div class="register-container">
            <div class="register-card">
                <div class="register-header">
                    <div class="logo-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <h1>Create Account</h1>
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
                <i class="fas fa-shield-alt" style="color: var(--primary-gold); margin-right: 6px;"></i>
                &copy; 2025 Expense Pro
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
                strengthText.style.color = 'rgba(255, 255, 255, 0.6)';
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