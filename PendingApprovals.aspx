<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PendingApprovals.aspx.cs" Inherits="ExpenseApp.PendingApprovals" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pending Approvals - Expense Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="~/ExpenseApp.css" rel="stylesheet" />
    <style>
        .expense-item {
            padding: 25px;
            border-bottom: 2px solid var(--border-light);
            transition: background-color 0.3s ease;
        }

        .expense-item:hover {
            background-color: rgba(197, 165, 114, 0.05);
        }

        .expense-item:last-child {
            border-bottom: none;
        }

        .workflow-badge {
            font-size: 0.75rem;
            padding: 5px 12px;
            margin-left: 10px;
            background: linear-gradient(135deg, var(--primary-gold), #d4af37);
            color: var(--dark-bg);
            border-radius: 20px;
            font-weight: 600;
        }

        .approval-progress {
            margin-top: 15px;
            padding: 12px;
            background-color: rgba(197, 165, 114, 0.1);
            border-radius: 8px;
            border-left: 3px solid var(--primary-gold);
        }

        .progress {
            height: 8px;
            border-radius: 10px;
            background-color: #e0e0e0;
            margin-top: 8px;
        }

        .progress-bar {
            background: linear-gradient(90deg, var(--primary-gold), #d4af37);
            border-radius: 10px;
            transition: width 0.6s ease;
        }

        .expense-item h5 {
            color: var(--text-primary);
            font-weight: 600;
            margin-bottom: 15px;
        }

        .expense-item p {
            color: var(--text-secondary);
            font-size: 0.9rem;
            margin-bottom: 8px;
        }

        .expense-item p i {
            color: var(--primary-gold);
            margin-right: 5px;
            width: 16px;
        }

        .comment-section {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid var(--border-light);
        }

        .comment-section label {
            font-weight: 400;
            color: var(--text-primary);
            margin-bottom: 8px;
            font-size: 0.9rem;
        }

        .comment-section label i {
            color: var(--primary-gold);
            margin-right: 6px;
        }

        .action-buttons {
            margin-top: 15px;
        }

        /* Professional Approve Button */
        .btn-approve {
            background: linear-gradient(135deg, #10B981 0%, #059669 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            font-weight: 600;
            font-size: 0.95rem;
            border-radius: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(16, 185, 129, 0.2);
            position: relative;
            overflow: hidden;
            display: inline-block;
            text-decoration: none;
        }

        .btn-approve::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .btn-approve:hover::before {
            left: 100%;
        }

        .btn-approve:hover {
            background: linear-gradient(135deg, #059669 0%, #047857 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.4);
            color: white;
            text-decoration: none;
        }

        .btn-approve:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(16, 185, 129, 0.3);
        }

        /* Professional Reject Button */
        .btn-reject {
            background: linear-gradient(135deg, #EF4444 0%, #DC2626 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            font-weight: 600;
            font-size: 0.95rem;
            border-radius: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(239, 68, 68, 0.2);
            position: relative;
            overflow: hidden;
            display: inline-block;
            text-decoration: none;
        }

        .btn-reject::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .btn-reject:hover::before {
            left: 100%;
        }

        .btn-reject:hover {
            background: linear-gradient(135deg, #DC2626 0%, #B91C1C 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(239, 68, 68, 0.4);
            color: white;
            text-decoration: none;
        }

        .btn-reject:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(239, 68, 68, 0.3);
        }

        /* Button Icons */
        .btn-approve i,
        .btn-reject i {
            margin-right: 8px;
            font-size: 1.1rem;
        }

        .no-approvals {
            padding: 80px 20px;
            text-align: center;
        }

        .no-approvals i {
            font-size: 4rem;
            color: var(--primary-gold);
            opacity: 0.3;
            margin-bottom: 20px;
        }

        .no-approvals h5 {
            color: var(--text-primary);
            margin-bottom: 10px;
        }

        .no-approvals p {
            color: var(--text-secondary);
        }

        @media (max-width: 768px) {
            .expense-item {
                padding: 20px 15px;
            }
            
            .action-buttons {
                text-align: center !important;
            }

            .btn-approve, .btn-reject {
                width: 100%;
                margin-bottom: 10px;
                margin-left: 0 !important;
            }

            .workflow-badge {
                display: block;
                margin: 10px 0;
                width: fit-content;
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
            <!-- Page Title -->
            <h3 class="section-title">Pending Approvals</h3>

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

            <!-- Expenses Card -->
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-clipboard-check"></i> Expenses Awaiting Your Approval</h5>
                </div>
                <div class="card-body p-0">
                    <asp:Repeater ID="rptExpenses" runat="server" OnItemCommand="rptExpenses_ItemCommand">
                        <ItemTemplate>
                            <div class="expense-item">
                                <div class="row">
                                    <!-- Expense Details -->
                                    <div class="col-lg-7 col-md-12 mb-3 mb-lg-0">
                                        <h5>
                                            <%# Eval("Description") %>
                                            <span class="workflow-badge">
                                                <i class="fas fa-layer-group"></i> Step <%# Eval("StepOrder") %>: <%# Eval("StepName") %>
                                            </span>
                                        </h5>
                                        
                                        <div class="row">
                                            <div class="col-md-6">
                                                <p>
                                                    <i class="fas fa-user"></i>
                                                    <strong>Employee:</strong> <%# Eval("EmployeeName") %>
                                                </p>
                                                <p>
                                                    <i class="fas fa-tag"></i>
                                                    <strong>Category:</strong> <%# Eval("Category") %>
                                                </p>
                                            </div>
                                            <div class="col-md-6">
                                                <p>
                                                    <i class="fas fa-calendar-alt"></i>
                                                    <strong>Date:</strong> <%# Eval("Date", "{0:MMM dd, yyyy}") %>
                                                </p>
                                                <p>
                                                    <i class="fas fa-money-bill-wave"></i>
                                                    <strong>Amount:</strong> <%# Eval("OriginalCurrency") %> <%# Eval("Amount", "{0:N2}") %>
                                                </p>
                                            </div>
                                        </div>

                                        <!-- Approval Progress -->
                                        <div class="approval-progress">
                                            <small>
                                                <i class="fas fa-chart-line"></i>
                                                <strong>Approval Progress:</strong> 
                                                <%# Eval("ApprovedCount") %> of <%# Eval("TotalApprovers") %> approvers have approved
                                            </small>
                                            <div class="progress">
                                                <div class="progress-bar" role="progressbar" 
                                                     style='width: <%# GetProgressPercentage(Eval("ApprovedCount"), Eval("TotalApprovers")) %>%'
                                                     aria-valuenow='<%# GetProgressPercentage(Eval("ApprovedCount"), Eval("TotalApprovers")) %>' 
                                                     aria-valuemin="0" aria-valuemax="100">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Action Section -->
                                    <div class="col-lg-5 col-md-12">
                                        <div class="comment-section">
                                            <label>
                                                <i class="fas fa-comment-dots"></i> Comments (Optional)
                                            </label>
                                            <asp:TextBox ID="txtComment" runat="server" CssClass="form-control" 
                                                placeholder="Add your comments here..." 
                                                TextMode="MultiLine" Rows="3"></asp:TextBox>
                                        </div>
                                        <div class="action-buttons text-right">
                                            <asp:LinkButton ID="btnApprove" runat="server" 
                                                CssClass="btn-approve" 
                                                CommandName="Approve" 
                                                CommandArgument='<%# Eval("ExpenseId") %>'>
                                                <i class="fas fa-check-circle"></i> Approve
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnReject" runat="server" 
                                                CssClass="btn-reject ml-2" 
                                                CommandName="Reject" 
                                                CommandArgument='<%# Eval("ExpenseId") %>' 
                                                OnClientClick="return confirm('Are you sure you want to reject this expense? This action cannot be undone.');">
                                                <i class="fas fa-times-circle"></i> Reject
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <!-- No Data Panel -->
                    <asp:Panel ID="pnlNoData" runat="server" Visible="false" CssClass="no-approvals">
                        <i class="fas fa-clipboard-check"></i>
                        <h5>No Pending Approvals</h5>
                        <p>You're all caught up! There are no expenses awaiting your approval at this time.</p>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </form>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>