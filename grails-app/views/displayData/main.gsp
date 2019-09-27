<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <asset:javascript src="jquery-3.3.1.js"/>
    <asset:javascript src="jquery.tablesorter.min.js"/>
    <asset:javascript src="jquery.tablesorter.widgets.js"/>
    <asset:stylesheet src="theme.blue.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>


    <g:set var="entityName" value="${message(code: 'displayData.label', default: 'DisplayData')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <STYLE>
    div.drilldown { display: inline-block; }
    </STYLE>
    <g:javascript library='jquery'>


            $(function () {


                var pcode= '${inputprscode}';
                var pstudy = '${inprsstudy}';
                //console.log(pstudy);
                $('#select_phenomes').append(new Option(pstudy, "value",true,true));

                 var select = document.getElementById("select_desc");
                    for(var i = 0;i < select.options.length;i++){
                       // console.log(select.options[i].value);
                        if(select.options[i].value == pcode ){
                            select.options[i].selected = true;
                        }
                    }


                     if(performance.navigation.type == 2){
                                               location.reload(true);
                                            }


               document.getElementById('pheinfo').style.visibility = "hidden";
           $('[data-toggle="popover"]').popover();

               $("#pheinfo").tablesorter({
                             theme : 'jui',
                            sortList: [[4,1]]

                          });


                 var jsonData = JSON.parse('${resultJson}');
                 //var uniqPhecodesDesc =JSON.parse('${uniqPhecodesDesc}');


                  $("#select_desc").change(function () {
                    var prswt = $(this).val();
                    //console.log("User selection");
                    //console.log(prswt);
                    var phenocat = "Neoplasms";

                    //console.log(jsonData);
                    $('#select_phenomes').empty();


                    var phelist = [];
                     var methodlist = [];

                    for (var i = 0; i < jsonData.length; i++) {
                            var counter = jsonData[i];
                            var phnm1 = counter.phenocatname;
                            var phid1 = counter.phenocatid;
                            var resobj1 = counter.phecodeObj;

                            //remove all child nodes
                              for (var j = 0; j < resobj1.length; j++) {
                                    var phenome = resobj1[j].phenome;
                                    var prsmethod = resobj1[j].prsmethod;
                                    var phecode = resobj1[j].phecode.replace('X','');
                                   // console.log("input : " + prswt +" loop :"+phecode+";");
                                    //console.log("input : " + prswt.replace(/\s/g, "").length +" loop : "+phecode.replace(/\s/g, "").length);



                                    if (phecode == prswt)
                                        {
                                            if(!phelist.includes(phenome))
                                                {
                                                    phelist.push(phenome);
                                                    var line = '<option value="'+phenome+'">'+phenome+'</option>';
                                                    var newOption = line;

                                                    //console.log(newOption);
                                                    $('#select_phenomes').append(newOption);
                                                    $('#select_phenomes').trigger("chosen:updated");


                                                }




                                        }

                             }


                        }

                });






            });

            function displayInfo(filename)
            {

                        //console.log("aloha from displayInfo function log");
                       // console.log(filename);

                         $.ajax( {
                            url: "${createLink(controller:'displayData',action:'getWtFileInfo')}",
                            type: "POST",
                            async: false,
                            data: { val1: filename},


                            success: myCallback,
                            error: function() {
                            alert("fail");
                            }
                            } );

                    };

            function displayTable2() {

                    var prswtsel = $("#select_desc").val();
                    var phenomesel = $('#select_phenomes').val();


                     $.ajax( {
                            url: "${createLink(controller:'displayData',action:'getTableData')}",
                            type: "POST",
                            async: false,
                            data: { prswt:prswtsel,phenome:phenomesel},


                            success: myCallback,
                            error: function() {
                            alert("fail");
                            }
                            } );


            }




            function displayTable() {
                var jsonData = JSON.parse('${resultJson}');


                    var prswtsel = $("#select_desc").val();
                    var phenocatsel = $("#select_PRS_code").val();
                    var phenomesel = $('#select_phenomes').val();
                     var oddssel = $('#select_odds').val();

                     console.log(oddssel);


                    var tbodyup = '';

                     for (var i = 0; i < jsonData.length; i++) {
                            var counter = jsonData[i];



                            var phnm1 = counter.phenocatname;
                            var phid1 = counter.phenocatid;
                            var resobj1 = counter.phecodeObj;
                            var linkpage = '';
                            var pval = '';
                            var or ='';
                            var orci = '';
                            var nomsig = '';
                            var warreveff = '';
                            var perunpow='';
                            var quaanal='';
                            var warn='';
                            var signline = '';
                            var prsdesc= '';

                            //remove all child nodes
                              for (var j = 0; j < resobj1.length; j++) {

                                   var phenome = resobj1[j].phenome;
                                   var phecode = resobj1[j].phecode.replace('X','');
                                   var model = resobj1[j].model;
                                   var recid = resobj1[j].pid;
                                   // console.log(recid);



                                   // console.log("input : " + prswt +" loop :"+phecode+";");
                                    //console.log("input : " + prswt.replace(/\s/g, "").length +" loop : "+phecode.replace(/\s/g, "").length);



                                    if (phecode === prswtsel && phenome === phenomesel)
                                        {
                                            //console.log(resobj1[j].prsweb);
                                             if(resobj1[j].prsweb === 'TRUE')
                                                {
                                                    //console.log("in prsweb loop");
                                                    //linkpage =  '<a class="intro"  href="<g:createLink action="showGraph" params="${[inputprscode:phecode, inprscat: prssrc ,inprsstudy:phenomes]}"/>">link</a></li>';
                                                    linkpagedr = '${createLink(action:'showGraph')}?phecode='+ phecode+'&model='+model+'&phenome='+phenome+'&id='+recid;

                                                   linkpage ='<a class="intro" href="'+linkpagedr +'">link</a>';

                                                  // console.log(linkpage);



                                                }
                                                 else
                                                {
                                                    linkpage = "--"

                                                    }


                                           /*      if(phenomesel === 'MGI')
                                                     {

                                                         pval=resobj1[j].mgip;
                                                         or=resobj1[j].mgior;
                                                         orci=resobj1[j].mgiorci;


                                                     }
                                                 else
                                                     {
                                                         pval=resobj1[j].ukbp;
                                                         or=resobj1[j].ukbor;
                                                         orci=resobj1[j].ukborci;


                                                     }*/

                                            prsdesc = resobj1[j].desc;

                                            if(prsdesc.length > 30)
                                                {
                                                    prsdesc = prsdesc.substring(0,30);
                                                }
                                            else
                                                {
                                                    prsdesc=prsdesc;
                                                }
                                             pval=resobj1[j].pval;
                                             or=resobj1[j].orval;
                                             orci=resobj1[j].orcival;
                                             nomsig =resobj1[j].nomsig;
                                             warreveff = resobj1[j].warreveff;
                                             perunpow=resobj1[j].perunpow;
                                             quaanal=resobj1[j].quaanal;



                                             if(nomsig == "FALSE" || warreveff== "TRUE")
                                                 {
                                                     console.log(nomsig.length);
                                                     console.log(resobj1[j].model);
                                             console.log(resobj1[j].prsmethod);
                                              console.log(resobj1[j].nomsig);
                                               console.log(resobj1[j].warreveff);
                                               console.log("***************************************");

                                                     if(nomsig == "FALSE")
                                                         {

                                                             warn = 'No nominal significant association observed trait of interest and PRS ; ';
                                                         }
                                                     if(warreveff == "TRUE")
                                                         {

                                                             warn = 'PRS associated with decreased risk for trait of interest ; '+warn;
                                                         }

                                                 signline ='<a href="#" title="'+ warn+'"> <i class="fas fa-exclamation-triangle" style="color:#d39e00;"></i> </a>';

                                                 }

                                             var filename = resobj1[j].prswebprefix;

                                            var filepathlink = '${createLink(action:'downloadFile')}?filename='+ filename+'&type=weight';

                                             var filelinkpage ='<a class="intro" href="'+filepathlink +'"><i class="fas fa-download"></i></a>';
                                             var pid = "mypopup"+j;



                                             var popuplink = '<span onclick="displayInfo(\''+filename+'\')"> <i class="fa fa-info-circle"></i> </span>';

                                             var topor;
                                             var topci;
                                             var topci2;

//topor:en.topor,topci1: en.toporci1,topci2:en.toporci2,tunp:en.tunparam,genob:en.genomebuild, topor2:en.topor2,topci12:en.toporci12,topci22:rn.toporci22,topor5:en.topor5,topci15:en.toporci15,topci25:rn.toporci25]


                                             if(oddssel == '1')
                                                 {
                                                        var topor = resobj1[j].topor;
                                                        var topci= resobj1[j].topci1;
                                                        var topci2=resobj1[j].topci2;

                                                          document.getElementById("headId").innerHTML = "Odds Ratio Top 1% vs Rest";

                                                 }
                                             else if(oddssel == '2')
                                                 {
                                                        var topor = resobj1[j].topor2;
                                                        var topci= resobj1[j].topci12;
                                                        var topci2=resobj1[j].topci22;
                                                         document.getElementById("headId").innerHTML = "Odds Ratio Top 2% vs Rest";


                                                 }
                                             else
                                                 {
                                                          var topor = resobj1[j].topor5;
                                                        var topci= resobj1[j].topci15;
                                                        var topci2=resobj1[j].topci25;
                                                         document.getElementById("headId").innerHTML = "Odds Ratio Top 5% vs Rest";





                                                 }



                                                    //onsole.log(signline);



                                                    var poptext = "PRSweb reference :"+resobj1[j].prswebprefix+"\n"
                                                                    +"PRSweb LD reference :"+resobj1[j].genld+"\n"
                                                                    +"PRSweb date :"+resobj1[j].datecreated+"\n"
                                                                    +"GWAS source :"+resobj1[j].srcdata+"\n"
                                                                    +"GWAS reference :"+resobj1[j].refdata+"\n"
                                                                    +"GWAS phenotype :"+resobj1[j].desc+"\n"
                                                                    +"GWAS id :"+resobj1[j].prefixdata+"\n"
                                                                    +"GWAS URL :"+resobj1[j].urldata+"\n"
                                                                    +"GWAS method :"+resobj1[j].prsmethod+"\n"
                                                                    +"PRS tuning parameter:"+resobj1[j].tunp+"\n"
                                                                     +"PRS evaluation in:"+resobj1[j].phenome+"\n"
                                                                    +"Genome build:"+resobj1[j].genob+"\n";

                                                    console.log(resobj1[j].logp);


                                                    var pval  = Math.pow(10, (-resobj1[j].logp)).toPrecision(2);




                                                                    var str = '<tr>'
                                                                        +'<td>'+resobj1[j].model+'</td>'
                                                                        +'<td>'+prsdesc+'</td>'
                                                                        +'<td>'+resobj1[j].prsmethod+'</td>'
                                                                        +'<td>'+resobj1[j].tunp+'</td>'
                                                                        +'<td>'+resobj1[j].snp+'</td>'
                                                                        +'<td>'+pval+'</td>'
                                                                        +'<td>'+resobj1[j].r2nag.toPrecision(2)+'</td>'
                                                                        +'<td>'+resobj1[j].brier+'</td>'
                                                                        +'<td>'+resobj1[j].auc+'</td>'
                                                                        +'<td>'+resobj1[j].aucci+'</td>'
                                                                        +'<td>'+resobj1[j].hom_p+'</td>'
                                                                        +'<td>'+resobj1[j].hom_chi+'</td>'


                                                                        +'<td>'+topor+'</td>'
                                                                        +'<td>'+topci+','+topci2+'</td>'

                                                                        +'<td>'+linkpage+'</td>'
                                                                        +'<td data-toggle="popover" data-trigger="hover" title="'+poptext+'">' + filelinkpage+ signline+'</td>'


                                                                        +'</tr>';

                                            tbodyup = tbodyup+str;
signline ='';







                                        }


                              }

                    }

                                //console.log(tbodyup);

                                //$('#pheinfo tbody').html(tbodyup).tablesorter();
                              // document.getElementById('pheinfo').style.visibility = "visible";
                               //$('#pheinfo').tablesorter();
                                $("#pheinfo").find('tbody').empty();

                               $("#pheinfo").trigger("destroy").append(tbodyup).tablesorter({

                                 theme : 'blue',

                                sortList: [[6,1]],
                                widthFixed : true,

                                // initialize zebra striping and filter widgets
                                widgets: ["zebra", "filter"],

                                widgetOptions : {
                                filter_cssFilter   : '',

                              // If there are child rows in the table (rows with class name from "cssChildRow" option)
                              // and this option is true and a match is found anywhere in the child row, then it will make that row
                              // visible; default is false
                              filter_childRows   : false,

                              // if true, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                              // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                              filter_hideFilters : false,

                              // Set this option to false to make the searches case sensitive
                              filter_ignoreCase  : true,

                              // jQuery selector string of an element used to reset the filters
                              filter_reset : '.reset',

                              // Use the $.tablesorter.storage utility to save the most recent filters
                              filter_saveFilters : true,

                              // Delay in milliseconds before the filter widget starts searching; This option prevents searching for
                              // every character while typing and should make searching large tables faster.
                              filter_searchDelay : 300,

                              // Set this option to true to use the filter to find text from the start of the column
                              // So typing in "a" will find "albert" but not "frank", both have a's; default is false
                              filter_startsWith  : false,


                             filter_functions : {

                                // Add select menu to this column
                                // set the column value to true, and/or add "filter-select" class name to header
                                // '.first-name' : true,

                                // Exact match only
                                1 : function(e, n, f, i, $r, c, data) {
                                  return e === f;
                                },

                                // Add these options to the select dropdown (regex example)
                                2 : {
                                  "p&T" : function(e, n, f, i, $r, c, data) { return e =='p&T'; },
                                  "P_5e-05" : function(e, n, f, i, $r, c, data) { return e =='P_5e-05'; }

                                },

                                // Add these options to the select dropdown (numerical comparison example)
                                // Note that only the normalized (n) value will contain numerical data
                                // If you use the exact text, you'll need to parse it (parseFloat or parseInt)
                               3 : {
                                  "< $10"      : function(e, n, f, i, $r, c, data) { return n < 10; },
                                  "$10 - $100" : function(e, n, f, i, $r, c, data) { return n >= 10 && n <=100; },
                                  "> $100"     : function(e, n, f, i, $r, c, data) { return n > 100; }
                                }
                              }
                              }





                          });

                      document.getElementById('pheinfo').style.visibility = "visible";











                        }


            function myCallback(response) {
                 var result = response;
                console.log("***********************************");
                console.log(result.split(":")[0]);

                var pid = "mypopup"+result.split(":")[0].trim();
                //window.alert(result.split(":")[1]);


                  $('button').attr('data-content', result.split(":")[1]);
                var popover = $('button').data('popover');

                var popover = $('#pid').data('bs.popover');

                console.log(popover);
                popover.setContent();
                popover.$tip.addClass(popover.options.placement);


               //document.getElementById("myPopup").innerHTML = result;


                    //popup.classList.toggle("show");

                };




    </g:javascript>

