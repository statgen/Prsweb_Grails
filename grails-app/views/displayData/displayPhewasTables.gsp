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

    <asset:javascript src="locuszoom.vendor.min.js"/>
    <asset:javascript src="locuszoom.app.js"/>

    <asset:javascript src="jquery-3.3.1.min.js"/>
    <asset:javascript src="bootstrap.bundle.js"/>
    <asset:javascript src="underscore.min.js"/>
    <asset:javascript src="utils.js"/>
    <babel:webpack src="drawplots1mod.es6"/>
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
    #c2 {

        float: right;
        overflow: hidden;
        white-space: nowrap;
        text-overflow:ellipsis;
    }
    #c3 {
        float: right;
        overflow: hidden;
        white-space: nowrap;
        padding-right: 2px;
        padding-left: 2px;

    }

    </STYLE>






    <script type="text/javascript">
        $(document).ready(function () {


            handle_data(${raw(dataRes)});

            $('#example').DataTable({
                destroy: true,
                "order": [[4, "asc"]],
                "pageLength": 50
            });
            $('#exclusion').DataTable({
                destroy: true,
                "order": [[3, "asc"]]
            });

            $('[data-toggle="popover"]').popover({
                html: true
            });


        });






    </script>



    <r:require module="export"/>

</head>

<body>
<a href="#list-displayData" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                  default="Skip to content&hellip;"/></a>

<div id="list-displayData" class="content scaffold-list" role="main">

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>






%{-- <g:link  action="main" params="${[inputprscode:dataRes.PRS_code, inprsstudy:dataRes.PRS_study]}"><span class="glyphicon glyphicon-th-list"></span> Go Back</g:link>--}--}%

</div>
</div>
</div>


</div>




<div class="container-fluid">
    <div class="row">

        <table class="table table-light table-condensed" class="infotable">
            <tr>

                <td colspan="2"><span
                        class="contentTitle">${dispObj.phenomes} PRS for ${pheobj.phecodedesc}(${pheobj.phecodeid}) based on ${dispObj.gwassource}</span>
                </td>
            </tr>


            <tr>
                <g:if test="${dispObj.refdata.equals('UKB_GWAS') && dispObj.source.equals('PheWAS_Codes')}">

                    <td style="width:40%">GWAS reference: <a href="https://www.ncbi.nlm.nih.gov/pubmed/?term=30107761"
                                                             target="_blank">${dispObj.refdata}</a></td>
                </g:if>
                <g:elseif test="${dispObj.refdata.equals('UKB_GWAS') && !(dispObj.source.equals('PheWAS_Codes'))}">

                    <td style="width:30%">GWAS reference: <a href="https://github.com/Nealelab/UK_Biobank_GWAS"
                                                             target="_blank">!${dispObj.refdata}</a></td>
                </g:elseif>
                <g:elseif test="${!(dispObj.refdata.equals('UKB_GWAS'))}">

                    <g:if test="${dispObj.refdata.size() > 30}">
                        <td style="width:30%" data-toggle="popover" data-content="${dispObj.refdata}"
                            data-trigger="hover">GWAS reference: <a
                                href="https://www.ncbi.nlm.nih.gov/pubmed/?term=${dispObj.refdata.replace(';', ',')}"
                                target="_blank">${dispObj.refdata.substring(0, dispObj.refdata.indexOf(';', 18))}....</a>
                        </td>
                    </g:if>
                    <g:else>
                        <td style="width:30%">GWAS reference: <a
                                href="https://www.ncbi.nlm.nih.gov/pubmed/?term=${dispObj.refdata.replace(';', ',')}"
                                target="_blank">${dispObj.refdata}</a></td>
                    </g:else>

                </g:elseif>
                <td style="width:30%">GWAS source: ${dispObj.gwassource}</td>
                <td style="width:30%">PRS method: ${dispObj.method}</td>
            </tr>
            <tr>
                <td>PRSweb LD reference: ${dispObj.genld}</td>
                <g:if test="${dispObj.descdata.size() > 60}">
                    <td data-toggle="popover" data-content="${dispObj.descdata}"
                        data-trigger="hover">GWAS phenotype: ${dispObj.descdata.substring(0, 60)}...</td>
                </g:if>
                <g:else>
                    <td>GWAS phenotype: ${dispObj.descdata}</td>
                </g:else>
                <td>PRSweb date: ${dispObj.datecreated}</td>
            </tr>
            <tr>
                <td>GWAS ID: ${dispObj.prefixdata}</td>
                <td>GWAS URL: <a href="${dispObj.urldata}" target="_blank">${dispObj.urldata}</a></td>
                <td>Genome build: GRCh37/hg19</td>
            </tr>

            <tr>
                <td>PRS tuning parameter: ${dispObj.tunparam}</td>
                <td>PRS evaluation in: ${dispObj.phenomes}</td>
            </tr>

        </table>
    </div>
    <div class="row">
        <div class="col-md-12">

            <ul class="nav nav-tabs" role="tablist">
                <li><a class="nav-item nav-link" href="${createLink(action:'showGraphSep')}?phecode=${dispObj.phecodedata.replace("X","")}&model=${dispObj.outsource}&phenome=${dispObj.phenomes}&id=${dispObj.id}" role="tab">Graph</a>

                </li>
                <li class="active"><a  class="nav-item nav-link active"  href="" >Table</a>

                </li>

            </ul>


        </div>
    </div>

