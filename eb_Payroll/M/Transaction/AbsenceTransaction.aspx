<%@ Page Title="Absence Request"  Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master"
    AutoEventWireup="true" CodeFile="AbsenceTransaction.aspx.cs" Inherits="AbsenceTransaction" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/M/Controls/ucEmployeeCard.ascx" TagPrefix="uc1" TagName="ucEmployeeCard" %>
<%@ Register Src="~/M/Controls/ucEmployeeLeaveBalance.ascx" TagPrefix="uc1" TagName="ucEmployeeLeaveBalance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <link type="text/css" rel="Stylesheet" href="../../App_Themes/Dark/Styles/rafia.css" />
    <!--<link type="text/css" rel="Stylesheet" href="../App_Themes/Default/Styles/main.css" />-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
<style type="text/css">


         .myBtn 
         {
            display: none;
            position: fixed;
            bottom: 20px;
            right: 30px;
            z-index: 99;
            border-radius:50%;
            cursor: pointer;
            width:40px;
            padding:25px;
            background-repeat:no-repeat;
            background-color:#2d6b9b;
            }


        .widget .title
            {
                line-height:22px;
                    }
        .accordion
        {
            max-height: 40px;
            background-color: #eee;
            color: #444;
            cursor: pointer;
            padding: 0px;
            width: 100%;
            border: none;
            text-align: left;
            outline: none;
            font-size: 15px;
            transition: 0.4s;
                    }
        #panel
        {
            padding: 0 0px;
            display: none;

                    }
        .heading
        {
            display: inline-block;
            float: left;
            font-size: 12px;
            color: #2E6B9B;
                    }
        button
        {
            text-transform:none;
                        }
        .RadAjaxPanel
        {
            padding: 0px 0px 0px 0px;
                        }
        .wEmployeePreview
        {
            margin-top: 3px;
            margin-left: 3px;
            margin-right: 3px;
                    }
        .widget
        {
            margin-top: 0px;
            margin-left: 3px;
            margin-right: 3px;
                            }
        .widget13, .widget14, .widget15
        {
            margin-top: 3px;
            margin-left: 3px;
            margin-right: 3px;
                            }
        .form input[type=text], .form input[type=password], .form textarea
        {
            width:50%;
                        }

        .wNavButtons .RadAjaxPanel
        {
            float: left;
            margin-left: 5px;
                        }
        .rgEditForm > table tr
        {
            height: 0px!important;
                    }
        #mainDiv
        {
            padding: 5px;
            border: 1px solid #cdcdcd;
            margin: 5px;
                    }
        .OuterddlsDiv
        {
            float:left;
            height: 46px;
                    }
        .ddlLabel
        {
            padding-top: 7px;
            float: left;
            padding-left: 10px;
            width: 67px;
                    }
        .OuterddlsDiv .RadAjaxPanel
        {
            float: left;

                }
        .tab_content
        {
            padding: 0px 0px;
            }

        /*@media only screen and (min-width: 1026px)
        {
            .RadComboBoxDropDown
            {
                width: 350px!important;
            }

            .RadComboBoxDropDown .Radgrid
            {
                width: 350px!important;
            }
        }*/
        @media only screen and (min-width: 601px) and (max-width: 1025px)
        {
            /*.RadComboBoxDropDown
            {
                width: 350px!important;
            }*/
       /*     .RadGrid_Silk input.rgFilterBox
            {
                width: 40%!important;
            }
*/
            .RadGrid .rgFilterRow > td
            {
                padding-left: 0px!important;
                padding-right: 0px!important;
            }
            .ddlVisible
            {
                display:none;
            }
            }


        @media only screen and (min-width: 0px) and (max-width: 600px)
        {
            .Responsiveddl
            {
                width: 180px!important;
            }
            .pageTitle
            {
                padding: 7px 0px 0px 0px !important;
            }
            .pageTitle h5
            {
                font-size: 20px;
            }
  /*          .RadGrid_Silk input.rgFilterBox
            {
                width: 80%!important;
            }

            .RadGrid_Silk .rgFilter
            {
                display: none;
            }*/

            .RadGrid .rgFilterRow > td
            {
                padding-left: 0px!important;
                padding-right: 0px!important;
            }

            #mainDiv
            {
                padding: 0px!important;
                border: 1px solid #cdcdcd;
                margin: 0px!important;
            }
            .ddlVisible
            {
                display:none;
                        }
            .tabLabelVisible
            {
                display:none;
                    }
            .tabimg
            {
                padding-top:6px;
                }
            .widget .title
            {
                height: 25px;
                line-height:11px;
            }

            .wEmployeePreview .title .titleIcon
            {
                padding: 7px 8px;
                }
            .line
            {
                display:none;
                }

            .comboResponsive .RadComboBox {width:180px!important}
            .comboResponsive .RadComboBox .RadGrid {width:180px!important}
            .comboResponsive .RadComboBox .rcbInputCellLeft input{width: 145px !important; }
            .comboResponsive .RadComboBox .rcbInputCellLeft{width: 142px !important;}
            }
    </style>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function HideTabs() {

                var tab = '#tab4';
                var wd = $("div[class^='widget']");
                if (wd != null && wd != undefined) {

                    wd.find("ul.tabs li:nth-child(1)").removeClass("activeTab").hide(); //Deactivate first tab and hide
                    wd.find("ul.tabs li:nth-child(2)").removeClass("activeTab").hide(); //Deactivate 2nd tab and hide
                    wd.find("ul.tabs li:nth-child(3)").removeClass("activeTab").hide(); //Deactivate 3rd tab and hide
                    wd.find(".tab_content:nth-child(n)").hide(); //hide all tabs content 
                    wd.find('a[href="' + tab + '"]').parent().addClass("activeTab").show(); //Add "active" class to selected tab
                    $(tab).show(); //Fade in the active content

                }
            }

            function RowClickedRevise(sender, args) {
                var cellValues = args.getDataKeyValue("ID");
                var UserID = args.getDataKeyValue("ID");

                var combo = $find(sender.ClientID.replace('_i0_rGrdLevels4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);

                    combo.commitChanges();
                }, 50);
            }

            function DeleteFiles() {
                var upload = $find("<%= ruDocument.ClientID %>");
                if (upload != null && upload != undefined) {
                    var inputs = upload.getUploadedFiles().length;
                    for (i = 0; i <= inputs; i++) {
                        upload.deleteFileInputAt(0);
                    }
                }
            }



            function ValidateForm() {
                if (!Page_ClientValidate('FrmSubmit')) {
                    showValidators();
                    var str = '';
                    var rCmbEmployee = $find("<%= rCmbEmployee.ClientID %>");
                    if (rCmbEmployee.get_items().getItem(0).get_value() == undefined || rCmbEmployee.get_items().getItem(0).get_value() == "") {
                        str += 'Employee Required.<br/>';
                    }
                    var rCmbLeaveType = $find("<%=  rCmbLeaveType.ClientID %>");
                    if (rCmbLeaveType.get_items().getItem(0).get_value() == undefined || rCmbLeaveType.get_items().getItem(0).get_value() == "") {
                        str += 'Absence Type Required.<br/>';
                    }

                    var rCmbLeaveCode = $find("<%=  rCmbLeaveCode.ClientID %>");
                    if (rCmbLeaveCode.get_items().getItem(0).get_value() == undefined || rCmbLeaveCode.get_items().getItem(0).get_value() == "") {
                        str += 'Absence Code Required.<br/>';
                    }

                    var rCmbEntryType = $find("<%=  rCmbEntryType.ClientID %>");
                    if (rCmbEntryType.get_items().getItem(0).get_value() == undefined || rCmbEntryType.get_items().getItem(0).get_value() == "") {
                        str += 'EntryType Required.<br/>';
                    }

                    if (rCmbEntryType.get_items().getItem(0).get_text() != 'Encashment' &&
                        rCmbEntryType.get_items().getItem(0).get_text() != 'Adjustment') {
                        var txtFromDate = $find("<%=  txtFromDate.ClientID %>");
                        if (txtFromDate.get_selectedDate() == undefined || txtFromDate.get_selectedDate() == "") {
                            str += 'From Date Required.<br/>';
                        }
                        var txtToDate = $find("<%=  txtToDate.ClientID %>");
                        if (txtToDate.get_selectedDate() == undefined || txtToDate.get_selectedDate() == "") {
                            str += 'To Date Required.<br/>';
                        }
                    }

                    var cbxhourly = $find("<%=  cbxhourly.ClientID %>");

                    if (cbxhourly.get_checked() == true) {
                        if ($("#hfdisFrmToTimeCtrls").val() == 'true') {
                            var tpFromTime = $find("<%=  tpFromTime.ClientID %>");
                            if (tpFromTime.get_dateInput().get_value() == undefined || tpFromTime.get_dateInput().get_value() == "") {
                                str += 'From Time Required.<br/>';
                            }

                            var tpToTime = $find("<%=  tpToTime.ClientID %>");
                            if (tpToTime.get_dateInput().get_value() == undefined || tpToTime.get_dateInput().get_value() == "") {
                                str += 'To Time Required.<br/>';
                            }
                        }
                        var txtOffHours = $find("<%=  txtOffHours.ClientID %>");
                        if (txtOffHours.get_value() == undefined || txtOffHours.get_value() == "") {
                            str += 'Off Hours Required.<br/>';
                        }

                        var txtDayPercentage = $find("<%=  txtDayPercentage.ClientID %>");
                        if (txtDayPercentage.get_value() == undefined || txtDayPercentage.get_value() == "") {
                            str += 'Day Percentage Required.<br/>';
                        }

                    }

                    var txtNumberOfDays = $find("<%=  txtNumberOfDays.ClientID %>");
                    if (txtNumberOfDays.get_value() == undefined || txtNumberOfDays.get_value() == "") {
                        str += 'Number Of Days Required.<br/>';
                    }

                    if (str != '') {
                        showError(str, null, 10000);

                        var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                        ajaxManager.ajaxRequest("Rebind");
                        return false;
                    }
                    else {
                        return true;
                    }
                }
                else
                    return true;
            }


            $(document).ready(function () {
                var str = $("#warningMsg").val();
                if (str != '') {
                    showWarning(str, null, 10000);
                }
            });

            //show/hide for CashAmountdiv. 
            function hideCashAmountDiv() {
                $("#divCashAmount").hide();
            }

            function showCashAmountDiv() {
                $("#divCashAmount").show();
            }
            //show/hide for CashCheckdiv. 
            function hideCashCheckdiv() {
                $("#divCashCheck").hide();
            }

            function showCashCheckdiv() {
                $("#divCashCheck").show();
            }
            //show/hide for LeaveSalarydiv. 
            function hideVacationSalarydiv() {
                $("#divVacationSalary").hide();
            }

            function showVacationSalarydiv() {
                $("#divVacationSalary").show();
            }
            //show/hide for divCheckboxesRow 
            function hideCheckboxesRowdiv() {
                $("#divCheckboxesRow").hide();
            }

            function showCheckboxesRowdiv() {
                $("#divCheckboxesRow").show();
            }


            //show/hide for PerDiemdiv. 
            function hidePerDiemdiv() {
                $("#divPerDiem").hide();
            }

            function showPerDiemdiv() {
                $("#divPerDiem").show();
            }
            //show/hide for Travelling Ticket. 
            function hideTicketdiv() {
                $("#divTicket").hide();
            }

            function showTicketdiv() {
                $("#divTicket").show();
            }

            function showMinutesDiv() {
                $("#minutesDiv").show();
            }

            function hideMinutesDiv() {
                $("#minutesDiv").hide();
            }


            //show/hide for TimePickerdiv. 
            function hideTimePicker() {
                $("#FromTimeDiv").hide();
                $("#ToTimeDiv").hide();
            }

            function showTimepicker() {
                $("#FromTimeDiv").show();
                $("#ToTimeDiv").show();
            }

            function checkMaxLimit() {
                var hfvalstr = $("#hfMaxCash").val();
                if (hfvalstr != '') {
                    var txtCashAmount = $("#txtCashAmount").val();
                    if (txtCashAmount != '') {
                        var hfVal = parseFloat($("#hfMaxCash").val());
                        var CashAmount = parseFloat($("#txtCashAmount").val());
                        if (CashAmount > hfVal) {
                            $("#txtCashAmount").val('');
                            showError('Cash Amount can not exceed the max limit of selected Absence type', null, 10000);
                        }
                    }
                }
            }

            function CashCheckedChanged() {
                $("#txtCashAmount").val('');

                //$("#divCashAmount").toggle();
                var chkBox = $find("<%=cbxCashcheck.ClientID%>");
                var isChecked = chkBox.get_checked();
                if (isChecked == true) {
                    $("#divCashAmount").show();
                }
                else {
                    $("#divCashAmount").hide();
                }

            }

            function TimepikerChanged() {
                //$("#FromTimeDiv").val('');
                //$("#FromTimeDiv").toggle();
                var chkBox = $find("<%=cbxhourly.ClientID%>");
                var txtOffHours = $find("<%=txtOffHours.ClientID%>");
                var isChecked = chkBox.get_checked();
                if (isChecked == true) {
                    if ($("#hfdisFrmToTimeCtrls").val() == 'true') {
                        $("#FromTimeDiv").show();
                        $("#ToTimeDiv").show();
                        //txtOffHours.enabled = false;
                    }
                    else {
                        $("#FromTimeDiv").hide();
                        $("#ToTimeDiv").hide();
                        //txtOffHours.enabled = true;
                    }
                }
                else {
                    $("#FromTimeDiv").hide();
                    $("#ToTimeDiv").hide();
                    //txtOffHours.enabled = false;
                }

            }


            function ShowEditForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvSavedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("EditForms/EditLeaveTransaction.aspx?LeaveTransactionID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowRecallForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvSubmittedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("EditForms/EditLeaveTransaction.aspx?LeaveTransactionID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            };

            function ShowSubmittedViewForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvSubmittedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ViewForms/ViewLeaveTransaction.aspx?LeaveTransactionID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowApproveForm(id, rowIndex, RequestStatusID, FormType) {
                var grid = $find("<%= gvPendingAppRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ApproveForms/ApproveLeaveTransaction.aspx?RequestID=" + id + "&RequestStatusID=" + RequestStatusID + "&FormType=" + FormType, "RadWindow2");
                return false;
            }

            function showSuccessMessage(msg) {
                showSuccess(msg, null, 10000);
            }

            function ShowApprovalViewForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvApprovedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ViewForms/ViewLeaveTransaction.aspx?LeaveTransactionID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowPendingViewForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvPendingAppRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ViewForms/ViewLeaveTransaction.aspx?LeaveTransactionID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowSavedViewForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvSavedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ViewForms/ViewLeaveTransaction.aspx?LeaveTransactionID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowTab(tab) {
                var wd = $("div[class^='widget']");
                if (wd != null && wd != undefined) {
                    if (typeof wd.contentTabs !== 'undefined' && $.isFunction(wd.contentTabs)) {
                        wd.contentTabs();
                        wd.find("ul.tabs li:nth-child(n)").removeClass("activeTab").show(); //Activate first tab
                        wd.find(".tab_content:nth-child(n)").hide(); //Show first tab content 
                        wd.find('a[href="' + tab + '"]').parent().addClass("activeTab"); //Add "active" class to selected tab
                        $(tab).show(); //Fade in the active content
                    }
                }
            };

            function refreshGrid2() {
                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                ajaxManager.ajaxRequest("Rebind");
            }

            function refreshGrid(arg) {
                if (!arg) {
                    var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                    ajaxManager.ajaxRequest("Rebind");
                }
            }

            function ShowOrgChart(id, rowIndex) {
                var grid = $find("<%= gvSavedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("WorkflowChart.aspx?LeaveTransactionID=" + id, "RadWindowOrgChart");
                return false;
            }

            function ShowReport(RequestId, Reportname) {
                window.open("../Reports/LaunchReport.aspx?RequestId=" + RequestId + "&Reportname=" + Reportname);
                return false;
            }


            function closeddl() {
                $('.rcbSlide').hide();
            }

            function OpenEmployeeddl() {
                //alert('EmployeeOuter');
                $('#emp .rcbSlide').show();
            }

            function OpenEntryTypeddl() {
                //alert('EmployeeOuter');
                $('#EntryType .rcbSlide').show();
            }

            function OpenLeaveTypeddl() {
                //alert('EmployeeOuter');
                $('#LeaveType .rcbSlide').show();
            }

            function OpenLeaveCodeddl() {
                //alert('EmployeeOuter');
                $('#LeaveCode .rcbSlide').show();
            }
        </script>
    </telerik:RadCodeBlock>

    <telerik:RadScriptBlock ID="radblocks" runat="server">
        <script type="text/javascript">

            function conditionalPostback(sender, eventArgs) {
                var theRegexp = new RegExp("\.EditColumn|\.AddNewRecordButton|\.InitInsertButton|\.UpdateButton|\.PerformInsertButton", "ig");

                if (eventArgs.get_eventTarget().match(theRegexp)) {
                    var upload = $find(window['UploadId']);
                    //AJAX is disabled only if file is selected for upload
                    if (upload.getFileInputs()[0].value != "") {
                        eventArgs.set_enableAjax(false);
                    }
                }
            }

        </script>
    </telerik:RadScriptBlock>

    <!-- this for dropdown grid common functions-->
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">
            var isSorted = false;
            var ctrlId = "";

            function setSorted(senderID) {
                isSorted = true;
                ctrlId = senderID;
            }

            function OnClientDropDownClosing(sender, eventArgs) {
                if (sender.get_id() == ctrlId && isSorted) {
                    eventArgs.set_cancel(true);
                }
                else {
                    eventArgs.set_cancel(false);
                }
                isSorted = false;
                ctrlId = "";
                if (sender.get_value() == "")
                    sender.set_text("");
            }

            function RowSelect(row, senderID) {
                var combo = $find(senderID);
                setTimeout(function () {
                    combo.set_text($(row).find('td.text').text().trim());
                    combo.set_value($(row).find('td.value').text().trim());
                }, 50);
            }

            function OnClientLoad(editor, args) {
                editor.add_modeChange(function (editor, args) {
                    var mode = editor.get_mode();
                    if (mode == 2) {
                        var htmlMode = editor.get_textArea();  //get a reference to the Html mode textarea
                        htmlMode.disabled = "true";
                    }
                });
            }

            function RowClickedBatch(sender, args) {
                var cellValues = args.getDataKeyValue("bchcod");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdBatches4DDL', ''));
                //setTimeout(function () {
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(UserID);
                combo.get_items().getItem(0).set_text(cellValues);
                combo.commitChanges();
                //}, 50);
            }

            function RowClickedEntryType(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var UserID = args.getDataKeyValue("Value");

                var combo = $find(sender.ClientID.replace('_i0_rGrdEntryTypes4DDL', ''));
                //setTimeout(function () {
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(UserID);
                combo.get_items().getItem(0).set_text(cellValues);
                combo.commitChanges();

                document.getElementById("<%=rfvrcmbEntryType.ClientID%>").style.visibility = "hidden";

                if (cellValues == 'Encashment' || cellValues == 'Adjustment') {
                    document.getElementById("<%=rfvtxtFromDate.ClientID%>").enabled = false;
                    document.getElementById("<%=rfvtxtToDate.ClientID%>").enabled = false;
                    document.getElementById("<%=tpFromTime.ClientID%>").enabled = false;
                    document.getElementById("<%=tpToTime.ClientID%>").enabled = false;
                    document.getElementById("<%=rfvtpFromTime.ClientID%>").enabled = false;
                    document.getElementById("<%=rfvtpToTime.ClientID%>").enabled = false;

                    document.getElementById("<%=rfvtxtOffHours.ClientID%>").enabled = false;
                    document.getElementById("<%=rfvtxtDayPercentage.ClientID%>").enabled = false;
                }
                else {
                    document.getElementById("<%=rfvtxtFromDate.ClientID%>").enabled = true;
                    document.getElementById("<%=rfvtxtToDate.ClientID%>").enabled = true;
                }

                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                ajaxManager.ajaxRequest("Rebind");
                //}, 50);
            }


            function enableDisableValidatorsOnHourly() {
                document.getElementById("<%=rfvtpFromTime.ClientID%>").enabled = true;
                document.getElementById("<%=rfvtpToTime.ClientID%>").enabled = true;
                document.getElementById("<%=rfvtxtOffHours.ClientID%>").enabled = true;
                document.getElementById("<%=rfvtxtDayPercentage.ClientID%>").enabled = true;
            }

            function enableDisableValidators() {
                document.getElementById("<%=rfvtpFromTime.ClientID%>").enabled = false;
                document.getElementById("<%=rfvtpToTime.ClientID%>").enabled = false;
                document.getElementById("<%=rfvtxtOffHours.ClientID%>").enabled = false;
                document.getElementById("<%=rfvtxtDayPercentage.ClientID%>").enabled = false;
            }

            function enableDisableValidatorsOnEditAndNew() {

                var rCmbEntryType = $find("<%=  rCmbEntryType.ClientID %>");

                if (rCmbEntryType.get_selectedIndex() != null) {
                    if (rCmbEntryType.get_items().getItem(0).get_text() != 'Encashment' &&
                        rCmbEntryType.get_items().getItem(0).get_text() != 'Adjustment') {

                        document.getElementById("<%=rfvtxtFromDate.ClientID%>").enabled = true;
                        document.getElementById("<%=rfvtxtToDate.ClientID%>").enabled = true;
                    }
                    else {
                        document.getElementById("<%=rfvtxtFromDate.ClientID%>").enabled = false;
                        document.getElementById("<%=rfvtxtToDate.ClientID%>").enabled = false;
                    }
                }
                else {
                    document.getElementById("<%=rfvtxtFromDate.ClientID%>").enabled = true;
                    document.getElementById("<%=rfvtxtToDate.ClientID%>").enabled = true;
                }

                var cbxhourly = $find("<%=  cbxhourly.ClientID %>");

                if (cbxhourly.get_checked() == true) {
                    if ($("#hfdisFrmToTimeCtrls").val() == 'true') {
                        document.getElementById("<%=rfvtpFromTime.ClientID%>").enabled = true;
                        document.getElementById("<%=rfvtpToTime.ClientID%>").enabled = true;
                    }
                    else {
                        document.getElementById("<%=rfvtpFromTime.ClientID%>").enabled = false;
                        document.getElementById("<%=rfvtpToTime.ClientID%>").enabled = false;
                    }
                    document.getElementById("<%=rfvtxtOffHours.ClientID%>").enabled = true;
                    document.getElementById("<%=rfvtxtDayPercentage.ClientID%>").enabled = true;
                }
                else {
                    document.getElementById("<%=rfvtpFromTime.ClientID%>").enabled = false;
                    document.getElementById("<%=rfvtpToTime.ClientID%>").enabled = false;
                    document.getElementById("<%=rfvtxtOffHours.ClientID%>").enabled = false;
                    document.getElementById("<%=rfvtxtDayPercentage.ClientID%>").enabled = false;

                }
            }

            function hideValidators() {

                document.getElementById("<%=rfvrcmbEmployee.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=rfvrcmbLeaveType.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=rfvrcmbLeaveCode.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=rfvrcmbEntryType.ClientID%>").style.visibility = "hidden";

                document.getElementById("<%=rfvtxtFromDate.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=rfvtxtToDate.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=rfvtpFromTime.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=rfvtpToTime.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=rfvtxtNumberOfDays.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=rfvtxtOffHours.ClientID%>").style.visibility = "hidden";
                document.getElementById("<%=rfvtxtDayPercentage.ClientID%>").style.visibility = "hidden";

            }

            //$(document).ready(function () {

            //});

            function showValidators() {
                document.getElementById("<%=rfvrcmbEmployee.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=rfvrcmbLeaveType.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=rfvrcmbLeaveCode.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=rfvrcmbEntryType.ClientID%>").style.visibility = "visible";

                document.getElementById("<%=rfvtxtFromDate.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=rfvtxtToDate.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=rfvtpFromTime.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=rfvtpToTime.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=rfvtxtNumberOfDays.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=rfvtxtOffHours.ClientID%>").style.visibility = "visible";
                document.getElementById("<%=rfvtxtDayPercentage.ClientID%>").style.visibility = "visible";
            }

            function RowClickedLeaveType(sender, args) {
                var cellValues = args.getDataKeyValue("levtypcod");
                var RecID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdLeaveTypes4DDL', ''));
                //setTimeout(function () {
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(RecID);
                combo.get_items().getItem(0).set_text(cellValues);
                combo.commitChanges();

                var rCmbLeaveCode = $find("<%= rCmbLeaveCode.ClientID %>");
                //rCmbLeaveCode.enable();

                document.getElementById("<%=rfvrcmbLeaveType.ClientID%>").style.visibility = "hidden";
                //$('#btnHidden1').click();
                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                ajaxManager.ajaxRequest("Rebind");


                //}, 50);
            }

            function RowClickedLeaveCode(sender, args) {
                var cellValues = args.getDataKeyValue("lvccod");
                var rcidd = args.getDataKeyValue("lvcidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdLeaveCodes4DDL', ''));
                //setTimeout(function () {
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(rcidd);
                combo.get_items().getItem(0).set_text(cellValues);
                combo.commitChanges();
                document.getElementById("<%=rfvrcmbLeaveCode.ClientID%>").style.visibility = "hidden";

                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                ajaxManager.ajaxRequest("Rebind");
                //}, 50);
            }

            function RowClickedEmployee(sender, args) {
                var cellValues = args.getDataKeyValue("empcod");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployees4DDL', ''));
                //setTimeout(function () {
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(UserID);
                combo.get_items().getItem(0).set_text(cellValues);
                combo.commitChanges();
                //$('#btnHidden1').click();
                document.getElementById("<%=rfvrcmbEmployee.ClientID%>").style.visibility = "hidden";

                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                ajaxManager.ajaxRequest("Rebind");
                //}, 50);
            }

            function RowClickedCalander(sender, args) {
                var cellValues = args.getDataKeyValue("grdclc");
                var UserID = args.getDataKeyValue("grdcli");

                var combo = $find(sender.ClientID.replace('_i0_rGrdCalanders4DDL', ''));
                //setTimeout(function () {
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(UserID);
                combo.get_items().getItem(0).set_text(cellValues);
                combo.commitChanges();
                //}, 50);
            }

            (function () {

                window.onClientFileUploaded = function (radAsyncUpload, args) {
                    var row = args.get_row(),
                        inputName = radAsyncUpload.getAdditionalFieldID("TextBox"),
                        inputType = "text",
                        inputID = inputName,
                        input = createInput(inputType, inputID, inputName),
                        label = createLabel(inputID),
                        br = document.createElement("br");

                    row.appendChild(br);
                    row.appendChild(label);
                    row.appendChild(input);
                }

                function createInput(inputType, inputID, inputName) {
                    var input = document.createElement("input");

                    input.setAttribute("type", inputType);
                    input.setAttribute("id", inputID);
                    input.setAttribute("name", inputName);

                    input.style.width = "150px";


                    return input;
                }

                function createLabel(forArrt) {
                    var label = document.createElement("label");

                    label.setAttribute("for", forArrt);
                    label.innerHTML = "File info: ";
                    label.style.width = "150px";

                    return label;
                }

            })();

            var currentLoadingPanel = null;
            var currentUpdatedControl = null;

            function RequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("lbtnDownload") >= 0) {
                    args.set_enableAjax(false);
                }
                else {
                    currentLoadingPanel = $find("<%= RadAjaxLoadingPanel1.ClientID %>");
                     currentUpdatedControl = "<%= pnlAjaxForm.ClientID %>";
                    currentLoadingPanel.show(currentUpdatedControl);
                }
            }

            function ResponseEnd() {
                //hide the loading panel and clean up the global variables
                if (currentLoadingPanel != null)
                    currentLoadingPanel.hide(currentUpdatedControl);
                currentUpdatedControl = null;
                currentLoadingPanel = null;

                //to enable disable validators with respect to scenario
                enableDisableValidatorsOnEditAndNew();
            }

            function InitiateAjaxRequest(arguments) {
                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                ajaxManager.ajaxRequest(arguments);
            }

            function GoToNewEntriesState() {
                alert('new button clicked');
                $('#rBtnNewRequest').click();
            }

        </script>
    </telerik:RadCodeBlock>

    <script type="text/javascript">

        var maxHeight = 900;
        function OnClientShow(active) {
            setTimeout(function () {
                var height = active._tableElement.offsetHeight < maxHeight ? active._tableElement.offsetHeight : maxHeight;
                active.set_height(height);
                active.set_contentScrolling(Telerik.Web.UI.ToolTipScrolling.Auto);
                active._show();
            }, 0);
        }

        function OnClientHide(active) {
            active.set_height(0);
            active.set_contentScrolling(Telerik.Web.UI.ToolTipScrolling.Default);
        }


        var mybutton = document.getElementById("myBtn");
        // When the user scrolls down 20px from the top of the document, show the button
        window.onscroll = function () { scrollFunction() };

        function scrollFunction() {
            if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                document.getElementById("myBtn").style.display = "block";
            }
            else {
                document.getElementById("myBtn").style.display = "none";
            }
        }
        // When the user clicks on the button, scroll to the top of the document
        function topFunction() {
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }

    </script>

    <style type="text/css">

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_cbxhourly
        {
            float:left
        }
        .myBtn {
            display: none;
            position: fixed;
            bottom: 20px;
            right: 30px;
            z-index: 99;
            border-radius:50%;
            cursor: pointer;
            width:40px;
            padding:25px;
            background-repeat:no-repeat;
            background-color:#2d6b9b;
        }

        .durationcaculate {
        float:left;
        display:flex;  
        }
        .rsdivprsntage {
            margin-left: 25px;
            margin-top: 3px;
        }
        .rsmints 
        {
         margin-left:10px;
       
        }

         .clearm {
        clear:none;
           }
        .lblMinutes {
           margin-top:7px;
           width:50px;
        }
        .rsdivhrs {
            margin-left: 50px;
        }

      /*@media only screen and (min-device-width: 640px) and (max-device-width: 360px) and 
          (orientation : landscape) and (-webkit-device-pixel-ratio: 4) {
    #Repnsvform 
            {
            margin-top:0px !important;  
            }
          }*/
          @media only screen and (min-width: 0px) and (max-width:768px ) {
               .rgPagerCell{
                display:inline-flex !important;
            }  
               .clearm {
        clear:both;
           } 
              .rsmints 
        {
         margin-left:38px !important;  
        }
            .lblMinutes {
            width:37px !important;
            }
             .rsdivhrs {
            margin-left: 0px !important;
        }
          
        }
        @media only screen and (min-width: 769px) and (max-width:1024px )
         {
             .rsdivhrs {
            margin-left: 0px !important;
        }
            .rslbhrs {
            width:96px !important;
            }
             .rsmints 
        {
         margin-left:50px;
       
        }
             .rsdivprsntage {
            margin-left: 55px;
        }
            .rslbpersnt {
            width:33px;
            }
        }
          
