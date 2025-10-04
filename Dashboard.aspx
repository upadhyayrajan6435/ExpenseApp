<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ExpenseApp.Dashboard" %>

<!DOCTYPE html>
<html>
<%--<head runat="server">
    <title>Dashboard - Expense Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet" />
    <style>
        :root {
            --primary-gold: #C5A572;
            --accent-gold: #D4AF37;
            --dark-primary: #2C2C2C;
            --dark-secondary: #3A3A3A;
            --light-bg: #F5F5F5;
            --card-bg: #FFFFFF;
            --text-primary: #1A1A1A;
            --text-secondary: #6B6B6B;
            --border-light: #E0E0E0;
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.08);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.12);
            --shadow-lg: 0 8px 24px rgba(0, 0, 0, 0.15);
            --shadow-gold: 0 4px 20px rgba(197, 165, 114, 0.3);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #F8F9FA 0%, #E9ECEF 100%);
            font-family: 'Inter', sans-serif;
            color: var(--text-primary);
            min-height: 100vh;
        }

        /* Navigation */
        .navbar {
            background: linear-gradient(135deg, var(--dark-primary) 0%, var(--dark-secondary) 100%) !important;
            border-bottom: 3px solid var(--primary-gold);
            box-shadow: var(--shadow-lg);
            padding: 1.2rem 2rem;
        }

        .navbar-brand {
            font-family: 'Playfair Display', serif;
            font-weight: 900;
            font-size: 1.6rem;
            color: var(--card-bg) !important;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

            .navbar-brand i {
                color: var(--primary-gold);
                font-size: 1.8rem;
            }

        .navbar .welcome-text {
            color: #FFFFFF !important;
            font-weight: 400;
            font-size: 0.95rem;
        }

            .navbar .welcome-text strong {
                color: var(--primary-gold);
                font-weight: 600;
            }

        .btn-outline-light {
            border: 2px solid var(--primary-gold);
            color: var(--primary-gold);
            font-weight: 600;
            padding: 8px 24px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

            .btn-outline-light:hover {
                background: var(--primary-gold);
                color: var(--dark-primary);
                transform: translateY(-2px);
                box-shadow: var(--shadow-gold);
            }

        /* Alert Info */
        .alert-info {
            background: var(--card-bg);
            border: 2px solid var(--primary-gold);
            border-left: 6px solid var(--primary-gold);
            color: var(--text-primary);
            border-radius: 12px;
            box-shadow: var(--shadow-md);
            padding: 20px 25px;
        }

            .alert-info i {
                color: var(--primary-gold);
                font-size: 1.2rem;
                margin-right: 8px;
            }

            .alert-info strong {
                color: var(--dark-primary);
                font-weight: 600;
            }

        /* Stat Cards */
        .stat-card {
            background: var(--card-bg);
            border: 2px solid var(--border-light);
            border-radius: 16px;
            padding: 0;
            margin-bottom: 25px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            position: relative;
        }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 5px;
                background: linear-gradient(90deg, var(--primary-gold), var(--accent-gold));
                transform: scaleX(0);
                transition: transform 0.3s ease;
            }

            .stat-card:hover::before {
                transform: scaleX(1);
            }

            .stat-card:hover {
                transform: translateY(-8px);
                border-color: var(--primary-gold);
                box-shadow: var(--shadow-gold);
            }

            .stat-card .card-body {
                padding: 30px 25px;
                position: relative;
            }

            .stat-card .stat-icon {
                position: absolute;
                right: 25px;
                top: 50%;
                transform: translateY(-50%);
                font-size: 3.5rem;
                color: var(--primary-gold);
                opacity: 0.12;
            }

            .stat-card h5 {
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                color: var(--text-secondary);
                margin-bottom: 12px;
                font-weight: 600;
            }

            .stat-card h2 {
                font-family: 'Playfair Display', serif;
                font-size: 2.8rem;
                font-weight: 900;
                margin: 0;
                color: var(--dark-primary);
                position: relative;
                z-index: 1;
            }

            .stat-card.gold-accent h2 {
                background: linear-gradient(135deg, var(--primary-gold), var(--accent-gold));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

        /* Action Buttons - UPDATED */
        .action-btn {
            background: var(--card-bg);
            border: 2px solid var(--border-light);
            color: var(--text-primary);
            padding: 35px 20px;
            border-radius: 16px;
            font-size: 1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
        }

            .action-btn i {
                font-size: 2.8rem;
                margin-bottom: 15px;
                color: var(--primary-gold);
                transition: all 0.3s ease;
                position: relative;
                z-index: 2; /* ADDED */
            }

            .action-btn::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                height: 0;
                background: linear-gradient(135deg, var(--primary-gold), var(--accent-gold));
                transition: height 0.4s ease;
                z-index: 1; /* CHANGED from 0 to 1 */
            }

            .action-btn:hover::after {
                height: 100%;
            }

            .action-btn:hover {
                color: #FFFFFF;
                border-color: var(--primary-gold);
                transform: translateY(-5px);
                box-shadow: var(--shadow-gold);
            }

                .action-btn:hover i {
                    color: #FFFFFF;
                    transform: scale(1.15);
                }

            .action-btn span {
                position: relative;
                z-index: 2; /* CHANGED from 1 to 2 */
            }
        /* Card Styling */
        .card {
            background: var(--card-bg);
            border: 2px solid var(--border-light);
            border-radius: 16px;
            box-shadow: var(--shadow-md);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .card-header {
            background: linear-gradient(135deg, var(--dark-primary) 0%, var(--dark-secondary) 100%);
            border-bottom: 3px solid var(--primary-gold);
            padding: 20px 30px;
        }

            .card-header h5 {
                font-family: 'Playfair Display', serif;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: #FFFFFF;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 12px;
            }

                .card-header h5 i {
                    color: var(--primary-gold);
                    font-size: 1.3rem;
                }

        .card-body {
            padding: 30px;
        }

        /* Table Styling */
        .table {
            color: var(--text-primary);
            margin-bottom: 0;
        }

            .table thead th {
                border-bottom: 2px solid var(--primary-gold);
                color: var(--dark-primary);
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1px;
                font-size: 0.8rem;
                padding: 18px 15px;
                background: #F8F9FA;
            }

            .table tbody tr {
                border-bottom: 1px solid var(--border-light);
                transition: all 0.2s ease;
            }

                .table tbody tr:hover {
                    background: linear-gradient(90deg, rgba(197, 165, 114, 0.08), transparent);
                    transform: translateX(5px);
                }

            .table tbody td {
                padding: 18px 15px;
                vertical-align: middle;
                font-weight: 500;
            }

        /* Badges */
        .badge {
            padding: 8px 18px;
            font-size: 0.8rem;
            font-weight: 700;
            border-radius: 20px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-pending {
            background: linear-gradient(135deg, #FFA726, #FB8C00);
            color: #FFFFFF;
            box-shadow: 0 2px 8px rgba(251, 140, 0, 0.3);
        }

        .badge-approved {
            background: linear-gradient(135deg, #66BB6A, #43A047);
            color: #FFFFFF;
            box-shadow: 0 2px 8px rgba(67, 160, 71, 0.3);
        }

        .badge-rejected {
            background: linear-gradient(135deg, #EF5350, #E53935);
            color: #FFFFFF;
            box-shadow: 0 2px 8px rgba(229, 57, 53, 0.3);
        }

        /* Section Headers */
        .section-title {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            font-size: 1.8rem;
            color: var(--dark-primary);
            margin-bottom: 25px;
            position: relative;
            padding-left: 20px;
        }

            .section-title::before {
                content: '';
                position: absolute;
                left: 0;
                top: 50%;
                transform: translateY(-50%);
                width: 5px;
                height: 70%;
                background: linear-gradient(180deg, var(--primary-gold), var(--accent-gold));
                border-radius: 10px;
            }

        /* Responsive */
        @media (max-width: 768px) {
            .stat-card h2 {
                font-size: 2rem;
            }

            .action-btn {
                padding: 25px 15px;
                font-size: 0.85rem;
            }

                .action-btn i {
                    font-size: 2rem;
                }

            .navbar {
                padding: 1rem;
            }

            .navbar-brand {
                font-size: 1.2rem;
            }
        }

        /* Loading Animation */
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .stat-card,
        .action-btn,
        .card {
            animation: slideIn 0.5s ease-out forwards;
        }

            .stat-card:nth-child(1) {
                animation-delay: 0.1s;
            }

            .stat-card:nth-child(2) {
                animation-delay: 0.2s;
            }

            .stat-card:nth-child(3) {
                animation-delay: 0.3s;
            }

            .stat-card:nth-child(4) {
                animation-delay: 0.4s;
            }
    </style>
</head>--%>
    <head runat="server">
    <title>Your Page Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="~/ExpenseApp.css" rel="stylesheet" />
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
                <div class="ml-auto d-flex align-items-center">
                    <span class="welcome-text mr-4">
                        <i class="fas fa-user-circle"></i>
                        Welcome, <strong>
                            <asp:Label ID="lblUser" runat="server"></asp:Label></strong>
                    </span>
                    <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-outline-light btn-sm" OnClick="btnLogout_Click">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </asp:LinkButton>
                </div>
            </div>
        </nav>

        <div class="container-fluid mt-4 px-4">
            <!-- User Info -->
            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i>
                <strong>Role:</strong>
                <asp:Label ID="lblRole" runat="server"></asp:Label>
                <span class="mx-2">|</span>
                <strong>Company:</strong>
                <asp:Label ID="lblCompany" runat="server"></asp:Label>
                <span class="mx-2">|</span>
                <strong>Currency:</strong>
                <asp:Label ID="lblCurrency" runat="server"></asp:Label>
            </div>

            <!-- Quick Actions -->
            <h3 class="section-title mt-4">Quick Actions</h3>
            <div class="row mb-4">
                <div class="col-lg-3 col-md-6 mb-3">
                    <asp:LinkButton ID="btnNewExpense" runat="server" CssClass="btn btn-block action-btn" OnClick="btnNewExpense_Click">
                        <i class="fas fa-plus-circle"></i>
                        <span>New Expense</span>
                    </asp:LinkButton>
                </div>
                <asp:PlaceHolder ID="phManager" runat="server" Visible="false">
                    <div class="col-lg-3 col-md-6 mb-3">
                        <asp:LinkButton ID="btnApprovals" runat="server" CssClass="btn btn-block action-btn" OnClick="btnApprovals_Click">
                            <i class="fas fa-tasks"></i>
                            <span>Approvals</span>
                        </asp:LinkButton>
                    </div>
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="phAdmin" runat="server" Visible="false">
                    <div class="col-lg-3 col-md-6 mb-3">
                        <asp:LinkButton ID="btnUsers" runat="server" CssClass="btn btn-block action-btn" OnClick="btnUsers_Click">
                            <i class="fas fa-users-cog"></i>
                            <span>Manage Users</span>
                        </asp:LinkButton>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-3">
                        <asp:LinkButton ID="btnSettings" runat="server" CssClass="btn btn-block action-btn" OnClick="btnSettings_Click">
                            <i class="fas fa-sliders-h"></i>
                            <span>Settings</span>
                        </asp:LinkButton>
                    </div>
                </asp:PlaceHolder>
            </div>

            <!-- Statistics -->
            <h3 class="section-title">Overview</h3>
            <div class="row">
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stat-card">
                        <div class="card-body text-center">
                            <i class="fas fa-file-invoice stat-icon"></i>
                            <h5>Total Expenses</h5>
                            <h2>
                                <asp:Label ID="lblTotal" runat="server">0</asp:Label></h2>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stat-card">
                        <div class="card-body text-center">
                            <i class="fas fa-hourglass-half stat-icon"></i>
                            <h5>Pending</h5>
                            <h2>
                                <asp:Label ID="lblPending" runat="server">0</asp:Label></h2>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stat-card">
                        <div class="card-body text-center">
                            <i class="fas fa-check-double stat-icon"></i>
                            <h5>Approved</h5>
                            <h2>
                                <asp:Label ID="lblApproved" runat="server">0</asp:Label></h2>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stat-card gold-accent">
                        <div class="card-body text-center">
                            <i class="fas fa-wallet stat-icon"></i>
                            <h5>Total Amount</h5>
                            <h2>
                                <asp:Label ID="lblCurr" runat="server"></asp:Label>
                                <asp:Label ID="lblAmount" runat="server">0.00</asp:Label>
                            </h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Expenses -->
            <h3 class="section-title mt-4">Recent Expenses</h3>
            <div class="row mb-5">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-history"></i>Transaction History</h5>
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
                                            <strong><%# Eval("OriginalCurrency") %> <%# Eval("Amount", "{0:N2}") %></strong>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Date">
                                        <ItemTemplate>
                                            <i class="far fa-calendar-alt text-muted"></i>
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
