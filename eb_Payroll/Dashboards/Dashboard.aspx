<%@ Page Title="Dashboard"  Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master"
    AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">

    <style type="text/css">
        .RadComboBox .rcbInputCellLeft {
            box-shadow: none;
            position: relative !important;
            height: 25px !important;
            float: left !important;
            width: 30px !important;
            padding: 5px 0 0 10px !important;
            margin-top: 0px !important;
            border-bottom: 0px !important;
        }
        .RadComboBoxDropDown {
            min-width: 68px;
            margin: 0 0 5px 0!important;
            padding: 0px!important;
        }

     /* .RadComboBox .rcbInputCellLeft input {
            box-shadow: none;
            width: 30px !important;
            background-color: transparent !important;
            height: 16px!important;
            font-size: 12px!important;
            margin-left: -11px;
            margin-top: -6px;
            padding-right: 5px !important;
        }*/
    </style>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
            function ShowTab(tab) {
                var wd = $("div[class^='widget']");
                wd.contentTabs();

                if (tab != "#tab1") {
                    wd.find("ul.tabs li:first").removeClass("activeTab").show(); //Activate first tab
                    wd.find(".tab_content:first").hide(); //Show first tab content

                    wd.find('a[href="' + tab + '"]').parent().addClass("activeTab"); //Add "active" class to selected tab
                    $(tab).show(); //Fade in the active content
                }
            }
        </script>
    </telerik:RadCodeBlock>

    <div class="col-6 col-m-6" style="display:block; float:left; box-sizing:border-box; padding-bottom:0px !important">
        <div class="widget"  style="padding-bottom:0px !important">
            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel1"  style="padding-bottom:0px !important">
                <div class="formRight" style="padding-bottom:0px !important">
                    <telerik:RadGrid ID="gvSubmitted" runat="server" AllowPaging="True" AllowSorting="True"
                        AllowFilteringByColumn="false" AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                        OnNeedDataSource="gvSubmitted_NeedDataSource" PageSize="20"
                        ShowStatusBar="false" OnItemCommand="gvSubmitted_ItemCommand"
                        OnItemDataBound="gvSubmitted_ItemDataBound"
                        OnDetailTableDataBind="gvSubmitted_DetailTableDataBind">
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <ClientSettings>
                            <Selecting CellSelectionMode="None"></Selecting>
                        </ClientSettings>
                        <ExportSettings
                            HideStructureColumns="true"
                            ExportOnlyData="true"
                            IgnorePaging="true"
                            OpenInNewWindow="true">
                            <Csv ColumnDelimiter="Tab" RowDelimiter="NewLine" FileExtension="TXT" EncloseDataWithQuotes="false" />
                            <Pdf PaperSize="A4">
                            </Pdf>
                        </ExportSettings>
                        <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="TypeId"
                            InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                            <DetailTables>
                                <telerik:GridTableView runat="server" Name="SubmittedDetail" CommandItemDisplay="Top" EditMode="InPlace" DataKeyNames="recidd">
                                    <CommandItemTemplate>
                                        <div class="title">
                                            <img src="../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Submitted Requests Detail</h6>
                                        </div>
                                        <tr class="rgCommandRow">
                                            
                                            <td colspan="9" class="rgCommandCell">

                                                <table style="width: 100%;" summary="Command item for additional functionalities for the grid like adding a new record and exporting." class="rgCommandTable">
                                                    <caption>

                                                        <span style="display: none">Command item</span>
                                                    </caption>
                                                    <thead>
                                                        <tr>
                                                            <th scope="col"></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>

                                                            <td align="left">
                                                                <%--                                                                    <asp:Button ID="btnNotificationDetailAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />--%>
                                                            </td>
                                                            <td align="right">
                                                                <%-- <asp:Button runat="server" ID="btnNotificationDetailExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" ID="btnNotificationDetailCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" ID="btnNotificationDetailPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                    <asp:Button runat="server" ID="btnNotificationDetailPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />--%>

                                                                <asp:Button ID="btnNotificationDetailRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </CommandItemTemplate>
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <DetailTables>
                                    </DetailTables>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="recidd" Visible="false" FilterControlAltText="Filter column column"
                                            HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32">
                                            <ColumnValidationSettings>
                                                <ModelErrorMessage Text=""></ModelErrorMessage>
                                            </ColumnValidationSettings>
                                            <FilterTemplate>
                                                <strong>Search</strong>
                                            </FilterTemplate>
                                            <ItemStyle Width="50px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn DataField="transactionNumber" FilterControlWidth="110px" SortExpression="transactionNumber" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Transaction No." UniqueName="transactionNumber">
                                            <ItemTemplate>
                                                <asp:Label ID="lbltransactionNumber" runat="server" Text='<%# Eval("transactionNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="RequestDate" FilterControlWidth="110px" SortExpression="RequestDate" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Request Date" UniqueName="RequestDate">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRequestDate" runat="server" Text='<%# Eval("RequestDate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="hlRedirect" runat="server" NavigateUrl='<%# Eval("RedirectURL") %>' CssClass="tipS">
                                                    <img src="../images/goto.gif" alt="" title="View"  />
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <%--<telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditNotificationDetail">
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Notification Detail record?"
                                                ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteNotificationDetail" ConfirmTextFormatString='Are you sure to delete Notification Detail record # {0}?'>
                                                <ItemStyle HorizontalAlign="Center" Width="0px" />
                                            </telerik:GridButtonColumn>--%>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                    </SortExpressions>
                                    <EditFormSettings>
                                        <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </telerik:GridTableView>
                            </DetailTables>
                            <CommandItemTemplate>
                                <tr class="rgCommandRow">
            <div class="title">
                                        <img src="../images/icons/dark/users.png" alt="" class="titleIcon" /><h6>Submitted Requests</h6>
                <div class="num">
                    <a class="blueNum">
                                                <asp:Literal ID="ltSubmittedCount" runat="server"></asp:Literal></a>
                </div>
            </div>
                                    <td colspan="10" class="rgCommandCell">

                                        <table style="width: 100%;" summary="Command item for additional functionalities for the grid like adding a new record and exporting." class="rgCommandTable">
                                        
                                              <caption>

                                                <span style="display: none">Command item</span>
                                            </caption>
                                            <thead>
                                                <tr>
                                                    <th scope="col"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td align="left">
                                                        <%--                                                        <asp:Button ID="Button1" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlteracteText="Add" ToolTip="Add" />--%>
                                                    </td>
                                                    <td align="right">
                                                        <%-- <asp:Button runat="server" ID="btnNotificationExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlteracteText="Excel" ToolTip="Excel" />

                                                        <asp:Button runat="server" ID="btnNotificationCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlteracteText="Csv" ToolTip="Csv" />
            
                                                        <asp:Button runat="server" ID="btnNotificationPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlteracteText="Pdf" ToolTip="Pdf" />
                                                        <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px">
                                                        </telerik:RadComboBox>
                                                        <asp:Button runat="server" ID="btnNotificationPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlteracteText="Print" ToolTip="Print" />--%>

                                                        <asp:Button ID="btnNotificationRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlteracteText="Refresh" ToolTip="Refresh" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </CommandItemTemplate>
                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridBoundColumn DataField="TypeId" SortExpression="TypeId" FilterControlAltText="Filter column column"
                                    HeaderText="ID" UniqueName="TypeId" ReadOnly="True" DataType="System.Int32" Visible="False">
                                    <ColumnValidationSettings>
                                        <ModelErrorMessage Text=""></ModelErrorMessage>
                                    </ColumnValidationSettings>
                                    <FilterTemplate>
                                        <strong>Search</strong>
                                    </FilterTemplate>
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="RequestType" FilterControlWidth="130px" SortExpression="RequestType"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Request Type" UniqueName="RequestType">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRequestType" runat="server" Text='<%# Eval("RequestType") %>'></asp:Label>
                                    </ItemTemplate>

                                    </telerik:GridTemplateColumn>
                                <%-- <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditNotification"
                                    ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Notification?"
                                    ConfirmTextFields="TypeId" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                    UniqueName="DeleteNotification" ConfirmTextFormatString='Are you sure to delete Notification record "{0}"?'>
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridButtonColumn>--%>
                            </Columns>
                            <EditFormSettings CaptionFormatString='Edit Details for Notification "{0}":' CaptionDataField="TypeId">
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                                <EditColumn ButtonType="ImageButton" />
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </telerik:RadAjaxPanel>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" IsSticky="true" runat="server" Transparency="20" style="padding:0px !important">
            </telerik:RadAjaxLoadingPanel>  
        </div>
        <div class="clear"  style="padding:0px !important"></div>
    </div>

    <div class="col-6 col-m-6" style="display:block; float:left; box-sizing:border-box; padding:0px !important">
        <div class="widget" style="padding:0px !important">
            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1" style="padding:0px !important">
                <div class="formRight" >
                    <telerik:RadGrid ID="gvNotification" runat="server" AllowPaging="True" AllowSorting="True"
                        AllowFilteringByColumn="false" AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                        OnNeedDataSource="gvNotification_NeedDataSource" PageSize="20"
                        ShowStatusBar="false" OnItemCommand="gvNotification_ItemCommand"
                        OnItemDataBound="gvNotification_ItemDataBound"
                        OnDetailTableDataBind="gvNotification_DetailTableDataBind">
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <ClientSettings>
                            <Selecting CellSelectionMode="None"></Selecting>
                        </ClientSettings>
                        <ExportSettings
                            HideStructureColumns="true"
                            ExportOnlyData="true"
                            IgnorePaging="true"
                            OpenInNewWindow="true">
                            <Csv ColumnDelimiter="Tab" RowDelimiter="NewLine" FileExtension="TXT" EncloseDataWithQuotes="false" />
                            <Pdf PaperSize="A4">
                            </Pdf>
                        </ExportSettings>
                        <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="TypeId"
                            InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                            <DetailTables>
                                <telerik:GridTableView runat="server" Name="NotificationDetail" CommandItemDisplay="Top" EditMode="InPlace" DataKeyNames="recidd">
                                    <CommandItemTemplate>
                                        <div class="title">
                                            <img src="../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Notification Detail</h6>
                                        </div>
                                        <tr class="rgCommandRow">
                                            
                                            <td colspan="9" class="rgCommandCell">

                                                <table style="width: 100%;" summary="Command item for additional functionalities for the grid like adding a new record and exporting." class="rgCommandTable">
                                                    <caption>

                                                        <span style="display: none">Command item</span>
                                                    </caption>
                                                    <thead>
                                                        <tr>
                                                            <th scope="col"></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>

                                                            <td align="left">
                                                                <%--                                                                    <asp:Button ID="btnNotificationDetailAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />--%>
                                                            </td>
                                                            <td align="right">
                                                                <%-- <asp:Button runat="server" ID="btnNotificationDetailExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" ID="btnNotificationDetailCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" ID="btnNotificationDetailPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                    <asp:Button runat="server" ID="btnNotificationDetailPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />--%>

                                                                <asp:Button ID="btnNotificationDetailRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </CommandItemTemplate>
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <DetailTables>
                                    </DetailTables>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="recidd" Visible="false" FilterControlAltText="Filter column column"
                                            HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32">
                                            <ColumnValidationSettings>
                                                <ModelErrorMessage Text=""></ModelErrorMessage>
                                            </ColumnValidationSettings>
                                            <FilterTemplate>
                                                <strong>Search</strong>
                                            </FilterTemplate>
                                            <ItemStyle Width="50px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn DataField="transactionNumber" FilterControlWidth="110px" SortExpression="transactionNumber" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Transaction No." UniqueName="transactionNumber">
                                            <ItemTemplate>
                                                <asp:Label ID="lbltransactionNumber" runat="server" Text='<%# Eval("transactionNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="RequestDate" FilterControlWidth="110px" SortExpression="RequestDate" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Request Date" UniqueName="RequestDate">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRequestDate" runat="server" Text='<%# Eval("RequestDate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="hlRedirect" runat="server" NavigateUrl='<%# Eval("RedirectURL") %>' CssClass="tipS">
                                                    <img src="../images/goto.gif" alt="" title="View"  />
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <%--<telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditNotificationDetail">
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Notification Detail record?"
                                                ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteNotificationDetail" ConfirmTextFormatString='Are you sure to delete Notification Detail record # {0}?'>
                                                <ItemStyle HorizontalAlign="Center" Width="0px" />
                                            </telerik:GridButtonColumn>--%>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                    </SortExpressions>
                                    <EditFormSettings>
                                        <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </telerik:GridTableView>
                            </DetailTables>
                            <CommandItemTemplate>
                                <tr class="rgCommandRow">
                                    <div class="title" style="padding:0px !important">
                                        <img src="../images/icons/dark/users.png" alt="" class="titleIcon" /><h6>Approval Notifications</h6>
                                        <div class="num" style="padding:0px !important">
                                            <a class="blueNum">
                                                <asp:Literal ID="ltNotiCount" runat="server"></asp:Literal></a>
                                        </div>
                                    </div>
                                    <td colspan="10" class="rgCommandCell">

                                        <table style="width: 100%;padding:0px !important" summary="Command item for additional functionalities for the grid like adding a new record and exporting." class="rgCommandTable">
                                        
                                              <caption>

                                                <span style="display: none">Command item</span>
                                            </caption>
                                            <thead>
                                                <tr>
                                                    <th scope="col"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td align="left">
                                                        <%--                                                        <asp:Button ID="Button1" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlteracteText="Add" ToolTip="Add" />--%>
                                                    </td>
                                                    <td align="right">
                                                        <%-- <asp:Button runat="server" ID="btnNotificationExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlteracteText="Excel" ToolTip="Excel" />

                                                        <asp:Button runat="server" ID="btnNotificationCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlteracteText="Csv" ToolTip="Csv" />

                                                        <asp:Button runat="server" ID="btnNotificationPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlteracteText="Pdf" ToolTip="Pdf" />
                                                        <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px">
                                                        </telerik:RadComboBox>
                                                        <asp:Button runat="server" ID="btnNotificationPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlteracteText="Print" ToolTip="Print" />--%>

                                                        <asp:Button ID="btnNotificationRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlteracteText="Refresh" ToolTip="Refresh" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </CommandItemTemplate>
                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridBoundColumn DataField="TypeId" SortExpression="TypeId" FilterControlAltText="Filter column column"
                                    HeaderText="ID" UniqueName="TypeId" ReadOnly="True" DataType="System.Int32" Visible="False">
                                    <ColumnValidationSettings>
                                        <ModelErrorMessage Text=""></ModelErrorMessage>
                                    </ColumnValidationSettings>
                                    <FilterTemplate>
                                        <strong>Search</strong>
                                    </FilterTemplate>
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="RequestType" FilterControlWidth="130px" SortExpression="RequestType"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Request Type" UniqueName="RequestType">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRequestType" runat="server" Text='<%# Eval("RequestType") %>'></asp:Label>
                                    </ItemTemplate>

                                    </telerik:GridTemplateColumn>
                                <%-- <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditNotification"
                                    ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Notification?"
                                    ConfirmTextFields="TypeId" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                    UniqueName="DeleteNotification" ConfirmTextFormatString='Are you sure to delete Notification record "{0}"?'>
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridButtonColumn>--%>
                            </Columns>
                            <EditFormSettings CaptionFormatString='Edit Details for Notification "{0}":' CaptionDataField="TypeId">
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                                <EditColumn ButtonType="ImageButton" />
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </telerik:RadAjaxPanel>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" IsSticky="true" runat="server" Transparency="20" >
            </telerik:RadAjaxLoadingPanel>  
        </div>
        <div class="clear" style="padding:0px !important"></div>
    </div>



      <div id="grpchart" class="col-6 col-m-6" style="display:block; float:left; box-sizing:border-box;">
        <div class="widget">
            <div class="title">
                <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>Reimbursment Charts</h6>
                <div class="num">
                    <a class="blueNum">
                        <asp:Literal ID="Literal3" runat="server"></asp:Literal></a>
                </div>
            </div>
            <%--<table cellpadding="0" cellspacing="0" width="100%" class="display dTable mainTable">--%>
                <telerik:RadChart ID="RadChart1" runat="server" DataSourceID="SqlDataSource1" Skin="ExcelClassic" Width="300px" Height="250px" DefaultType="Pie" Visible="False" >
                    <Series>
                        <telerik:ChartSeries DataLabelsColumn="exptcod" DataYColumn="value" Name="value" Type="Pie">
                            <Appearance>
                                <FillStyle MainColor="156, 154, 255" SecondColor="156, 154, 255">
                                </FillStyle>
                                <Border Color="Black" />
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                    <Legend>
                        <Appearance>
                            <ItemTextAppearance TextProperties-Font="Verdana, 9pt">
                            </ItemTextAppearance>
                            <Border Color="Black" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis AutoScale="False" DataLabelsColumn="exptcod" MaxValue="7" MinValue="1" Step="1">
                            <Appearance>
                                <MajorGridLines Color="DimGray" Width="0" />
                            </Appearance>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Font="Verdana, 9.75pt, style=Bold">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                            <Items>
                                <telerik:ChartAxisItem Value="1">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="2">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="3">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="4">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="5">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="6">
                                </telerik:ChartAxisItem>
                                <telerik:ChartAxisItem Value="7">
                                </telerik:ChartAxisItem>
                            </Items>
                        </XAxis>
                        <YAxis>
                           <%-- <Appearance>
                                <MajorGridLines Color="Black" />
                            </Appearance>--%>