/*
        .RadDropDownList_Silk .rddlFocused,.RadDropDownList_Silk .rddlInner
        {
            width: 100% !important;
        }*/
        #divCashAmount {
            display: none;
            height: 20px;
        }
        #minutesDiv
        {
            display: none;
            float:left;
            margin-right: 66px;
        }
        #FromTimeDiv {
            display: none;
        }

        #Rspsvprsntgdiv {
                display:flex;
                float: left;
            }

        #ToTimeDiv {
            display: none;
        }

        #RspnsvCashAmnt {
            margin-left: 20px;
            display: inline-block;
        }

        #divCashCheck {
            float: left;
            margin-left: 20px;
            margin-top: 8px;
        }

        #divVacationSalary {
            float: left;
            margin-left: 20px;
            margin-top: 8px;
        }

        #divPerDiem {
            float: left;
            margin-left: 20px;
            margin-top: 8px;
        }
         #divTicket {
            float: left;
            margin-left: 0px;
            margin-top: 8px;
        }
        #lbairticket {
            margin-top: 8px;
        }

        #txtmaxdiv {
            width: 50px;
            display: inline-block;
            margin-left: 10px;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_gvAttachments {
            width: 615px;
            display: flex;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_txtNumberOfDaysPanel {
            float: left !important;
            margin-left: 5px !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_txtNumberOfDays {
            width: 60px !important;
            /*margin-left:25px !important;*/
            margin-top: 3px !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_txtNumberOfDays_wrapper {
            margin-left: 95px !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_txtOffHoursPanel {
            display: block !important;
            margin-left: 30px !important;
            width: 60px !important;
            float: left !important;
            margin-right: 5px !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_txtDayPercentagePanel {
            display: block !important;
            width: 60px !important;
            float: left !important;
            margin-left: 15px !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_rBtnSavePanel {
            margin-right: 5px !important;
            float: left !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_rBtnNewRequestPanel {
            margin-right: 5px !important;
            float: left !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_lblNoOfDaysPanel {
            float: left !important;
            margin-top: 7px !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_lblOffHours {
            float: left !important;
            margin-top: 8px !important;
        }

        /*#ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_lblDayPercentagePanel {
            float: left !important;
            margin-top: 5px !important;
        }*/

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_rfvtxtNumberOfDays {
            margin-top: 3px;
        }

        .RadComboBox .rcbInputCellLeft {
            width: 216px !important;
        }

        div.checker span {
            height: 13px !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_checkAirTicket {
          
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_checkAirTicketPanel {
            margin-left: 64px !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_checkAirTicketPanel {
            float: right !important;
            margin-left: 10px !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_cbxPerDiemPanel {
            float: right !important;
            margin-left: 10px !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_cbxLeaveSalaryPanel {
            float: right !important;
            margin-left: 10px !important;
        }

        #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_cbxCashcheckPanel {
            float: right !important;
            margin-left: 10px !important;
        }

        #Rspsvlbhourly {
            margin-left: 22px;
            float: left;
        }

        #Repnsvform {
            margin-top: 32px;
        }

        #RspnsvButtons {
            display: inline-flex;
            float: right;
            padding: 0 15px 0 0;
        }

        /*Media qeury for Mobile devices*/
        @media only screen and (min-width: 0px) and (max-width: 640px) {
            .RadGrid .rgPager .rgAdvPart {
            display:none !important;
            }
             .RadGrid .rgHeader {
                padding-left: 7px !important;
                /*padding-right: 0px !important;*/
            }

            .widget {
                margin-left: 4px !important;
                margin-right: 4px !important;
            }

          

            #Repnsvform {
                margin-top: 0px;
                float: left !important;
            }

            #Rspsvlbhourly {
                margin-left: 0px !important;
            }

            #Rspsvhourly1 {
                width: 100% !important;
                float: left !important;
            }

            #divCashAmount {
                float: left !important;
                height: 35px !important;
            }

            #ctl00_ctl00_MainContent_mainContentPlaceHolder_cbxhourly {
                margin-top: 1px !important;
            }

            #ctl00_ctl00_MainContent_mainContentPlaceHolder_txtNumberOfDays {
                margin-left: -80px !important;
            }

            /*#Rspsvprsntgdiv {
                float: left !important;
                width: 100% !important;
            }*/

            #ctl00_ctl00_MainContent_mainContentPlaceHolder_txtDayPercentage {
                margin-left: 10px !important;
            }

            #ctl00_ctl00_MainContent_mainContentPlaceHolder_checkAirTicket {
                margin-left: -50px !important;
            }

            #divPerDiem {
                margin-left: -20px !important;
            }

            #divVacationSalary {
                margin-left: 10px !important;
            }

            #divCashCheck {
                margin-left: 0px !important;
            }

            #cbxCashcheck {
                margin-left: 4px !important;
            }

            #RspnsvCashAmnt {
                margin-left: 0px;
            }
        }

        @media only screen and (min-width: 0px) and (max-width: 320px) {
           #RspnsvButtons {
            float:left !important;
            }
             #RspsvlbVSlry {
                margin-left: -10px !important;
            }

            #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_rBtnSavePanel {
                margin-left: -10px !important;
            }

            #ctl00_ctl00_MainContent_mainContentPlaceHolder_gvAttachments {
                width: 250px !important;
            }
            #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_checkAirTicketPanel {
            margin-left:76px !important;
            }
            #ctl00_ctl00_MainContent_mainContentPlaceHolder_cbxPerDiem {
            margin-left:5px !important;
            }

        }

        @media only screen and (min-width: 321px) and (max-width: 430px) {
            #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_rBtnSavePanel {
                margin-left: 8px;
            }

            #ctl00_ctl00_MainContent_mainContentPlaceHolder_gvAttachments {
                width: 310px !important;
            }
        }
        @media only screen and (min-width: 0px) and (max-width: 768px)
         {
        
        }

        @media only screen and (min-width: 641px) and (max-width: 705px)
        {
            #Repnsvform {
                margin-top: 0px !important;
            }
        }

        @media only screen and (min-width: 768px) and (max-width: 812px)
        {
            #Rspsvlbhourly {
                margin-left: 0px !important;
            }
        }

        @media only screen and (min-width: 800px) and (max-width: 1020px)
        {
            #divCashCheck {
                margin-left: 0px !important;
            }
            #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_cbxCashcheckPanel {
                margin-left: 62px !important;
            }
        }

        /*Media qeury for Tablet Mood*/
        @media only screen and (min-width: 600px) and (max-width: 768px) {

            #Rspsvlbhourly {
                margin-left: 0px !important;
            }

            #Rspsvhourly1 {
                display: flex !important;
            }

            .widget {
                margin-left: 4px !important;
                margin-right: 4px !important;
            }

            #Rspsvlbhourly {
                margin-left: 0px !important;
            }

            #Rspsvhourly1 {
                width: 100% !important;
                float: left !important;
            }

            #divCashAmount {
                float: left !important;
                height: 35px !important;
            }

            #ctl00_ctl00_MainContent_mainContentPlaceHolder_cbxhourly {
                margin-top: 1px !important;
            }

            #ctl00_ctl00_MainContent_mainContentPlaceHolder_txtNumberOfDays {
                margin-left: -80px !important;
            }

            /*#Rspsvprsntgdiv {
                float: left !important;
                width: 100% !important;
            }*/

            #ctl00_ctl00_MainContent_mainContentPlaceHolder_txtDayPercentage {
                margin-left: 10px !important;
            }

            #ctl00_ctl00_MainContent_mainContentPlaceHolder_checkAirTicket {
                margin-left: -50px !important;
            }

            #divPerDiem {
                margin-left: -20px !important;
            }

            #divVacationSalary {
                margin-left: 0px !important;
            }

            #divCashCheck {
                margin-left: 0px !important;
            }

            #cbxCashcheck {
                margin-left: 4px !important;
            }

            #RspnsvCashAmnt {
                margin-left: 0px;
            }

            #ctl00_ctl00_MainContent_mainContentPlaceHolder_gvAttachments {
                width: 340px !important;
            }
        }

      
            #ctl00_ctl00_MainContent_mainContentPlaceHolder_gvAttachments {
                width: 340px !important;
            }
            #txtCashAmount_wrapper {
                margin-left:47px !important;
            }

            #RspnsvCashAmnt {
                display: contents !important;
            }
            #divCashAmount {
            margin-bottom:40px !important;
            }
     
        
    </style>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvSubmittedRequests">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvAttachments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvAttachments" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvPendingAppRequests">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvPendingAppRequests" />
                    <telerik:AjaxUpdatedControl ControlID="ApprovalPanel"   />

                    <telerik:AjaxUpdatedControl ControlID="rBtnSave" />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSaveAndSubmit" />

                    <telerik:AjaxUpdatedControl ControlID="rCmbEmployee" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType" />
                    <telerik:AjaxUpdatedControl ControlID="lbltab1" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType" />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket" />
                    <telerik:AjaxUpdatedControl ControlID="cbxPerDiem" />
                    <telerik:AjaxUpdatedControl ControlID="cbxLeaveSalary" />
                    <telerik:AjaxUpdatedControl ControlID="cbxCashcheck" />
                    <telerik:AjaxUpdatedControl ControlID="txtCashAmount" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2" />
                    <telerik:AjaxUpdatedControl ControlID="ltrNoResults" />
                    <telerik:AjaxUpdatedControl ControlID="ruDocument" />
                    <telerik:AjaxUpdatedControl ControlID="gvAttachments" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveChart" />


                    <telerik:AjaxUpdatedControl ControlID="cbxhourly" />
                    <telerik:AjaxUpdatedControl ControlID="tpFromTime" />
                    <telerik:AjaxUpdatedControl ControlID="tpToTime" />
                    <telerik:AjaxUpdatedControl ControlID="lblOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="ddlMinutes" />
                    <%--<telerik:AjaxUpdatedControl ControlID="lblDayPercentage" />--%>
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvApprovedRequests">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvApprovedRequests" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnNewRequest">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rBtnSave" />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSaveAndSubmit" />

                    <telerik:AjaxUpdatedControl ControlID="rBtnNewRequest" />
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployees4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveChart" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />
                    <telerik:AjaxUpdatedControl ControlID="lbltab1" />
                    <telerik:AjaxUpdatedControl ControlID="cbxPerDiem" />
                    <telerik:AjaxUpdatedControl ControlID="cbxLeaveSalary" />
                    <telerik:AjaxUpdatedControl ControlID="txtCashAmount" />
                    <telerik:AjaxUpdatedControl ControlID="cbxCashcheck" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbEmployee" />
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployees4DDL" />

                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests" />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests" />

                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode" />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket" />
                    <telerik:AjaxUpdatedControl ControlID="gvAttachments" />
                    <telerik:AjaxUpdatedControl ControlID="ltrNoResults" />
                    <telerik:AjaxUpdatedControl ControlID="ruDocument" />

                    <telerik:AjaxUpdatedControl ControlID="cbxhourly" />
                    <telerik:AjaxUpdatedControl ControlID="tpFromTime" />
                    <telerik:AjaxUpdatedControl ControlID="tpToTime" />
                    <telerik:AjaxUpdatedControl ControlID="lblOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="ddlMinutes" />
                    <%--<telerik:AjaxUpdatedControl ControlID="lblDayPercentage" />--%>
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />

                    <telerik:AjaxUpdatedControl ControlID="ApprovalPanel"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="BtnNewRequest">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="lbltab1" />
                    <telerik:AjaxUpdatedControl ControlID="gvAttachments" />
                    <telerik:AjaxUpdatedControl ControlID="ltrNoResults" />
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployees4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveChart" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />
                    <telerik:AjaxUpdatedControl ControlID="ruDocument" />
                    <telerik:AjaxUpdatedControl ControlID="cbxPerDiem" />
                    <telerik:AjaxUpdatedControl ControlID="cbxLeaveSalary" />
                    <telerik:AjaxUpdatedControl ControlID="txtCashAmount" />
                    <telerik:AjaxUpdatedControl ControlID="cbxCashcheck" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbEmployee" />
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployees4DDL" />

                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests" />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests" />

                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode" />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket" />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSave" />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSaveAndSubmit" />


                    <telerik:AjaxUpdatedControl ControlID="cbxhourly" />
                    <telerik:AjaxUpdatedControl ControlID="tpFromTime" />
                    <telerik:AjaxUpdatedControl ControlID="tpToTime" />
                    <telerik:AjaxUpdatedControl ControlID="lblOffHours" />
                    <%--<telerik:AjaxUpdatedControl ControlID="lblDayPercentage" />--%>
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="ddlMinutes" />
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />

                    <telerik:AjaxUpdatedControl ControlID="ApprovalPanel"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvSavedRequests">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="rBtnSave" />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSaveAndSubmit" />

                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbEmployee" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType" />
                    <telerik:AjaxUpdatedControl ControlID="lbltab1" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType" />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket" />
                    <telerik:AjaxUpdatedControl ControlID="cbxPerDiem" />
                    <telerik:AjaxUpdatedControl ControlID="cbxLeaveSalary" />
                    <telerik:AjaxUpdatedControl ControlID="cbxCashcheck" />
                    <telerik:AjaxUpdatedControl ControlID="txtCashAmount" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2" />
                    <telerik:AjaxUpdatedControl ControlID="ltrNoResults" />
                    <telerik:AjaxUpdatedControl ControlID="ruDocument" />
                    <telerik:AjaxUpdatedControl ControlID="gvAttachments" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveChart" />


                    <telerik:AjaxUpdatedControl ControlID="cbxhourly" />
                    <telerik:AjaxUpdatedControl ControlID="tpFromTime" />
                    <telerik:AjaxUpdatedControl ControlID="tpToTime" />
                    <telerik:AjaxUpdatedControl ControlID="lblOffHours" />
                    <%--<telerik:AjaxUpdatedControl ControlID="lblDayPercentage" />--%>
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="ddlMinutes" />
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />


                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdEmployees4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployees4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveChart" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />

                    <telerik:AjaxUpdatedControl ControlID="rGrdLeaveType4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode" />
                    <telerik:AjaxUpdatedControl ControlID="rGrdLeaveCode4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket" />
                    <telerik:AjaxUpdatedControl ControlID="tpFromTime" />
                    <telerik:AjaxUpdatedControl ControlID="tpToTime" />
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="ddlMinutes" />
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />

                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnSaveAndSubmit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployees4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveChart" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />

                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests" />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests" />

                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode" />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket" />
                    <telerik:AjaxUpdatedControl ControlID="cbxPerDiem" />
                    <telerik:AjaxUpdatedControl ControlID="cbxLeaveSalary" />
                    <telerik:AjaxUpdatedControl ControlID="cbxCashcheck" />
                    <telerik:AjaxUpdatedControl ControlID="txtCashAmount" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2" />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSave" />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSaveAndSubmit" />
                    <telerik:AjaxUpdatedControl ControlID="cbxhourly" />
                    <telerik:AjaxUpdatedControl ControlID="tpFromTime" />
                    <telerik:AjaxUpdatedControl ControlID="tpToTime" />
                    <telerik:AjaxUpdatedControl ControlID="lblOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="ddlMinutes" />
                    <%--<telerik:AjaxUpdatedControl ControlID="lblDayPercentage" />--%>
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployees4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveChart" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />

                    <telerik:AjaxUpdatedControl ControlID="cbxPerDiem" />
                    <telerik:AjaxUpdatedControl ControlID="cbxLeaveSalary" />
                    <telerik:AjaxUpdatedControl ControlID="txtCashAmount" />
                    <telerik:AjaxUpdatedControl ControlID="cbxCashcheck" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbEmployee" />
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployees4DDL" />

                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests" />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests" />

                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode" />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket" />

                    <telerik:AjaxUpdatedControl ControlID="rBtnSave" />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSaveAndSubmit" />

                    <telerik:AjaxUpdatedControl ControlID="cbxhourly" />
                    <telerik:AjaxUpdatedControl ControlID="tpFromTime" />
                    <telerik:AjaxUpdatedControl ControlID="tpToTime" />
                    <telerik:AjaxUpdatedControl ControlID="lblOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="ddlMinutes" />
                    <%--<telerik:AjaxUpdatedControl ControlID="lblDayPercentage" />--%>
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />



                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="txtFromDate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cbxhourly">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />

                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="lblOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="ddlMinutes" />
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />

                    <telerik:AjaxUpdatedControl ControlID="tpFromTime" />
                    <telerik:AjaxUpdatedControl ControlID="tpToTime" />

                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="txtToDate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdEntryTypes4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdEntryTypes4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="cbxhourly" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="tpFromTime" />
                    <telerik:AjaxUpdatedControl ControlID="tpToTime" />
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="ddlMinutes" />
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />

                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdLeaveTypes4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdLeaveTypes4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="rGrdLeaveCodes4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="rGrdEntryTypes4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />
                    <telerik:AjaxUpdatedControl ControlID="cbxPerDiem" />
                    <telerik:AjaxUpdatedControl ControlID="cbxLeaveSalary" />
                    <telerik:AjaxUpdatedControl ControlID="cbxCashcheck" />
                    <telerik:AjaxUpdatedControl ControlID="txtCashAmount" />
                    <telerik:AjaxUpdatedControl ControlID="hfMaxCash" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdLeaveCodes4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdLeaveCodes4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tpFromTime">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tpToTime">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnApprove">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="gvPendingAppRequests"/>
                    <telerik:AjaxUpdatedControl ControlID="ApprovalPanel"   />
                    <telerik:AjaxUpdatedControl ControlID="rCmbEmployee" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType" />
                    <telerik:AjaxUpdatedControl ControlID="lbltab1" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType" />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket" />
                    <telerik:AjaxUpdatedControl ControlID="cbxPerDiem" />
                    <telerik:AjaxUpdatedControl ControlID="cbxLeaveSalary" />
                    <telerik:AjaxUpdatedControl ControlID="cbxCashcheck" />
                    <telerik:AjaxUpdatedControl ControlID="txtCashAmount" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2" />
                    <telerik:AjaxUpdatedControl ControlID="ltrNoResults" />
                    <telerik:AjaxUpdatedControl ControlID="ruDocument" />
                    <telerik:AjaxUpdatedControl ControlID="gvAttachments" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveChart" />

                    <telerik:AjaxUpdatedControl ControlID="cbxhourly" />
                    <telerik:AjaxUpdatedControl ControlID="tpFromTime" />
                    <telerik:AjaxUpdatedControl ControlID="tpToTime" />
                    <telerik:AjaxUpdatedControl ControlID="lblOffHours" />
                    <%--<telerik:AjaxUpdatedControl ControlID="lblDayPercentage" />--%>
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="ddlMinutes" />
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnReject">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="gvPendingAppRequests"/>
                    <telerik:AjaxUpdatedControl ControlID="ApprovalPanel"   />

                    <telerik:AjaxUpdatedControl ControlID="rCmbEmployee" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType" />
                    <telerik:AjaxUpdatedControl ControlID="lbltab1" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType" />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket" />
                    <telerik:AjaxUpdatedControl ControlID="cbxPerDiem" />
                    <telerik:AjaxUpdatedControl ControlID="cbxLeaveSalary" />
                    <telerik:AjaxUpdatedControl ControlID="cbxCashcheck" />
                    <telerik:AjaxUpdatedControl ControlID="txtCashAmount" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2" />
                    <telerik:AjaxUpdatedControl ControlID="ltrNoResults" />
                    <telerik:AjaxUpdatedControl ControlID="ruDocument" />
                    <telerik:AjaxUpdatedControl ControlID="gvAttachments" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveChart" />

                    <telerik:AjaxUpdatedControl ControlID="cbxhourly" />
                    <telerik:AjaxUpdatedControl ControlID="tpFromTime" />
                    <telerik:AjaxUpdatedControl ControlID="tpToTime" />
                    <telerik:AjaxUpdatedControl ControlID="lblOffHours" />
                    <%--<telerik:AjaxUpdatedControl ControlID="lblDayPercentage" />--%>
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="ddlMinutes" />
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnRevise">
                <UpdatedControls>
                     <%--<telerik:AjaxUpdatedControl ControlID="gvPendingAppRequests"/>--%>
                    <telerik:AjaxUpdatedControl ControlID="ApprovalPanel"   />

                    <telerik:AjaxUpdatedControl ControlID="rCmbEmployee" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType" />
                    <telerik:AjaxUpdatedControl ControlID="lbltab1" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType" />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket" />
                    <telerik:AjaxUpdatedControl ControlID="cbxPerDiem" />
                    <telerik:AjaxUpdatedControl ControlID="cbxLeaveSalary" />
                    <telerik:AjaxUpdatedControl ControlID="cbxCashcheck" />
                    <telerik:AjaxUpdatedControl ControlID="txtCashAmount" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1" />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2" />
                    <telerik:AjaxUpdatedControl ControlID="ltrNoResults" />
                    <telerik:AjaxUpdatedControl ControlID="ruDocument" />
                    <telerik:AjaxUpdatedControl ControlID="gvAttachments" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveBalance" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeLeaveChart" />

                    <telerik:AjaxUpdatedControl ControlID="cbxhourly" />
                    <telerik:AjaxUpdatedControl ControlID="tpFromTime" />
                    <telerik:AjaxUpdatedControl ControlID="tpToTime" />
                    <telerik:AjaxUpdatedControl ControlID="lblOffHours" />
                    <%--<telerik:AjaxUpdatedControl ControlID="lblDayPercentage" />--%>
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />
                    <telerik:AjaxUpdatedControl ControlID="txtOffHours" />
                    <telerik:AjaxUpdatedControl ControlID="ddlMinutes" />
                    <telerik:AjaxUpdatedControl ControlID="txtDayPercentage" />
                    <telerik:AjaxUpdatedControl ControlID="lblNoOfDays" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="txtOffHours">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="txtDayPercentage"/>
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlMinutes">
                <UpdatedControls>
                     <telerik:AjaxUpdatedControl ControlID="txtDayPercentage"/>
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <ClientEvents OnRequestStart="RequestStart" OnResponseEnd="ResponseEnd" />
    </telerik:RadAjaxManager>

    <!-- Fullscreen tabs -->
    <div class="widget">
        <ul class="tabs">
            <li class="Tab1 col-2 col-m-20">
                <a href="#tab1">
                    <asp:Label ID="lbltab1" Text="New Requests" runat="server"></asp:Label></a>
            </li>
            <li class="Tab2 col-2 col-m-20">
                <a href="#tab2">
                    <asp:Label ID="lbltab2" Text="Saved Requests" runat="server"></asp:Label></a>
            </li>
            <li class="Tab3 col-2 col-m-20">
                <a href="#tab3">
                    <asp:Label ID="lbltab3" Text="Submitted Requests" runat="server"></asp:Label></a>
            </li>
            <li class="Tab4 col-2 col-m-20">
                <a href="#tab4">
                    <asp:Label ID="lbltab4" Text="Pending Requests" runat="server"></asp:Label></a>
            </li>
            <li class="Tab5 col-2 col-m-20">
                <a href="#tab5">
                    <asp:Label ID="lbltab5" Text="Approved Requests" runat="server"></asp:Label></a>
            </li>

        </ul>

        <div class="tab_container">
            <asp:Panel ID="pnlAjaxForm" runat="server" CssClass="fluid">
                <div id="tab1" class="tab_content">

                    <%--                     <div class="wizButtons">--%>
                    <span class="wNavButtons" style="" id="RspnsvButtons">

                        <asp:Button ID="rBtnSave" runat="server" OnClick="rBtnSave_Click" Text="Save"
                            ValidationGroup="FrmSubmit" class="button greenB" CausesValidation="true"
                            OnClientClick="if (!ValidateForm()) { return false;};"></asp:Button>

                        <asp:Button ID="rBtnNewRequest" runat="server" OnClick="rBtnnewrequest_Click" Text="New Request"
                            Style="" class="button greenB" CausesValidation="false" OnClientClick="hideValidators()"></asp:Button>

                        <asp:Button ID="rBtnSaveAndSubmit" runat="server" OnClick="rBtnSaveAndSubmit_Click"
                            OnClientClick="if (!ValidateForm()) { return false;};"
                            Text="Save and Submit" class="button blueB"
                            ValidationGroup="FrmSubmit" CausesValidation="true"></asp:Button>

                    </span>
                    <%--     </div>--%>
                    <div class="fluid">
                        <div class="span8 col-7 col-m-6" id="Repnsvform">
                            <div class="widget11">

                                <div class="title">
                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                    <h6b>Request Details</h6b>
                                </div>
                                <asp:HiddenField ID="hfdisFrmToTimeCtrls" ClientIDMode="Static" Value="false" runat="server" />
                                <asp:HiddenField ID="warningMsg" ClientIDMode="Static" Value="" runat="server" />
                                <asp:Button ID="btnHidden1" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                <div class="formRow" style="height:34px!important;">
                                    <div class="formCol" style="padding-bottom:0px !important; font-size:12px;">
                                        <label>Employee</label>
                                        <div class="formRight" id="emp"  style="padding-bottom:0px !important">
                                            <telerik:RadComboBox ID="rCmbEmployee"
                                                runat="server" AutoPostBack="false"
                                                Width="242px"
                                                DropDownWidth="255px"
                                                EmptyMessage="Please select..."
                                                OnSelectedIndexChanged="rCmbEmployee_SelectedIndexChanged" Style="float: left">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">

                                                        <telerik:RadGrid ID="rGrdEmployees4DDL" runat="server" AllowSorting="True"
                                                            AutoGenerateColumns="False" ClientSettings-ClientEvents-OnRowSelected="closeddl"
                                                            CellSpacing="0" GridLines="None" Width="255px" ClientSettings-EnableRowHoverStyle="True"
                                                            OnItemCommand="rGrdEmployees4DDL_ItemCommand" AllowFilteringByColumn="true"
                                                            OnNeedDataSource="rGrdEmployees4DDL_NeedDataSource" OnDataBound="rGrdEmployees4DDL_DataBound"
                                                            OnSelectedIndexChanged="rGrdEmployees4DDL_SelectedIndexChanged">
                                                            <GroupingSettings CaseSensitive="false" />
                                                            <ClientSettings>
                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                            </ClientSettings>
                                                           <MasterTableView DataKeyNames="recidd,empcod,empfsn" ClientDataKeyNames="recidd,empcod,empfsn">
                                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="recidd" Visible="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter recidd column"
                                                                            HeaderText="ID" UniqueName="recidd">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="empcod" FilterControlAltText="Filter empcod column"
                                                                            HeaderText="Code" UniqueName="empcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="empfsn" FilterControlAltText="filter empfsn column"
                                                                            HeaderText="Name" UniqueName="empfsn" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                </MasterTableView>
                                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                                <ClientEvents OnRowClick="RowClickedEmployee"></ClientEvents>


                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </div>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>

                                            <asp:RequiredFieldValidator
                                                ID="rfvrcmbEmployee"
                                                ControlToValidate="rCmbEmployee"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="formRow"  style="height:34px!important; font-size:12px;">
                                    <div class="formCol"  style="padding-bottom:0px !important">
                                        <label>Absence Type</label>
                                        <div class="formRight"  style="padding-bottom:0px !important" id="LeaveType">
                                            <telerik:RadComboBox ID="rCmbLeaveType" runat="server" Width="242px" DropDownWidth="255px"
                                                EmptyMessage="Please select..." AutoPostBack="false" Style="float: left">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">
                                                        <telerik:RadGrid ID="rGrdLeaveTypes4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" Width="255px" ClientSettings-EnableRowHoverStyle="True"
                                                            OnItemCommand="rGrdLeaveTypes4DDL_ItemCommand" OnNeedDataSource="rGrdLeaveTypes4DDL_NeedDataSource"
                                                            ClientSettings-ClientEvents-OnRowSelected="closeddl" AllowFilteringByColumn="true"
                                                            OnSelectedIndexChanged="rGrdLeaveTypes4DDL_SelectedIndexChanged"
                                                            OnDataBound="rGrdLeaveTypes4DDL_DataBound">
                                                            <GroupingSettings CaseSensitive="false" />
                                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                            </ClientSettings>
                                                            <MasterTableView DataKeyNames="recidd,levdft,LevplnAll,levdftpln,levperdiem,levsal,levadvcash,levmaxcash,levtypcod"
                                                                ClientDataKeyNames="recidd,levtypcod">
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column" HeaderText="ID"
                                                                        UniqueName="column" AutoPostBackOnFilter="true" FilterControlWidth="50px" Visible="false" 
                                                                        CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="levtypcod" FilterControlAltText="Filter column1 column" HeaderText="Absence Type"
                                                                        UniqueName="column1" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="levdsc" FilterControlAltText="Filter column11 column" HeaderText="Description"
                                                                        UniqueName="column11" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <ClientEvents OnRowClick="RowClickedLeaveType"></ClientEvents>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </div>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>

                                            <asp:RequiredFieldValidator
                                                ID="rfvrcmbLeaveType"
                                                ControlToValidate="rCmbLeaveType"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>


                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow"  style="height:34px!important; font-size:12px;">
                                    <div class="formCol"  style="padding-bottom:0px !important">
                                        <label>Absence Code</label>
                                        <div class="formRight"  style="padding-bottom:0px !important" id="LeaveCode">
                                            <telerik:RadComboBox ID="rCmbLeaveCode" runat="server" Width="242px" DropDownWidth="255px"
                                                EmptyMessage="Please select..." AutoPostBack="false" Style="float: left">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">
                                                        <telerik:RadGrid ID="rGrdLeaveCodes4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" Width="255px" ClientSettings-EnableRowHoverStyle="True"
                                                            OnNeedDataSource="rGrdLeaveCodes4DDL_NeedDataSource"
                                                            OnItemCommand="rGrdLeaveCodes4DDL_ItemCommand" ClientSettings-ClientEvents-OnRowSelected="closeddl" AllowFilteringByColumn="true"
                                                            OnSelectedIndexChanged="rGrdLeaveCodes4DDL_SelectedIndexChanged"
                                                            OnDataBound="rGrdLeaveCodes4DDL_DataBound">
                                                            <GroupingSettings CaseSensitive="false" />
                                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                            </ClientSettings>
                                                            <MasterTableView DataKeyNames="lvcidd,lvccod,levdft,levcdftpln"
                                                                ClientDataKeyNames="lvcidd,lvccod">
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="lvcidd" FilterControlAltText="Filter column column" HeaderText="ID"
                                                                        UniqueName="column" AutoPostBackOnFilter="true" FilterControlWidth="50px" Visible="false" 
                                                                        CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="lvccod" FilterControlAltText="Filter column1 column" HeaderText="Code"
                                                                        UniqueName="column1" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="levdsc" FilterControlAltText="Filter column11 column" HeaderText="Description"
                                                                        UniqueName="column11" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <ClientEvents OnRowClick="RowClickedLeaveCode"></ClientEvents>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </div>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>

                                            <asp:RequiredFieldValidator
                                                ID="rfvrcmbLeaveCode"
                                                ControlToValidate="rCmbLeaveCode"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>


                                <div class="formRow"  style="height:34px!important; font-size:12px;">
                                    <div class="formCol"  style="padding-bottom:0px !important">
                                        <label>Entry Type</label>
                                        <div class="formRight"  style="padding-bottom:0px !important" id="EntryType">
                                            <telerik:RadComboBox ID="rCmbEntryType" AutoPostBack="false" runat="server" Width="242px" DropDownWidth="255px"
                                                EmptyMessage="Please select..." Style="float: left"  >
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">
                                                        <telerik:RadGrid ID="rGrdEntryTypes4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" Width="255px" ClientSettings-EnableRowHoverStyle="True"
                                                            OnItemCommand="rGrdEntryTypes4DDL_ItemCommand" OnNeedDataSource="rGrdEntryTypes4DDL_NeedDataSource"
                                                            ClientSettings-ClientEvents-OnRowSelected="closeddl" AllowFilteringByColumn="true"
                                                            OnSelectedIndexChanged="rGrdEntryTypes4DDL_SelectedIndexChanged">
                                                            <GroupingSettings CaseSensitive="false" />
                                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                            </ClientSettings>
                                                            <MasterTableView DataKeyNames="Value,Text"
                                                                ClientDataKeyNames="Value,Text">
                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                </ExpandCollapseColumn>
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="Value" FilterControlAltText="Filter column column" HeaderText="ID"
                                                                        UniqueName="column" AutoPostBackOnFilter="true" FilterControlWidth="50px" Visible="false" 
                                                                        CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column1 column" HeaderText="Entry Type"
                                                                        UniqueName="column1" AutoPostBackOnFilter="true" FilterControlWidth="50px"
                                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <ClientEvents OnRowClick="RowClickedEntryType"></ClientEvents>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </div>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>

                                            <asp:RequiredFieldValidator
                                                ID="rfvrcmbEntryType"
                                                ControlToValidate="rCmbEntryType"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>

                                        </div>


                                    </div>
                                    <div class="clear"></div>
                                </div>


                                <div class="formRow"  style="height:34px!important;font-size:12px;">
                                    <div class="formCol"  style="padding-bottom:0px !important">
                                        <label>From Date</label>
                                        <div class="formRight"  style="padding-bottom:0px !important">
                                            <telerik:RadDatePicker ID="txtFromDate" runat="server" DateInput-DateFormat="MM/dd/yyyy" AutoPostBack="true"
                                                OnSelectedDateChanged="txtFromDate_SelectedDateChanged" Style="float: left;" >
                                            </telerik:RadDatePicker>

                                            <asp:RequiredFieldValidator
                                                ID="rfvtxtFromDate"
                                                ControlToValidate="txtFromDate"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server" ></asp:RequiredFieldValidator>
                                            <div id="Rspsvhourly1">
                                                <label id="Rspsvlbhourly">Hourly</label>
                                                <%-- <div class="formRight" style="float:none;">--%>
                                                <telerik:RadCheckBox ID="cbxhourly" runat="server" Text="" Checked="false"
                                                    OnCheckedChanged="cbxhourly_CheckedChanged" AutoPostBack="true"
                                                    OnClientCheckedChanged="TimepikerChanged">
                                                </telerik:RadCheckBox>
                                            </div>
                                            <%--</div>--%>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="formRow"  style="height:34px!important;font-size:12px;">
                                    <div class="formCol"  style="padding-bottom:0px !important">
                                        <label>To Date</label>
                                        <div class="formRight"  style="padding-bottom:0px !important">
                                            <telerik:RadDatePicker ID="txtToDate" runat="server" DateInput-DateFormat="MM/dd/yyyy" AutoPostBack="true"
                                                OnSelectedDateChanged="txtToDate_SelectedDateChanged" Style="float: left;">
                                            </telerik:RadDatePicker>

                                            <asp:RequiredFieldValidator
                                                ID="rfvtxtToDate"
                                                ControlToValidate="txtToDate"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="formRow"  style="height:34px!important;font-size:12px;" id="FromTimeDiv">
                                    <div class="formCol"   style="padding-bottom:0px !important">
                                        <label>From Time</label>
                                        <div class="formRight"  style="padding-bottom:0px !important">
                                            <telerik:RadTimePicker ID="tpFromTime" runat="server" Style="float: left;"
                                                OnSelectedDateChanged="tpFromTime_SelectedDateChanged" AutoPostBack="true">
                                                <TimeView ID="TimeView" runat="server" Interval="00:15" />
                                            </telerik:RadTimePicker>
                                            <asp:RequiredFieldValidator
                                                ID="rfvtpFromTime"
                                                Enabled="false"
                                                ControlToValidate="tpFromTime"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="formRow"  style="height:34px!important;font-size:12px;" id="ToTimeDiv">
                                    
                                    <div class="formCol"   style="padding-bottom:0px !important">
                                        <label>To Time</label>
                                        <div class="formRight"  style="padding-bottom:0px !important">
                                            <telerik:RadTimePicker ID="tpToTime" runat="server" Style="float: left;"
                                                OnSelectedDateChanged="tpToTime_SelectedDateChanged" AutoPostBack="true">
                                                <TimeView ID="TimeView1" runat="server" Interval="00:15" />
                                            </telerik:RadTimePicker>

                                            <asp:RequiredFieldValidator
                                                ID="rfvtpToTime"
                                                Enabled="false"
                                                ControlToValidate="tpToTime"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>
                                <div class="formRow"  style="height:34px!important;font-size:12px;">
                                    <div class="formCol"   style="padding-bottom:0px !important">
                                        <label>Rejoining Date</label>
                                        <div class="formRight"  style="padding-bottom:0px !important">
                                            <telerik:RadDatePicker ID="txtRejoiningDate" runat="server" DateInput-DateFormat="MM/dd/yyyy" Enabled="false"></telerik:RadDatePicker>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="formRow main-div"  style="height:32px!important;font-size:12px;">
                                    <div class="durationcaculate"   style="height:29px!important;padding-bottom:0px !important">
                                    <label id="lblNoOfDays" runat="server">Days</label>
                                    <telerik:RadNumericTextBox ID="txtNumberOfDays" Visible="true" runat="server"
                                        Height="22px" AutoPostBack="true" Style="float: left; margin-top:0px!important;" >
                                    </telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator
                                        ID="rfvtxtNumberOfDays"
                                        ControlToValidate="txtNumberOfDays"
                                        ErrorMessage="*"
                                        Display="Dynamic"
                                        CssClass="requiredvalidators"
                                        ValidationGroup="FrmSubmit"
                                        SetFocusOnError="False"
                                        runat="server"></asp:RequiredFieldValidator>
                                        </div>

                                    <div class="durationcaculate rsdivprsntage"   style="height:29px!important;padding-bottom:0px !important">
                                        <label id="lblDayPercentage" runat="server" class="rslbpersnt" style="margin-top:2px">%</label>
                                        <telerik:RadNumericTextBox ID="txtDayPercentage" runat="server" Enabled="false"
                                            Height="25px" Style="float: left;margin-left: 11px; margin-top:0px!important;">
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator
                                            ID="rfvtxtDayPercentage"
                                            Enabled="false"
                                            ControlToValidate="txtDayPercentage"
                                            ErrorMessage="*"
                                            Display="Dynamic"
                                            CssClass="requiredvalidators"
                                            ValidationGroup="FrmSubmit"
                                            SetFocusOnError="False"
                                            runat="server"></asp:RequiredFieldValidator>
                                    </div>
                                                         
                                      <div class="clearm"></div>

                                   
                                      <div  class="durationcaculate rsdivhrs"   style="height:29px!important;padding-bottom:0px !important">
                                    <label id="lblOffHours" runat="server" class="rslbhrs">Hrs</label>          
                                    <telerik:RadNumericTextBox ID="txtOffHours" runat="server" Enabled="false" ShowSpinButtons="true"
                                        Height="25px" OnTextChanged="txtOffHours_TextChanged" AutoPostBack="true" MinValue="0" MaxValue="8">
                                    </telerik:RadNumericTextBox>

                                    <asp:RequiredFieldValidator
                                        ID="rfvtxtOffHours"
                                        Enabled="false"
                                        ControlToValidate="txtOffHours"
                                        ErrorMessage="*"
                                        Display="Dynamic"
                                        CssClass="requiredvalidators"
                                        ValidationGroup="FrmSubmit"
                                        SetFocusOnError="False"
                                        runat="server"></asp:RequiredFieldValidator>
                                        </div>
                                    
                                      <div class="durationcaculate rsmints"   style="height:29px!important;padding-bottom:0px !important">
                                        <label id="lblMinutes" class="lblMinutes" runat="server">Mints</label>
                                    
                                        <telerik:RadDropDownList RenderMode="Lightweight" ID="ddlMinutes" OnSelectedIndexChanged="ddlMinutes_SelectedIndexChanged" 
                                            AutoPostBack="true" runat="server"  Style="margin-left: 8px;" 
                                            Width ="26px" DropDownWidth="60px" Enabled="false" >
                                            <Items>
                                                <telerik:DropDownListItem Text="0" Value="0" />
                                                <telerik:DropDownListItem Text="15" Value="15"/>
                                                <telerik:DropDownListItem Text="30" Value="30" />
                                                <telerik:DropDownListItem Text="45" Value="45" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                    </div> 

                                    
                    
                                    <div class="clear"></div>
                                </div>

                                <div id="divCheckboxesRow" class="formRow" style="height:34px!important;font-size:12px;">

                                    <div id="divTicket" >
                                    <label id="lbairticket">Travelling Ticket</label>
                                    <telerik:RadCheckBox ID="checkAirTicket" runat="server" Text=""></telerik:RadCheckBox>
                                    </div>                                    
                                    <div id="divPerDiem">
                                        <label>Per Diem</label>
                                        <telerik:RadCheckBox ID="cbxPerDiem" runat="server" Text=""></telerik:RadCheckBox>
                                    </div>
                                    <div id="divVacationSalary">
                                        <label id="RspsvlbVSlry">Absence Salary</label>
                                        <telerik:RadCheckBox ID="cbxLeaveSalary" runat="server" Text=""></telerik:RadCheckBox>
                                    </div>
                                    <div id="divCashCheck" >
                                        <label>Advance Cash Request</label>
                                        <telerik:RadCheckBox ID="cbxCashcheck" ClientIDMode="Static" runat="server" Text=""
                                            OnClientCheckedChanged="CashCheckedChanged">
                                        </telerik:RadCheckBox>
                                    </div>

                                    <div id="divCashAmount">
                                        <label id="RspnsvCashAmnt">Cash Amount</label>
                                        <div id="txtmaxdiv">
                                            <asp:HiddenField ID="hfMaxCash" ClientIDMode="Static" Value="" runat="server" />
                                            <telerik:RadNumericTextBox ID="txtCashAmount" runat="server" ClientIDMode="Static" Height="25px" ClientEvents-OnValueChanged="checkMaxLimit">
                                                <NumberFormat GroupSeparator="" DecimalDigits="2" />
                                            </telerik:RadNumericTextBox>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>


                                <div class="formRow"   style="height:34px!important;font-size:12px;">
                                    <div class="formCol" style="padding-bottom:0px !important">
                                        <label>Remarks 1</label>
                                        <div class="formRight" style="padding-bottom:0px !important">
                                            <telerik:RadTextBox ID="txtRemarks1" runat="server" MaxLength="30" Height="25px">
                                            </telerik:RadTextBox>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="formRow"   style="height:34px!important;font-size:12px;">
                                    <div class="formCol" style="padding-bottom:0px !important">
                                        <label>Remarks 2</label>
                                        <div class="formRight" style="padding-bottom:0px !important">
                                            <telerik:RadTextBox ID="txtRemarks2" runat="server" MaxLength="30" Height="25px">
                                            </telerik:RadTextBox>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>

                                <div class="formRow"   style="height:34px!important;font-size:12px;">
                                    <div class="formCol" style="padding-bottom:0px !important">
                                        <label>Attachments</label>
                                        <div class="formRight" style="padding-bottom:0px !important">
                                            <telerik:RadAsyncUpload runat="server" ID="ruDocument" overwriteexistingfiles="true" Width="296px" InputSize="150"
                                                AllowedFileExtensions="txt,pdf,doc,jpg,png,gif,bmp,docx,xlsx"
                                                MultipleFileSelection="Disabled" MaxFileSize="524288"
                                                MaxFileInputsCount="3"
                                                OnClientFileUploaded="onClientFileUploaded"
                                                TemporaryFolder="~\App_Data\RadUploadTemp\">
                                            </telerik:RadAsyncUpload>


                                            <asp:Literal runat="server" ID="ltrNoResults" Visible="false" Text="<br><strong>No files uploaded</strong></br>" />
                                            <telerik:RadGrid ID="gvAttachments" Visible="false" Width="565px" OnNeedDataSource="gvAttachments_NeedDataSource"
                                                OnItemCommand="gvAttachments_ItemCommand" OnDeleteCommand="gvAttachments_DeleteCommand" OnItemdatabound="gvAttachments_ItemDataBound"
                                                runat="server">
                                                <FilterMenu EnableImageSprites="False">
                                                </FilterMenu>
                                                <ClientSettings>
                                                    <Selecting CellSelectionMode="None"></Selecting>
                                                </ClientSettings>
                                                <MasterTableView Name="AttachmentList" CommandItemDisplay="None" AutoGenerateColumns="False"
                                                    DataKeyNames="RecordId,OnlineId"
                                                    InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="InPlace"
                                                    CommandItemSettings-ShowAddNewRecordButton="false"
                                                    AllowFilteringByColumn="false">
                                                    <DetailTables>
                                                    </DetailTables>
                                                    <CommandItemTemplate>
                                                        <div class="title">
                                                            <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><%--<h6>Attachments</h6>--%>
                                                        </div>
                                                        <tr class="rgCommandRow">

                                                            <td colspan="8" class="rgCommandCell">

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

                                                                                <asp:Button ID="addTask" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
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

                                                        <telerik:GridTemplateColumn DataField="DocName" FilterControlWidth="50px" AutoPostBackOnFilter="true" SortExpression="DocName"
                                                            CurrentFilterFunction="Contains" FilterControlAltText="Filter DocName column"
                                                            HeaderText="Document Name" UniqueName="DocName">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDocName" runat="server" Text='<%# Eval("DocName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn DataField="DocType" FilterControlWidth="50px" AutoPostBackOnFilter="true" SortExpression="DocType"
                                                            CurrentFilterFunction="Contains" FilterControlAltText="Filter DocType column"
                                                            HeaderText="Document Type" UniqueName="DocType">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDocType" runat="server" Text='<%# Eval("DocType") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn DataField="Description" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="Description"
                                                            CurrentFilterFunction="Contains" FilterControlAltText="Filter Description column"
                                                            HeaderText="Description" UniqueName="Description">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDesc" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="additionalColumn" />
                                                            <ItemStyle CssClass="additionalColumn" />
                                                        </telerik:GridTemplateColumn>

                                                        <%--<telerik:GridTemplateColumn DataField="attachedOn"  AutoPostBackOnFilter="true" SortExpression="attachedOn"
                                                            CurrentFilterFunction="Contains" FilterControlAltText="Filter attachedOn column"
                                                            HeaderText="Date" UniqueName="attachedOn">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblattachedOn" runat="server" Text='<%# Eval("attachedOn") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn DataField="UserName" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="UserName"
                                                            CurrentFilterFunction="Contains" FilterControlAltText="Filter UserName column"
                                                            HeaderText="User" UniqueName="UserName">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>--%>

                                                        <telerik:GridTemplateColumn>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lbtnDownload" runat="server" Text="Download" CommandName="Download" ToolTip="Download">
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="70px" HorizontalAlign="Center" />
                                                        </telerik:GridTemplateColumn>


                                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete the selected attachment?"
                                                            ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                            UniqueName="DeleteAttachment">
                                                            <ItemStyle HorizontalAlign="Center" Width="0px" />
                                                        </telerik:GridButtonColumn>

                                                    </Columns>
                                                    <EditFormSettings CaptionFormatString='Edit Details for task "{0}":' CaptionDataField="id">
                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                        </EditColumn>
                                                        <EditColumn ButtonType="ImageButton" />
                                                    </EditFormSettings>
                                                </MasterTableView>

                                            </telerik:RadGrid>



                                        </div>
                                    </div>
                                 <div class="clear" style="padding-bottom:0px !important"></div>
                                </div>

                                <div class="clear" style="padding-bottom:0px !important"></div>

                            </div>
                            <div class="clear" style="padding-bottom:0px !important"></div> 

                        </div>
                        <div class="span4 col-5 col-m-6">
                            <uc1:ucEmployeeCard runat="server" ID="ucEmployeeCard" />
                            <uc1:ucEmployeeLeaveBalance runat="server" ID="ucEmployeeLeaveBalance" />
                       
                        </div>
                        <div class="clear"></div>


                        <%-- <div class="wizButtons">
                            <span class="wNavButtons" style="width: 520px">

                                <asp:Button ID="rBtnSave" runat="server" OnClick="rBtnSave_Click" Text="Save"
                                    ValidationGroup="FrmSubmit" class="button greenB" CausesValidation="true"
                                    OnClientClick="if (!ValidateForm()) { return false;};"></asp:Button>

                                <asp:Button ID="rBtnNewRequest" runat="server" OnClick="rBtnnewrequest_Click" Text="New Request"
                                    Style="" class="button greenB" CausesValidation="false"></asp:Button>

                                <asp:Button ID="rBtnSaveAndSubmit" runat="server" OnClick="rBtnSaveAndSubmit_Click"
                                    OnClientClick="if (!ValidateForm()) { return false;};"
                                    Text="Save and Submit" class="button blueB"
                                    ValidationGroup="FrmSubmit" CausesValidation="true"></asp:Button>

                            </span>
                        </div>--%>

                        <%--<div class="clear"></div>--%>



                        <asp:Panel ID="ApprovalPanel" Visible="false" runat="server">
                             <div class="widget">
                            
                            <div class="title">
                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6>Decision Remarks</h6>
                            </div>
                            <div class="formRow">
                                <div class="formCol">
                                    <label>Remarks</label>
                                    <div class="formRight">
                                        <telerik:RadTextBox ID="txtremarks" runat="server" MaxLength="50">
                                        </telerik:RadTextBox>
                                    </div>
                                </div>

                                <div class="clear"></div>
                            </div>
                    </div>
                    <%--start--%>

   

                    <div class="widget">
                            <div class="title">
                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6>Select User to Revise/Review</h6>
                            </div>
                            <div class="formRow">
                                <div class="formCol">
                                    <label>User</label>
                                    <div class="formRight">
                                        <span class="combo180">
                                          <telerik:RadComboBox ID="rCmbLevels" runat="server" Width="180px" DropDownWidth="180px" EmptyMessage="Please select...">
                                            <ItemTemplate>
                                                <telerik:RadGrid ID="rGrdLevels4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                    CellSpacing="0" GridLines="None" Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                    <ClientSettings>
                                                        <Selecting AllowRowSelect="true"></Selecting>

                                                    </ClientSettings>
                                                    <MasterTableView DataKeyNames="ID" ClientDataKeyNames="ID">

                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="ID" FilterControlAltText="Filter column column"
                                                                HeaderText="ID" UniqueName="column">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="UserLevel" FilterControlAltText="Filter column column"
                                                                HeaderText="Level" UniqueName="column">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="ApprovedByUserID" FilterControlAltText="Filter column1 column"
                                                                HeaderText="User" UniqueName="column1">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="RequestStatusID" FilterControlAltText="Filter column2 column"
                                                                HeaderText="RequestStatusID" UniqueName="column2">
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <ClientEvents OnRowClick="RowClickedRevise"></ClientEvents>
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </ItemTemplate>
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                            </Items>
                                        </telerik:RadComboBox>
                                            </span>
                                    </div>
                                </div>

                                <div class="clear"></div>
                            </div>
                    </div>
                    <%--end--%>
                    <div class="wizButtons">
                        <span class="wNavButtons">

                            <asp:Button ID="rBtnApprove" runat="server" OnClick="rBtnApprove_Click" Text="Approve"
                                class="button greenB" CausesValidation="True"></asp:Button>

                            <asp:Button ID="rBtnReject" runat="server" OnClick="rBtnReject_Click"
                                Text="Reject" class="button blueB" CausesValidation="True"></asp:Button>

                            <asp:Button ID="rBtnRevise" runat="server" OnClick="rBtnRevise_Click"
                                Text="Revise" class="button blueB" CausesValidation="True"></asp:Button>
                        </span>
                    </div>
                    <div class="clear"></div>
                    <%--start--%>
                    <div class="formRight">
                    <telerik:RadGrid ID="gvHistory" runat="server" AllowPaging="True" AllowSorting="True"
                        AllowFilteringByColumn="false" AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                        OnNeedDataSource="gvHistory_NeedDataSource" PageSize="20"
                        ShowStatusBar="false" OnItemCommand="gvHistory_ItemCommand"
                        OnItemDataBound="gvHistory_ItemDataBound"
                        >
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
                        <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="ID"
                            InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                            <DetailTables>
                            </DetailTables>
                            <CommandItemTemplate>
                                <tr class="rgCommandRow">
                                    <div class="title">
                                        <img src="../../images/icons/dark/users.png" alt="" class="titleIcon" /><h6>Request History</h6>
                                        <div class="num">
                                            <a class="blueNum">
                                                <asp:Literal ID="ltNotiCount" runat="server"></asp:Literal></a>
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
                                                    </td>
                                                    <td align="right">
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
                                <telerik:GridBoundColumn DataField="ID" Visible="false" SortExpression="ID" FilterControlAltText="Filter column column"
                                    HeaderText="ID" UniqueName="ID" ReadOnly="True" DataType="System.Int32">
                                    <ColumnValidationSettings>
                                        <ModelErrorMessage Text=""></ModelErrorMessage>
                                    </ColumnValidationSettings>
                                    <FilterTemplate>
                                        <strong>Search</strong>
                                    </FilterTemplate>
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="ApprovedByUserID" FilterControlWidth="130px" SortExpression="ApprovedByUserID"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Approved By User" UniqueName="ApprovedByUserID">
                                    <ItemTemplate>
                                        <asp:Label ID="lblApprovedByUserID" runat="server" Text='<%# Eval("ApprovedByUserID") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="UpdateDate" FilterControlWidth="130px" SortExpression="UpdateDate"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Update Date" UniqueName="UpdateDate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUpdateDate" runat="server" Text='<%# Eval("UpdateDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                 <telerik:GridTemplateColumn DataField="Remarks" FilterControlWidth="130px" SortExpression="Remarks"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Remarks" UniqueName="Remarks">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                 <telerik:GridTemplateColumn DataField="Transremarks" FilterControlWidth="130px" SortExpression="Transremarks"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Trans Remarks" UniqueName="Transremarks">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransremarks" runat="server" Text='<%# Eval("Transremarks") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                            </Columns>
                            <EditFormSettings CaptionFormatString='Edit Details for Notification "{0}":' CaptionDataField="ID">
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                                <EditColumn ButtonType="ImageButton" />
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>

                        </asp:Panel>









                    </div>
                </div>

                <div id="tab2" class="tab_content">


                    <fieldset>

                        <span class="wNavButtons" style="display: inline-flex; float: right; margin-right: 15px; margin-bottom: 10px;">
                            <asp:Button ID="btnNewRequest" runat="server" OnClick="rBtnnewrequest_Click" Text="New Request"
                                Style="margin-left: 5px;" class="button greenB" CausesValidation="false" OnClientClick="hideValidators()"></asp:Button>

                        </span>



                        <%--<div class="widget12">--%>
                        <div class="wEmployeePreview">
                            <div class="title2">
                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6i>This Grid is showing all the saved requests by the current user.</h6i>
                            </div>
                            <telerik:RadGrid ID="gvSavedRequests" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="gvSavedRequests_NeedDataSource"
                                PageSize="20" ShowStatusBar="True" OnDetailTableDataBind="gvSavedRequests_DetailTableDataBind"
                                OnItemCreated="gvSavedRequests_ItemCreated" OnItemCommand="gvSavedRequests_ItemCommand">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                    <Selecting CellSelectionMode="None" AllowRowSelect="true"></Selecting>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="RequestID" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                                    AllowMultiColumnSorting="true" EditMode="EditForms">
                                    <DetailTables>
                                        <telerik:GridTableView runat="server" Name="RequestStatuses" AllowMultiColumnSorting="true">
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </ExpandCollapseColumn>
                                            <Columns>

                                                <telerik:GridBoundColumn DataField="ID" FilterControlAltText="Filter column column"
                                                    HeaderText="ID" UniqueName="column6" ReadOnly="True" Visible="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="UserLevel" FilterControlAltText="Filter column column"
                                                    HeaderText="Level" UniqueName="column2" ReadOnly="True">
                                                    <ItemStyle Width="20px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="MappingType" FilterControlAltText="Filter column column"
                                                    HeaderText="App. Type" UniqueName="column">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="groupcode" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Group" UniqueName="column5">
                                                    <ItemStyle Width="30px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="MainApproverFullName" FilterControlAltText="Filter column3 column"
                                                    HeaderText="Approver" UniqueName="column3">
                                                    <ItemStyle Width="150px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="RequestStatus" FilterControlAltText="Filter column column"
                                                    HeaderText="Status" UniqueName="colRequestStatus" ReadOnly="True">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UpdateDate" FilterControlAltText="Filter column1 column"
                                                    HeaderText="Status Update Date/Time" UniqueName="column1" DataType="System.DateTime" DataFormatString="{0:d/M/yyyy hh:mm tt}">
                                                    <ItemStyle Width="120px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="ApprovedByFullName" FilterControlAltText="Filter column4 column"
                                                    HeaderText="Decision by" UniqueName="column4">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Remarks" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Status Description" UniqueName="column5">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="levelcolor" FilterControlAltText="Filter column5 column"
                                                    HeaderText="levelcolor" UniqueName="collevelcolor" Display="true" Visible="false">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <SortExpressions>
                                                <telerik:GridSortExpression FieldName="UpdateDate" SortOrder="Descending" />
                                                <telerik:GridSortExpression FieldName="ID" SortOrder="Descending" />
                                            </SortExpressions>
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
                                        <telerik:GridBoundColumn DataField="RequestID" SortExpression="RequestID" FilterControlAltText="Filter column1 column"
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="transactionNumber" SortExpression="transactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="Transaction No." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="RequestDate" SortExpression="RequestDate" FilterControlAltText="Filter column6 column"
                                            HeaderText="Entry Date" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="180px" />

                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="employeeCode" SortExpression="employeeCode" FilterControlAltText="Filter column3 column"
                                            HeaderText="Emp. Code" UniqueName="column3" ReadOnly="True">
                                            <ItemStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="FullName" SortExpression="FullName" FilterControlAltText="Filter column4 column"
                                            HeaderText="Submitted for" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="160px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <%--<asp:ImageButton ID="imgBtnEdit" runat="server" CommandName="Edit" ImageUrl="~/Images/16x16_pencil.png"
                                                    Visible='<%# isEditVisible(Eval("Last_Status_ID").ToString(),int.Parse(Eval("EmployeeUserID").ToString())) %>'
                                                    ToolTip="Edit this request." />--%>
                                                <asp:ImageButton ID="imgBtnEdit" runat="server" CommandName="ViewEdit" ImageUrl="~/Images/16x16_pencil.png"
                                                    CommandArgument='<%# Eval("RequestID") %>' OnClientClick="hideValidators()"
                                                    ToolTip="Edit this request." />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>

                                                <asp:ImageButton ID="imgBtnSubmit" runat="server" CommandName="Submit" ImageUrl="~/Images/16x16_tick2.png"
                                                    Visible='<%# isSubmitVisible(Eval("Last_Status_ID").ToString(),int.Parse(Eval("EmployeeUserID").ToString())) %>'
                                                    ToolTip="Submit Now!" CommandArgument='<%# Eval("RequestID") %>' />

                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="TemplateColumn">
                                            <ItemTemplate>
                                                <%--  <asp:ImageButton ID="imgBtnDelete" runat="server" ImageUrl="~/Images/Delete.png"
                                                    AlternateText="Delete" ToolTip="Delete Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Delete" ConfirmText="Are you sure to delete selected request?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete Request" 
                                                    ConfirmTextFormatString='Are you sure to delete Suggestion Request "{0}"?' />--%>

                                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/Delete.png"
                                                    AlternateText="Delete" ToolTip="Delete Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this request ?');" />

                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="RequestID" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="transactionNumber">
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                        <EditColumn ButtonType="ImageButton" />
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                        
                    </fieldset>
                </div>
                <div id="tab3" class="tab_content">

                    <fieldset>
                        <div class="widget13">
                            <div class="title3">
                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6i>This Grid is showing all the requests submitted for approval by the current user.</h6i>
                            </div>

                            <telerik:RadGrid ID="gvSubmittedRequests" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="gvSubmittedRequests_NeedDataSource"
                                PageSize="20" ShowStatusBar="True" OnDetailTableDataBind="gvSubmittedRequests_DetailTableDataBind"
                                OnItemCreated="gvSubmittedRequests_ItemCreated" OnItemCommand="gvSubmittedRequests_ItemCommand"
                                OnItemDataBound="gvSubmittedRequests_ItemDataBound">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                </ClientSettings>
                                <MasterTableView Name="entryview" AutoGenerateColumns="False" DataKeyNames="RequestID" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                                    AllowMultiColumnSorting="true" EditMode="EditForms">
                                    <DetailTables>
                                        <telerik:GridTableView runat="server" Name="RequestStatuses" AllowMultiColumnSorting="true">
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </ExpandCollapseColumn>

                                            <Columns>

                                                <telerik:GridBoundColumn DataField="ID" FilterControlAltText="Filter column column"
                                                    HeaderText="ID" UniqueName="column6" ReadOnly="True" Visible="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="UserLevel" FilterControlAltText="Filter column column"
                                                    HeaderText="Level" UniqueName="column2" ReadOnly="True">
                                                    <ItemStyle Width="20px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="MappingType" FilterControlAltText="Filter column column"
                                                    HeaderText="App. Type" UniqueName="column">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="groupcode" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Group" UniqueName="column5">
                                                    <ItemStyle Width="30px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="MainApproverFullName" FilterControlAltText="Filter column3 column"
                                                    HeaderText="Approver" UniqueName="column3">
                                                    <ItemStyle Width="150px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="RequestStatus" FilterControlAltText="Filter column column"
                                                    HeaderText="Status" UniqueName="colRequestStatus" ReadOnly="True">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UpdateDate" FilterControlAltText="Filter column1 column"
                                                    HeaderText="Status Update Date/Time" UniqueName="column1" DataType="System.DateTime" DataFormatString="{0:d/M/yyyy hh:mm tt}">
                                                    <ItemStyle Width="120px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="ApprovedByFullName" FilterControlAltText="Filter column4 column"
                                                    HeaderText="Decision by" UniqueName="column4">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Remarks" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Status Description" UniqueName="column5">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="levelcolor" FilterControlAltText="Filter column5 column"
                                                    HeaderText="levelcolor" UniqueName="collevelcolor" Display="true" Visible="false">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <SortExpressions>
                                                <telerik:GridSortExpression FieldName="UpdateDate" SortOrder="Descending" />
                                                <telerik:GridSortExpression FieldName="ID" SortOrder="Descending" />
                                            </SortExpressions>
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
                                        <telerik:GridBoundColumn DataField="RequestID" FilterControlAltText="Filter column1 column"
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="transactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="Transaction No." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="150px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="RequestDate" FilterControlAltText="Filter column6 column"
                                            HeaderText="Entry Date/Time" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="180px" />

                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="employeeCode" FilterControlAltText="Filter column3 column"
                                            HeaderText="Emp. Code" UniqueName="column3" ReadOnly="True">
                                            <ItemStyle Width="80px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="FullName" FilterControlAltText="Filter column4 column"
                                            HeaderText="Submitted for" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="160px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>

                                                <asp:ImageButton ID="imgBtnRecall" runat="server" CommandName="Recall" ImageUrl="~/Images/16x16_recall.png"
                                                    Visible='<%# isRecallVisible(Convert.ToString(Eval("Last_Status_ID")),int.Parse(Convert.ToString(Eval("SubmittedByUserID")))) %>'
                                                    ToolTip="Recall request." />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>

                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="RequestID" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="transactionNumber">
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                        <EditColumn ButtonType="ImageButton" />
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </fieldset>
                </div>
                <div id="tab4" class="tab_content">
                    <fieldset>
                        <div class="widget14">
                            <div class="title4">
                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6i>This Grid is showing all the requests pending for approval by the current user.</h6i>
                            </div>

                            <telerik:RadGrid ID="gvPendingAppRequests" runat="server" AllowPaging="True"
                                AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                                OnNeedDataSource="gvPendingAppRequests_NeedDataSource" PageSize="20" ShowStatusBar="True"
                                OnItemCreated="gvPendingAppRequests_ItemCreated" OnItemCommand="gvPendingAppRequests_ItemCommand"
                                OnItemDataBound="gvPendingAppRequests_ItemDataBound" OnDetailTableDataBind="gvPendingAppRequests_DetailTableDataBind">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                    <Selecting CellSelectionMode="None"></Selecting>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="RequestID,RequestStatusID"
                                    InsertItemPageIndexAction="ShowItemOnCurrentPage" AllowMultiColumnSorting="true"
                                    EditMode="EditForms">

                                    <DetailTables>
                                        <telerik:GridTableView runat="server" Name="RequestStatuses" AllowMultiColumnSorting="true">
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </ExpandCollapseColumn>
                                            <Columns>

                                                <telerik:GridBoundColumn DataField="ID" FilterControlAltText="Filter column column"
                                                    HeaderText="ID" UniqueName="column6" ReadOnly="True" Visible="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="UserLevel" FilterControlAltText="Filter column column"
                                                    HeaderText="Level" UniqueName="column2" ReadOnly="True">
                                                    <ItemStyle Width="20px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="MappingType" FilterControlAltText="Filter column column"
                                                    HeaderText="App. Type" UniqueName="column">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="groupcode" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Group" UniqueName="column5">
                                                    <ItemStyle Width="30px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="MainApproverFullName" FilterControlAltText="Filter column3 column"
                                                    HeaderText="Approver" UniqueName="column3">
                                                    <ItemStyle Width="150px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="RequestStatus" FilterControlAltText="Filter column column"
                                                    HeaderText="Status" UniqueName="colRequestStatus" ReadOnly="True">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UpdateDate" FilterControlAltText="Filter column1 column"
                                                    HeaderText="Status Update Date/Time" UniqueName="column1" DataType="System.DateTime" DataFormatString="{0:d/M/yyyy hh:mm tt}">
                                                    <ItemStyle Width="120px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="ApprovedByFullName" FilterControlAltText="Filter column4 column"
                                                    HeaderText="Decision by" UniqueName="column4">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Remarks" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Status Description" UniqueName="column5">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="levelcolor" FilterControlAltText="Filter column5 column"
                                                    HeaderText="levelcolor" UniqueName="collevelcolor" Display="true" Visible="false">
                                                </telerik:GridBoundColumn>
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

                                        <telerik:GridBoundColumn DataField="RequestID" FilterControlAltText="Filter column1 column"
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="transactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="Transaction No." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="RequestDate" FilterControlAltText="Filter column5 column"
                                            HeaderText="Entry Date/Time" UniqueName="column5" ReadOnly="True">
                                            <ItemStyle Width="180px" />

                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="SubmittedByUserCode" FilterControlAltText="Filter column column"
                                            HeaderText="Emp. Code" UniqueName="column6" ReadOnly="True" Visible="True">
                                            <ItemStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="FullName" FilterControlAltText="Filter column4 column"
                                            HeaderText="Submitted for" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="160px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnApprove" runat="server" CommandArgument='<%#  Eval("RequestID")+ ";" +Eval("RequestStatusID") %>' CommandName="Approve" ImageUrl="~/Images/16x16_Check.png"
                                                    ToolTip="Approve/Reject this request." Visible='<%# int.Parse(Eval("Priority").ToString()) == 1 %>' />
                                                <asp:Image ID="imgApproved" runat="server" ImageUrl="~/Images/16x16_approved.png" Visible='<%# int.Parse(Eval("Priority").ToString()) == 2 %>'
                                                    ToolTip="This Request is Approved." />
                                                <asp:Image ID="imgReject" runat="server" ImageUrl="~/Images/16x16_rejected.png" Visible='<%# int.Parse(Eval("Priority").ToString()) == 3 %>'
                                                    ToolTip="This Request is Rejected." />

                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                    </Columns>
                                    <EditFormSettings CaptionFormatString='Edit Details for this Suggestion "{0}":' CaptionDataField="transactionNumber">
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                        <EditColumn ButtonType="ImageButton" />
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </fieldset>
                </div>
                <div id="tab5" class="tab_content">

                    <fieldset>
                        <div class="widget15">
                            <div class="title5">
                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6i>This Grid is showing all the approved requests by the current user.</h6i>
                            </div>


                            <telerik:RadToolTipManager ID="RadToolTipManager3" runat="server" Position="BottomCenter"
                                Animation="Fade" RelativeTo="Element" Style="font-size: 18px; text-align: center; font-family: Arial;"
                                RenderInPageRoot="true" OnClientShow="OnClientShow" OnClientHide="OnClientHide" Width="900" Height="500">
                            </telerik:RadToolTipManager>

                            <telerik:RadGrid ID="gvApprovedRequests" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                                PageSize="20" ShowStatusBar="True"
                                OnNeedDataSource="gvApprovedRequests_NeedDataSource"
                                OnDetailTableDataBind="gvApprovedRequests_DetailTableDataBind"
                                OnItemCreated="gvApprovedRequests_ItemCreated"
                                OnItemCommand="gvApprovedRequests_ItemCommand"
                                OnItemDataBound="gvApprovedRequests_ItemDataBound">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                    <Selecting CellSelectionMode="None"></Selecting>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="RequestID" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                                    AllowMultiColumnSorting="true" EditMode="EditForms">

                                    <DetailTables>
                                        <telerik:GridTableView runat="server" Name="RequestStatuses" AllowMultiColumnSorting="true">
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </ExpandCollapseColumn>
                                            <Columns>

                                                <telerik:GridBoundColumn DataField="ID" FilterControlAltText="Filter column column"
                                                    HeaderText="ID" UniqueName="column6" ReadOnly="True" Visible="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="UserLevel" FilterControlAltText="Filter column column"
                                                    HeaderText="Level" UniqueName="column2" ReadOnly="True">
                                                    <ItemStyle Width="20px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="MappingType" FilterControlAltText="Filter column column"
                                                    HeaderText="App. Type" UniqueName="column">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="groupcode" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Group" UniqueName="column5">
                                                    <ItemStyle Width="30px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="MainApproverFullName" FilterControlAltText="Filter column3 column"
                                                    HeaderText="Approver" UniqueName="column3">
                                                    <ItemStyle Width="150px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="RequestStatus" FilterControlAltText="Filter column column"
                                                    HeaderText="Status" UniqueName="colRequestStatus" ReadOnly="True">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UpdateDate" FilterControlAltText="Filter column1 column"
                                                    HeaderText="Status Update Date/Time" UniqueName="column1" DataType="System.DateTime" DataFormatString="{0:d/M/yyyy hh:mm tt}">
                                                    <ItemStyle Width="120px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="ApprovedByFullName" FilterControlAltText="Filter column4 column"
                                                    HeaderText="Decision by" UniqueName="column4">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Remarks" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Status Description" UniqueName="column5">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="levelcolor" FilterControlAltText="Filter column5 column"
                                                    HeaderText="levelcolor" UniqueName="collevelcolor" Display="true" Visible="false">
                                                </telerik:GridBoundColumn>
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
                                        <telerik:GridBoundColumn DataField="RequestID" FilterControlAltText="Filter column1 column"
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="transactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="Transaction No." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="RequestDate" FilterControlAltText="Filter column5 column"
                                            HeaderText="Entry Date/Time" UniqueName="column5" ReadOnly="True">
                                            <ItemStyle Width="180px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="employeeCode" FilterControlAltText="Filter column3 column"
                                            HeaderText="Emp. Code" UniqueName="column3" ReadOnly="True">
                                            <ItemStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="FullName" FilterControlAltText="Filter column4 column"
                                            HeaderText="Submitted for" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="160px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumnsdf1" HeaderText="Status">
                                            <ItemTemplate>

                                                <asp:Image ID="imgCompletsdfed" runat="server" ImageUrl='<%# getImagePathForTrue((Eval("status").ToString())) %>'
                                                    ToolTip="Request Status" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="RequestID" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="transactionNumber">
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                        <EditColumn ButtonType="ImageButton" />
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </fieldset>
                </div>

                <button onclick="topFunction()" id="myBtn" class="myBtn button blueB" title="Go to top" type="button"><img src="../../Images/icons/arrow-185-32.png"  style="margin-top:-19px;margin-left:-16px"/></button>
            </asp:Panel>
        </div>
        <div class="clear"></div>
    </div>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Style="z-index: 10000;">
        <Windows>
            <telerik:RadWindow ID="RadWindow1" runat="server" Modal="true"
                Width="1000px" Height="580px" ReloadOnShow="true" ShowContentDuringLoad="false"
                VisibleStatusbar="false" EnableShadow="true" MinHeight="580px" MaxHeight="580px"
                MinWidth="1000px" MaxWidth="1000px">
            </telerik:RadWindow>
            <telerik:RadWindow ID="RadWindow2" runat="server" Modal="true" Title="Approve or reject request"
                Width="1000px" Height="580px" ReloadOnShow="true" ShowContentDuringLoad="false"
                VisibleStatusbar="false" EnableShadow="true" MinHeight="480px" MaxHeight="580px"
                MinWidth="1000px" MaxWidth="1000px">
            </telerik:RadWindow>
            <telerik:RadWindow ID="RadWindowOrgChart" runat="server" Modal="true" Title="Workflow Details"
                Width="800px" Height="500px" ReloadOnShow="true" ShowContentDuringLoad="false"
                VisibleStatusbar="false" EnableShadow="false" MinHeight="480px" MaxHeight="500px"
                MinWidth="800px" MaxWidth="800px">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" IsSticky="true" runat="server" />
</asp:Content>
