using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI.Diagram;
using System.Collections;
public partial class Controls_Diagram : System.Web.UI.UserControl
{
    private int transactionEntryID;

    public int TransactionEntryID
    {
        get { return this.transactionEntryID; }
        set { this.transactionEntryID = value; }
    }
       public enum RequestStatus
        {
            Initiated = 1,
            Pending = 3,
            Approved = 5,
            Rejected = 6,
            Completed = 8,
            Revised = 9,
            Recalled = 10,
            RejectedCompleted = 14,
            ApprovedCompleted = 15
        }

        public struct PrlreitrxStatus
        {
            public string ID;
            public string RequestStatusId;
            public string MappingType;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void Render(string tableName, string fieldName, int value, int width, int height, string Title)
        {
            lblTitle.Text = Title;

            RadDiagram1.Width = width;
            RadDiagram1.Height = height;

            RadDiagram1.ConnectionsCollection.Clear();
            RadDiagram1.ShapesCollection.Clear();
            RadDiagram1.LayoutSettings.Enabled = true;
            RadDiagram1.LayoutSettings.Type = LayoutType.Layered;
            RadDiagram1.LayoutSettings.Subtype = LayoutSubtype.Right;
            RadDiagram1.ShapeDefaultsSettings.ContentSettings.FontSize = 9;


            int tempLevel = 0;

            List<object> group = new List<object>();
            List<object> shapes = new List<object>();
            List<object> connections = new List<object>();
            List<PrlreitrxStatus> status = new List<PrlreitrxStatus>();
            List<PrlreitrxStatus> currentInCol = new List<PrlreitrxStatus>();

            DataTable dt = GetData(tableName, fieldName, value);
            DataView view = new DataView(dt);
            DataTable distinctValues = view.ToTable(true, "RequestStatusID", "UserLevel", "levelversion");

            int MaxId = int.Parse(dt.Rows[dt.Rows.Count - 1]["ID"].ToString());
            int MaxSeq = int.Parse(dt.Rows[dt.Rows.Count - 1]["seq"].ToString());
            for (int level = 1; level <= MaxSeq; level++)
            {
                DataRow[] dr = dt.Select("seq = " + level);

                List<PrlreitrxStatus> tempStatus = new List<PrlreitrxStatus>();
                bool proccess = false, missingApprovingLine = false;

                foreach (var item in dr)
                {
                    if (item["RequestStatusID"].ToString() == ((int)RequestStatus.Pending).ToString())
                    {
                        string MappingType = item["MappingType"].ToString();
                        string MainApproverUserID = item["MainApproverUserID"].ToString();
                        string ApprovedByUserID = item["ApprovedByUserID"].ToString();
                        string Approvingline = item["approvingline"].ToString();
                        string ID = item["ID"].ToString();
                        string LevelVersion = item["levelversion"].ToString();

                        if (tempLevel != level)
                        {
                            group.Add(new { id = "Shape" + ID, Level = LevelVersion });
                            tempLevel = level;
                        }

                        shapes.Add(GetShapeByRequestId(item["RequestStatusID"].ToString(), MainApproverUserID, ID, MappingType));

                        foreach (var state in status)
                        {
                            dynamic objtemp = GetConnectionsByRequestId("Shape" + state.ID, "Shape" + ID);
                            connections.Add(objtemp);
                        }

                        DataTable subDt = dr.CopyToDataTable();
                        DataRow[] subDr = subDt.Select("approvingline = " + ID);
                        if (subDr.Length > 0)
                        {
                            proccess = true;
                            if (subDr[0]["RequestStatusID"].ToString() == ((int)RequestStatus.Approved).ToString() || (subDr[0]["RequestStatusID"].ToString() == ((int)RequestStatus.Revised).ToString()))
                            {
                                shapes.Add(GetShapeByRequestId(subDr[0]["RequestStatusID"].ToString(), ApprovedByUserID, subDr[0]["ID"].ToString(), MappingType));
                            }
                            else
                            {
                                shapes.Add(GetShapeByRequestId(subDr[0]["RequestStatusID"].ToString(), ApprovedByUserID, subDr[0]["ID"].ToString(), MappingType));
                            }
                            connections.Add(GetConnectionsByRequestId("Shape" + ID, "Shape" + subDr[0]["ID"].ToString()));

                            PrlreitrxStatus state;
                            state.ID = subDr[0]["ID"].ToString();
                            state.RequestStatusId = subDr[0]["RequestStatusID"].ToString();
                            state.MappingType = subDr[0]["MappingType"].ToString();
                            tempStatus.Add(state);

                            currentInCol.Add(state);
                        }
                        else
                        {
                            missingApprovingLine = true;
                            //add main box in list if approving line is missing
                            PrlreitrxStatus state;
                            state.ID = ID;
                            state.RequestStatusId = item["RequestStatusID"].ToString();
                            state.MappingType = MappingType;
                            currentInCol.Add(state);
                        }
                    }
                    else if (item["RequestStatusID"].ToString() == ((int)RequestStatus.Recalled).ToString())
                    {
                        shapes.Add(GetShapeByRequestId(item["RequestStatusID"].ToString(), "", item["ID"].ToString() + "previous", ""));

                        foreach (var obj in currentInCol)
                        {
                            dynamic objtemp = GetConnectionsByRequestId("Shape" + obj.ID, "Shape" + item["ID"].ToString() + "previous");
                            connections.Add(objtemp);
                        }

                        shapes.Add(GetShapeByRequestId(11, "", item["ID"].ToString(), ""));
                        connections.Add(GetConnectionsByRequestId("Shape" + item["ID"].ToString() + "previous", "Shape" + item["ID"].ToString()));

                        PrlreitrxStatus state;
                        state.ID = item["ID"].ToString();
                        state.RequestStatusId = item["MainApproverUserID"].ToString();
                        state.MappingType = item["MappingType"].ToString();
                        tempStatus.Add(state);

                        currentInCol = new List<PrlreitrxStatus>();
                    }
                    else if (item["RequestStatusID"].ToString() == ((int)RequestStatus.Rejected).ToString())
                    {
                        currentInCol = new List<PrlreitrxStatus>();
                    }
                    else if ((item["RequestStatusID"].ToString() != ((int)RequestStatus.Approved).ToString()) && (item["RequestStatusID"].ToString() != ((int)RequestStatus.Revised).ToString()))
                    {
                        shapes.Add(GetShapeByRequestId(item["RequestStatusID"].ToString(), "", item["ID"].ToString(), ""));

                        if (status.Count > 0)
                        {
                            foreach (var state in status)
                            {
                                dynamic objtemp = GetConnectionsByRequestId("Shape" + state.ID, "Shape" + item["ID"].ToString());
                                connections.Add(objtemp);
                            }
                        }
                        else
                        {
                            PrlreitrxStatus state;
                            state.ID = item["ID"].ToString();
                            state.RequestStatusId = item["MainApproverUserID"].ToString();
                            state.MappingType = item["MappingType"].ToString();
                            tempStatus.Add(state);
                        }
                        currentInCol = new List<PrlreitrxStatus>();
                    }
                }
                if (missingApprovingLine)
                {
                    //break;
                }
                status = tempStatus;
                if (proccess)
                {
                    DataView pendingRequestDt = dt.Select("seq = " + level + "And RequestStatusID =" + 3).CopyToDataTable().AsDataView();
                    DataView approvedRequestDt = dt.Select("seq = " + level + "And RequestStatusID in (5, 6, 9)").CopyToDataTable().AsDataView();

                    int pendingRequest = pendingRequestDt.ToTable(true, "MappingType", "groupidd").Rows.Count;
                    int approvedRequest = approvedRequestDt.ToTable(true, "MappingType", "groupidd").Rows.Count;

                    if (approvedRequest != pendingRequest)
                    {
                        int rejectedRequest = dt.Select("seq = " + level + "And RequestStatusID = 6").Length;
                        if (rejectedRequest > 0)
                        {
                            shapes.Add(GetShapeByRequestId(15, "", MaxId.ToString() + "Requestor", ""));
                            connections.Add(GetConnectionsByRequestId("Shape" + tempStatus[0].ID, "Shape" + MaxId.ToString() + "Requestor"));
                        }
                        int revisedRequest = dt.Select("seq = " + level + "And RequestStatusID = 9").Length;
                        if (revisedRequest > 0)
                        {
                            shapes.Add(GetShapeByRequestId(11, "", MaxId.ToString() + "Requestor", ""));
                            connections.Add(GetConnectionsByRequestId("Shape" + tempStatus[0].ID, "Shape" + MaxId.ToString() + "Requestor"));
                        }
                        break;
                    }
                    MaxId++;
                    bool Reject = false;
                    foreach (var item in tempStatus)
                    {
                        connections.Add(GetConnectionsByRequestId("Shape" + item.ID, "Shape" + MaxId.ToString()));
                        if (item.RequestStatusId == ((int)RequestStatus.Rejected).ToString())
                        {
                            Reject = true;
                        }
                    }
                    if (Reject)
                    {
                        shapes.Add(GetShapeByRequestId(25, "", MaxId.ToString(), ""));
                    }
                    else
                    {
                        shapes.Add(GetShapeByRequestId(24, "", MaxId.ToString(), ""));
                    }
                    status.Clear();

                    PrlreitrxStatus state;
                    state.ID = MaxId.ToString();
                    state.RequestStatusId = "";
                    state.MappingType = "";
                    status.Add(state);

                    proccess = false;
                }
            }

            RadDiagram1.ConnectionDataSource = connections;
            RadDiagram1.DataSource = shapes;
            RadDiagram1.DataBind();

            var json = JsonConvert.SerializeObject(group);
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "group", "var shapes = " + json, true);
        }

