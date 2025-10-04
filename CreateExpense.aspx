<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateExpense.aspx.cs" Inherits="ExpenseApp.CreateExpense" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Create Expense</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { background-color: #f4f6f9; padding: 20px; }
        .card { border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-8 mx-auto">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h4 class="mb-0">Create New Expense</h4>
                        </div>
                        <div class="card-body">
                            <div class="alert alert-info">
                                Company Currency: <strong><asp:Label ID="lblCurrency" runat="server"></asp:Label></strong>
                            </div>

                            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success">
                                <asp:Label ID="lblSuccess" runat="server"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger">
                                <asp:Label ID="lblError" runat="server"></asp:Label>
                            </asp:Panel>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Amount *</label>
                                        <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" 
                                            TextMode="Number" step="0.01" placeholder="0.00"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Currency *</label>
                                        <asp:DropDownList ID="ddlCurrency" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="USD">USD</asp:ListItem>
                                            <asp:ListItem Value="INR">INR</asp:ListItem>
                                            <asp:ListItem Value="GBP">GBP</asp:ListItem>
                                            <asp:ListItem Value="EUR">EUR</asp:ListItem>
                                            <asp:ListItem Value="CAD">CAD</asp:ListItem>
                                            <asp:ListItem Value="AUD">AUD</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Category *</label>
                                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="">Select Category</asp:ListItem>
                                            <asp:ListItem Value="Travel">Travel</asp:ListItem>
                                            <asp:ListItem Value="Meals">Meals</asp:ListItem>
                                            <asp:ListItem Value="Office Supplies">Office Supplies</asp:ListItem>
                                            <asp:ListItem Value="Training">Training</asp:ListItem>
                                            <asp:ListItem Value="Software">Software</asp:ListItem>
                                            <asp:ListItem Value="Hardware">Hardware</asp:ListItem>
                                            <asp:ListItem Value="Other">Other</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Date *</label>
                                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" 
                                            TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Description *</label>
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" 
                                    TextMode="MultiLine" Rows="3" placeholder="Enter expense details"></asp:TextBox>
                            </div>

                            <div class="form-group mt-4">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit Expense" 
                                    CssClass="btn btn-primary btn-lg" OnClick="btnSubmit_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                    CssClass="btn btn-secondary btn-lg ml-2" OnClick="btnCancel_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>