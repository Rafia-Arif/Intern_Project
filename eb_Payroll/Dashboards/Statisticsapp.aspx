<%@ Page Title="Statistics Chart" MetaDescription="Miscellenous Charts for the Applicants" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master"
    AutoEventWireup="true" CodeFile="Statisticsapp.aspx.cs" Inherits="Statisticsapp" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>



 <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">

      
     


        <div class="widgets">
        <div class="oneTwo">
               <div class="widget">
                <div class="title">
                    <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>No. of Applicants by Position</h6>
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
                                   <telerik:ColumnSeries Name="countofapp" DataFieldY="countofapp">
                                        <TooltipsAppearance Color="White" ></TooltipsAppearance>
                                        <LabelsAppearance Visible="false">
                                        </LabelsAppearance>
                                   </telerik:ColumnSeries>
                              </Series>
                           
                              <XAxis DataLabelsField="Position">
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
                    <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>No. of Applicants by Nationality</h6>
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
                                   <telerik:ColumnSeries Name="countofapp" DataFieldY="countofapp">
                                        <TooltipsAppearance Color="White" ></TooltipsAppearance>
                                        <LabelsAppearance Visible="false">
                                        </LabelsAppearance>
                                   </telerik:ColumnSeries>
                              </Series>
                           
                              <XAxis DataLabelsField="Nationality">
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
         
     <div class="widgets">
        <div class="oneTwo">
               <div class="widget">
                <div class="title">
                    <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>No. of Applicants by Gender</h6>
                    <div class="num">
                        <a class="blueNum">
                            <asp:Literal ID="Literal2" runat="server"></asp:Literal></a>
                    </div>
                </div>

                    
                   <table cellpadding="0" cellspacing="0" width="100%" class="display dTable mainTable">
             
                    <telerik:RadHtmlChart runat="server" ID="RadHtmlChart3" DataSourceID="SqlDataSource3"
                         Style="float: left;" Skin="Office2010Blue" >
                         <PlotArea>
                              <Series>
                                   <telerik:ColumnSeries Name="countofapp" DataFieldY="countofapp">
                                        <TooltipsAppearance Color="White" ></TooltipsAppearance>
                                        <LabelsAppearance Visible="false">
                                        </LabelsAppearance>
                                   </telerik:ColumnSeries>
                              </Series>
                           
                              <XAxis DataLabelsField="Gender">
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
                    <img src="../images/icons/dark/timer.png" alt="" class="titleIcon" /><h6>No. of Applicants by Job Type</h6>
                    <div class="num">
                        <a class="blueNum">
                            <asp:Literal ID="Literal3" runat="server"></asp:Literal></a>
                    </div>
                </div>

                   <table cellpadding="0" cellspacing="0" width="100%" class="display dTable mainTable">
                      <telerik:RadHtmlChart runat="server" ID="RadHtmlChart4"  DataSourceID="SqlDataSource4"
                         Style="float: left;"  Skin="Sunset" >
                         <PlotArea>
                              <Series>
                                   <telerik:ColumnSeries Name="countofapp" DataFieldY="countofapp">
                                        <TooltipsAppearance Color="White" ></TooltipsAppearance>
                                        <LabelsAppearance Visible="false">
                                        </LabelsAppearance>
                                   </telerik:ColumnSeries>
                              </Series>
                           
                              <XAxis DataLabelsField="JobType">
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
           SelectCommand="Sts_applicants_by_pos" SelectCommandType="StoredProcedure">
           
     </asp:SqlDataSource>


     <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
           SelectCommand="Sts_applicants_by_nat" SelectCommandType="StoredProcedure">
          
         
     </asp:SqlDataSource>
 

          <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
           SelectCommand="Sts_applicants_by_gnd" SelectCommandType="StoredProcedure">
           
     </asp:SqlDataSource>


     <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>"
           SelectCommand="Sts_applicants_by_jbt" SelectCommandType="StoredProcedure">
          
         
     </asp:SqlDataSource>
</asp:Content>