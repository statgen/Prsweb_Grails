
<head>


<asset:javascript src="jquery-3.3.1.js"/>

<!-- Tablesorter: required -->



    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.6/select2.min.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.6/select2.min.js"></script>
    <asset:javascript src="widget-filter-formatter-select2.js" />

    <asset:stylesheet href="locuszoom.css"/>


    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-121436353-1"></script>
    <script>window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','UA-121436353-1')</script>

    <meta name="layout" content="main"/>
    <asset:javascript src="jquery-3.3.1.js"/>
    <asset:stylesheet src="theme.blue.css"/>
    <asset:javascript src="jquery.tablesorter.js"/>
    <asset:javascript src="jquery.tablesorter.widgets.js"/>
    <asset:javascript src="widget-filter-formatter-select2.js"/>
    <asset:javascript src="select2.min.js"/>    >
    <asset:stylesheet src="select2.css" />



    <g:set var="entityName" value="${message(code: 'displayData.label', default: 'DisplayData')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <STYLE>
    div.drilldown { display: inline-block; }
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
    widgets: ['zebra', 'stickyHeaders', 'filter'],
    widgetOptions : {
      // Use the $.tablesorter.storage utility to save the most recent filters
      filter_saveFilters : true,
      // jQuery selector string of an element used to reset the filters
      filter_reset : 'button.reset',
      // add custom selector elements to the filter row
      filter_formatter : {

        // Alphanumeric (match)
        0 : function($cell, indx) {
          return $.tablesorter.filterFormatter.select2( $cell, indx, {
            match : true,         // adds "filter-match" to header
            cellText : 'Match: ', // Cell text
            width: '85%',         // adjusted width to allow for cell text
            value: ['abc', 'def'] // initial values
          });
        },

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
        0 : function(table, column) {
          return ['abc', 'def', 'zyx'];
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
</g:javascript>
</head>







</head>

<body>


<div class="col-md-12 col-sm-12" id="chart1" style="border: 1px solid lightgray; padding:1px">

    <div class="table-bordered table-responsive text-center">
        <div id="c2">
            <label class="display:inline-block;text-align: right;"><input id="option1btn" type="checkbox"
                                                                          value="option1" >Show All methods
            </label>
            <label class="display:inline-block;text-align: right;"><input id="option2btn" type="checkbox"
                                                                          value="option2">Show Excluded PRS
            </label>

            <a href="/displayData/downloadMainTable?phecode=145.2&phenome=MGI&oddratio=1">Download Table <i
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
                    style=" word-wrap: break-word;word-break: break-word;"></span>Odds Ratio <br/> Top 1% vs Rest
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



            <tr id="hidethis" style="display:none;" class="option1">
                <td class="align-middle">UKB GWAS (PHESANT)</td>


                <td class="align-middle" data-toggle="popover" data-content="Cancer code, self-reported: tongue cancer"
                    data-trigger="hover">Cancer code, self-reported: to..</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=5e-06"
                    data-trigger="hover">P_5e-06</td>

                <td class="align-middle">6</td>
                <td class="align-middle">0.92</td>
                <td>3.05E-4</td>
                <td class="align-middle">0.0828</td>
                <td class="align-middle">0.512</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.487, 0.537</td>
                <td class="align-middle"
                    style="white-space:nowrap;">7.78e-01</td>
                <td class="align-middle">4.8</td>

                <td class="align-middle">1.17</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.466,2.46</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  PHESANT <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Cancer code, self-reported: tongue cancer <br /> GWAS id :20001_1011 <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method P_5e-06 <br /> PRS tuning parameter: P&lt;=5e-06 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;PRS associated with decreased risk for trait of interest ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis" style="display:none;" class="option1">




                <td class="align-middle">UKB GWAS (PHESANT)</td>


                <td class="align-middle" data-toggle="popover" data-content="Cancer code, self-reported: tongue cancer"
                    data-trigger="hover">Cancer code, self-reported: to..</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=5e-05"
                    data-trigger="hover">P_5e-05</td>

                <td class="align-middle">41</td>
                <td class="align-middle">0.65</td>
                <td>6.32E-4</td>
                <td class="align-middle">0.0828</td>
                <td class="align-middle">0.52</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.495, 0.546</td>
                <td class="align-middle"
                    style="white-space:nowrap;">1.34e-01</td>
                <td class="align-middle">12.4</td>

                <td class="align-middle">1.17</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.468,2.47</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  PHESANT <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Cancer code, self-reported: tongue cancer <br /> GWAS id :20001_1011 <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method P_5e-05 <br /> PRS tuning parameter: P&lt;=5e-05 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis2" style="display:none;" class="option2">






                <td class="align-middle">UKB GWAS (PHESANT)</td>


                <td class="align-middle" data-toggle="popover" data-content="Cancer code, self-reported: tongue cancer"
                    data-trigger="hover">Cancer code, self-reported: to..</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=3.16e-05"
                    data-trigger="hover">P&amp;T</td>

                <td class="align-middle">30</td>
                <td class="align-middle">0.95</td>
                <td>0.00133</td>
                <td class="align-middle">0.0828</td>
                <td class="align-middle">0.523</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.498, 0.549</td>
                <td class="align-middle"
                    style="white-space:nowrap;">6.95e-01</td>
                <td class="align-middle">5.58</td>

                <td class="align-middle">1.18</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.472,2.49</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  PHESANT <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Cancer code, self-reported: tongue cancer <br /> GWAS id :20001_1011 <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method P&amp;T <br /> PRS tuning parameter: P&lt;=3.16e-05 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr>





                <td class="align-middle">UKB GWAS (PHESANT)</td>


                <td class="align-middle" data-toggle="popover" data-content="Cancer code, self-reported: tongue cancer"
                    data-trigger="hover">Cancer code, self-reported: to..</td>



                <td class="align-middle" data-toggle="popover" data-content="s=1;Lambda=0.01833"
                    data-trigger="hover">Lassosum</td>

                <td class="align-middle">2064908</td>
                <td class="align-middle">0.021</td>
                <td>0.00611</td>
                <td class="align-middle">0.0826</td>
                <td class="align-middle">0.545</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.52, 0.571</td>
                <td class="align-middle"
                    style="white-space:nowrap;">3.01e-01</td>
                <td class="align-middle">9.51</td>

                <td class="align-middle">1.38</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.588,2.8</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>










                <td data-toggle="popover" data-trigger="hover" title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  PHESANT <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Cancer code, self-reported: tongue cancer <br /> GWAS id :20001_1011 <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method Lassosum <br /> PRS tuning parameter: s=1;Lambda=0.01833 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=PRSWEB_PHECODE145.2_20001-1011_LASSOSUM_MGI_20200114&type=weight"
                        target="_blank"><i class="fas fa-download"></i></a></a> -- </td>




            </tr>
            <tr id="hidethis" style="display:none;" class="option1">




                <td class="align-middle">UKB GWAS (ICD10)</td>


                <td class="align-middle" data-toggle="popover" data-content="Diagnoses - main ICD10: C01 Malignant neoplasm of base of tongue"
                    data-trigger="hover">Diagnoses - main ICD10: C01 Ma..</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=5e-06"
                    data-trigger="hover">P_5e-06</td>

                <td class="align-middle">9</td>
                <td class="align-middle">0.33</td>
                <td>3.89E-4</td>
                <td class="align-middle">0.0828</td>
                <td class="align-middle">0.522</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.498, 0.547</td>
                <td class="align-middle"
                    style="white-space:nowrap;">3.09e-02</td>
                <td class="align-middle">16.9</td>

                <td class="align-middle">1.37</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.584,2.78</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  ICD10 <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Diagnoses - main ICD10: C01 Malignant neoplasm of base of tongue <br /> GWAS id :C01 <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method P_5e-06 <br /> PRS tuning parameter: P&lt;=5e-06 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis" style="display:none;" class="option1">




                <td class="align-middle">UKB GWAS (ICD10)</td>


                <td class="align-middle" data-toggle="popover" data-content="Diagnoses - main ICD10: C01 Malignant neoplasm of base of tongue"
                    data-trigger="hover">Diagnoses - main ICD10: C01 Ma..</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=5e-05"
                    data-trigger="hover">P_5e-05</td>

                <td class="align-middle">41</td>
                <td class="align-middle">0.8</td>
                <td>0.00208</td>
                <td class="align-middle">0.0827</td>
                <td class="align-middle">0.529</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.504, 0.554</td>
                <td class="align-middle"
                    style="white-space:nowrap;">2.48e-01</td>
                <td class="align-middle">10.3</td>

                <td class="align-middle">1.17</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.466,2.45</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  ICD10 <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Diagnoses - main ICD10: C01 Malignant neoplasm of base of tongue <br /> GWAS id :C01 <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method P_5e-05 <br /> PRS tuning parameter: P&lt;=5e-05 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;PRS associated with decreased risk for trait of interest ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis2" style="display:none;" class="option2">
                <td class="align-middle">UKB GWAS (ICD10)</td>


                <td class="align-middle" data-toggle="popover" data-content="Diagnoses - main ICD10: C01 Malignant neoplasm of base of tongue"
                    data-trigger="hover">Diagnoses - main ICD10: C01 Ma..</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=9.73e-05"
                    data-trigger="hover">P&amp;T</td>

                <td class="align-middle">79</td>
                <td class="align-middle">0.66</td>
                <td>0.00368</td>
                <td class="align-middle">0.0827</td>
                <td class="align-middle">0.54</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.515, 0.565</td>
                <td class="align-middle"
                    style="white-space:nowrap;">8.55e-01</td>
                <td class="align-middle">4.02</td>

                <td class="align-middle">1.17</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.466,2.45</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  ICD10 <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Diagnoses - main ICD10: C01 Malignant neoplasm of base of tongue <br /> GWAS id :C01 <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method P&amp;T <br /> PRS tuning parameter: P&lt;=9.73e-05 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;PRS associated with decreased risk for trait of interest ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis2" style="display:none;" class="option2">
             <td class="align-middle">UKB GWAS (ICD10)</td>


                <td class="align-middle" data-toggle="popover" data-content="Diagnoses - main ICD10: C01 Malignant neoplasm of base of tongue"
                    data-trigger="hover">Diagnoses - main ICD10: C01 Ma..</td>



                <td class="align-middle" data-toggle="popover" data-content="s=0.2;Lambda=0.008859"
                    data-trigger="hover">Lassosum</td>

                <td class="align-middle">914083</td>
                <td class="align-middle">0.12</td>
                <td>0.00299</td>
                <td class="align-middle">0.0827</td>
                <td class="align-middle">0.54</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.515, 0.566</td>
                <td class="align-middle"
                    style="white-space:nowrap;">4.81e-01</td>
                <td class="align-middle">7.53</td>

                <td class="align-middle">1.8</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.844,3.46</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  ICD10 <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Diagnoses - main ICD10: C01 Malignant neoplasm of base of tongue <br /> GWAS id :C01 <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method Lassosum <br /> PRS tuning parameter: s=0.2;Lambda=0.008859 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;PRS associated with decreased risk for trait of interest ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis" style="display:none;" class="option1">




                <td class="align-middle">UKB GWAS (ICD10)</td>


                <td class="align-middle" data-toggle="popover" data-content="Diagnoses - main ICD10: C02 Malignant neoplasm of other and unspecified parts of tongue"
                    data-trigger="hover">Diagnoses - main ICD10: C02 Ma..</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=5e-06"
                    data-trigger="hover">P_5e-06</td>

                <td class="align-middle">7</td>
                <td class="align-middle">0.64</td>
                <td>9.59E-4</td>
                <td class="align-middle">0.0828</td>
                <td class="align-middle">0.521</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.495, 0.546</td>
                <td class="align-middle"
                    style="white-space:nowrap;">7.36e-01</td>
                <td class="align-middle">5.2</td>

                <td class="align-middle">2.28</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">1.14,4.2</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  ICD10 <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Diagnoses - main ICD10: C02 Malignant neoplasm of other and unspecified parts of tongue <br /> GWAS id :C02 <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method P_5e-06 <br /> PRS tuning parameter: P&lt;=5e-06 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis" style="display:none;" class="option1">
                <td class="align-middle">UKB GWAS (ICD10)</td>


                <td class="align-middle" data-toggle="popover" data-content="Diagnoses - main ICD10: C02 Malignant neoplasm of other and unspecified parts of tongue"
                    data-trigger="hover">Diagnoses - main ICD10: C02 Ma..</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=5e-05"
                    data-trigger="hover">P_5e-05</td>

                <td class="align-middle">61</td>
                <td class="align-middle">0.98</td>
                <td>0.00159</td>
                <td class="align-middle">0.0828</td>
                <td class="align-middle">0.527</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.501, 0.552</td>
                <td class="align-middle"
                    style="white-space:nowrap;">9.72e-01</td>
                <td class="align-middle">2.26</td>

                <td class="align-middle">0.779</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.254,1.83</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  ICD10 <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Diagnoses - main ICD10: C02 Malignant neoplasm of other and unspecified parts of tongue <br /> GWAS id :C02 <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method P_5e-05 <br /> PRS tuning parameter: P&lt;=5e-05 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;PRS associated with decreased risk for trait of interest ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis2" style="display:none;" class="option2">
                <td class="align-middle">UKB GWAS (ICD10)</td>


                <td class="align-middle" data-toggle="popover" data-content="Diagnoses - main ICD10: C02 Malignant neoplasm of other and unspecified parts of tongue"
                    data-trigger="hover">Diagnoses - main ICD10: C02 Ma..</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=9.98e-05"
                    data-trigger="hover">P&amp;T</td>

                <td class="align-middle">106</td>
                <td class="align-middle">0.59</td>
                <td>0.00202</td>
                <td class="align-middle">0.0827</td>
                <td class="align-middle">0.532</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.507, 0.558</td>
                <td class="align-middle"
                    style="white-space:nowrap;">7.51e-01</td>
                <td class="align-middle">5.06</td>

                <td class="align-middle">0.968</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.355,2.14</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  ICD10 <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Diagnoses - main ICD10: C02 Malignant neoplasm of other and unspecified parts of tongue <br /> GWAS id :C02 <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method P&amp;T <br /> PRS tuning parameter: P&lt;=9.98e-05 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr>





                <td class="align-middle">UKB GWAS (ICD10)</td>


                <td class="align-middle" data-toggle="popover" data-content="Diagnoses - main ICD10: C02 Malignant neoplasm of other and unspecified parts of tongue"
                    data-trigger="hover">Diagnoses - main ICD10: C02 Ma..</td>



                <td class="align-middle" data-toggle="popover" data-content="s=1;Lambda=0.001"
                    data-trigger="hover">Lassosum</td>

                <td class="align-middle">3478092</td>
                <td class="align-middle">0.023</td>
                <td>0.00419</td>
                <td class="align-middle">0.0827</td>
                <td class="align-middle">0.54</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.515, 0.566</td>
                <td class="align-middle"
                    style="white-space:nowrap;">8.15e-01</td>
                <td class="align-middle">4.44</td>

                <td class="align-middle">0.247</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.028,0.909</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>










                <td data-toggle="popover" data-trigger="hover" title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  ICD10 <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Diagnoses - main ICD10: C02 Malignant neoplasm of other and unspecified parts of tongue <br /> GWAS id :C02 <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method Lassosum <br /> PRS tuning parameter: s=1;Lambda=0.001 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=PRSWEB_PHECODE145.2_C02_LASSOSUM_MGI_20200114&type=weight"
                        target="_blank"><i class="fas fa-download"></i></a></a> -- </td>




            </tr>
            <tr id="hidethis" style="display:none;" class="option1">




                <td class="align-middle">UKB GWAS (FINNGEN)</td>


                <td class="align-middle" data-toggle="popover" data-content="Malignant neoplasm of other and unspecified parts of tongue"
                    data-trigger="hover">Malignant neoplasm of other an..</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=5e-06"
                    data-trigger="hover">P_5e-06</td>

                <td class="align-middle">10</td>
                <td class="align-middle">0.81</td>
                <td>4.92E-4</td>
                <td class="align-middle">0.0828</td>
                <td class="align-middle">0.521</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.496, 0.546</td>
                <td class="align-middle"
                    style="white-space:nowrap;">8.94e-01</td>
                <td class="align-middle">3.57</td>

                <td class="align-middle">0.967</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.355,2.13</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  FINNGEN <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Malignant neoplasm of other and unspecified parts of tongue <br /> GWAS id :C3_TONGUENAS <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method P_5e-06 <br /> PRS tuning parameter: P&lt;=5e-06 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;PRS associated with decreased risk for trait of interest ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis" style="display:none;" class="option1">
                <td class="align-middle">UKB GWAS (FINNGEN)</td>


                <td class="align-middle" data-toggle="popover" data-content="Malignant neoplasm of other and unspecified parts of tongue"
                    data-trigger="hover">Malignant neoplasm of other an..</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=5e-05"
                    data-trigger="hover">P_5e-05</td>

                <td class="align-middle">49</td>
                <td class="align-middle">0.42</td>
                <td>4.4E-5</td>
                <td class="align-middle">0.0828</td>
                <td class="align-middle">0.514</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.489, 0.539</td>
                <td class="align-middle"
                    style="white-space:nowrap;">1.73e-01</td>
                <td class="align-middle">11.5</td>

                <td class="align-middle">1.16</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.465,2.45</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  FINNGEN <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Malignant neoplasm of other and unspecified parts of tongue <br /> GWAS id :C3_TONGUENAS <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method P_5e-05 <br /> PRS tuning parameter: P&lt;=5e-05 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis2" style="display:none;" class="option2">






                <td class="align-middle">UKB GWAS (FINNGEN)</td>


                <td class="align-middle" data-toggle="popover" data-content="Malignant neoplasm of other and unspecified parts of tongue"
                    data-trigger="hover">Malignant neoplasm of other an..</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=3.98e-05"
                    data-trigger="hover">P&amp;T</td>

                <td class="align-middle">35</td>
                <td class="align-middle">0.71</td>
                <td>0.00425</td>
                <td class="align-middle">0.0827</td>
                <td class="align-middle">0.545</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.52, 0.571</td>
                <td class="align-middle"
                    style="white-space:nowrap;">1.09e-01</td>
                <td class="align-middle">13.1</td>

                <td class="align-middle">0.773</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.252,1.82</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  FINNGEN <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Malignant neoplasm of other and unspecified parts of tongue <br /> GWAS id :C3_TONGUENAS <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method P&amp;T <br /> PRS tuning parameter: P&lt;=3.98e-05 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr>





                <td class="align-middle">UKB GWAS (FINNGEN)</td>


                <td class="align-middle" data-toggle="popover" data-content="Malignant neoplasm of other and unspecified parts of tongue"
                    data-trigger="hover">Malignant neoplasm of other an..</td>



                <td class="align-middle" data-toggle="popover" data-content="s=1;Lambda=0.001"
                    data-trigger="hover">Lassosum</td>

                <td class="align-middle">3339172</td>
                <td class="align-middle">0.0031</td>
                <td>0.00541</td>
                <td class="align-middle">0.0826</td>
                <td class="align-middle">0.549</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.524, 0.574</td>
                <td class="align-middle"
                    style="white-space:nowrap;">6.05e-01</td>
                <td class="align-middle">6.38</td>

                <td class="align-middle">0.414</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.0857,1.21</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>










                <td data-toggle="popover" data-trigger="hover" title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  FINNGEN <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Malignant neoplasm of other and unspecified parts of tongue <br /> GWAS id :C3_TONGUENAS <br /> GWAS URL: http://www.nealelab.is/uk-biobank <br /> GWAS method Lassosum <br /> PRS tuning parameter: s=1;Lambda=0.001 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=PRSWEB_PHECODE145.2_C3-TONGUENAS_LASSOSUM_MGI_20200114&type=weight"
                        target="_blank"><i class="fas fa-download"></i></a></a> -- </td>




            </tr>
            <tr id="hidethis" style="display:none;" class="option1">




                <td class="align-middle">UKB GWAS (PheCode)</td>

                <td class="align-middle">Cancer of tongue</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=5e-06"
                    data-trigger="hover">P_5e-06</td>

                <td class="align-middle">8</td>
                <td class="align-middle">0.23</td>
                <td>0.00153</td>
                <td class="align-middle">0.0828</td>
                <td class="align-middle">0.525</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.5, 0.55</td>
                <td class="align-middle"
                    style="white-space:nowrap;">9.97e-01</td>
                <td class="align-middle">1.2</td>

                <td class="align-middle">1.38</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.589,2.8</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  PHEWAS-CODES <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Cancer of tongue <br /> GWAS id :UKBB_SAIGE_HRC_X145.2 <br /> GWAS URL: ftp://share.sph.umich.edu/UKBB_SAIGE_HRC/ <br /> GWAS method P_5e-06 <br /> PRS tuning parameter: P&lt;=5e-06 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis" style="display:none;" class="option1">




                <td class="align-middle">UKB GWAS (PheCode)</td>

                <td class="align-middle">Cancer of tongue</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=5e-05"
                    data-trigger="hover">P_5e-05</td>

                <td class="align-middle">80</td>
                <td class="align-middle">0.48</td>
                <td>5.42E-4</td>
                <td class="align-middle">0.0828</td>
                <td class="align-middle">0.525</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.5, 0.55</td>
                <td class="align-middle"
                    style="white-space:nowrap;">1.44e-01</td>
                <td class="align-middle">12.2</td>

                <td class="align-middle">0.976</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.358,2.15</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  PHEWAS-CODES <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Cancer of tongue <br /> GWAS id :UKBB_SAIGE_HRC_X145.2 <br /> GWAS URL: ftp://share.sph.umich.edu/UKBB_SAIGE_HRC/ <br /> GWAS method P_5e-05 <br /> PRS tuning parameter: P&lt;=5e-05 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis2" style="display:none;" class="option2">






                <td class="align-middle">UKB GWAS (PheCode)</td>

                <td class="align-middle">Cancer of tongue</td>



                <td class="align-middle" data-toggle="popover" data-content="P&lt;=7.94e-05"
                    data-trigger="hover">P&amp;T</td>

                <td class="align-middle">131</td>
                <td class="align-middle">0.94</td>
                <td>0.00291</td>
                <td class="align-middle">0.0827</td>
                <td class="align-middle">0.534</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.509, 0.56</td>
                <td class="align-middle"
                    style="white-space:nowrap;">1.32e-02</td>
                <td class="align-middle">19.3</td>

                <td class="align-middle">0.973</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.357,2.15</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  PHEWAS-CODES <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Cancer of tongue <br /> GWAS id :UKBB_SAIGE_HRC_X145.2 <br /> GWAS URL: ftp://share.sph.umich.edu/UKBB_SAIGE_HRC/ <br /> GWAS method P&amp;T <br /> PRS tuning parameter: P&lt;=7.94e-05 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;PRS associated with decreased risk for trait of interest ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>
            <tr id="hidethis2" style="display:none;" class="option2">






                <td class="align-middle">UKB GWAS (PheCode)</td>

                <td class="align-middle">Cancer of tongue</td>



                <td class="align-middle" data-toggle="popover" data-content="s=0.9;Lambda=0.001624"
                    data-trigger="hover">Lassosum</td>

                <td class="align-middle">5363073</td>
                <td class="align-middle">0.55</td>
                <td>0.00349</td>
                <td class="align-middle">0.0827</td>
                <td class="align-middle">0.534</td>
                <td class="align-middle"
                    style=" word-wrap: break-word;word-break: break-word;">0.509, 0.559</td>
                <td class="align-middle"
                    style="white-space:nowrap;">9.75e-01</td>
                <td class="align-middle">2.17</td>

                <td class="align-middle">0.966</td>
                <td class="align-middle" style=" word-wrap: break-word;
                word-break: break-word;">0.354,2.13</td>









                <td class="align-middle" style=" position:sticky;left:0px;">--</td>






















                <td data-toggle="popover" data-trigger="hover"
                    title="PRSweb LD reference : UKB <br />PRSweb date 2020-01-14 <br /> GWAS source  PHEWAS-CODES <br /> GWAS reference: UKB_GWAS <br /> GWAS phenotype: Cancer of tongue <br /> GWAS id :UKBB_SAIGE_HRC_X145.2 <br /> GWAS URL: ftp://share.sph.umich.edu/UKBB_SAIGE_HRC/ <br /> GWAS method Lassosum <br /> PRS tuning parameter: s=0.9;Lambda=0.001624 <br /> PRS evaluation inMGI <br /> Genome build:: GRCh37/hg19"><a
                        class="intro"
                        href="/displayData/downloadFile?filename=&type=weight"><i
                            class="fas fa-download"></i></a> <a href="#" title="No nominal significant association observed trait of interest and PRS ;"><i
                        class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a></td>




            </tr>



            </tbody>
        </table>
    </div>






</body>
</html>
