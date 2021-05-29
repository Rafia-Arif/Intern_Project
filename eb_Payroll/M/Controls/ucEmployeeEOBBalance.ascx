<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucEmployeeEOBBalance.ascx.cs" Inherits="Controls_ucEmployeeEOBBalance" %>

<div class="widget">

    <div class="title">
        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
        <h6>Details</h6>
    </div>

    <div class="formRow">
        <div class="formCol">
            <label>
                Worked Years:
                                            <asp:Literal runat="server" ID="literalBroughtForward"></asp:Literal></label>
        </div>
        <div class="formCol">
            <label>
                Gratuity Amount:
                                            <asp:Literal runat="server" ID="literalLeaveTakenYTD"></asp:Literal></label>
        </div>
        <div class="clear"></div>
    </div>
    <div class="formRow">
        <div class="formCol">
            <label>
                Worked Months:
                                            <asp:Literal runat="server" ID="literalAvailableBalance"></asp:Literal></label>
        </div>
        <div class="formCol">
            <label>
                Leave Salary Amount:
                                            <asp:Literal runat="server" ID="literalLeaveTakenLTD"></asp:Literal></label>
        </div>
        <div class="clear"></div>
    </div>
    <div class="formRow">
        <div class="formCol">
            <label>
                Worked Days:
                                            <asp:Literal runat="server" ID="literalLVBalanceAOD"></asp:Literal></label>
        </div>
        <div class="formCol">
            <label>
                Last Month Salary Amount:
                                            <asp:Literal runat="server" ID="literalLeaveTakenAOY"></asp:Literal></label>
        </div>
        <div class="clear"></div>
    </div>
    <div class="formRow">
        <div class="formCol">
            <label>
                Absent days:
                                            <asp:Literal runat="server" ID="literalUnpostedLeaves"></asp:Literal></label>
        </div>
        <div class="formCol">
            <label>
                Loan Recover Amount:
                                            <asp:Literal runat="server" ID="literalLoanRecoverAmount"></asp:Literal></label>
        </div>
        <div class="clear"></div>
    </div>

    <div class="formRow">
        <div class="formCol">
            <label>
                Actual worked days:
                                            <asp:Literal runat="server" ID="literalUnpostedLeaves1"></asp:Literal></label>
        </div>
        <div class="formCol">
            <label></label>
        </div>
        <div class="clear"></div>
    </div>


</div>