<Appearance MinorTick-Width="0">
<MajorGridLines Color="Black"></MajorGridLines>
    <MinorGridLines Width="0" />
</Appearance>

                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Font="Verdana, 9.75pt, style=Bold">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis>
                        <YAxis2>
                            <AxisLabel>
                                <TextBlock>
                                    <Appearance TextProperties-Font="Verdana, 9.75pt, style=Bold">
                                    </Appearance>
                                </TextBlock>
                            </AxisLabel>
                        </YAxis2>
                        <Appearance Corners="Round, Round, Round, Round, 6">
                            <FillStyle MainColor="Silver" FillType="Solid">
                            </FillStyle>
                            <%--<Border Color="94, 94, 93" />--%>

<Border Color="Gray"></Border>
                        </Appearance>
                    </PlotArea>
                    <ChartTitle>
                        <Appearance Dimensions-Margins="4%, 10px, 14px, 0%" Position-AlignedPosition="Top">
                        </Appearance>
                        <TextBlock Text="Reimbur. by Exp. Type">
                            <Appearance TextProperties-Color="Black" TextProperties-Font="Verdana, 12pt">
                            </Appearance>
                        </TextBlock>
                    </ChartTitle>
                </telerik:RadChart>

            <telerik:RadHtmlChart runat="server" ID="DonutChart" Transitions="true" Skin="WebBlue">
    <Appearance>
        <FillStyle BackgroundColor="White"></FillStyle>
    </Appearance>
    <ChartTitle Text="Reimbursment requests by Status">
   <Appearance>
            <%--<TextStyle Color= "BlueViolet" FontSize="18"   />--%>
        </Appearance>
    </ChartTitle>
    <PlotArea>
        <Series>
            <telerik:DonutSeries HoleSize="50">
                <LabelsAppearance Visible="false">
                </LabelsAppearance>
                <TooltipsAppearance DataFormatString="{0}%" BackgroundColor="White"></TooltipsAppearance>
                <SeriesItems>
                    <telerik:PieSeriesItem  Name="Pending"
                        Y="55.6"></telerik:PieSeriesItem>
                    <telerik:PieSeriesItem Name="Draft" Y="2.5"></telerik:PieSeriesItem>
                    <telerik:PieSeriesItem Name="In Process" Y="2.8"></telerik:PieSeriesItem>
                    <telerik:PieSeriesItem Name="Submitted" Y="1.8"></telerik:PieSeriesItem>
                    <telerik:PieSeriesItem Name="Revise" Y="21.1"></telerik:PieSeriesItem>
                    <telerik:PieSeriesItem Name="Rejected" Y="4.7"></telerik:PieSeriesItem>
                    <telerik:PieSeriesItem Name="Approved" Y="8.7"></telerik:PieSeriesItem>
                    <telerik:PieSeriesItem Name="Completed" Y="2.2"></telerik:PieSeriesItem>
                </SeriesItems>
            </telerik:DonutSeries>
        </Series>
    </PlotArea>
