<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ExpenseApp.Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - Expense Management</title>
    
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
            padding: 20px;
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

        .login-container {
            width: 100%;
            max-width: 440px;
            position: relative;
            z-index: 10;
        }

        .login-card {
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
        .login-card::before {
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

        .login-header {
            background: linear-gradient(135deg, 
                rgba(197, 165, 114, 0.15) 0%, 
                rgba(212, 175, 55, 0.1) 100%
            );
            padding: 35px 30px;
            text-align: center;
            color: white;
            position: relative;
            overflow: hidden;
            border-bottom: 1px solid rgba(197, 165, 114, 0.2);
        }

        .login-header::after {
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
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, 
                rgba(197, 165, 114, 0.25) 0%, 
                rgba(212, 175, 55, 0.15) 100%
            );
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            border: 2px solid rgba(197, 165, 114, 0.3);
            position: relative;
            z-index: 1;
            box-shadow: 
                0 10px 40px rgba(197, 165, 114, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        .logo-icon::before {
            content: '';
            position: absolute;
            inset: -2px;
            border-radius: 20px;
            background: linear-gradient(45deg, var(--primary-gold), var(--accent-gold));
            z-index: -1;
            opacity: 0;
            transition: opacity 0.4s ease;
        }

        .logo-icon:hover {
            transform: scale(1.1) translateY(-5px);
            box-shadow: 
                0 20px 60px rgba(197, 165, 114, 0.5),
                inset 0 1px 0 rgba(255, 255, 255, 0.2);
        }

        .logo-icon:hover::before {
            opacity: 0.3;
        }

        .logo-icon i {
            font-size: 40px;
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

        .login-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 900;
            margin: 0 0 8px 0;
            text-transform: uppercase;
            letter-spacing: 3px;
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

        .login-header p {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.7);
            position: relative;
            z-index: 1;
            font-weight: 400;
        }

        .login-body {
            padding: 35px 30px;
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

        .alert i {
            margin-right: 8px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            color: rgba(255, 255, 255, 0.9);
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 8px;
            display: block;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-gold);
            font-size: 18px;
            pointer-events: none;
            z-index: 2;
            transition: all 0.3s ease;
        }

        .form-control {
            height: 54px;
            padding-left: 50px;
            padding-right: 50px;
            border: 2px solid rgba(197, 165, 114, 0.3);
            border-radius: 14px;
            font-size: 15px;
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

        .form-control:focus {
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

        .password-toggle {
            position: absolute;
            right: 18px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: rgba(255, 255, 255, 0.5);
            font-size: 18px;
            z-index: 3;
            transition: all 0.3s ease;
        }

        .password-toggle:hover {
            color: var(--primary-gold);
            transform: translateY(-50%) scale(1.15);
        }

        .btn-login {
            height: 54px;
            border-radius: 14px;
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

        .btn-login::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, var(--accent-gold) 0%, var(--primary-gold) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 0;
        }

        .btn-login::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.4);
            transform: translate(-50%, -50%);
            transition: width 0.6s ease, height 0.6s ease;
            z-index: 0;
        }

        .btn-login span {
            position: relative;
            z-index: 1;
        }

        .btn-login:hover {
            transform: translateY(-4px) scale(1.02);
            box-shadow: 
                0 12px 40px rgba(197, 165, 114, 0.6),
                inset 0 1px 0 rgba(255, 255, 255, 0.4);
        }

        .btn-login:hover::before {
            opacity: 1;
        }

        .btn-login:active::after {
            width: 300px;
            height: 300px;
            transition: width 0s, height 0s;
        }

        .btn-login:disabled {
            opacity: 0.5;
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
            padding: 0 16px;
            color: rgba(255, 255, 255, 0.6);
            font-size: 12px;
            position: relative;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .register-section {
            text-align: center;
            padding-top: 22px;
            border-top: 1px solid rgba(197, 165, 114, 0.2);
        }

        .register-section p {
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
            margin: 0;
            font-weight: 500;
        }

        .register-link {
            color: var(--primary-gold);
            font-weight: 700;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
        }

        .register-link::before {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--primary-gold), var(--accent-gold));
            transition: width 0.3s ease;
        }

        .register-link:hover {
            color: var(--accent-gold);
            text-shadow: 0 0 10px rgba(197, 165, 114, 0.5);
        }

        .register-link:hover::before {
            width: 100%;
        }

        .login-footer {
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
                padding: 15px;
            }

            .login-header {
                padding: 28px 25px;
            }

            .login-body {
                padding: 28px 25px;
            }

            .login-header h1 {
                font-size: 24px;
                letter-spacing: 2px;
            }

            .logo-icon {
                width: 70px;
                height: 70px;
            }

            .logo-icon i {
                font-size: 34px;
            }

            .form-control,
            .btn-login {
                height: 50px;
            }
        }

        @media (max-height: 700px) {
            .login-header {
                padding: 22px 25px;
            }

            .logo-icon {
                width: 60px;
                height: 60px;
                margin-bottom: 10px;
            }

            .logo-icon i {
                font-size: 30px;
            }

            .login-header h1 {
                font-size: 22px;
                margin-bottom: 5px;
            }

            .login-body {
                padding: 25px;
            }

            .form-group {
                margin-bottom: 16px;
            }

            .form-control,
            .btn-login {
                height: 48px;
            }
        }

        /* Performance optimizations */
        .login-card,
        .logo-icon,
        .form-control,
        .btn-login {
            will-change: transform;
        }

        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
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
        <div class="login-container">
            <div class="login-card">
                <div class="login-header">
                    <div class="logo-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h1>Expense Pro</h1>
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
    </script>
</body>
</html>