</div>





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
                        Download the table:

                        <div id="c2">

                        <export:formats formats="['csv', 'excel']" params="[id:"${inputid}",phecode:"${dispObj.phecodedata}",phenome:"${dispObj.phenomes}",model:"${dispObj.outsource}"]" />
                        </div>
                        <i class="fas fa-download"></i>



                    </div>

                    <table  class="table-striped table-bordered table-light tablesorter" style="border: 1px solid #ddd !important;" cellspacing="0" id="example">

                    <thead>
                    <tr>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th colspan="5" align="center"> PRS PheWAS Summary Statistics </th>
                        <th colspan="5" align="center"> Exclusion PRS PheWAS Summary Statistics</th>
                    </tr>
                    <tr>
                        <th>PheWAS<br/>Code</th>
                        <th>Description</th>
                        <th>Category</th>
                        <th>Sex</th>
                        <th>P value</th>
                        <th>Odds<br/> Ratio </th>
                        <th>95% CI</th>
                        <th># Cases</th>
                        <th># Controls</th>
                        <th>P value</th>
                        <th>Odds <br/>Ratio</th>
                        <th>95% CI</th>
                        <th># Cases</th>
                        <th># Controls</th>

                    </tr>
                    </thead>
                    <tbody id="insertfirsttable">
                    <g:each var="prop" in="${combinedlist}" index="i">
                        <tr>
                            <td><a class="intro" href="${createLink(controller: 'phecodeData', action: 'showPhecodeInfoTable')}?phecode=${prop.getCode()}" target="_blank">${prop.getCode()}</a></td></td>
                        <td>${prop.getPstring()}</td>
                        <td>${prop.getCategory()}</td>
                        <td>${prop.getSex()}</td>
                        <td>${prop.getPrsp()}</td>
                        <td>${prop.getOr()}</td>
                        <td>${prop.getCc1()}${prop.getCc2()}</td>
                        <td>${prop.getNumcases()}</td>
                        <td>${prop.getNumcont()}</td>
                        <td>${prop.getExprsp()}</td>
                        <td>${prop.getExor()}</td>
                        <td>${prop.getExcc1()},${prop.getExcc2()}</td>
                        <td>${prop.getExnumcases()}</td>
                        <td>${prop.getExnumcont()}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
                </div>
            </div>



        </div>
    </div>
</div>





</div>
<div class="row">

    <div><span class="mx-1"><a class="btn btn-primary"
                               href="${createLink(action: 'downloadFile')}?filename=${dispObj.prswebprefix}&type=weight">Download weights of GRCh37</a>
    </span></div>

  %{--  <div><span class="mx-1"><a class="btn btn-primary"
                               href="${createLink(action: 'downloadFile')}?filename=${dispObj.prswebprefix}&type=df">Download PRS Phewas</a>
    </span></div>

    <div><span class="mx-1"><a class="btn btn-primary"
                               href="${createLink(action: 'downloadFile')}?filename=${dispObj.prswebprefix}&type=excl">Download PRS Phewas Exclusion</a>
    </span></div>--}%

</div>

<div class="row my-2"><div class="col-12">
    <div class="card"><div class="card-body">
        <h3>LEGENDS</h3>

        <p></p><A name="phewasinfo"><b>Figure 1: PheWAS results</b><br>
            P-values correspond to associations between the polygenic risk score (PRS) and the electronic health record-derived phenotype obtained using Firth’s logistic regression and also adjusting for age, gender, genotyping array, and the first four genotype principal components.<br>
            Upward (downward)-pointing triangles indicate a positive (negative) association.<br>
            Additional details are available by hovering the cursor over a particular triangle and by clicking the triangle. The horizontal dashed line indicates phenome-wide significance. Results are color-coded by disease category.</p>
        </A>

        <p><A name="phewasdfinfo"><b>Figure 2: Exclusion PheWAS results</b><br>
            Results from a PheWAS performed using only subjects who never had the primary cancer diagnosis. The results are obtained as in Figure 1 but using the reduced dataset.

        </A>

        <p class="mb-0"><b><A name="forestinfo">Figure 3: Associations between PRS and Selected Phenotype</b><br>
            This figure shows results for the selected phenotype in Figure 1.<br>
            This figure provides the beta estimate for the adjusted association between the PRS and the selected phenotype from Firth-corrected logistic regression. The corresponding confidence intervals are also shown. Results are presented for models using either a continuous or a categorical version of the PRS.<br>
            Q1 through Q4 represent the four quartiles of the PRS.</p>
    </A>
    </div></div>
</div></div>










</div>
</div>
</div>
</div>
</html>