</telerik:RadHtmlChart>

            <telerik:RadHtmlChart runat="server" ID="FunnelChart1" Width="450" Height="400" Skin="WebBlue">
    <PlotArea>
        <Series>
            <telerik:FunnelSeries DynamicSlopeEnabled="false" DynamicHeightEnabled="true" SegmentSpacing="5" NeckRatio="0.4">
                <SeriesItems>
                    <telerik:FunnelSeriesItem Y="20" Name="Pending" />
                    <telerik:FunnelSeriesItem Y="5" Name="In Process" />
                    <telerik:FunnelSeriesItem Y="10" Name="Completed" />
                    <telerik:FunnelSeriesItem Y="2" Name="Rejected" />
                    <telerik:FunnelSeriesItem Y="1" Name="Revised" />
                </SeriesItems>
            </telerik:FunnelSeries>
        </Series>
    </PlotArea>
    <ChartTitle Text="">
    </ChartTitle>
</telerik:RadHtmlChart>
            </div>
          </div>
    <div id="grpchart" class="col-6 col-m-6" style="display:block; float:left; box-sizing:border-box;">
        <div class="widget">
            <div class="title">
                <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>Leave Charts</h6>
                <div class="num">
                    <a class="blueNum">
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal></a>
                </div>
            </div>
            <telerik:RadHtmlChart runat="server" ID="BarChart1"  Transitions="true" Skin="WebBlue">
    <PlotArea>
        <Series>
            <telerik:BarSeries Name="Annual Leave Taken" Stacked="false">
               <%-- <Appearance>
                    <FillStyle BackgroundColor="RoyalBlue" />
                </Appearance>--%>
                <LabelsAppearance  Position="Center" />
                <%--<TooltipsAppearance BackgroundColor="White"  />--%>
                <SeriesItems>
                    <telerik:CategorySeriesItem Y="30" />
                    <telerik:CategorySeriesItem Y="5" />
                    <telerik:CategorySeriesItem Y="10" />
                </SeriesItems>
            </telerik:BarSeries>
            <telerik:BarSeries Name="Sick Leave Taken">
                <Appearance>
                    <%--<FillStyle BackgroundColor="Red" />--%>
                </Appearance>
                <LabelsAppearance  Position="Center" />
                <%--<TooltipsAppearance BackgroundColor="Gray" />--%>
                <SeriesItems>
                    <telerik:CategorySeriesItem Y="20" />
                    <telerik:CategorySeriesItem Y="2" />
                    <telerik:CategorySeriesItem Y="9" />
                </SeriesItems>
            </telerik:BarSeries>
        </Series>
        <XAxis AxisCrossingValue="0" Color="Black" MajorTickType="Outside" MinorTickType="Outside"
            Reversed="false">
            <Items>
                <telerik:AxisItem LabelText="1001" />
                <telerik:AxisItem LabelText="1002" />
                <telerik:AxisItem LabelText="1005" />
            </Items>
            <LabelsAppearance DataFormatString="Emp: {0}" RotationAngle="0" />
           <%-- <MajorGridLines Color="#EFEFEF" Width="1" />
            <MinorGridLines Color="Black" Width="1" />--%>
            <TitleAppearance Position="Center" RotationAngle="0" Text="Employee" />
        </XAxis>
        <YAxis AxisCrossingValue="0"  MajorTickSize="1" MajorTickType="Outside"
            MaxValue="90" MinorTickSize="10" MinorTickType="Outside" MinValue="0" Reversed="false"
            Step="10">
            <LabelsAppearance  RotationAngle="0" />
            <%--<MajorGridLines Color="#EFEFEF" Width="1" />--%>
            <%--<MinorGridLines Color="#F7F7F7" Width="1" />--%>
            <TitleAppearance Position="Center" RotationAngle="0" Text="Days" />
        </YAxis>
    </PlotArea>
    <ChartTitle Text="Annual Leave Comparison 2020">

    </ChartTitle>
    <Legend>
        <Appearance Position="Bottom" />
    </Legend>
