<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Diagram.ascx.cs" Inherits="Controls_Diagram" %>

 
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
 <link href="../App_Themes/Default/Styles/main.css" rel="stylesheet" />
<%--<style>
    .k-layer text
{
    fill:white !important;
    font-size: 9px !important;
    text-align: left !important;
}
</style>--%>
<center>
    <asp:label ID="lblTitle" text="Request Workflow Status" runat="server" Font-Size="Large" Font-Italic="True" Font-Names="Arial" ForeColor="Navy" />
</center>
<telerik:RadDiagram ID="RadDiagram1" runat="server" Editable="false" Selectable="false" Pannable="false" >
    <ClientEvents OnLoad="diagram_load" />
    <ShapeDefaultsSettings Width="60" Height="60" Visual="visualizeShape">
        <ContentSettings Align="center" Color="black" />
    </ShapeDefaultsSettings>
    
    <BindingSettings>
        <ShapeSettings DataContentTextField="text" DataIdField="id" DataTypeField="type" DataFillColorField="color" DataRotationAngleField="angle" DataPathField="path" />
        <ConnectionSettings DataFromShapeIdField="sourceShapeId" DataFromConnectorField="sourceConnector"
            DataToShapeIdField="targetShapeId" DataToConnectorField="targetConnector" DataStartCapField="startCapField"
            DataEndCapField="endCapField" />
    </BindingSettings>
</telerik:RadDiagram>
<button runat="server" onclick="exportToPDF()">Export as PDF</button>

