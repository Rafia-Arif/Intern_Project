(function () {
    var demo = window.demo = window.demo || {};
    var ListBoxID;
    var TreeViewID;

    //indicates whether the user is currently dragging a listbox item
    var listBoxDragInProgress = false;

    //indicates whether the user is currently dragging a tree node
    var treeViewDragInProgress = false;

    demo.initialize = function () {
        ListBoxID = demo.ListBoxID;
        TreeViewID = demo.TreeViewID;
    };

    //chech if a given html element is a child of an element with the specified id
    function isOverElement(target, id) {
        while (target) {
            if (target.id == id)
                break;

            target = target.parentNode;
        }
        return target;
    }

    function checkDropTargets(target) {
        if (isOverElement(target, ListBoxID) || isOverElement(target, TreeViewID)) {
            //if the mouse is over the treeview or listbox - set the cursor to default
            document.body.style.cursor = "";
        } else {
            //else set the cursor to "no-drop" to indicate that dropping over this html element is not supported
            document.body.style.cursor = "no-drop";
        }
    }

    //select the hovered listbox item if the user is dragging a node
    window.onListBoxMouseOver = function (sender, args) {
        if (treeViewDragInProgress) {
            args.get_item().set_selected(true);
        }
    }

    //select the hovered tree node if the user is dragging a listbox item
    window.onTreeViewMouseOver = function (sender, args) {
        
    }

    //unselect the item if the user is dragging a node
    window.onListBoxMouseOut = function (sender, args) {
        if (treeViewDragInProgress) {
            args.get_item().set_selected(false);
        }
    }

    //unselect the node if the user is dragging a listbox item
    window.onTreeViewMouseOut = function (sender, args) {
        if (listBoxDragInProgress) {
            args.get_node().set_selected(false);
        }
    }

    //indicate that the user started dragging a listbox item
    window.onListBoxDragStart = function (sender, args) {
        listBoxDragInProgress = true;
    }

    //indicate that the user started dragging a tree node
    window.onTreeViewDragStart = function (sender, args) {
        treeViewDragInProgress = true;
    }

    //handle the drop of the listbox item
    window.onListBoxDropping = function (sender, args) {
        //indicate that the user stopped dragging
        listBoxDragInProgress = false;
        document.body.style.cursor = "";
        //restore the cursor to the default state
        document.body.style.cursor = "";

        //get the html element on which the item is dropped
        var target = args.get_htmlElement();

        //if dropped on the listbox itself return.
        //if (isOverElement(target, ListBoxID)) {
        //    return;

        //check if dropped on the treeview
        target = isOverElement(target, TreeViewID);

        //if not cancel the dropping event so it does not postback
        if (!target) {
            args.set_cancel(true);
            return;
        }

        //the item was dropped on the treeview - set the htmlElement. 
        //it can be later accessed via the HtmlElementID property of the RadListBox
        args.set_htmlElement(target);
    }

    //handle the drop of the tree node
    window.onTreeViewDropping = function (sender, args) {
        //indicate that the user stopped dragging
        treeViewDragInProgress = false;

        //restore the cursor to the default state
        document.body.style.cursor = "";

        //get the html element on which the node is dropped
        var target = args.get_htmlElement();

        //if dropped on the treeview itself return.
        if (isOverElement(target, ListBoxID)) {
            return;
        }
        //check if dropped on the listbox
        target = isOverElement(target,TreeViewID );

        //if not cancel the dropping event so it does not postback
        if (!target) {
            args.set_cancel(true);
            return;
        }

        //the node was dropped on the listbox - set the htmlElement. 
        //it can be later accessed via the HtmlElementID property of the RadTreeNodeDragDropEventArgs
        args.set_htmlElement(target);
    }

    //update the cursor if the user is dragging the item over supported drop target - listbox or treeview
    window.onListBoxDragging = function (sender, args) {
        checkDropTargets(args.get_htmlElement());
    }

    //update the cursor if the user is dragging the node over supported drop target - listbox or treeview
    window.onTreeViewDragging = function (sender, args) {
        checkDropTargets(args.get_htmlElement());
    }
}());