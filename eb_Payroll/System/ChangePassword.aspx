<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master"
    AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="User_ChangePassword" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <div id="content">
        <h1 style="font-size: 18px; font-weight: bold; font-family: Tahoma; color: #333333;
            border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: #C0C0C0;
            width: 960px;">
            Change Password</h1>
        <div style="margin-top: 20px;">
            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1"
                Width="960px">
                <table style="width: 100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 130px">
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Old Password:"></asp:Label>
                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rTxtOldPwd"
                                ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="rTxtOldPwd" runat="server" MaxLength="20" TextMode="Password">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="New Password:"></asp:Label>
                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rTxtNewPwd"
                                ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="rTxtNewPwd" runat="server" MaxLength="20" TextMode="Password">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Confirm Password:"></asp:Label>
                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rTxtNewPwdConfirm"
                                ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="rTxtNewPwdConfirm" runat="server" MaxLength="20" TextMode="Password">
                            </telerik:RadTextBox>
                            &nbsp;
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="rTxtNewPwd"
                                ControlToValidate="rTxtNewPwdConfirm" ErrorMessage="Password must be matched!"
                                SetFocusOnError="false"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td style="padding-left: 15px">
                            <telerik:RadButton ID="rBtnChangePwd" runat="server" OnClick="rBtnChangePwd_Click"
                                Text="Change Password">
                            </telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Label ID="lblStatus" runat="server" Font-Bold="True" Font-Italic="True" Font-Size="X-Small"></asp:Label>
                        </td>
                    </tr>
                </table>
            </telerik:RadAjaxPanel>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
        </div>
    </div>
</asp:Content>
