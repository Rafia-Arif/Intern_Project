<%@ Page Title="Access Control List Management" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master"
    AutoEventWireup="true" CodeFile="ManageACL.aspx.cs" Inherits="Admin_ManageACL" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        html body .riSingle .riTextBox[type="text"] {
            width: 180px !important;
        }

        @media only screen and (min-width: 0px) and (max-width: 600px) {
            .tab_content {
                padding: 0px 0px !important;
            }

            .wEmployeePreview {
                margin: 0px !important;
            }
        }

    </style>
</asp:Content>
<%--<asp:Content ID="Content6" ContentPlaceHolderID="ACLMenuBlock" Runat="Server">
    <li id="tray-active"><a href="../Admin/ManageACL.aspx">Manage ACL</a></li>
</asp:Content>--%>
<asp:Content ID="Content7" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">


            
            
           


            function RowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Name");
                var EmployeeID = args.getDataKeyValue("UserRoleID");

                var combo = $find(sender.ClientID.replace('_i0_rGrdRoles4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(EmployeeID);
                    combo.commitChanges();
                }, 50);
            }

            function ValidateRoles()
            {
                if (!Page_ClientValidate('FrmSubmit')) {
                    var str = '';

                    if ($('#' + "<%=ddlURolesNew.ClientID %>").val() == undefined || $('#' + "<%=ddlURolesNew.ClientID %>").val() == "") {
                        str += 'User Role Required.<br/>';
                    }

                    if (str != '') {
                        showError(str, null, 10000);
                        return false;
                    }
                    else {
                        return true;
                    }
                }
                else
                    return true;
            }


            var currentLoadingPanel = null;
            var currentUpdatedControl = null;

            function RequestStart(sender, args) {
                currentLoadingPanel = $find("<%= RadAjaxLoadingPanel1.ClientID %>");
                currentUpdatedControl = "<%= pnlAjaxForm.ClientID %>";
                currentLoadingPanel.show(currentUpdatedControl);
            }

            function ResponseEnd() {
                //hide the loading panel and clean up the global variables
                if (currentLoadingPanel != null)
                    currentLoadingPanel.hide(currentUpdatedControl);
                currentUpdatedControl = null;
                currentLoadingPanel = null;
            }


            
           
        </script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdRoles4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvACL2" />
                    <telerik:AjaxUpdatedControl ControlID="rGrdRoles4DDL" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSaveNew">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvACL2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvACL2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvACL2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

