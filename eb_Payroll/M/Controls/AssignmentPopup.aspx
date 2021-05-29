<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignmentPopup.aspx.cs" Inherits="Payroll_Setup_AssignmentPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Resource Assignment Details</title>
</head>
<body onload="AdjustRadWidow();" style="background: none">
    <form id="Form2" method="post" runat="server">
        <style>
          /*  .RadComboBox .rcbInputCellLeft input {
                margin-left: 0px !important;
                margin-top: 0px !important;
                border: 0px !important;
            }*/

            .rcbReadOnly {
                border: 1px solid #d7d7d7 !important;
            }

            .RadComboBox_Silk .rcbReadOnly .rcbInputCell {
                border: 0px !important;
            }
        </style>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Path="~/Scripts/jquery.js" />
                <asp:ScriptReference Path="~/Scripts/jquery-ui-1.8.min.js" />
            </Scripts>
        </telerik:RadScriptManager>
        <telerik:RadFormDecorator ID="RadFormDecorator1" DecoratedControls="All" runat="server" />
        <script type="text/javascript">
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }
            var ctlr;
            var ctlrcolor;
            function openWin2(obj, objcolor) {
                ctlr = obj;
                ctlrcolor = objcolor;
                var parentPage = GetRadWindow().BrowserWindow;
                var parentRadWindowManager = parentPage.GetRadWindowManager();
                window.setTimeout(function () {
                    parentRadWindowManager.open("ColorPopup.aspx", "radColorWindow");
                }, 0);
            }

            function populateColor(arg) {
                document.getElementById(ctlr).value = arg;
                document.getElementById(ctlrcolor).style.backgroundColor = arg;
            }

            function AdjustRadWidow() {
                //var oWindow = GetRadWindow();
                //setTimeout(function () {
                //    oWindow.autoSize(true);
                //}, 320);
            }

            function returnToRequesterParent() {

                var txtRequester = document.getElementById('<%=txtRequester.ClientID%>');

                var oArg = new Object();

                oArg.RecordIdd = document.getElementById("hdnRecordIdd").value;

                //get user type (requester,approver, owner) 
                oArg.UserType = 'requester';

                //get the Requesetor Description            
                oArg.ReqDescription = txtRequester.value;

                //get a reference to the current RadWindow
                var oWnd = GetRadWindow();

                //Close the RadWindow and send the argument to the parent page
                oWnd.close(oArg);
            }

            function returnToApproverParent() {

                var txtApprover = document.getElementById('<%=txtbxApprover.ClientID%>');
                var dtpapprovdate = document.getElementById('<%=dtpApproverDate.ClientID%>');

                //if (ValidateForm(txtDescription, ddlEmployee, txtCategory)) {
                //create the argument that will be returned to the parent page
                var oArg = new Object();

                oArg.RecordIdd = document.getElementById("hdnRecordIdd").value;

                //get user type (requester,approver, owner) 
                oArg.UserType = 'approver';

                //get the Approver Description            
                oArg.AppDescription = txtApprover.value;

                //get the Owner date
                oArg.Appdate = dtpapprovdate.value;

                //get the Is Approved
                oArg.IsApp = '<%=radioApprove.Checked %>'

                //get a reference to the current RadWindow
                var oWnd = GetRadWindow();

                //Close the RadWindow and send the argument to the parent page
                oWnd.close(oArg);
            }

            function returnToOwnerParent() {

                var txtOwner = document.getElementById('<%=txtOwner.ClientID%>');
                var dtpdate = document.getElementById('<%=dtpdate.ClientID%>');

                //if (ValidateForm(txtDescription, ddlEmployee, txtCategory)) {
                //create the argument that will be returned to the parent page
                var oArg = new Object();

                oArg.RecordIdd = document.getElementById("hdnRecordIdd").value;

                //get user type (requester,approver, owner) 
                oArg.UserType = 'owner';

               //get the Owner date
                oArg.Owndate = dtpdate.value;

                //get the Is Provided
                oArg.IsProvided = document.getElementById("chkIsProvided").checked;

                //get the Owner Description            
                oArg.OwnDescription = txtOwner.value;

                //get a reference to the current RadWindow
                var oWnd = GetRadWindow();

                //Close the RadWindow and send the argument to the parent page
                oWnd.close(oArg);
            }

            function ValidateForm(txtDescription, ddlEmployeeId, txtCategory) {
                var str = '';
                if (txtDescription.value == "") {
                    str = 'Description Required.<br/>';
                }

                if (ddlEmployeeId.value == "") {
                    str += 'Employee Required.<br/>';
                }

                if (txtCategory.value == "") {
                    str += 'Category Required.<br/>';
                }

                if (str != '') {
                    //get a reference to the current RadWindow
                    var oWnd = GetRadWindow();

                    //Call the predefined function in Parent Page
                    oWnd.BrowserWindow.showError(str, null, 10000);

                    return false;
                }
                else {
                    return true;
                }
            }

        </script>
        <style type="text/css">
            .CustomInput {
                width: 100px !important;
            }

                .CustomInput .riLabel {
                    width: 30% !important;
                }

            span.CustomInput .riContentWrapper,
            span.CustomInput.riContButton.riContSpinButtons .riContentWrapper {
                width: 70% !important;
                padding-right: 0;
            }
        </style>
        <fieldset id="fld1">
            <div style="width: 632px; height: 995px;">
                <asp:HiddenField ID="hdnRecordIdd" runat="server" ClientIDMode="Predictable" />
                 <asp:HiddenField ID="hdnUserType" runat="server" ClientIDMode="Predictable" />
                <div style="border: 0px black solid; width: 310px;height:985px; float: left; display:inline-block">
                    <div style="border: 1px black solid; width: 300px;height:980px; float: left;margin:10px 0 10px 10px" >
                        <div style="float: left; margin: 10px 0 0 0;">
                            <div style="float: left; margin: 6px 0 0 8px; width: 100px;">
                                Description
                            </div>
                            <input type="text" id="txtDescription" runat="server" style="float: left; width: 175px; padding-left: 5px" />
                        </div>

                        <div style="float: left; margin: 10px 0 0 0;">
                            <div style="float: left; margin: 6px 0 0 8px; width: 100px;">
                                Catergory
                            </div>
                            <span class="combo125">
                                <telerik:RadComboBox ID="ddlCategory" AutoPostBack="false" runat="server" Width="124px" DropDownWidth="124px"
                                    EmptyMessage="Please select...">
                                    <ItemTemplate>
                                        <div style="overflow: auto; max-height: 300px;">

                                            <telerik:RadGrid ID="rGrdCategory4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                CellSpacing="0" GridLines="None" Width="124px" ClientSettings-EnableRowHoverStyle="True"
                                                AllowFilteringByColumn="false">
                                                <GroupingSettings CaseSensitive="false" />
                                                <%--OnNeedDataSource="rGrdCategory4DDL_NeedDataSource" OnSelectedIndexChanged="rGrdCategory4DDL_SelectedIndexChanged"--%>
                                                <ClientSettings>
                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                </ClientSettings>
                                                <MasterTableView DataKeyNames="Id,Code,Description" ClientDataKeyNames="Id,Code,Description">
                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                    </RowIndicatorColumn>
                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                    </ExpandCollapseColumn>
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="Id" FilterControlAltText="Filter Id column" HeaderText="ID"
                                                            UniqueName="Id" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                            CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Code" FilterControlAltText="Filter Code column" HeaderText="Code"
                                                            UniqueName="Code" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                            CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column"
                                                            HeaderText="Description" UniqueName="Description" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                            CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
                                                </MasterTableView>
                                                <ClientSettings EnablePostBackOnRowClick="true">
                                                    <ClientEvents OnRowClick="RowClickedCategory"></ClientEvents>
                                                </ClientSettings>
                                            </telerik:RadGrid>

                                        </div>
                                    </ItemTemplate>
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                    </Items>
                                </telerik:RadComboBox>
                            </span>
                        </div>


                        <asp:Panel ID="ControlsPanel" Visible="false" runat="server">

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="Label1" runat="server" Text="Label" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>
                                <input type="text" id="txt1" runat="server" style="float: left; width: 120px; padding-left: 5px" />
                                <asp:CheckBox ID="cbx1" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />

                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="Label2" runat="server" Text="Label" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>
                                <input type="text" id="txt2" runat="server" style="float: left; width: 120px; padding-left: 5px" />
                                <asp:CheckBox ID="cbx2" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />
                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="Label3" runat="server" Text="Label" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>
                                <input type="text" id="txt3" runat="server" style="float: left; width: 120px; padding-left: 5px" />
                                <asp:CheckBox ID="cbx3" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />

                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="Label4" runat="server" Text="Label" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>
                                <input type="text" id="txt4" runat="server" style="float: left; width: 120px; padding-left: 5px" />
                                <asp:CheckBox ID="cbx4" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />
                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="Label5" runat="server" Text="Label" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>
                                <input type="text" id="txt5" runat="server" style="float: left; width: 120px; padding-left: 5px" />
                                <asp:CheckBox ID="cbx5" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />

                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="Label6" runat="server" Text="Label" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>
                                <input type="text" id="txt6" runat="server" style="float: left; width: 120px; padding-left: 5px" />
                                <asp:CheckBox ID="cbx6" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />
                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="lblddl1" runat="server" Text="ddl1" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>
                                <span class="combo125" style="float: left;">
                                    <telerik:RadComboBox ID="ddl1" AutoPostBack="false" runat="server" Width="124px" DropDownWidth="124px"
                                        EmptyMessage="Please select...">
                                        <ItemTemplate>
                                            <div style="overflow: auto; max-height: 300px;">

                                                <telerik:RadGrid ID="rGrdddl14DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                    CellSpacing="0" GridLines="None" Width="124px" ClientSettings-EnableRowHoverStyle="True"
                                                    AllowFilteringByColumn="false">
                                                    <GroupingSettings CaseSensitive="false" />
                                                    <ClientSettings>
                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                    </ClientSettings>
                                                    <MasterTableView DataKeyNames="value,text" ClientDataKeyNames="value,text">
                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                            <HeaderStyle Width="2px"></HeaderStyle>
                                                        </RowIndicatorColumn>
                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                            <HeaderStyle Width="2px"></HeaderStyle>
                                                        </ExpandCollapseColumn>
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="value" FilterControlAltText="Filter value column" HeaderText="ID"
                                                                UniqueName="value" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="text" FilterControlAltText="Filter text column" HeaderText="Code"
                                                                UniqueName="text" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings EnablePostBackOnRowClick="false">
                                                        <ClientEvents OnRowClick="ddl1RowClicked"></ClientEvents>
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </div>
                                        </ItemTemplate>
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                        </Items>
                                    </telerik:RadComboBox>
                                </span>
                                <asp:CheckBox ID="cbxddl1" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />
                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="lblddl2" runat="server" Text="ddl2" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>
                                <span class="combo125" style="float: left;">
                                    <telerik:RadComboBox ID="ddl2" AutoPostBack="false" runat="server" Width="124px" DropDownWidth="124px"
                                        EmptyMessage="Please select...">
                                        <ItemTemplate>
                                            <div style="overflow: auto; max-height: 300px;">

                                                <telerik:RadGrid ID="rGrdddl24DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                    CellSpacing="0" GridLines="None" Width="124px" ClientSettings-EnableRowHoverStyle="True"
                                                    
                                                    AllowFilteringByColumn="false">
                                                    <GroupingSettings CaseSensitive="false" />
                                                    <ClientSettings>
                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                    </ClientSettings>
                                                    <MasterTableView DataKeyNames="value,text" ClientDataKeyNames="value,text">
                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                            <HeaderStyle Width="2px"></HeaderStyle>
                                                        </RowIndicatorColumn>
                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                            <HeaderStyle Width="2px"></HeaderStyle>
                                                        </ExpandCollapseColumn>
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="value" FilterControlAltText="Filter value column" HeaderText="ID"
                                                                UniqueName="value" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="text" FilterControlAltText="Filter text column" HeaderText="Code"
                                                                UniqueName="text" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings EnablePostBackOnRowClick="false">
                                                        <ClientEvents OnRowClick="ddl2RowClicked"></ClientEvents>
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </div>
                                        </ItemTemplate>
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                        </Items>
                                    </telerik:RadComboBox>
                                </span>
                                <asp:CheckBox ID="cbxddl2" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />
                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="lblddl3" runat="server" Text="ddl3" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>
                                <span class="combo125" style="float: left;">
                                    <telerik:RadComboBox ID="ddl3" AutoPostBack="false" runat="server" Width="124px" DropDownWidth="124px"
                                        EmptyMessage="Please select...">
                                        <ItemTemplate>
                                            <div style="overflow: auto; max-height: 300px;">

                                                <telerik:RadGrid ID="rGrdddl34DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                    CellSpacing="0" GridLines="None" Width="124px" ClientSettings-EnableRowHoverStyle="True"
                                                    AllowFilteringByColumn="false">
                                                    <GroupingSettings CaseSensitive="false" />
                                                    <ClientSettings>
                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                    </ClientSettings>
                                                    <MasterTableView DataKeyNames="value,text" ClientDataKeyNames="value,text">
                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                            <HeaderStyle Width="2px"></HeaderStyle>
                                                        </RowIndicatorColumn>
                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                            <HeaderStyle Width="2px"></HeaderStyle>
                                                        </ExpandCollapseColumn>
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="value" FilterControlAltText="Filter value column" HeaderText="ID"
                                                                UniqueName="value" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="text" FilterControlAltText="Filter text column" HeaderText="Code"
                                                                UniqueName="text" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings EnablePostBackOnRowClick="false">
                                                        <ClientEvents OnRowClick="ddl3RowClicked"></ClientEvents>
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </div>
                                        </ItemTemplate>
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                        </Items>
                                    </telerik:RadComboBox>
                                </span>
                                <asp:CheckBox ID="cbxddl3" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />
                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="lblddl4" runat="server" Text="ddl4" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>
                                <span class="combo125" style="float: left;">
                                    <telerik:RadComboBox ID="ddl4" AutoPostBack="false" runat="server" Width="124px" DropDownWidth="124px"
                                        EmptyMessage="Please select...">
                                        <ItemTemplate>
                                            <div style="overflow: auto; max-height: 300px;">

                                                <telerik:RadGrid ID="rGrdddl44DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                    CellSpacing="0" GridLines="None" Width="124px" ClientSettings-EnableRowHoverStyle="True"
                                                    
                                                    AllowFilteringByColumn="false">
                                                    <GroupingSettings CaseSensitive="false" />
                                                    <ClientSettings>
                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                    </ClientSettings>
                                                    <MasterTableView DataKeyNames="value,text" ClientDataKeyNames="value,text">
                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                            <HeaderStyle Width="2px"></HeaderStyle>
                                                        </RowIndicatorColumn>
                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                            <HeaderStyle Width="2px"></HeaderStyle>
                                                        </ExpandCollapseColumn>
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="value" FilterControlAltText="Filter value column" HeaderText="ID"
                                                                UniqueName="value" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="text" FilterControlAltText="Filter text column" HeaderText="Code"
                                                                UniqueName="text" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings EnablePostBackOnRowClick="false">
                                                        <ClientEvents OnRowClick="ddl4RowClicked"></ClientEvents>
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </div>
                                        </ItemTemplate>
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                        </Items>
                                    </telerik:RadComboBox>
                                </span>
                                <asp:CheckBox ID="cbxddl4" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />
                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="dplbl1" runat="server" Text="Label" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="dp1" Width="124px" runat="server" Style="float: left;">
                                </telerik:RadDatePicker>
                                <asp:CheckBox ID="cbxdp1" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />

                            </div>
                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="dplbl2" runat="server" Text="Label" Style="width: 100px; float: left; margin-left: 10px; margin-top: 5px;"></asp:Label>
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="dp2" Width="122px" runat="server" Style="float: left;">
                                </telerik:RadDatePicker>
                                <asp:CheckBox ID="cbxdp2" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />
                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="dplbl3" runat="server" Text="Label" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="dp3" Width="124px" runat="server" Style="float: left;">
                                </telerik:RadDatePicker>
                                <asp:CheckBox ID="cbxdp3" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />

                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="dplbl4" runat="server" Text="Label" Style="width: 100px; float: left; margin-left: 10px; margin-top: 5px;"></asp:Label>
                                <telerik:RadDatePicker RenderMode="Lightweight" ID="dp4" Width="122px" runat="server" Style="float: left;">
                                </telerik:RadDatePicker>
                                <asp:CheckBox ID="cbxdp4" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />
                            </div>


                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="rblbl1" runat="server" Text="RB Label" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>

                                <asp:RadioButtonList ID="rbl1" runat="server" RepeatDirection="Vertical" Style="width: 124px; float: left;">
                                    <Items>
                                        <asp:ListItem Text="Option 1 " Value="1" Selected="True" />
                                        <asp:ListItem Text="Option 2 " Value="2" />
                                    </Items>
                                </asp:RadioButtonList>
                                <asp:CheckBox ID="cbxrb1" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />

                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="rblbl2" runat="server" Text="RB Label" Style="width: 100px; float: left; margin-left: 10px; margin-top: 5px;"></asp:Label>
                                <asp:RadioButtonList ID="rbl2" runat="server" RepeatDirection="Vertical" Style="width: 122px; float: left;">
                                    <Items>
                                        <asp:ListItem Text="Option 1 " Value="1" Selected="True" />
                                        <asp:ListItem Text="Option 2 " Value="2" />
                                    </Items>
                                </asp:RadioButtonList>
                                <asp:CheckBox ID="cbxrb2" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />
                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="rblbl3" runat="server" Text="RB Label" Style="width: 100px; float: left; margin-left: 8px; margin-top: 5px;"></asp:Label>

                                <asp:RadioButtonList ID="rbl3" runat="server" RepeatDirection="Vertical" Style="width: 124px; float: left;">
                                    <Items>
                                        <asp:ListItem Text="Option 1 " Value="1" Selected="True" />
                                        <asp:ListItem Text="Option 2 " Value="2" />
                                    </Items>
                                </asp:RadioButtonList>
                                <asp:CheckBox ID="cbxrb3" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />

                            </div>

                            <div style="float: left; margin: 10px 0 0 0;">
                                <asp:Label ID="rblbl4" runat="server" Text="RB Label" Style="width: 100px; float: left; margin-left: 10px; margin-top: 5px;"></asp:Label>
                                <asp:RadioButtonList ID="rbl4" runat="server" RepeatDirection="Vertical" Style="width: 122px; float: left;">
                                    <Items>
                                        <asp:ListItem Text="Option 1 " Value="1" Selected="True" />
                                        <asp:ListItem Text="Option 2 " Value="2" />
                                    </Items>
                                </asp:RadioButtonList>
                                <asp:CheckBox ID="cbxrb4" runat="server" ClientIDMode="Predictable" Style="float: left; vertical-align: text-top; margin-top: 4px" />
                            </div>

                        </asp:Panel>


                    </div>
                </div>
                <div style="border: 0px black solid; width: 322px; float: left;display:inline-block">
                    <div style="margin: 10px; border: 1px black solid; width: 300px; float: left">
                        <br />
                        <lagend style="margin: 10px;">Requester</lagend>

                        <div style="margin: 10px 0 0 0;">
                            <div style="float: left; margin: 6px 0 0 18px; width: 100px;">
                                Date
                            </div>
                            <asp:Label ID="lblDate" runat="server" Style="width: 150px; padding-left: 5px; margin: 6px 0px 0px 0px"></asp:Label>
                        </div>
                        <br />
                        <div>
                            <div style="float: left; margin: 6px 0 0 18px; width: 100px;">
                                Requester
                            </div>
                            <asp:TextBox TextMode="MultiLine" Enabled="false" ID="txtRequester" runat="server" Style="width: 150px; height: 60px; padding-left: 5px" />
                        </div>
                        <br />
                        <div style="margin-left: 120px">
                            <button title="Submit" style="float: left;" id="closeRequester" runat="server" visible="false" onclick="returnToRequesterParent(); return false;">
                                Submit</button>
                        </div>
                    </div>

                    <div style="margin: 5px 10px; border: 1px black solid; width: 300px; float: left">
                        <br />
                        <lagend style="margin: 10px;">Approver</lagend>
                        <div>
                            <div style="float: left; margin: 6px 0 0 18px; width: 100px;">
                                Date
                            </div>
                            <telerik:RadDatePicker ID="dtpApproverDate" runat="server" Enabled="false" Culture="en-US" Style="padding-left: 5px; margin: 6px 0px 0px 0px" Width="150px">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                            </telerik:RadDatePicker>
                        </div>
                        <br />
                        <div>
                            <div style="float: left; margin: 0px 0 5px 18px; width: 100px;">
                                Approve/Reject
                            </div>
                            <telerik:RadButton ID="radioApprove" Checked="true" runat="server" ClientIDMode="Static" Enabled="false" ToggleType="Radio" ButtonType="ToggleButton"
                                Text="Approve" GroupName="StandardButton">
                            </telerik:RadButton>
                            <telerik:RadButton ID="radioReject" runat="server" ToggleType="Radio" ClientIDMode="Static" Enabled="false" ButtonType="ToggleButton"
                                Text="Reject" GroupName="StandardButton">
                            </telerik:RadButton>
                        </div>
                        <br />
                        <div>
                            <div style="float: left; margin: 6px 0 0 18px; width: 100px; height: 100px">
                                Approver
                            </div>
                            <asp:TextBox TextMode="MultiLine" ID="txtbxApprover" Enabled="false" runat="server" Style="width: 150px; height: 60px; padding-left: 5px" />
                        </div>
                        <br />
                        <div>
                            <button title="Submit" style="float: left;" id="closeApprover" runat="server" visible="false" onclick="returnToApproverParent(); return false;">
                                Submit</button>
                        </div>
                    </div>
                    <div style="margin: 10px; border: 1px black solid; width: 300px; float: left">
                        <br />
                        <lagend style="margin: 10px;">Owner</lagend>

                        <div>
                            <div style="float: left; margin: 6px 0 0 18px; width: 100px;">
                                Date
                            </div>
                            <telerik:RadDatePicker ID="dtpdate" runat="server" Culture="en-US" Enabled="false" Style="padding-left: 5px; margin: 6px 0px 0px 0px" Width="150px">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                            </telerik:RadDatePicker>
                        </div>
                        <br />
                        <div>
                            <div style="float: left; margin: 0px 0 5px 18px; width: 100px;">
                                Is Provided
                            </div>
                            <asp:CheckBox ID="chkIsProvided" runat="server" Enabled="false" ClientIDMode="Predictable" Style="vertical-align: text-bottom; margin-top: 5px" />
                        </div>
                        <br />
                        <div>
                            <div style="float: left; margin: 6px 0 0 18px; width: 100px; height: 100px">
                                Owner
                            </div>
                            <asp:TextBox TextMode="MultiLine" ID="txtOwner" Enabled="false" runat="server" Style="width: 150px; height: 60px; padding-left: 5px" />
                        </div>
                        <br />
                        <div>
                            <button title="Submit" id="closeOwner" style="float: left" runat="server" visible="false" onclick="returnToOwnerParent(); return false;">
                                Submit</button>
                        </div>
                    </div>
                </div>
               
            </div>
        </fieldset>
    </form>
</body>
</html>