        private DataTable GetData(string tableName, string fieldName, int value)
        {
            string connStr = ConfigurationManager.ConnectionStrings["eb_payroll"].ToString();
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT * FROM eb_prlreitrx_Status WHERE ReimbursmentID = " + value.ToString() + " ORDER BY seq, ID", conn))
                {
                    da.Fill(dt);
                }
            }
            return dt;
        }

        private object GetShapeByRequestId(string RequestStatusID, string text, string ID, string type)
        {
            return GetShapeByRequestId(int.Parse(RequestStatusID), text, ID, type);
        }

        private object GetShapeByRequestId(int RequestStatusID, string value, string ID, string type)
        {
            //value = "azadar - " + value; // for testing
            value = value.Replace(" ", ";"); //as per your requirement limit the char limits
            switch (RequestStatusID)
            {
                case 1:
                    return new { id = "Shape" + ID, text = value, type = "circle", color = "Khaki", angle = "0", path = "" };
                    break;
                case 3:
                    if (type == "Group")
                    {
                        return new { id = "Shape" + ID, text = value, type = "rectangle", color = "orange", angle = "0", path = "" };
                    }
                    else
                    {
                        return new { id = "Shape" + ID, text = value, type = "rectangle", color = "Plum", angle = "0", path = "" };
                    }
                    break;
                case 5:
                    return new { id = "Shape" + ID, text = value, type = "diamond", color = "lightgreen", angle = "0", path = "M70,0 L140,70 L70,140 L0,70 z" };
                    break;
                case 9:
                    return new { id = "Shape" + ID, text = value, type = "diamond", color = "green", angle = "0", path = "M70,0 L140,70 L70,140 L0,70 z" };
                    break;
                case 6:
                    return new { id = "Shape" + ID, text = value, type = "diamond", color = "pink", angle = "0", path = "M70,0 L140,70 L70,140 L0,70 z" };
                    break;
                case 10:
                    return new { id = "Shape" + ID, text = "Requestor;Recalled", type = "diamond", color = "pink", angle = "0", path = "M70,0 L140,70 L70,140 L0,70 z" };
                    break;
                case 11: //<=requestor
                    return new { id = "Shape" + ID, text = "Requestor", type = "rectangle", color = "lightblue", angle = "0", path = "" };
                    break;
                case 8:
                case 15:
                    return new { id = "Shape" + ID, text = value, type = "circle", color = "red", angle = "0", path = "" };
                    break;
                case 14:
                    return new { id = "Shape" + ID, text = value, type = "circle", color = "darkgreen", angle = "0", path = "" };
                    break;
                case 24:
                    return new { id = "Shape" + ID, text = value, type = "diamond", color = "green", angle = "0", path = "M70,0 L140,70 L70,140 L0,70 z" };
                    break;
                case 25:
                    return new { id = "Shape" + ID, text = value, type = "diamond", color = "red", angle = "0", path = "M70,0 L140,70 L70,140 L0,70 z" };
                    break;
                default:
                    return new { id = "Shape" + ID, text = value, type = "circle", color = "red", angle = "0", path = "" };
            }
        }

        private object GetConnectionsByRequestId(string sourceShapeIdstr, string targetShapeIdstr)
        {
            return new { sourceShapeId = sourceShapeIdstr, sourceConnector = "right", targetShapeId = targetShapeIdstr, targetConnector = "left", startCapField = ConnectionStartCap.FilledCircle, endCapField = ConnectionEndCap.ArrowEnd };
        }
    
}