(function (global, undefined) {
    var telerikDemo = global.telerikDemo = {
        //Hide a tooltip if it is visible when an RadAjaxPanel request starts 
        closeActiveToolTip: function () {
            var tooltip = Telerik.Web.UI.RadToolTip.getCurrent();
            if (tooltip) tooltip.hide();
        },

        onClientMouseOver: function (sender, args) {
            args.get_node().set_selected(true);

            var nodeElem = args.get_node();
            if (nodeElem.get_level() > 0) {
                var node = nodeElem.get_textElement();

                var tooltipManager = $find(telerikDemo.tooltipManagerID);

                //If the user hovers the image before the page has loaded, there is no manager created
                if (!tooltipManager) return;

                //Find the tooltip for this element if it has been created 
                var tooltip = tooltipManager.getToolTipByElement(node);

                //Create a tooltip if no tooltip exists for such element
                if (!tooltip) {
                    tooltip = tooltipManager.createToolTip(node);
                    tooltip.set_value(nodeElem.get_value() + '-' + sender._element.id);
                    setTimeout(function () {
                        tooltip.show();
                    }, 10);
                }
            }
        },
        onEmployeeClientMouseOver: function (sender, args) {
            args.get_node().set_selected(true);

            var nodeElem = args.get_node();
            if (nodeElem.get_level() > 2) {
                var node = nodeElem.get_textElement();

                var tooltipManager = $find(telerikDemo.tooltipManagerID);

                //If the user hovers the image before the page has loaded, there is no manager created
                if (!tooltipManager) return;

                //Find the tooltip for this element if it has been created 
                var tooltip = tooltipManager.getToolTipByElement(node);

                //Create a tooltip if no tooltip exists for such element
                if (!tooltip) {
                    tooltip = tooltipManager.createToolTip(node);
                    tooltip.set_value(nodeElem.get_value() + '-' + sender._element.id);
                    setTimeout(function () {
                        tooltip.show();
                    }, 10);
                }
            }
        }
    }


    function serverID(name, id) {
        telerikDemo[name] = id;
    }

    global.serverID = serverID;
})(window);