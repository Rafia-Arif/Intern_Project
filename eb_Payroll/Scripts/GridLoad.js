
function getRequestData(value) {
    return JSON.stringify({
        "ContentText": value

    });
}

function executeMethod(location, methodName, methodArguments, onSuccess, onFail) {
    $.ajax({
        type: "POST",
        url: location + "/" + methodName,
        data: methodArguments,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: onSuccess,
        fail: onFail
    });
}


executeMethod(window.location.pathname.substring(window.location.pathname.lastIndexOf("/") + 1, window.location.pathname.length),
             "GetRequestedProductsCount",
             null,
            function (result) {

                result = result.d;
                $('.requests > h2 a count').html(result.pending);

                $('#s1d1 h4').html(result.today);
                $('#s1d2 h4').html(result.total);
                $('#s1d3 h4').html(result.pending);

                $('.requests > h2 a').click(function () {
                    $('#s1').slideToggle(150);
                });
                $(document).bind('click', function (e) {
                    var $clicked = $(e.target);
                    if (!$clicked.parents().hasClass("requests"))
                        $("#s1").slideUp(150);
                });

            },
        function (result) { alert(result.get_message()); }
   );

executeMethod(window.location.pathname.substring(window.location.pathname.lastIndexOf("/") + 1, window.location.pathname.length),
        "GetTransitProductsCount",
        null,
        function (result) {
            result = result.d;
            $('.transit > h2 a count').html(result.pending);

            $('#s2d1 h4').html(result.total);
            $('#s2d2 h4').html(result.received);
            $('#s2d3 h4').html(result.pending);

            $('.transit > h2 a').click(function () {
                $('#s2').slideToggle(150);
            });
            $(document).bind('click', function (e) {
                var $clicked = $(e.target);
                if (!$clicked.parents().hasClass("transit"))
                    $("#s2").slideUp(150);
            });

        },
        function (result) { alert(result.get_message()); }
   );


        executeMethod(window.location.pathname.substring(window.location.pathname.lastIndexOf("/") + 1, window.location.pathname.length),
        "GetInhandProductsCount",
        null,
        function (result) {
            result = result.d;
            $('.inhand > h2 a count').html(result.inhand);

            $('#s3d1 h4').html(result.received);
            $('#s3d2 h4').html(result.sold);
            $('#s3d3 h4').html(result.inhand);

            $('.inhand > h2 a').click(function () {
                $('#s3').slideToggle(150);
            });
            $(document).bind('click', function (e) {
                var $clicked = $(e.target);
                if (!$clicked.parents().hasClass("inhand"))
                    $("#s3").slideUp(150);
            });

        },
        function (result) { alert(result.get_message()); }
   );

//===== Sparklines =====//
$('.posBar').sparkline('html', { type: 'bar', barColor: '#6daa24' });
$('.negBar').sparkline('html', { type: 'bar', barColor: '#db6464' });
$('.zeroBar').sparkline('html', { type: 'bar', barColor: '#4e8fc6' }); 