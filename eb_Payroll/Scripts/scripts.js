var $ = $telerik.$;
var uploadsInProgress = 0;

function onFileSelected(sender, args) {
    if (!uploadsInProgress)
        $("#SaveButton").attr("disabled", "disabled");

    uploadsInProgress++;

    var row = args.get_row();

    $(row).addClass("file-row");
}

function onFileUploaded(sender, args) {
    decrementUploadsInProgress();
}

function onUploadFailed(sender, args) {
    decrementUploadsInProgress();
}

function decrementUploadsInProgress() {
    uploadsInProgress--;

    if (!uploadsInProgress)
        $("#SaveButton").removeAttr("disabled");
}