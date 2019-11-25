<%--
  Created by IntelliJ IDEA.
  User: snehalpatil
  Date: 2019-11-21
  Time: 16:16
--%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'displayData.label', default: 'DisplayData')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
    <asset:javascript src="jquery-3.3.1.js"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
    <g:javascript library='jquery'>
        $(document).ready(function() {

            $("#jstree_demo_div").bind("loaded.jstree", function(event, data) {
                data.instance.open_all();
            });
            $("#jstree_demo_div").jstree().bind("select_node.jstree", function (e, data) {
                var href = data.node.a_attr.href;
                document.location.href = href;
                console.log(href);
            });
            $("#jstree_demo_div").jstree();
        })

        $("#jstree_demo_div").on("click", "li > a", function() {
            var id = $(this).closest("li").attr("id");
            $(this).siblings(".jstree-icon").click();
            alert(id);
        });

        $('.majorpoints').click(function(){
            $(this).find('.hiders').toggle();
        });

    </g:javascript>
    <style>
<style>
ul, #myUL {
    list-style-type: none;
}

#myUL {
    margin: 0;
    padding: 0;
}

.caret {
    cursor: pointer;
    -webkit-user-select: none; /* Safari 3.1+ */
    -moz-user-select: none; /* Firefox 2+ */
    -ms-user-select: none; /* IE 10+ */
    user-select: none;
}

.caret::before {
    content: "\25B6";
    color: black;
    display: inline-block;
    margin-right: 6px;
}

.caret-down::before {
    -ms-transform: rotate(90deg); /* IE 9 */
    -webkit-transform: rotate(90deg); /* Safari */'
transform: rotate(90deg);
}

.nested {
    display: none;
}

.active {
    display: block;
}
</style>




    <style>
    .tree {
        min-height:20px;
        padding:19px;
        margin-bottom:20px;
        background-color:#fbfbfb;
        border:1px solid #999;
        -webkit-border-radius:4px;
        -moz-border-radius:4px;
        border-radius:4px;
        -webkit-box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05);
        -moz-box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05);
        box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05)
    }
    .tree li {
        list-style-type:none;
        margin:0;
        padding:10px 5px 0 5px;
        position:relative
    }
    .tree li::before, .tree li::after {
        content:'';
        left:-20px;
        position:absolute;
        right:auto
    }
    .tree li::before {
        border-left:1px solid #999;
        bottom:50px;
        height:100%;
        top:0;
        width:1px
    }
    .tree li::after {
        border-top:1px solid #999;
        height:20px;
        top:25px;
        width:25px
    }
    .tree li span {
        -moz-border-radius:5px;
        -webkit-border-radius:5px;
        border:1px solid #999;
        border-radius:5px;
        display:inline-block;
        padding:3px 8px;
        text-decoration:none
    }
    .tree li.parent_li>span {
        cursor:pointer
    }
    .tree>ul>li::before, .tree>ul>li::after {
        border:0
    }
    .tree li:last-child::before {
        height:30px
    }
    .tree li.parent_li>span:hover, .tree li.parent_li>span:hover+ul li span {
        background:#eee;
        border:1px solid #94a0b4;
        color:#000
    }
    .table thead tr th {
        font-weight: bold;
        font-size: 14px;
    }
    .table tbody tr td { height: auto;
        padding: 5px;
        cellspacing:0;
        font-weight: normal;
    }
    label{
        font-size: 14px;
        padding: 5px;
        padding-bottom: 0px;
        color:midnightblue;
    }
    .panel {
        border-radius: 12px;
        border: 2px solid  #ebebeb;
        padding: 20px;
    }
    #div1{
        position:relative;
        display:block;
        height:0px;
        overflow-y:scroll;
        overflow:auto;
        padding: 0px 10px;
    }
    #div2{
        position:relative;
        display:block;
        height:0px;
        overflow-y:auto;
        padding: 0px 10px;
    }
    </style>

    <style>
    .mb-0 > a {
        display: block;
        position: relative;
    }
    .mb-0 > a:after {
        content: "\f078"; /* fa-chevron-down */
        font-family: 'FontAwesome';
        position: absolute;
        right: 0;
    }
    .mb-0 > a[aria-expanded="true"]:after {
        content: "\f077"; /* fa-chevron-up */
    }
    </style>
    <script>
        $(document).ready(function(){
            // Add minus icon for collapse element which is open by default
            $(".collapse.show").each(function(){
                $(this).prev(".card-header").find(".fa").addClass("fa-minus").removeClass("fa-plus");
            });

            // Toggle plus minus icon on show hide of collapse element
            $(".collapse").on('show.bs.collapse', function(){
                $(this).prev(".card-header").find(".fa").removeClass("fa-plus").addClass("fa-minus");
            }).on('hide.bs.collapse', function(){
                $(this).prev(".card-header").find(".fa").removeClass("fa-minus").addClass("fa-plus");
            });
        });
    </script>


