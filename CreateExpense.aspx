<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateExpense.aspx.cs" Inherits="ExpenseApp.CreateExpense" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Create Expense - Expense Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="~/ExpenseApp.css" rel="stylesheet" />
    <style>
        /* Force dropdown text visibility */
        select.form-control,
        select.form-control option {
            color: #000000 !important;
            background-color: #FFFFFF !important;
            font-size: 16px !important;
            font-weight: 500 !important;
        }
        
        select.form-control {
            height: 45px !important;
            line-height: 1.5 !important;
            padding: 10px 16px !important;
        }

        /* Label styling - not bold */
        .form-group label {
            font-weight: 400 !important;
        }

        .form-group label i {
            margin-right: 8px;
        }

        /* Validation styles */
        .validation-error {
            color: #dc3545;
            font-size: 0.85rem;
            margin-top: 5px;
            display: block;
        }

        .validation-summary {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            color: #721c24;
        }

        .validation-summary ul {
            margin: 0;
            padding-left: 20px;
        }

        .input-validation-error {
            border-color: #dc3545 !important;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25) !important;
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
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-outline-light btn-sm" 
                        OnClick="btnCancel_Click" CausesValidation="false">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </asp:LinkButton>
                </div>
            </div>
        </nav>

        <div class="container mt-4 mb-5">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <!-- Page Title -->
                    <h3 class="section-title">Create New Expense</h3>

                    <!-- Currency Info Alert -->
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i>
                        <strong>Company Currency:</strong> 
                        <asp:Label ID="lblCurrency" runat="server"></asp:Label>
                    </div>

                    <!-- Validation Summary -->
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                        CssClass="validation-summary" 
                        HeaderText="Please correct the following errors:"
                        DisplayMode="BulletList" />

                    <!-- Success Message -->
                    <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <asp:Label ID="lblSuccess" runat="server"></asp:Label>
                    </asp:Panel>

                    <!-- Error Message -->
                    <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i>
                        <asp:Label ID="lblError" runat="server"></asp:Label>
                    </asp:Panel>

                    <!-- Expense Form Card -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-file-invoice-dollar"></i> Expense Details</h5>
                        </div>
                        <div class="card-body">
                            <!-- Amount & Currency Row -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-dollar-sign text-gold"></i> Amount *
                                        </label>
                                        <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" 
                                            TextMode="Number" step="0.01" placeholder="0.00"></asp:TextBox>
                                        
                                        <asp:RequiredFieldValidator ID="rfvAmount" runat="server" 
                                            ControlToValidate="txtAmount"
                                            ErrorMessage="Amount is required"
                                            Display="Dynamic"
                                            CssClass="validation-error"
                                            SetFocusOnError="true">
                                            <i class="fas fa-exclamation-circle"></i> Amount is required
                                        </asp:RequiredFieldValidator>
                                        
                                        <asp:RangeValidator ID="rvAmount" runat="server" 
                                            ControlToValidate="txtAmount"
                                            Type="Double"
                                            MinimumValue="0.01"
                                            MaximumValue="999999.99"
                                            ErrorMessage="Amount must be between 0.01 and 999,999.99"
                                            Display="Dynamic"
                                            CssClass="validation-error"
                                            SetFocusOnError="true">
                                            <i class="fas fa-exclamation-circle"></i> Amount must be greater than 0
                                        </asp:RangeValidator>
                                        
                                        <small class="form-text">Enter the expense amount</small>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-money-bill-wave text-gold"></i> Currency *
                                        </label>
                                        <asp:DropDownList ID="ddlCurrency" runat="server" CssClass="form-control"
                                            style="color: #000 !important; background: #fff !important; font-size: 16px !important;">
                                            <asp:ListItem Value="USD">USD - US Dollar</asp:ListItem>
                                            <asp:ListItem Value="INR">INR - Indian Rupee</asp:ListItem>
                                            <asp:ListItem Value="GBP">GBP - British Pound</asp:ListItem>
                                            <asp:ListItem Value="EUR">EUR - Euro</asp:ListItem>
                                            <asp:ListItem Value="CAD">CAD - Canadian Dollar</asp:ListItem>
                                            <asp:ListItem Value="AUD">AUD - Australian Dollar</asp:ListItem>
                                        </asp:DropDownList>
                                        <small class="form-text">Select the currency of payment</small>
                                    </div>
                                </div>
                            </div>

                            <!-- Category & Date Row -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-tags text-gold"></i> Category *
                                        </label>
                                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"
                                            style="color: #000 !important; background: #fff !important; font-size: 16px !important;">
                                            <asp:ListItem Value="">Select Category</asp:ListItem>
                                            <asp:ListItem Value="Travel">Travel</asp:ListItem>
                                            <asp:ListItem Value="Meals">Meals & Entertainment</asp:ListItem>
                                            <asp:ListItem Value="Office Supplies">Office Supplies</asp:ListItem>
                                            <asp:ListItem Value="Training">Training & Development</asp:ListItem>
                                            <asp:ListItem Value="Software">Software & Subscriptions</asp:ListItem>
                                            <asp:ListItem Value="Hardware">Hardware & Equipment</asp:ListItem>
                                            <asp:ListItem Value="Transportation">Transportation</asp:ListItem>
                                            <asp:ListItem Value="Accommodation">Accommodation</asp:ListItem>
                                            <asp:ListItem Value="Other">Other</asp:ListItem>
                                        </asp:DropDownList>
                                        
                                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" 
                                            ControlToValidate="ddlCategory"
                                            InitialValue=""
                                            ErrorMessage="Category is required"
                                            Display="Dynamic"
                                            CssClass="validation-error"
                                            SetFocusOnError="true">
                                            <i class="fas fa-exclamation-circle"></i> Please select a category
                                        </asp:RequiredFieldValidator>
                                        
                                        <small class="form-text">Choose the expense category</small>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-calendar-alt text-gold"></i> Date *
                                        </label>
                                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" 
                                            TextMode="Date"></asp:TextBox>
                                        
                                        <asp:RequiredFieldValidator ID="rfvDate" runat="server" 
                                            ControlToValidate="txtDate"
                                            ErrorMessage="Date is required"
                                            Display="Dynamic"
                                            CssClass="validation-error"
                                            SetFocusOnError="true">
                                            <i class="fas fa-exclamation-circle"></i> Date is required
                                        </asp:RequiredFieldValidator>
                                        
                                        <asp:CustomValidator ID="cvDate" runat="server" 
                                            ControlToValidate="txtDate"
                                            ClientValidationFunction="validateDate"
                                            ErrorMessage="Date cannot be in the future"
                                            Display="Dynamic"
                                            CssClass="validation-error"
                                            SetFocusOnError="true">
                                            <i class="fas fa-exclamation-circle"></i> Date cannot be in the future
                                        </asp:CustomValidator>
                                        
                                        <small class="form-text">Date when expense was incurred</small>
                                    </div>
                                </div>
                            </div>

                            <!-- Description -->
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-align-left text-gold"></i> Description *
                                </label>
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" 
                                    TextMode="MultiLine" Rows="4" 
                                    placeholder="Provide detailed information about this expense..."></asp:TextBox>
                                
                                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" 
                                    ControlToValidate="txtDescription"
                                    ErrorMessage="Description is required"
                                    Display="Dynamic"
                                    CssClass="validation-error"
                                    SetFocusOnError="true">
                                    <i class="fas fa-exclamation-circle"></i> Description is required
                                </asp:RequiredFieldValidator>
                                
                                <asp:RegularExpressionValidator ID="revDescription" runat="server" 
                                    ControlToValidate="txtDescription"
                                    ValidationExpression="^[\s\S]{10,500}$"
                                    ErrorMessage="Description must be between 10 and 500 characters"
                                    Display="Dynamic"
                                    CssClass="validation-error"
                                    SetFocusOnError="true">
                                    <i class="fas fa-exclamation-circle"></i> Description must be between 10 and 500 characters
                                </asp:RegularExpressionValidator>
                                
                                <small class="form-text">Include relevant details such as purpose, vendor, location, etc. (10-500 characters)</small>
                            </div>

                            <!-- Action Buttons -->
                            <div class="form-group mt-4 mb-2">
                                <asp:Button ID="btnSubmit" runat="server" Text="✓ Submit Expense" 
                                    CssClass="btn btn-primary btn-lg" OnClick="btnSubmit_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="✕ Cancel" 
                                    CssClass="btn btn-secondary btn-lg ml-2" OnClick="btnCancel_Click" 
                                    CausesValidation="false" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        // Set today's date as default
        window.onload = function () {
            var today = new Date().toISOString().split('T')[0];
            var dateField = document.getElementById('<%= txtDate.ClientID %>');
            if (dateField && !dateField.value) {
                dateField.value = today;
            }
        };

        // Custom date validation - prevent future dates
        function validateDate(sender, args) {
            var selectedDate = new Date(args.Value);
            var today = new Date();
            today.setHours(0, 0, 0, 0);

            args.IsValid = selectedDate <= today;
        }

        // Add validation styling on blur
        document.addEventListener('DOMContentLoaded', function () {
            var inputs = document.querySelectorAll('.form-control');
            inputs.forEach(function (input) {
                input.addEventListener('blur', function () {
                    if (this.value.trim() === '' && this.hasAttribute('required')) {
                        this.classList.add('input-validation-error');
                    } else {
                        this.classList.remove('input-validation-error');
                    }
                });

                input.addEventListener('input', function () {
                    this.classList.remove('input-validation-error');
                });
            });
        });
    </script>
</body>
</html>