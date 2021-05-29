<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucEmployeeLeaveBalance.ascx.cs" Inherits="Controls_ucEmployeeLeaveBalance" %>

<style>
    #ctl00_ctl00_MainContent_mainContentPlaceHolder_ctl00_ctl00_MainContent_mainContentPlaceHolder_ucEmployeeLeaveBalancePanel {
   display:inline-flex !important;
   width:100% !important;
         }
    @media only screen and (min-width: 0px) and (max-width:812px ) {
        .crv{
            display: contents;
        }
        .crvdiv {
       margin-left:40px;
       padding:0 0 0 5px;  
       width:90px;
        }  
    }

</style>

<div class = "widget13" style="width:50%; float:left">
     <div
        class = "title">
        <img
            alt = ""
            class = "titleIcon"
            src = "../../images/icons/dark/list.png"/>
         <div class="crvdiv">
        <h6B class="crv">Current Request Details</h6B>
             </div>
    </div>
    <div
        class = "formRow">
        <div
            class = "formCol40">
            <label>
                Type:
                <asp:Literal
                    ID = "literalLeaveType"
                    runat = "server">
                </asp:Literal>
            </label>
        </div>
         <div
            class = "formCol60">
            <label>
                Code:
                              <asp:Literal
                    ID = "literalLeaveCode"
                    runat = "server">
                </asp:Literal>
                 
            </label>
        </div> 
        <div
            class = "clear">
        </div>
    </div>
    <div
        class = "formRow">
        <div
            class = "formCol40">
            <label>
                Calandar Days:
                <asp:Literal
                    ID = "literalCalandarDays"
                    runat = "server">
                </asp:Literal>
            </label>
        </div>
         <div
            class = "formCol60">
            <label>
                Public Holidays:
                <asp:Literal
                    ID = "literalPublicHolidays"
                    runat = "server">
                </asp:Literal>
            </label>
        </div> 
        <div
            class = "clear">
        </div>
    </div>

    <div
        class = "formRow">
        <div
            class = "formCol40">
            <label>
                Weekends:
                <asp:Literal
                    ID = "literalWeekends"
                    runat = "server">
                </asp:Literal>
            </label>
        </div>
        <div
            class = "formCol60">
            <label>
                Excess Days:
                <asp:Literal
                    ID = "literalExcessDays"
                    runat = "server">
                </asp:Literal>
            </label>
        </div>
        <div
            class = "clear">
        </div>
    </div>

     
    <div
        class = "formRow">
        <div
            class = "formCol40">
            <label>
                Actual Leave Days:
                <asp:Literal
                    ID = "literalActualLeaveDays"
                    runat = "server">
                </asp:Literal>
            </label>
        </div>
        <div
            class = "formCol60">
            <label></label>
        </div>
        <div
            class = "clear">
        </div>
    </div>
</div>
<div
    class = "widget" style="width:50%;float:left">

    <div
        class = "title">
        <img
            alt = ""
            class = "titleIcon"
            src = "../../images/icons/dark/list.png"/>
        <div class="crvdiv">
        <h6B class="crv">Periodic Absence Card</h6B>
            </div>
    </div>

    <div
        class = "formRow">
        <div
            class = "formCol40">
            <label>
                Brought Forward:
                <asp:Literal
                    ID = "literalBroughtForward"
                    runat = "server">
                </asp:Literal>
            </label>
        </div>


        <div
            class = "formCol60">
            <label>
                Leave Taken Calendar YTD:
                <asp:Literal
                    ID = "literalLeaveTakenYTD"
                    runat = "server">
                </asp:Literal>
            </label>
        </div>
        <div
            class = "clear">
        </div>
    </div>

    <div
        class = "formRow">
         <div
            class = "formCol40">
            <label>
                Adjusted Days:
                <asp:Literal
                    ID = "literalAdjustedDays"
                    runat = "server">
                </asp:Literal>
            </label>
        </div>
         <div
            class = "formCol60">
            <label>
                Available Balance:
                <asp:Literal
                    ID = "literalAvailableBalance"
                    runat = "server">
                </asp:Literal>
            </label>
        </div>
        <div
            class = "clear">
        </div>
    </div>

    <div
        class = "formRow">
        <div
            class = "formCol40">
            <label>
                Saved Leaves:
                <asp:Literal
                    ID = "literalUnpostedLeaves"
                    runat = "server">
                </asp:Literal>
            </label>
        </div>
        <div
            class = "formCol60">
            <label>
                UnApproved Leaves:
                <asp:Literal
                    ID = "literalUnapprovedLeaves"
                    runat = "server">
                </asp:Literal>
            </label>
        </div>

        <div
            class = "clear">
        </div>
    </div>

</div>


    