</head>
<body>
<div id="accordion">
    <div class="card">
        <div class="card-header" id="heading-1">
            <h5 class="mb-0">
                <a role="button" data-toggle="collapse" href="#collapse-1" aria-expanded="true" aria-controls="collapse-1">
                    Version 2 - Nov 2019
                </a>
            </h5>
        </div>
        <div id="collapse-1" class="collapse show" data-parent="#accordion" aria-labelledby="heading-1">
            <div class="card-body">

                <div id="accordion-1">


                <g:each in="${phecodeuniquedata3}" var="phecode">
                        <div class="card">
                        <div class="card-header" id="heading-1-1">
                        <h5 class="mb-0">
                            <a class="collapsed" role="button" data-toggle="collapse" href="#collapse-${phecode.phecodeid}" aria-expanded="false" aria-controls="collapse-${phecode.phecodeid}">
                                ${phecode.phecodeid}
                            </a>
                        </h5>
                        </div>
                        <div id="collapse-${phecode.phecodeid}" class="collapse" data-parent="#accordion-1" aria-labelledby="heading-1-1">
                                    <div class="card-body">

                                        <div id="accordion-1-1">
                                            <div class="card">
                                                <div class="card-header" id="heading-1-1-1">
                                                    <h5 class="mb-0">
                                                        <a class="collapsed" role="button" data-toggle="collapse" href="#collapse-1-1-1" aria-expanded="false" aria-controls="collapse-1-1-1">
                                                            Item 1 > 1 > 1
                                                        </a>
                                                    </h5>
                                                </div>
                                                <div id="collapse-1-1-1" class="collapse" data-parent="#accordion-1-1" aria-labelledby="heading-1-1-1">
                                                    <div class="card-body">
                                                        Text 1 > 1 > 1
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card">
                                                <div class="card-header" id="heading-1-1-2">
                                                    <h5 class="mb-0">
                                                        <a class="collapsed" role="button" data-toggle="collapse" href="#collapse-1-1-2" aria-expanded="false" aria-controls="collapse-1-1-2">
                                                            Item 1 > 1 > 2
                                                        </a>
                                                    </h5>
                                                </div>
                                                <div id="collapse-1-1-2" class="collapse" data-parent="#accordion-1-1" aria-labelledby="heading-1-1-2">
                                                    <div class="card-body">
                                                        Text 1 > 1 > 2
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card">
                                                <div class="card-header" id="heading-1-1-3">
                                                    <h5 class="mb-0">
                                                        <a class="collapsed" role="button" data-toggle="collapse" href="#collapse-1-1-3" aria-expanded="false" aria-controls="collapse-1-1-3">
                                                            Item 1 > 1 > 3
                                                        </a>
                                                    </h5>
                                                </div>
                                                <div id="collapse-1-1-3" class="collapse" data-parent="#accordion-1-1" aria-labelledby="heading-1-1-3">
                                                    <div class="card-body">
                                                        Text 1 > 1 > 3
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                        </div>
                </g:each>
                    <div class="card">
                        <div class="card-header" id="heading-1-2">
                            <h5 class="mb-0">
                                <a class="collapsed" role="button" data-toggle="collapse" href="#collapse-1-2" aria-expanded="false" aria-controls="collapse-1-2">
                                    Item 1 > 2
                                </a>
                            </h5>
                        </div>
                        <div id="collapse-1-2" class="collapse" data-parent="#accordion-1" aria-labelledby="heading-1-2">
                            <div class="card-body">
                                Text 1 > 2
                            </div>
                        </div>
                    </div>
                </div>

            </div>





        </div>
    </div>
    <div class="card">
        <div class="card-header" id="heading-2">
            <h5 class="mb-0">
                <a class="collapsed" role="button" data-toggle="collapse" href="#collapse-2" aria-expanded="false" aria-controls="collapse-2">
                    Version 1 - Aug 2019
                </a>
            </h5>
        </div>
        <div id="collapse-2" class="collapse" data-parent="#accordion" aria-labelledby="heading-2">
            <div class="card-body">
                Text 2
            </div>
        </div>
    </div>

</div>

<div id="create-displayData" class="content scaffold-create mt-5" role="main">
    <div class="container-fluid">
        <div class="card">
            <div class="row">





                <div id="jstree_demo_div">




                    <ul>
                        <li>Version 2 - Nov 2019
                            <ul>
                            <g:each in="${phecodeuniquedata3}" var="phecode">
                                <li>${phecode.phecodeid}



                                </li>
                            </g:each>
                            </ul>




                        </li>
                        <li>Version 1 -Aug 2018</li>

                    </ul>

            </div>


        </div>
    </div>
</div>
</div>
</body>
</html>
