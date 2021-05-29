<%@ Page Title="Login to eServices" Language="C#" AutoEventWireup="true" CodeFile="LoginPage.aspx.cs" Inherits="System_LoginPage"
    MasterPageFile="~/MasterPages/Main.master" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">
        $().ready(function () {
            $("html").css('background', 'url(images/backgrounds/bg.jpg) repeat');
            $(".tblogin").focus();
        });

        function getTimeZoneOffset() {
            var timeZoneOffset = -1 * parseInt(new Date().getTimezoneOffset());
            //alert(timeZoneOffset);
            $("#hfTimeOffset").val(timeZoneOffset);
        }

        function showError(str, redirect, delay) {

            if (delay) {
                $('#alertMessage').removeClass('success info warning').addClass('error').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 500, function () {
                    $(this).delay(delay).animate({ opacity: 0, right: '-20' }, 500, function () { $(this).hide(); if (redirect != null) { redirectWindow(redirect); } });
                });
                return false;
            }
            $('#alertMessage').addClass('error').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 500);
        }
        function showSuccess(str, redirect, delay) {
            if (delay) {
                $('#alertMessage').removeClass('error info warning').addClass('success').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 500, function () {
                    $(this).delay(delay).animate({ opacity: 0, right: '-20' }, 500, function () { $(this).hide(); if (redirect != null) { redirectWindow(redirect); } });
                });
                return false;
            }
            $('#alertMessage').addClass('success').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 500);
        }
        function showWarning(str, redirect, delay) {
            if (delay) {
                $('#alertMessage').removeClass('error success  info').addClass('warning').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 500, function () {
                    $(this).delay(delay).animate({ opacity: 0, right: '-20' }, 500, function () { if (redirect != null) { redirectWindow(redirect); } });
                });
                return false;
            }
            $('#alertMessage').addClass('warning').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 500);
        }
        function showInfo(str, redirect, delay) {
            if (delay) {
                $('#alertMessage').removeClass('error success  warning').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 500, function () {
                    $(this).delay(delay).animate({ opacity: 0, right: '-20' }, 500, function () { $(this).hide(); if (redirect != null) { redirectWindow(redirect); } });
                });
                return false;
            }
            $('#alertMessage').html(str).stop(true, true).show().animate({ opacity: 1, right: '10' }, 500);
        }

        $('#alertMessage').click(function () {
            $(this).hide();
        });
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <!-- Top fixed navigation -->
    <div class="topNav">
        <div class="wrapper">
        </div>
    </div>
    <!-- Main content wrapper -->
     <div id="alertMessage" class="error">
    </div>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="loginbutton">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="LoginButton" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="FailureText" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <div class="loginWrapper">
        <asp:HiddenField ID="hfTimeOffset" Value="0" ClientIDMode="Static" runat="server" /> 
        <div class="loginLogo">
            <%--<img src="../Images/Logo.png" alt="" />--%>
            <img alt="" runat="server" id="imgLogo" style="max-height:150px;max-width:150px;height:auto;width:auto;" visible="True" />
        </div>
        <div class="widget inner">
            <div class="title">
                <img src="../Images/icons/dark/files.png" alt="" class="titleIcon" /><h6>eServices User Login</h6>
            </div>
            <fieldset>
                <div class="formRow">
                    <label for="login">
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                    </label>
                    <div class="loginInput">
                        <asp:TextBox ID="UserName" name="login" class="tblogin validate[required]" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div class="formRow">
                    <label for="pass">
                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label></label>
                    <div class="loginInput">
                        <asp:TextBox ID="Password" runat="server" name="password" TextMode="Password" class="validate[required]"></asp:TextBox>
                    </div>

                    
                    
                    <div class="clear">
                    </div>
                    
                       <%--Style="margin-right: 18px;margin-left: 190px;"--%>
                       
                </div>
                <div class="loginControl">
                    <div class="rememberMe">
                        <telerik:RadCheckBox runat="server" Style="margin-top:-2px" ID="rememberme" AutoPostBack="false">
                            </telerik:RadCheckBox>
                        <asp:Label ID="Label1" runat="server" AssociatedControlID="">Remember Me</asp:Label>
                    </div>

                    <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In"
                        class="dblueB logMeIn" OnClick="LoginButton_Click" />
                    <div class="clear">
                    </div>
                    <asp:Label ID="FailureText" runat="server" ForeColor="Red" Font-Bold="true"  EnableViewState="false" type="ErrorLabel"></asp:Label>
                </div>
                  <div class="loginControl">
                    <div class="rememberMe">
                        <telerik:RadLinkButton runat="server" Style="margin-top:-2px" ID="RadLinkButton1" AutoPostBack="false" NavigateUrl>
                            </telerik:RadLinkButton>
                        <asp:Label ID="Label2" runat="server" AssociatedControlID="">Forget Password</asp:Label>
                    </div>

                    <asp:Button ID="Button1" runat="server" CommandName="Login" Text="Log In"
                        class="dblueB logMeIn" OnClick="LoginButton_Click" />
                    <div class="clear">
                    </div>
                    <asp:Label ID="Label3" runat="server" ForeColor="Red" Font-Bold="true"  EnableViewState="false" type="ErrorLabel"></asp:Label>
                </div>
            </fieldset>
        </div>
    </div>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"   Transparency="20">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>