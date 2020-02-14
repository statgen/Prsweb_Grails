<!DOCTYPE html>
<html>
<head>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-143045158-2"></script>
    <script>
        window.dataLayer = window.dataLayer || [];

        function gtag() {
            dataLayer.push(arguments);
        }

        gtag('js', new Date());

        gtag('config', 'UA-143045158-2');
    </script>


    <meta name="layout" content="main"/>
    <asset:javascript src="jquery-3.3.1.js"/>
    <asset:stylesheet src="theme.blue.css"/>
    <asset:javascript src="jquery.tablesorter.js"/>
    <asset:javascript src="jquery.tablesorter.widgets.js"/>
    <asset:javascript src="widget-filter-formatter-select2.js"/>
    <asset:javascript src="select2.min.js"/>    >
    <asset:stylesheet src="select2.css" />


    <g:set var="entityName" value="${message(code: 'displayData.label', default: 'DisplayData')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
    <STYLE>
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
    <g:javascript library='jquery'>



        $(function () {
            $("#select_desc").select2({ theme: "classic" });
            $("#select_phenomes").select2({theme: "classic",minimumResultsForSearch: -1});
            $("#select_odds").select2({theme: "classic",minimumResultsForSearch: -1});
            $('[data-toggle="popover"]').popover(  { html:true  });
            var $options = $('[id^="option"]');
            $('.tablesorter').tablesorter({
                theme: 'blue',
                widthFixed: true,
                sortList: [[5,1]],
                widgets: ['zebra', 'stickyHeaders', 'filter'],
                widgetOptions : {
                    // Use the $.tablesorter.storage utility to save the most recent filters
                    scroller_fixedColumns: 2,
                    scroller_addFixedOverlay: true,
                    scroller_rowHighlight: 'hover',
                    scroller_barWidth: null,

                    filter_saveFilters : true,
                    // jQuery selector string of an element used to reset the filters
                    filter_reset : 'button.reset',
                    // add custom selector elements to the filter row
                    filter_formatter : {

                        // Alphanumeric (match)


                        // Alphanumeric (exact)
                        1 : function($cell, indx) {
                            return $.tablesorter.filterFormatter.select2( $cell, indx, {
                                match : false // exact match only
                            });
                        },
                        2 : function($cell, indx) {
                            return $.tablesorter.filterFormatter.select2( $cell, indx, {
                                match : true,         // adds "filter-match" to header
                                cellText : 'Match: ', // Cell text
                                width: '85%',         // adjusted width to allow for cell text
                                value: ['Lassosum','P&T','P&G'] // initial values
                            });
                        }
                    },

                    // option added in v2.16.0
                    filter_selectSource : {
                        // Alphanumeric match (prefix only)
                        // added as select2 options (you could also use select2 data option)
                        2 : function(table, column) {
                            return ['P&T', 'Lassosum','P_5e-06','P_5e-05','P_5e-09','P_5e-07','P&G'];
                        }
                    }
                }

            });
            $("#select_desc").change(function () {
                var prswt = $(this).val();
                //console.log("User selection");
                 var phenval = $("#select_phenomes").val();
                //console.log(prswt);
                var phenocat = "Neoplasms";

                //console.log(jsonData);

                var phelist = [];
                var methodlist = [];
                  $.ajax( {
                           url: "${createLink(action: 'getPhenome')}",
                        type: "POST",
                        async: false,
                        data: { val1: prswt},


                        success: setPhenomeValue,
                        error: function() {
                        alert("fail");
                        }
                        } );
            });
            $("#select_phenomes").change(function () {
                    var cohort = $(this).val();
                    var phenocat = "Neoplasms";
                    var descval=  $("#select_desc").val();
                    var descvallen =  $("#select_desc").val().length;
                    console.log(descvallen);
                    $('#select_desc').empty();
                    var phelist = [];
                    var methodlist = [];
                     $.ajax({
                            url: "${createLink(controller:'displayData',action:'getTrait')}",
                            type: "POST",
                            async: false,
                            data: { cohort:cohort},
                            dataType: 'json',
                            success: function(json) {
                            console.log(json);
                            var $el = $("#select_desc");
                            $el.empty(); // remove old options
                            console.log(typeof jsonData);
                            var tbodyup = '';
                                for (var i = 0; i < json.length; i++) {
                                var counter = json[i];
                                var phecodeid = counter.phecodeid;
                                var phecodedesc = counter.phdesc;
                                    if(phecodedesc.includes(descval) && descval != 0 )
                                    {
                                        console.log("inside found desc");
                                        $el.append($("<option></option>")
                                        .attr("value", phecodeid)
                                        .text(phecodedesc)
                                        .prop('selected', true));
                                        }
                                        else
                                        {
                                        $el.append($("<option></option>")
                                        .attr("value", phecodeid).text(phecodedesc));

                                        }

                                    }
                                }
                            });
                   });

             $options.on('change', function() {
                  var $elementsToToggle = $('.' + this.value);
                  if (this.checked) {
                    $elementsToToggle.show();
                    console.log("its checked");
                    $("tablesorter").trigger("updateAll");
                    $('tablesorter').trigger('sortReset');

                  } else {
                      console.log("its checked");
                    $elementsToToggle.each(function() {
                      var hide = true,
                          elementToToggle = this;

                      $options.each(function() {
                        var optionClass = this.value,
                            optionValue = this.checked;
                        if (elementToToggle.classList.contains(optionClass) && optionValue)
                          hide = false;
                      });

                      if (hide === true)
                        $(elementToToggle).hide();
                    });
                  }
                });
        });




        function setPhenomeValue(response) {
                 result = response;
                 var phenval = $("#select_phenomes").val().trim();
                 var phenlen= phenval.length;
                 $('#select_phenomes').empty();
                 console.log("selected phenome is "+phenval+" length is "+phenlen);
                 console.log(typeof response);
                //console.log("Inside ajax: "+response);
                 var trainindIdArray = response.replace("[","").replace("]","").split(",");
                 var keys = [];
                 $.each( trainindIdArray, function( key, value ) {

                    console.log(value.replace(/("|')/g,"").trim().length);
                    var phe =value.replace(/("|')/g,"").trim();
                     console.log("loop val"+phe);
                     console.log(phe.length+"phenloen"+phenlen);
                    if(phe == phenval)
                        {
                              console.log("in the phe loop"+ phe + ";"+phenval);
                             var line = '<option selected value="'+phe+'">'+phe+'</option>';
                        }
                    else
                        {
                             var line = '<option value="'+phe+'">'+phe+'</option>';
                        }

                    var newOption = line;
                    $('#select_phenomes').append(newOption);
                });


                                    }
         function createLink(response){
                var prswtsel = $("#select_desc").val();
                var phenocatsel = $("#select_PRS_code").val();
                var phenomesel = $('#select_phenomes').val();
                var oddssel = $('#select_odds').val();
                var filepathlink = '${createLink(action: 'displayTable')}?select_desc='+ prswtsel+'&select_phenomes='+phenomesel+'&select_odds='+oddssel;
                window.location.href =filepathlink;
        }




    </g:javascript>

</head>

<body>
<a href="#create-displayData" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                    default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">

</div>

<div id="create-displayData" class="content scaffold-create mt-5" role="main">
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card"><div class="card-body">

                    <h1>Overview</h1>
                    Integrating published and freely available genome-wide association studies (GWAS) summary statistics from multiple sources (published GWAS, the NHGRI-EBI GWAS Catalog, or UKB-based GWAS), we created an online repository for polygenic risk scores (PRS) for common cancer traits. Our framework condenses these summary statistics into PRS using linkage disequilibrium pruning and p-value thresholding (fixed or data-adaptively optimized thresholds) or penalized, genome-wide effect size weighting. We evaluate them in the cancer-enriched cohort of the Michigan Genomics Initiative (MGI), a longitudinal biorepository effort at Michigan Medicine, and in the population-based UK Biobank Study (UKB). For each PRS construct, measures on performance, calibration, and discrimination are provided. Beyond the cancer PRS evaluation in MGI and UKB, the PRSweb platform features construct downloads, risk evaluation in the top percentiles, and phenome-wide PRS association studies (PRS-PheWAS) for a subset of PRS that are predictive for the primary cancer.
                    <br/>  For more information, see our bioRxiv preprint  <a href="https://www.biorxiv.org/content/10.1101/2020.01.22.915751v1" target="_blank"> here  </a>and the "Method" tab on top of this page."

                </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid"><div class="row">
        <div class="col-12 mt-2">
            <div class="card">
                <div class="card-body">
                    %{-- <g:form controller="DisplayData" action="showGraph" method="post" id="upform" name="upform" enctype="multipart/form-data">--}%
                    %{--<div class="drilldown mr-2">
                   <label for="select_PRS_code" class="mb-0">Phenotype Category</label><br/>
                        <g:select name="phenocat" id="select_PRS_code" class="form-control" from="${phenocat.phename}">

                                <option value="${phenocat.phename}">${phenocat.phename}</option>
                        </g:select>
                    </div>--}%

                    <div class="drilldown mr-2">
                        <label for="select_desc" class="mb-0">Cancer Trait (phecode)</label><br/>
                        <select name="select_desc" id="select_desc" class="form-control" value="phecode">
                            <option value="">Select Cancer Site/Trait</option>
                            <g:each in="${phecodeuniquedata}" status="i" var="dm">
                                <g:if test="${dm.phecodeid.equals(phecode)}">
                                    <option value="${dm.phecodeid}"
                                            selected>${dm.phecodedesc}&nbsp;(${dm.phecodeid})</option>

                                </g:if>
                                <g:else>
                                    <option value="${dm.phecodeid}">${dm.phecodedesc} &nbsp;(${dm.phecodeid})</option>
                                </g:else>

                            </g:each>
                        </select>

                    </div>

                    <div class="drilldown mr-2">
                        <label for="select_phenomes" class="form-check-label">Evaluation Cohort</label><br/>
                        <select name="select_phenomes" id="select_phenomes" class="form-control">

                            <g:each in="${phenomes}" status="i" var="dmp">
                                <option value="${dmp}">${dmp}</option>
                            </g:each>

                        </select>
                    </div>

                    <div class="drilldown mr-2">

                        <label for="select_odds" class="form-check-label">Odds Ratio Top</label><br/>
                        <select name="select_odds" id="select_odds" class="form-control">

                            <g:if test="${odds.toInteger() == 1}">
                                <option value="1" selected>1% vs Rest</option>
                            </g:if>
                            <g:else><option value="1">1% vs Rest</option></g:else>
                            <g:if test="${odds.toInteger() == 2}">
                                <option value="2" selected>2% vs Rest</option>
                            </g:if>
                            <g:else><option value="2">2% vs Rest</option></g:else>
                            <g:if test="${odds.toInteger() == 5}">
                                <option value="5" selected>5% vs Rest</option>
                            </g:if>
                            <g:else><option value="5">5% vs Rest</option></g:else>
                            <g:if test="${odds.toInteger() == 10}">
                                <option value="10" selected>10% vs Rest</option>
                            </g:if>
                            <g:else><option value="10">10% vs Rest</option></g:else>
                            <g:if test="${odds.toInteger() == 25}">
                                <option value="25" selected>25% vs Rest</option>
                            </g:if>
                            <g:else><option value="25">25% vs Rest</option></g:else>

                        </select>

                    </div>

                    <div class="drilldown mr-2">
                        %{--<g:submitButton name="Search" class="submit"/>--}%
                        <button onclick="createLink()" class="submit">Show table with PRS</button>
                    </div>

                </div>
            </div>

            <div class="col-md-12 col-sm-12" id="chart1" style="border: 1px solid lightgray; padding:1px">

                <div class="table-bordered table-responsive text-center">
                    <div id="c2">
                        <label class="display:inline-block;text-align: right;"><input id="option1btn" type="checkbox"
                                                                                      value="option1" >Show All methods
                        </label>
                        <label class="display:inline-block;text-align: right;"><input id="option2btn" type="checkbox"
                                                                                      value="option2">Show Excluded PRS
                        </label>

                        <a href="${createLink(action: 'downloadMainTable')}?phecode=${phecode}&phenome=${phenome}&oddratio=${odds}">Download Table <i
                                class="fas fa-download"></i></a>
                    </div>
                    <table class="table-striped table-bordered table-light table w-100 d-block d-md-table tablesorter"
                           style="border: 1px solid #ddd !important;" id='example'>
                        <thead class="thead-light">
                        <tr>

                            <th class="sorter-false"></th>
                            <th class="sorter-false"></th>
                            <th class="sorter-false"></th>
                            <th class="sorter-false"></th>

                            <th class="sorter-false">Association</th>
                            <th colspan="2" align="center">Overall Performance</th>
                            <th colspan="2" align="center" data-toggle="popover" data-trigger="hover" title="Area under the Receiver Operating Characteristic (ROC) Curve estimated using fitted predictors from a 5-fold cross validation; larger is better
" style="word-wrap: break-word;word-break: break-word;" class="sorter-false">Discrimination/AUC</th>
                            <th colspan="2" align="center" data-toggle="popover" data-trigger="hover" title="Hosmer-Lemeshow goodness of fit test for logistic regression estimated using fitted predictors from a 5-fold cross validation; small p-value indicates evidence of poor model fit
                " class="sorter-false">Calibration <br/> Hosmer-Lemeshow</th>

                            <th colspan="2" align="center" data-toggle="popover" data-trigger="hover" title="Odds ratio of being case (phecode) in the top X% PRS percentile versus the bottom (100 – X%) PRS percentile in the matched case control study (adjusted for age, array, PC1-4, and sex [if informative])
" class="sorter-false" id="headId"
                                style=" word-wrap: break-word;word-break: break-word;"></span>Odds Ratio <br/> Top ${odds}% vs Rest
                            </th>
                            <th class="sorter-false"></th>

                            <th class="sorter-false"></th>

                        </tr>



                        <tr>

                            <th class="sorter-false" data-toggle="popover" data-trigger="hover"
                                title="Source of GWAS summary statistics that were used to generate PRS">GWAS <br></br>Source
                            </th>
                            <th class="sorter-false" data-toggle="popover" data-trigger="hover"
                                title="Description of phenotype model(s) in GWAS source(s)">Phenotype <br/> Description
                            </th>
                            <th data-toggle="popover" data-trigger="hover"
                                title="Used method to generate variant lists and weights for PRS generation, see method tab on top of the page"
                                class="filter-select filter-match filter-parsed">Method</th>

                            <th data-toggle="popover" data-trigger="hover"
                                title="Number of variants used for PRS generation"># SNPs</th>
                            <th data-toggle="popover" data-trigger="hover" title="Association between the PRS and the phecodein the matched case control study (adjusted for age, array, PC1-4, and sex [if informative])
">P-value</th>
                            <th data-toggle="popover" data-trigger="hover" title="Nagelkerke’s pseudo-R2 estimated using fitted predictors from a 5-fold cross validation; larger is better
">Pseudo-R2</th>
                            <th data-toggle="popover" data-trigger="hover" title="Brier Score, accuracy of PRS predictions, estimated using fitted predictors from a 5-fold cross validation; smaller is better
">Brier score</th>
                            <th data-toggle="popover" data-trigger="hover" title="">AUC</th>
                            <th data-toggle="popover" data-trigger="hover"
                                style=" word-wrap: break-word;word-break: break-word;" title="">95%CI</th>
                            <th data-toggle="popover" data-trigger="hover" title="">P</th>
                            <th data-toggle="popover" data-trigger="hover" title="">Chi-Square</th>
                            <th data-toggle="popover" data-trigger="hover" style=" word-wrap: break-word;word-break: break-word;" title="">Odds Ratio</th>
                            <th data-toggle="popover" data-trigger="hover" title="">95 % CI</th>
                            <th data-toggle="popover" data-trigger="hover" title="Link to phenome-wide association study (PheWAS); testing association between PRS and all phenotypes in the corresponding phecode-based phenome
">PRS <br/> PheWAS</th>

                            <th data-toggle="popover" data-trigger="hover" title="Direct download of all variants (see column “#SNPs”) and their weights that were used to calculate the PRS in the corresponding cohort
">Download PRS</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${disobj}" var="dobj" status="i">
                            <g:if test="${dobj.method.contains('P_5e')}">

                                <tr id="hidethis" style="display:none;" class="option1">
                            </g:if>
                            <g:elseif test="${dobj.nomsig.equals('FALSE') || dobj.warreveff.equals('TRUE')}">

                                <tr id="hidethis2" style="display:none;" class="option2">


                            </g:elseif>

                            <g:else>
                                <tr>

                            </g:else>



                            <td class="align-middle">${dobj.gwassource}</td>
                            <g:if test="${dobj.descdata.length() > 30}">

                                <td class="align-middle" data-toggle="popover" data-content="${dobj.descdata}"
                                    data-trigger="hover">${dobj.descdata.substring(0, 30)}..</td>

                            </g:if>
                            <g:else>
                                <td class="align-middle">${dobj.descdata}</td>

                            </g:else>

                            <td class="align-middle" data-toggle="popover" data-content="${dobj.tunparam}"
                                data-trigger="hover">${dobj.method}</td>

                            <td class="align-middle">${dobj.nsnp}</td>
                            <td class="align-middle">${dobj.pval}</td>
                            <td>${dobj.r2_nage}</td>
                            <td class="align-middle">${dobj.brierScore}</td>
                            <td class="align-middle">${dobj.auc}</td>
                            <td class="align-middle"
                                style=" word-wrap: break-word;word-break: break-word;">${dobj.aucci}</td>
                            <td class="align-middle"
                                style="white-space:nowrap;">${String.format("%.2e", dobj.hosm_p)}</td>
                            <td class="align-middle">${dobj.hosm_chi}</td>
                            <g:if test="${odds.toInteger() == 1}">
                                <td class="align-middle">${dobj.topor}</td>
                                <td class="align-middle" style=" word-wrap: break-word;
                                word-break: break-word;">${dobj.toporci1},${dobj.toporci2}</td>

                            </g:if>


                            <g:if test="${odds.toInteger() == 2}">
                                <td class="align-middle">${dobj.topor2}</td>
                                <td class="align-middle"
                                    style=" word-wrap: break-word;word-break: break-word;">${dobj.toporci12},${dobj.toporci22}</td>

                            </g:if>

                            <g:if test="${odds.toInteger() == 5}">
                                <td class="align-middle">${dobj.topor5}</td>
                                <td class="align-middle" style=" word-wrap: break-word;word-break: break-word;">${dobj.toporci15},</br>${dobj.toporci25}</td>

                            </g:if>
                            <g:if test="${odds.toInteger() == 10}">
                                <td class="align-middle">${dobj.topor5}</td>
                                <td class="align-middle" style=" word-wrap: break-word;word-break: break-word;">${dobj.toporci15},</br>${dobj.toporci25}</td>

                            </g:if>
                            <g:if test="${odds.toInteger() == 25}">
                                <td class="align-middle">${dobj.topor5}</td>
                                <td class="align-middle" style=" word-wrap: break-word;word-break: break-word;">${dobj.toporci15},</br>${dobj.toporci25}</td>

                            </g:if> <g:if test="${dobj.prsweb.equals('TRUE')}">
                            <td class="align-middle" style=" position:sticky;left:0px;"><a class="intro"
                                                                                           href="${createLink(action: 'showGraphSep')}?phecode=${phecode}&model=${dobj.outsource}&phenome=${dobj.phenomes}&id=${dobj.pid}"
                                                                                           target="_blank">link</a></td>

                        </g:if>
                            <g:else>
                                <td class="align-middle" style=" position:sticky;left:0px;">--</td>
                            </g:else>








                            <g:if test="${dobj.nomsig.equals('FALSE') || dobj.warreveff.equals('TRUE')}">
                                <g:if test="${dobj.nomsig.equals('FALSE')}">
                                    <g:set var="warn"
                                           value="No nominal significant association observed trait of interest and PRS ;"/>

                                </g:if>
                                <g:else>
                                    <g:set var="warn" value=""/>

                                </g:else>

                                <g:if test="${dobj.warreveff.equals("TRUE")}">
                                    <g:set var="warnw"
                                           value="PRS associated with decreased risk for trait of interest ;"/>

                                </g:if>
                                <g:else>

                                    <g:set var="warnw" value=""/>
                                </g:else>

                                <g:set var="fwarn" value="${warn + warnw}"/>

                                <td data-toggle="popover" data-trigger="hover"
                                    title="PRSweb LD reference : ${dobj.genld} <br />PRSweb date ${dobj.datecreated} <br /> GWAS source  ${dobj.outsource} <br /> GWAS reference: ${dobj.refdata} <br /> GWAS phenotype: ${dobj.descdata} <br /> GWAS id :${dobj.prefixdata} <br /> GWAS URL: ${dobj.urldata} <br /> GWAS method ${dobj.method} <br /> PRS tuning parameter: ${dobj.tunparam} <br /> PRS evaluation in${dobj.phenomes} <br /> Genome build:: ${dobj.genomebuild}"><a
                                        class="intro"
                                        href="${createLink(action: 'downloadFile')}?filename=${prswebprefix}&type=weight"><i
                                            class="fas fa-download"></i></a> <a href="#" title="${fwarn}"><i
                                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>

                            </g:if>
                            <g:else>
                                <td data-toggle="popover" data-trigger="hover" title="PRSweb LD reference : ${dobj.genld} <br />PRSweb date ${dobj.datecreated} <br /> GWAS source  ${dobj.outsource} <br /> GWAS reference: ${dobj.refdata} <br /> GWAS phenotype: ${dobj.descdata} <br /> GWAS id :${dobj.prefixdata} <br /> GWAS URL: ${dobj.urldata} <br /> GWAS method ${dobj.method} <br /> PRS tuning parameter: ${dobj.tunparam} <br /> PRS evaluation in${dobj.phenomes} <br /> Genome build:: ${dobj.genomebuild}"><a
                                    class="intro"
                                    href="${createLink(action: 'downloadFile')}?filename=${dobj.prswebprefix}&type=weight"
                                    target="_blank"><i class="fas fa-download"></i></a></a> -- </td>

                            </g:else>


                            </tr>

                        </g:each>

                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div></div>
</div>


</div>

</body>
</html>
