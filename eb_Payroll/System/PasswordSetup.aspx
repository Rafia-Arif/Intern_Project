<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="PasswordSetup.aspx.cs" Inherits="Payroll_PasswordSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <script type="text/javascript">
        function showSuccess(str, redirect, delay) {
            if (delay) {
                $('#alertMessage').removeClass('error info warning').addClass('success').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 250, function () {
                    $(this).delay(delay).animate({ opacity: 0, right: '-20' }, 250, function () { $(this).hide(); if (redirect != null) { redirectWindow(redirect); } });
                });
                return false;
            }
            $('#alertMessage').addClass('success').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 250);
        }
        function showError(str, redirect, delay) {

            if (delay) {
                $('#alertMessage').removeClass('success info warning').addClass('error').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 250, function () {
                    $(this).delay(delay).animate({ opacity: 0, right: '-20' }, 250, function () { $(this).hide(); if (redirect != null) { redirectWindow(redirect); } });
                });
                return false;
            }
            $('#alertMessage').addClass('error').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 250);
        }
        function validateform() {
            var str = '';
            if ($('#txtbxEmployeeEdit').val() == undefined || $('#txtbxEmployeeEdit').val() == "") {
                str = 'Employee Edit Required.<br/>';
            }
            if ($('#txtbxActionSheet').val() == undefined || $('#txtbxActionSheet').val() == "") {
                str += 'Action Sheet Required.<br/>';
            }
            if ($('#txtbxEndofServiceApproval').val() == undefined || $('#txtbxEndofServiceApproval').val() == "") {
                str += 'End of Service Approval Required.<br/>';
            }
            if ($('#txtbxLeaveEncashment').val() == undefined || $('#txtbxLeaveEncashment').val() == "") {
                str += 'Leave Encashment Required.<br/>';
            }
            if ($('#txtbxGridRolldown').val() == undefined || $('#txtbxGridRolldown').val() == "") {
                str += 'Grid Rolldown Required.<br/>';
            }
            if ($('#txtbxPositionRolldown').val() == undefined || $('#txtbxPositionRolldown').val() == "") {
                str += 'Position Rolldown Required.<br/>';
            }
            if ($('#txtbxEmployeeClassRolldown').val() == undefined || $('#txtbxEmployeeClassRolldown').val() == "") {
                str += 'Employee Class Rolldown Required.<br/>';
            }
            if (str != '') {
                showError(str, null, 10000);
                return false;
            }
            else
                return true;
        }
    </script>
    <fieldset>
        <div class="widget">
            <div class="title">
                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                <h6>Password Setup</h6>
                <div style="float: right; padding: 5px 0px; margin-right: 10px;">
                    <div style="float: right; margin-top: 0px; margin-right: 10px;">
                         <asp:ImageButton ID="rbutUpdate" runat="server"  ClientIDMode="Static"  ImageUrl="../../Images/save.gif" ToolTip="Update Passwords." CausesValidation="true" OnClientClick="return validateform()" OnClick="rbutUpdate_Click" />
                           </div>
                    <div style="float: right; padding-top: 7px; margin-right: 10px;">
                        <asp:Button runat="server" ID="btnNationalityPrint" CssClass="rgPrint" ClientIDMode="Static" CausesValidation="false" CommandName="Print" AlternateText="Print" ToolTip="Print" OnClick="btnNationalityPrint_Click" />
                    </div>
                    <div style="float: right; margin-top: 0px; margin-right: 10px;">
                        <telerik:RadComboBox ID="ddlPrintOptions" runat="server" Width="250px" DropDownWidth="250px">
                        </telerik:RadComboBox>
                    </div>
                </div>
            </div>
            <div class="formRow">
                <div class="formCol">
                    <label style="width: 130px !important">
                        Employee Edit
                    </label>
                    <div class="formRight">
                        <asp:TextBox runat="server" Style="float: left" ClientIDMode="Static" ID="txtbxEmployeeEdit" TextMode="Password" MaxLength="25" Width="250px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="txtbxEmployeeEdit"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="clear"></div>

            </div>
            <div class="formRow">
                <div class="formCol">
                    <label style="width: 130px !important">Action Sheet</label>
                    <div class="formRight">
                        <asp:TextBox runat="server" Style="float: left" ClientIDMode="Static" ID="txtbxActionSheet" MaxLength="25" TextMode="Password" Width="250px"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="txtbxActionSheet"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="clear"></div>

            </div>
            <div class="formRow">
                <div class="formCol">
                    <label style="width: 130px !important">End of Service Approval</label>
                    <div class="formRight">
                        <asp:TextBox runat="server" ClientIDMode="Static" Style="float: left" ID="txtbxEndofServiceApproval" TextMode="Password" MaxLength="25" Width="250px"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="txtbxEndofServiceApproval"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="clear"></div>

            </div>
            <div class="formRow">
                <div class="formCol">
                    <label style="width: 130px !important">Leave Encashment</label>
                    <div class="formRight">
                        <asp:TextBox runat="server" ClientIDMode="Static" Style="float: left" ID="txtbxLeaveEncashment" TextMode="Password" MaxLength="25" Width="250px"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="txtbxLeaveEncashment"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="clear"></div>

            </div>
            <div class="formRow">
                <div class="formCol">
                    <label style="width: 130px !important">Grid Rolldown</label>
                    <div class="formRight">
                        <asp:TextBox runat="server" ClientIDMode="Static" Style="float: left" ID="txtbxGridRolldown" TextMode="Password" MaxLength="25" Width="250px"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="txtbxGridRolldown"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="clear"></div>

            </div>
            <div class="formRow">
                <div class="formCol">
                    <label style="width: 130px !important">Position Rolldown</label>
                    <div class="formRight">
                        <asp:TextBox runat="server" Style="float: left" ClientIDMode="Static" ID="txtbxPositionRolldown" TextMode="Password" MaxLength="25" Width="250px"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="txtbxPositionRolldown"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="clear"></div>

            </div>
            <div class="formRow">
                <div class="formCol">
                    <label style="width: 130px !important">Employee Class Rolldown</label>
                    <div class="formRight">
                        <asp:TextBox runat="server" Style="float: left" ClientIDMode="Static" ID="txtbxEmployeeClassRolldown" TextMode="Password" MaxLength="25" Width="250px"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                            ControlToValidate="txtbxEmployeeClassRolldown"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="clear"></div>

            </div>
        </div>
    </fieldset>

</asp:Content>

