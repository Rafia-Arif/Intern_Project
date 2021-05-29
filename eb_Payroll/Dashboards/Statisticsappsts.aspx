<%@ Page Title="Statistics Chart" MetaDescription="Miscellenous Charts for the Requisitions" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master"
    AutoEventWireup="true" CodeFile="Statisticsappsts.aspx.cs" Inherits="Statisticsappsts" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>



 <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">

      
     


        <div class="widgets">
        <div class="oneTwo">
               <div class="widget">
                <div class="title">
                    <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>No. of Applicants with Status</h6>
                    <div class="num">
                        <a class="blueNum">
                            <asp:Literal ID="ltassignmentNotiCount" runat="server"></asp:Literal></a>
                    </div>
                </div>

                    
                   <table cellpadding="0" cellspacing="0" width="100%" class="display dTable mainTable">
                    
                      <%-- <telerik:RadHtmlChart runat="server" ID="PieChart1" Transitions="true">
    <PlotArea>
        <Series>
            <telerik:PieSeries StartAngle="90">
                <LabelsAppearance Position="Circle" />
                <TooltipsAppearance  />
                <SeriesItems>
                    <telerik:PieSeriesItem BackgroundColor="Purple" Exploded="false" Name="Scheduled Interviews"  />
                    <telerik:PieSeriesItem BackgroundColor="Red" Exploded="false" Name="Completed Interviews" />
                    <telerik:PieSeriesItem BackgroundColor="Green" Exploded="false" Name="Marked As Final" />    
                    <telerik:PieSeriesItem BackgroundColor="Blue" Exploded="false" Name="Pre-hiring"  />
                    <telerik:PieSeriesItem BackgroundColor="Orange" Exploded="false" Name="Offer Letter Issued"  />
      
                </SeriesItems>
            </telerik:PieSeries>
        </Series>
    </PlotArea>
    <ChartTitle Text="Applicants stage">
    </ChartTitle>
</telerik:RadHtmlChart>--%>
                       
                       </table>

     
        
         </div>
            </div>

           <div class="oneTwo">
               <div class="widget">
                <div class="title">
                    <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>No. of Applicants by Position</h6>
                    <div class="num">
                        <a class="blueNum">
                            <asp:Literal ID="Literal1" runat="server"></asp:Literal></a>
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
                           
                              <XAxis DataLabelsField="appidd">
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
         
 
   
  <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
           SelectCommand="sts_app_count_by_req" SelectCommandType="StoredProcedure">
           
     </asp:SqlDataSource>

     
</asp:Content>