</telerik:RadHtmlChart>

            <telerik:RadHtmlChart runat="server" ID="BulletChart1" Width="600" Height="300" Transitions="true" Skin="WebBlue">
    <ChartTitle Text="Annual Leaves">
       <Appearance>
            <TextStyle   FontSize="18"   />
        </Appearance>

    </ChartTitle>

    <PlotArea>

        <Series>
            <telerik:BulletSeries>
                <SeriesItems>
                    <telerik:BulletSeriesItem Current="12" Target="15" />
                    <telerik:BulletSeriesItem Current="18" Target="15" />
                    <telerik:BulletSeriesItem Current="5" Target="20" />
                    <telerik:BulletSeriesItem Current="22" Target="20" />
                    <telerik:BulletSeriesItem Current="15" Target="15" />
                </SeriesItems>
  <Appearance>
                    <%--<FillStyle BackgroundColor="green" />--%>
                </Appearance>            </telerik:BulletSeries>
        </Series>
        <XAxis AxisCrossingValue="0" MajorTickType="Outside" MinorTickType="None"
            Reversed="false">
            <Items>
                <telerik:AxisItem LabelText="1001"></telerik:AxisItem>
                <telerik:AxisItem LabelText="1002"></telerik:AxisItem>
                <telerik:AxisItem LabelText="1003"></telerik:AxisItem>
                <telerik:AxisItem LabelText="1004"></telerik:AxisItem>
                <telerik:AxisItem LabelText="1005"></telerik:AxisItem>
            </Items>
            <TitleAppearance Position="Center" RotationAngle="0" Text="Employee"></TitleAppearance>
            <MajorGridLines Visible="false" />
            <MinorGridLines Visible="false" />
        </XAxis>
        <YAxis AxisCrossingValue="0" MajorTickSize="1"  
Reversed="false">
            <MajorGridLines Visible="false" />
            <MinorGridLines Visible="false" />
        </YAxis>
    </PlotArea>
</telerik:RadHtmlChart>

               <asp:SqlDataSource runat="server" ID="SqlDataSource1" SelectCommandType="StoredProcedure"
                        SelectCommand="eb_dsh_expensevaluebycategory"
                        ConnectionString="<%$ ConnectionStrings:eb_payroll %>" />
            <%--</table>--%>
        </div>
  
    </div>

    
    <div class="clear"></div>
<%--    <asp:SqlDataSource ID="Sql_applicant_status" runat="server" ConnectionString="<%$ ConnectionStrings:connection%>" SelectCommand="dsh_applicantstatuses" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connection%>" SelectCommand="dsh_usercountforroles" SelectCommandType="StoredProcedure"></asp:SqlDataSource>--%>
</asp:Content>
