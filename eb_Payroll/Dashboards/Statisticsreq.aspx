<%@ Page Title="Statistics Chart" MetaDescription="Miscellenous Charts for the Requisitions" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master"
    AutoEventWireup="true" CodeFile="Statisticsreq.aspx.cs" Inherits="Statisticsreq" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>



 <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">

      
     


        <div class="widgets">
        <div class="oneTwo">
               <div class="widget">
                <div class="title">
                    <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>No. of Requests by Department</h6>
                    <div class="num">
                        <a class="blueNum">
                            <asp:Literal ID="ltassignmentNotiCount" runat="server"></asp:Literal></a>
                    </div>
                </div>

                    
                   <table cellpadding="0" cellspacing="0" width="100%" class="display dTable mainTable">
             
                    <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1" Width="575px" DataSourceID="SqlDataSource1"
                         Style="float: left;">
                         <PlotArea>
                              <Series>
                                   <telerik:ColumnSeries Name="countofreq" DataFieldY="countofreq">
                                        <TooltipsAppearance Color="White" ></TooltipsAppearance>
                                        <LabelsAppearance Visible="false">
                                        </LabelsAppearance>
                                   </telerik:ColumnSeries>
                              </Series>
                           
                              <XAxis DataLabelsField="Department">
                                   <MinorGridLines Visible="false"></MinorGridLines>
                                   <MajorGridLines Visible="false"></MajorGridLines>
                              </XAxis>
                              <YAxis>
                                   <LabelsAppearance >
                                   </LabelsAppearance>
                                   <MinorGridLines Visible="false"></MinorGridLines>
                              </YAxis>
                         </PlotArea>
                         <Legend>
                              <Appearance Visible="false">
                              </Appearance>
                         </Legend>
                         
                    </telerik:RadHtmlChart>
                       </table>

     
        
         </div>
            </div>

              <div class="oneTwo">
               <div class="widget">
                <div class="title">
                    <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>No. of Requests by Employee</h6>
                    <div class="num">
                        <a class="blueNum">
                            <asp:Literal ID="Literal1" runat="server"></asp:Literal></a>
                    </div>
                </div>

                   <table cellpadding="0" cellspacing="0" width="100%" class="display dTable mainTable">
                      <telerik:RadHtmlChart runat="server" ID="RadHtmlChart2" Width="575px" DataSourceID="SqlDataSource2"
                         Style="float: left;"  Skin="WebBlue">
                         <PlotArea>
                              <Series>
                                   <telerik:ColumnSeries Name="countofreq" DataFieldY="countofreq">
                                        <TooltipsAppearance Color="White" ></TooltipsAppearance>
                                        <LabelsAppearance Visible="false">
                                        </LabelsAppearance>
                                   </telerik:ColumnSeries>
                              </Series>
                           
                              <XAxis DataLabelsField="User_Requested">
                                   <MinorGridLines Visible="false"></MinorGridLines>
                                   <MajorGridLines Visible="false"></MajorGridLines>
                              </XAxis>
                              <YAxis>
                                   <LabelsAppearance >
                                   </LabelsAppearance>
                                   <MinorGridLines Visible="false"></MinorGridLines>
                              </YAxis>
                         </PlotArea>
                         <Legend>
                              <Appearance Visible="false">
                              </Appearance>
                         </Legend>
                         
                    </telerik:RadHtmlChart>
                       </table>
               </div>
              </div>
     

             <div class="clear"></div>
            </div>
         
 
   
               
     <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
           SelectCommand="Sts_requisition_by_emp" SelectCommandType="StoredProcedure">
          
         
     </asp:SqlDataSource>
  <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
           SelectCommand="Sts_requisition_by_dpt" SelectCommandType="StoredProcedure">
           
     </asp:SqlDataSource>

     
</asp:Content>