<script>
    (function (global, undefined) {
        global.pageLoad = pageLoad;
        global.diagram_load = diagram_load;
        global.visualizeShape = visualizeShape;

        var diagram;

        function diagram_load(sender) {
            diagram = sender.get_kendoWidget();
         
            shapes.forEach(function (item, index) {
            
                var xaxis = diagram.getShapeById(item.id).position().x;
                var yaxis = diagram.getShapeById(item.id).position().y;

                var tb = new kendo.dataviz.diagram.TextBlock({
                    text: item.Level,
                    x: 15,
                    fontSize: 27,
                    color: 'red',
                    fontFamily: 'Lucida Calligraphy'
            });
                var shape = new kendo.dataviz.diagram.Shape({
                    x: xaxis, y: 0, height: 20, wdith: 30, stroke:
                    {
                        width: 0
                    }
                });

                shape.visual.append(tb);
                diagram.addShape(shape);
            });
        }

        /*---------New Edition-------*/

        function pageLoad() {
            //capAllConnections(diagram.connections);
            cleanUpShapesContent(diagram.shapes);
        }

        function visualizeShape(options) {
            var ns = kendo.dataviz.diagram,
                diagramCanvas = getDiagramCanvasOnPage(),
                lineHeight = 10,
                type = options.type,
                shapeGroup = new ns.Group({ autoSize: true }),
                textGroup = new ns.Group(),
                textLines = [];

            if (options.type != "text" && options.content && options.content.text) {
                text = options.content.text.split(";;;");

                var textHeight = options.height - (text.length - 1) * lineHeight;

                for (var i = 0; i < text.length; i++) {
                    var y = (i * lineHeight);

                    textLines.push(new ns.TextBlock({
                        autoSize: false,
                        text: text[i],
                        x: 0,
                        y: y,
                        width: options.width,
                        height: textHeight + 2 * y,
                        color: options.content.color,
                        fontFamily: "Segoe UI",
                        fontSize: options.content.fontSize
                    }));
                }
                options.content.text = "";
            }

            if (type == "rectangle") {
                var rectangle = new ns.Rectangle(options);
                appendToGroupWithoutOffset(rectangle, shapeGroup);
            }
            else if (type == "circle") {
                var circle = new ns.Circle(options);
                appendToGroupWithoutOffset(circle, shapeGroup);
            }
            else {
                options.data = "M70,0 L140,70 L70,140 L0,70 z";
                var path = new ns.Path(options);
                appendToGroupWithoutOffset(path, shapeGroup);
            }

            if (options.type != "text") {
                diagramCanvas.append(shapeGroup);
                var lineHeight_x2 = 2 * lineHeight,
                    box = shapeGroup.drawingElement.bbox(),
                    largestTextContainerHeight = 60 + lineHeight * (textLines.length - 1);

                for (var j = textLines.length - 1, textEdge = largestTextContainerHeight; j >= 0; j--, textEdge -= lineHeight_x2) {
                    var textLine = textLines[j];
                    shapeGroup.append(textLine);
                    var containerRect = new kendo.dataviz.diagram.Rect(0, 0, 60, textEdge);
                    alignTextShape(containerRect, textLine);
                }
                diagramCanvas.remove(shapeGroup);
            }

            return shapeGroup;
        }

        function appendToGroupWithoutOffset(shape, group) {
            shape.position(0, 0);
            group.append(shape);
        }

        function alignTextShape(containerRect, textLine) {
            var aligner = new kendo.dataviz.diagram.RectAlign(containerRect);
            var contentBounds = textLine.drawingElement.bbox(null);

            var contentRect = new kendo.dataviz.diagram.Rect(0, 0, contentBounds.width(), contentBounds.height());
            var alignedBounds = aligner.align(contentRect, "center middle");

            textLine.position(alignedBounds.topLeft());
        }

        function createCustomMarker() {
            return new kendo.dataviz.diagram.ArrowMarker({
                path: "M 0 0 L 8 4 L 0 8 L 2 4 z",
                fill: "#6c6c6c",
                stroke: {
                    color: "#6c6c6c",
                    width: 0.5
                },
                id: "custom",
                orientation: "auto",
                width: 10,
                height: 10,
                anchor: new kendo.dataviz.diagram.Point(7, 4)
            });
        }

        function capAllConnections(connections) {
            Array.forEach(connections, function (connection) {
                var marker = createCustomMarker();
                connection.path._markers.end = marker;
                connection.path.drawingContainer().append(marker.drawingElement);
                connection.path._redrawMarkers(true, connection.path.options);
            });
        }
        function cleanUpShapesContent(shapes) {
            Array.forEach(shapes, function (shape) {
                if (!/Yes|No/.test(shape.content())) {
                    shape.visual.remove(shape._contentVisual);
                }
            });
        }

        function getDiagramCanvasOnPage() {
            return $telerik.$(".k-diagram").getKendoDiagram().canvas;
        }

    })(window);

    function exportToPDF() {
        var diagram = $find("<%=RadDiagram1.ClientID %>").get_kendoWidget();
        diagram.saveAsPDF();
    }

    /*function ImageTemplate(options) {
        var dataviz = kendo.dataviz;
        var group = new dataviz.diagram.Group({ autoSize: true, height:60, width:60 });
        var dataItem = options.dataItem;
        var textLines = [];
        var canvas = $telerik.$("#<= RadDiagram1.ClientID %>").getKendoDiagram().canvas;

        if (options.type == "rectangle") {
            group.append(new dataviz.diagram.Rectangle({
                x: 0,
                y: 0,
                width: options.width,
                height: options.height,
                fill: {
                    color: options.fill.color
                }
            }));
        } else if (options.type == "circle") {
            group.append(new dataviz.diagram.Circle({
                x: 0,
                y: 0,
                width: options.width,
                height: options.height,
                fill: {
                    color: options.fill.color
                }
            }));
        } else {
            group.append(new dataviz.diagram.Path({
                //x: 20,
                x: 0,
                y: 0,
                width: options.width,
                height: options.height,
                fill: {
                    color: options.fill.color
                },
                data: "M70,0 L140,70 L70,140 L0,70 z"
            }));

            //group.append(new dataviz.diagram.TextBlock({
            //    text: options.content.text,
            //    x: 0,
            //    y: 0,
            //    fontSize: 11,
            //    width: 20,
            //    height: 50
            //}));

            //group.append(new dataviz.diagram.TextBlock({
            //    text: " No ",
            //    x: 85,
            //    y: 0,
            //    fontSize: 11
            //}));
        }
       
        if (options.type != "text" && options.content && options.content.text) {
            text = options.content.text.split(" ");
            //var textHeight = options.height - (text.length - 1) * 16;
            for (var i = 0; i < text.length; i++) {
                var y = (i * 16);
                textLines.push(new dataviz.diagram.TextBlock({
                    text: text[i],
                    x: 0,
                    y: y,
                    //width: options.width,
                    //height: textHeight + 2 * y,
                    color: options.stroke.color//,
                    //fontFamily: "Segoe UI"
                }));

            }
            options.content.text = "";
        }
        for (var j = 0; j < textLines.length; j++) {
            var textLine = textLines[j];
            group.append(textLine);
            canvas.append(group);
            //textLine.align(options.content.align);
            canvas.remove(group);
        }

        return group;
    };*/
</script>