</head>
<body>
<a href="#create-displayData" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">

</div>
<div id="create-displayData" class="content scaffold-create mt-5" role="main">
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card"><div class="card-body">
                    <h1>Overview</h1>
                    Integrating published and freely available genome-wide association studies (GWAS) summary statistics from multiple sources: published GWAS, the NHGRI-EBI GWAS Catalog, or UKB-based GWAS, we created an online repository for polygenic risk scores (PRS) for common cancer traits. Our framework condenses these summary statistics into PRS using linkage disequilibrium pruning and p-value thresholding (fixed or data-adaptively optimized thresholds), or penalized, genome-wide effect size weighting.
                    We evaluate them in the cancer-enriched cohort of the Michigan Genomics Initiative (MGI), a longitudinal biorepository effort at Michigan Medicine, and in the population-based UK Biobank Study (UKB). For each PRS construct, measures on performance, calibration, and differentiation are provided.
                    Besides the cancer PRS evaluation in MGI and UKB, the PRSweb platform features construct downloads, risk evaluation in the top percentiles as well as phenome-wide PRS association studies (PRS PheWAS) for a subset of PRS that are predictive for the primary cancer.
                <br/>
                    For more information, see our <a href="https://doi.org/10.1101/384909" target="_blank">Previous publication on skin cancer PRS</a> and the "Method" tab on top of this page.


                </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">   <div class="row">
        <div class="col-12 mt-2">
            <div class="card"><div class="card-body">
                %{-- <g:form controller="DisplayData" action="showGraph" method="post" id="upform" name="upform" enctype="multipart/form-data">--}%
                %{--<div class="drilldown mr-2">
               <label for="select_PRS_code" class="mb-0">Phenotype Category</label><br/>
                    <g:select name="phenocat" id="select_PRS_code" class="form-control" from="${phenocat.phename}">

                            <option value="${phenocat.phename}">${phenocat.phename}</option>
                    </g:select>
                </div>--}%

                <div class="drilldown mr-2">
                    <label for="select_desc" class="mb-0"> Cancer Trait</label>
                    <select name="select_desc" id="select_desc" class="form-control">
                        <option value="">Select Cancer Site/Trait</option>
                        <g:each in="${phecodeuniquedata}" status="i" var="dm">
                            <option value="${dm.phecodeid}">${dm.phecodedesc}(${dm.phecodeid})</option>
                        </g:each>
                    </select>

                </div>

                <div class="drilldown mr-2">
                    <label for="select_phenomes"  class="form-check-label">Evaluation Cohort</label>
                    <g:select name="select_phenomes" id="select_phenomes" class="form-control" from="" noSelection="['':'- Choose PRS weights-']">
                        <option value="${drilldown}">${drilldown.phenomes} </option>
                    </g:select>
                </div>

                <div class="drilldown mr-2">
                    <label for="select_odds"  class="form-check-label">Odds Ratio Top</label>
                    <select name="select_odds" id="select_odds" class="form-control">
                        <option value="1"> 1% vs Rest </option>
                        <option value="2"> 2% vs Rest </option>
                        <option value="5"> 5% vs Rest </option>
                    </select>
                </div>





                <div class="drilldown mr-2">
                    %{--<g:submitButton name="Search" class="submit"/>--}%

                    <button onclick="displayTable()">Show table</button>

                </div>


            </div>

                <div class="table-bordered table-responsive fixed-table-body text-center">
                    <table class="table-striped table-bordered table-light " style="border: 1px solid #ddd !important;" id='pheinfo'>
                        <thead class="thead-light">
                        <tr>
                            <th class="sorter-false"></th>
                            <th class="sorter-false"></th>
                            <th class="sorter-false"></th>
                            <th class="sorter-false"></th>
                            <th class="sorter-false"></th>
                            <th class="sorter-false">Association</th>
                            <th colspan="2" align="center"> Overall Performance</th>
                            <th colspan="2" align="center" class="sorter-false">Discrimination/AUC</th>
                            <th colspan="2" align="center" class="sorter-false"> Hosmer-lemeshow Test Statistics</th>

                            <th colspan="2" align="center" class="sorter-false" id="headId"> </span>Odds Ratio Top 1% vs Rest</th>
                            <th class="sorter-false"></th>
                            <th class="sorter-false"></th>

                        </tr>
                        <tr>
                            <th class="sorter-false"> GWAS Source<br/>/ Phenotype Model</th>
                            <th class="sorter-false">Phenotype Model <br/> Description</th>
                            <th data-column="P&T,Lassosum" class="filter-select filter-onlyAvail">Method</th>
                            <th class="filter-false">Tuning Parameter</th>
                            <th class="filter-false"># SNPs</th>
                            <th>P-value</th>
                            <th class="filter-false">Pseudo-R2</th>
                            <th class="filter-false">Brier Score</th>
                            <th class="filter-false">Estimate</th>
                            <th class="filter-false">95%CI</th>
                            <th class="filter-false">P</th>
                            <th class="filter-false">Chi-Square</th>
                            <th class="filter-false">Estimate</th>
                            <th class="filter-false">95 % CI</th>

                            <th class="sorter-false,filter-false">PRS PheWAS</th>
                            <th class="sorter-false,filter-false"> Download PRS</th>
                        </tr>
                        </thead>
                        <tbody id="insertfirsttable">



                        </tbody>


                    </table>
                </div>

            </div>
        </div></div>
    </div>


</div>





</body>
</html>
