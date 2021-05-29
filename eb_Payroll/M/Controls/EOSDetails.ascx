<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EOSDetails.ascx.cs" Inherits="Controls_EOSDetails" %>

<div class="widget">
    <ul class="tabs">
        <li>
            <a href="#tab11">Gratuity Detail</a>
        </li>
        <li>
            <a href="#tab12">Leave Detail</a>
        </li>
        <li>
            <a href="#tab13">Salary Detail</a>
        </li>
        <li>
            <a href="#tab14">Loan Detail</a>
        </li>
    </ul>

    <div class="tab_container">
        <div id="tab11" class="tab_content">
            <telerik:RadGrid ID="gridGratuityDetail" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                CellSpacing="0" GridLines="None" ClientSettings-EnableRowHoverStyle="True">
                <MasterTableView DataKeyNames="LineItemSequence" ClientDataKeyNames="LineItemSequence">
                    <Columns>
                        <telerik:GridBoundColumn DataField="LineItemSequence" FilterControlAltText="Filter column column" HeaderText="Line Item Sequence" UniqueName="column">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="GratuityCode" FilterControlAltText="Filter column1 column" HeaderText="Gratuity Code" UniqueName="column1">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="FromYear" FilterControlAltText="Filter column2 column" HeaderText="From Year" UniqueName="column2">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ToYear" FilterControlAltText="Filter column3 column" HeaderText="To year" UniqueName="column3">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NoOfDays" FilterControlAltText="Filter column4 column" HeaderText="No. of Days" UniqueName="column4">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Amount" FilterControlAltText="Filter column5 column" HeaderText="Amount" UniqueName="column5">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CurrentTransactionAmount" FilterControlAltText="Filter column6 column" HeaderText="Current Transaction Amount" UniqueName="column6">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
        <div id="tab12" class="tab_content">
            <telerik:RadGrid ID="gridLeaveDetail" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                CellSpacing="0" GridLines="None" ClientSettings-EnableRowHoverStyle="True">
                <MasterTableView DataKeyNames="LineItemSequence" ClientDataKeyNames="LineItemSequence">
                    <Columns>
                        <telerik:GridBoundColumn DataField="LineItemSequence" FilterControlAltText="Filter column column" HeaderText="Line Item Sequence" UniqueName="column">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="LeaveTypeCode" FilterControlAltText="Filter column1 column" HeaderText="Leave Type Code" UniqueName="column1">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="LeaveCode" FilterControlAltText="Filter column2 column" HeaderText="Leave Code" UniqueName="column2">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="LeaveBalance" FilterControlAltText="Filter column3 column" HeaderText="Leave Balance" UniqueName="column3">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Amount" FilterControlAltText="Filter column4 column" HeaderText="Amount" UniqueName="column4">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
        <div id="tab13" class="tab_content">
            <telerik:RadGrid ID="gridSalaryDetail" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                CellSpacing="0" GridLines="None" ClientSettings-EnableRowHoverStyle="True">
                <MasterTableView DataKeyNames="LineItemSequence" ClientDataKeyNames="LineItemSequence">
                    <Columns>
                        <telerik:GridBoundColumn DataField="LineItemSequence" FilterControlAltText="Filter column column" HeaderText="Line Item Sequence" UniqueName="column">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="PayCode" FilterControlAltText="Filter column1 column" HeaderText="Pay Code" UniqueName="column1">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="DeductionCode" FilterControlAltText="Filter column2 column" HeaderText="Deduction Code" UniqueName="column2">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter column3 column" HeaderText="Description" UniqueName="column3">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Amount" FilterControlAltText="Filter column4 column" HeaderText="Amount" UniqueName="column4">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
        <div id="tab14" class="tab_content">
            <telerik:RadGrid ID="gridLoanDetail" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                CellSpacing="0" GridLines="None" ClientSettings-EnableRowHoverStyle="True">
                <MasterTableView DataKeyNames="LineItemSequence" ClientDataKeyNames="LineItemSequence">
                    <Columns>
                        <telerik:GridBoundColumn DataField="LineItemSequence" FilterControlAltText="Filter column column" HeaderText="Line Item Sequence" UniqueName="column">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="DeductionCode" FilterControlAltText="Filter column2 column" HeaderText="Deduction Code" UniqueName="column2">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="LoanCode" FilterControlAltText="Filter column1 column5" HeaderText="Loan Code" UniqueName="column5">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Principal Amount" FilterControlAltText="Filter column3 column" HeaderText="Principal Amount" UniqueName="column3">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Principal Balance" FilterControlAltText="Filter column4 column" HeaderText="Principal Balance" UniqueName="column4">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Remaining Loan Amount" FilterControlAltText="Filter column6 column" HeaderText="RemainingLoanAmount" UniqueName="column6">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
</div>
<div class="clear"></div>