<%--        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RequiredFieldValidator1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlURolesNew" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>

        <ClientEvents OnRequestStart="RequestStart" OnResponseEnd="ResponseEnd" />
    </telerik:RadAjaxManager>

    <%--<div style="overflow: auto">--%>
    <div class="widget">
        <div class="title">
            <img src="../images/icons/dark/list.png" alt="" class="titleIcon" />
            <h6>Manage Access Control List (ACL)</h6>
        </div>
            <div class="tab_container">
                <asp:Panel ID="pnlAjaxForm" runat="server" CssClass="fluid">
                <div id="tab1" class="tab_content" style="overflow: auto; width: -webkit-fill-available;">
                    <fieldset>
                        <div class="wEmployeePreview">
                            <table style="width: 100%;" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 100px; padding-left: 5px">
                                        <asp:Label ID="Label1" runat="server" Text="User Role:"></asp:Label>
                                    </td>
                                    <td style="padding-top: 5px;width:190px">
                                        <span class="combo180">
                                            <telerik:RadComboBox ID="ddlURolesNew" runat="server" Width="180px" Height="200px" DropDownWidth="180px"
                                                EmptyMessage="Please select..." AutoPostBack="true" OnSelectedIndexChanged="ddlURolesNew_SelectedIndexChanged"
                                                 OnPreRender="ddlURolesNew_PreRender">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 200px;">
                                                            <telerik:RadGrid ID="rGrdRoles4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                CellSpacing="0" GridLines="None" Width="180px" ClientSettings-EnableRowHoverStyle="True"
                                                                OnSelectedIndexChanged="rGrdRoles4DDL_SelectedIndexChanged">
                                                                <ClientSettings>
                                                                    <Selecting AllowRowSelect="true"></Selecting>
                                                                </ClientSettings>
                                                                <MasterTableView DataKeyNames="UserRoleID" ClientDataKeyNames="UserRoleID,Name">
                                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn DataField="UserRoleID" FilterControlAltText="Filter column1 column" HeaderText="ID" UniqueName="column1" Visible="false">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter column2 column" HeaderText="Name" UniqueName="Name">
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                    <EditFormSettings>
                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                        </EditColumn>
                                                                    </EditFormSettings>
                                                                </MasterTableView>
                                                                <ClientSettings EnablePostBackOnRowClick="true">
                                                                    <ClientEvents OnRowClick="RowClicked"></ClientEvents>
                                                                </ClientSettings>
                                                                <FilterMenu EnableImageSprites="False">
                                                                </FilterMenu>
                                                            </telerik:RadGrid>
                                                    </div>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>
                                        </span>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ValidationGroup="FrmSubmit"
                                            ForeColor="Red" ControlToValidate="ddlURolesNew">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                    <td style="width: 100px; text-align: right; padding-bottom: 0px; padding-top: 5px;">
                                        <%--<telerik:RadButton ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" Width="80px" CssClass="save-button"></telerik:RadButton>--%>
                                        <asp:Button ID="btnSaveNew" runat="server" ValidationGroup="FrmSubmit" CausesValidation="true" OnClientClick="if (!ValidateRoles()) {return false;};" OnClick="btnSaveNew_Click" CssClass="save-button" BorderStyle="None" />
                                    </td>
                                </tr>
                                <%--<tr>
                                <td colspan="2" style="padding: 5px; text-align: center;">
                                    <asp:Label ID="lblError" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                </td>
                                <td></td>
                            </tr>--%>
                            </table>
                            <telerik:RadGrid ID="gvACL2" runat="server" AllowPaging="True" AllowSorting="True" Width="100%"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="gvACL2_NeedDataSource"
                                PageSize="20" ShowStatusBar="True" OnDetailTableDataBind="gvACL2_DetailTableDataBind" OnItemCommand="gvACL2_ItemCommand" AllowMultiRowSelection="True" ClientSettings-EnableRowHoverStyle="True"  >
                                <ClientSettings >
                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" UseClientSelectColumnOnly="True" ></Selecting>                  
                                </ClientSettings>
                                <GroupingSettings CaseSensitive="false" />
                                <MasterTableView InsertItemPageIndexAction="ShowItemOnCurrentPage"
                                    AllowMultiColumnSorting="True" DataKeyNames="MainModule" >
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <DetailTables>
                                        <telerik:GridTableView runat="server"  Name="SubModules" AllowMultiColumnSorting="True" DataKeyNames="SubModule" >
                                            <DetailTables >
                                                <telerik:GridTableView runat="server" Name="ACL" DataKeyNames="UserActionID"    >
                                                    <CommandItemSettings ExportToPdfText="Export to PDF" />
                                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                        <HeaderStyle Width="20px" />
                                                    </RowIndicatorColumn>
                                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                        <HeaderStyle Width="20px" />
                                                    </ExpandCollapseColumn>
                                                    <EditFormSettings>
                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                        </EditColumn>
                                                    </EditFormSettings>
                                                    <Columns >

                                                        
                                                        <telerik:GridBoundColumn DataField="UserAction" FilterControlAltText="Filter column2 column"
                                                            HeaderText="User Action" UniqueName="column1" ReadOnly="True">
                                                        </telerik:GridBoundColumn>
                                             
                                                       
                                                        
                                                        <telerik:GridTemplateColumn HeaderText="Allow Access" UniqueName="column2">
                                                            
                                                            <ItemTemplate>
                                                                
                                                                <asp:CheckBox ID="chkAllow"  runat="server" Checked='<%# Eval("AllowUserAction") %>' />                    
                                                            </ItemTemplate>
                                                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </telerik:GridTemplateColumn>


                 





                                                       


                                                        <telerik:GridTemplateColumn HeaderText="Allow Workflow" UniqueName="column3">
                                                            <ItemTemplate>


                                                                <asp:CheckBox ID="chkAllowWorkflow" runat="server" Checked='<%# Eval("AllowWorkflow") %>' />
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </telerik:GridTemplateColumn>

                                                     






                                                        <telerik:GridTemplateColumn HeaderText="Access Level" UniqueName="column4" FilterControlAltText="Filter column4 column">
                                                            <ItemTemplate>
                                                                <span class="combo180">
                                                                    <telerik:RadComboBox ID="ddlDataAccess" runat="server" Width="180px" DataSource='<%# GetDataAccessDataSource() %>' DataTextField="Name" DataValueField="ID" SelectedValue='<%# Eval("DataAccessTypeID") %>'>
                                                                    </telerik:RadComboBox>
                                                                </span>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="300px" HorizontalAlign="Left" />
                                                            <HeaderStyle HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>


                                                    <BatchEditingSettings EditType="Row"></BatchEditingSettings>
                                                </telerik:GridTableView>
                                            </DetailTables>
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="SubModule" FilterControlAltText="Filter column2 column"
                                                    HeaderText="Sub Module" UniqueName="column2" ReadOnly="True">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </telerik:GridTableView>










                                       <%-- /******************************************************** /--%>
























                                        <telerik:GridTableView runat="server" Name="ReportRole" AllowMultiColumnSorting="True" DataKeyNames="idd">
                                            <DetailTables>
                                            </DetailTables>
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="idd" FilterControlAltText="Filter column2 column"
                                                    HeaderText="ID" UniqueName="column2" ReadOnly="True">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column" SortExpression="modulename"
                                                    HeaderText="Module Name" UniqueName="TemplateColumn2" DataField="modulename"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterDelay="2000" ShowFilterIcon="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblmodulename" runat="server" Text='<%# Eval("modulename") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column" SortExpression="formname"
                                                    HeaderText="Form Name" UniqueName="TemplateColumn3" DataField="formname"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterDelay="2000" ShowFilterIcon="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblformname" runat="server" Text='<%# Eval("formname") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Allow Access" UniqueName="column4">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkAllowRptRole" runat="server" Checked='<%# Eval("AllowUserAction") %>' />
                                                    </ItemTemplate>
                                                    <ItemStyle Width="100px" HorizontalAlign="Center" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </telerik:GridTableView>
























































                                    </DetailTables>
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="MainModule" FilterControlAltText="Filter column2 column"
                                            HeaderText="Main Module" UniqueName="column2" ReadOnly="True">
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column" ButtonType="ImageButton">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>



                                

































                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                            </telerik:RadGrid>
                        </div>
                    </fieldset>
                </div>
                    </asp:Panel>
            </div>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" IsSticky="true" />
    </div>
    <%-- </div>--%>
</asp:Content>
