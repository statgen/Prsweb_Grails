<!DOCTYPE html>
<html>
<head><!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-143045158-2"></script>
    <script>
        window.dataLayer = window.dataLayer || [];

        function gtag() {
            dataLayer.push(arguments);
        }

        gtag('js', new Date());

        gtag('config', 'UA-143045158-2');
    </script>


    <meta charset="UTF-8">
    <title>PRSweb</title>
    <meta name="layout" content="main"/>
    <link rel="stylesheet"
          type="text/css"
          href="https://cdn.jsdelivr.net/npm/locuszoom@0.10.0-beta.1/dist/locuszoom.css"/>


    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-121436353-1"></script>

    <script>window.dataLayer = window.dataLayer || [];

    function gtag() {
        dataLayer.push(arguments);
    }

    gtag('js', new Date());
    gtag('config', 'UA-121436353-1')</script>

    <asset:javascript src="jquery-3.3.1.js"/>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>

    <asset:javascript src="widget-filter-formatter-select2.js" />



    <asset:stylesheet src="theme.blue.css"/>
    <asset:javascript src="jquery.tablesorter.js"/>
    <asset:javascript src="jquery.tablesorter.widgets.js"/>

    <asset:javascript src="select2.min.js"/>
    <asset:stylesheet src="select2.css" />

    <asset:stylesheet src="magnific-popup.css"/>
    <asset:javascript src="jquery.magnific-popup.js" />

    <asset:stylesheet src="datatables.css"/>
    <asset:javascript src="datatables.js"/>

    <STYLE>
    div.drilldown {
        display: inline-block;
    }
    .row {
        position: relative;
        /* max-width: 1400px; */
        margin: 0 auto;
        padding: 0 1%;
    }

    #wrapper .text {
        position: relative;
        bottom: 30px;
        left: 0px;
        visibility: hidden;
        font-size: small;
    }

    #wrapper:hover .text {
        visibility: visible;
    }

    .line {
        fill: none;
        stroke: steelblue;
        stroke-width: 2px;
    }

    .grid line {
        stroke: lightgrey;
        stroke-opacity: 0.7;
        shape-rendering: crispEdges;
    }

    .grid path {
        stroke-width: 0;
    }
    div.container {
        width: 80%;
    }
    table.dataTable thead th,
    table.dataTable tfoot th {

    }
    table.dataTable thead th,
    table.dataTable thead td {
        padding: 1px 1px;
        border-bottom: 1px solid #111;
        padding: 5px;
        font-weight: bold;
        font-size: 13px;
        white-space: normal;
    }


    table.dataTable tbody th,
    table.dataTable tbody td {
        padding: 4px 5px;
        font-size: 12px;
    }


    div.drilldown {
        display: inline-block;
    }

    .option1, .option2, .option3, .option4 {
        display: none;
    }

    .show {
        display: block;
    }

    #c2 {
        padding: 5px;
        float: right
    }

    .headcol {
        position: absolute;
        width: 5em;

        top: auto;

        /*only relevant for first row*/
        margin-top: -1px;
        /*compensate for top border*/
    }

    .headcol:before {
        content: '';
    }

    .long {
        background: yellow;
        letter-spacing: 1em;
    }


</STYLE>






    <script type="text/javascript">
        $(document).ready(function () {




           var table=  $('#example').DataTable({
                destroy: true,
                "order": [[0, "asc"]],
                "paging": false,

           } );





        });






    </script>



    <r:require module="export"/>

</head>

<body>











<div class="row">
    <div class="col-md-12">


        %{--<g:each var="question" in="${(grails.converters.JSON.parse(dataRes)).phewas_df}" index="i">
            <tr>
                <td>${question.getKey()}</td>
                <td>${question.getValue().get(i)}</td>
            </tr>
        </g:each>
--}%



        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                <div class="table-bordered table-responsive fixed-table-body text-center">
                    <div id="c3">


                        <div id="c2">
                           %{-- Download the table:<i class="fas fa-download"></i>--}%

                         </div>




                    </div>

                    <table class="display" style="width:100%" id='example'>
                   <thead class="thead-light">
                    <tr>
                        <th rowspan="2">PheWAS<br/>Code</th>
                        <th rowspan="2">Description</th>
                        <th colspan="2">MGI Count</th>
                        <th colspan="2">UKB Count</th>


                    </tr>
                   <tr>


                       <th>Filtered</th>
                       <th> Total</th>
                       <th>Filtered</th>
                       <th> Total</th>


                   </tr>
                    </thead>
                        <tbody>

                           <g:each in="${allpheList}" var="pobj">
                               <tr>
                               <td><a class="intro" href="${createLink(controller: 'phecodeData', action: 'showPhecodeInfoTable')}?phecode=${pobj.phecodeid}" target="_blank">${pobj.phecodeid}</a></td>
                               <td>${pobj.phecodedesc}</td>
                               <td><a class="nav-item nav-link" href="${createLink(action:'displayTableOld')}?select_desc=${pobj.phecodeid}&select_phenomes=MGI&select_odds=1" role="tab">${pobj.mgifilcount}</a></td>
                               <td>${pobj.mgicount}</td>
                               <td><a class="nav-item nav-link" href="${createLink(action:'displayTableOld')}?select_desc=${pobj.phecodeid}&select_phenomes=UKB&select_odds=1" role="tab">${pobj.ukbfilcout}</a></td>
                               <td>${pobj.ukbcount}</td>
                               </tr>


                            </g:each>


                        </tbody>
                        <tfooter>
                            <tr>
                                <th></th>
                                <th style="text-align:right">Totals:</th>
                                <th>${mfiltotct}</th>
                                <th>${mtotct}</th>
                                <th>${ufiltotct}</th>
                                <th>${utotct}</th>
                            </tr>
                        </tfooter>


                </table>
                </div>
            </div>



        </div>
    </div>
</div>





</div>











</div>
</div>
</div>
</div>
</html>