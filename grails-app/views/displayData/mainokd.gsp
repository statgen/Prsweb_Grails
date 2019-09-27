<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <asset:javascript src="jquery-3.3.1.js"/>
        <asset:javascript src="jquery.tablesorter.min.js"/>
        <asset:stylesheet src="datatables.css" />


        <g:set var="entityName" value="${message(code: 'displayData.label', default: 'DisplayData')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <STYLE>
        div.drilldown { display: inline-block; }
        </STYLE>
        <g:javascript library='jquery'>

            $(function () {

                console.log("on the page function");

                $("select#select_PRS_code option").filter(function() {
                         return this.value == "Neoplasm";
             }).prop('selected', true);


               document.getElementById('pheinfo').style.visibility = "hidden";

               $("#pheinfo").tablesorter();


                 var jsonData = JSON.parse('${resultJson}');
                 var uniqPhecodesDesc =JSON.parse('${uniqPhecodesDesc}');




              /*  $("#select_PRS_code").change(function () {
                    var selectedItem = $(this).val();
                    var abc=$(this).val();
                    console.log(selectedItem);

                    var phelist = [];

                    for (var i = 0; i < uniqPhecodesDesc.length; i++) {
                            var counter = uniqPhecodesDesc[i];
                            var phnm = counter.phenocatname;
                            var phid = counter.phenocatid;
                            var resobj = counter.phecodetest;
                            if(phnm === selectedItem)
                                {
                                $('#select_desc').empty(); //remove all child nodes


                                    for (var j = 0; j < resobj.length; j++) {
                                        //console.log(resobj[j].phecodename);
                                        var line = '<option value="'+resobj[j].phecodeid+'">'+resobj[j].phecodename+ "("+resobj[j].phecodeid+")"+'</option>';
                                        var newOption = line;
                                        $('#select_desc').append(newOption);
                                        $('#select_desc').trigger("chosen:updated");
                                     }

                                 //THis part is hardcoded for the first record just to avaoid the loop to run thro for the first prsweight and when user selects the another one it will go thro the Jsondata to find the prsstudy value
   $                                                ('#select_phenomes').empty();
                                                    var linephe = '<option value="MGI">MGI</option>';
                                                    $('#select_phenomes').append(linephe);
                                                    $('#select_phenomes').trigger("chosen:updated");

                                }
                        }

                });*/


                  $("#select_desc").change(function () {
                    var prswt = $(this).val();
                    console.log("User selection");
                    console.log(prswt);
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
                                    console.log("input : " + prswt +" loop :"+phecode+";");
                                    //console.log("input : " + prswt.replace(/\s/g, "").length +" loop : "+phecode.replace(/\s/g, "").length);



                                    if (phecode == prswt)
                                        {
                                            if(!phelist.includes(phenome))
                                                {
                                                    phelist.push(phenome);
                                                    var line = '<option value="'+phenome+'">'+phenome+'</option>';
                                                    var newOption = line;
                                                    $('#select_phenomes').append(newOption);
                                                    $('#select_phenomes').trigger("chosen:updated");


                                                }




                                        }

                             }


                        }

                });






            });

            function displayTable() {
                var jsonData = JSON.parse('${resultJson}');


                    var prswtsel = $("#select_desc").val();
                    var phenocatsel = $("#select_PRS_code").val();
                    var phenomesel = $('#select_phenomes').val();

                    var tbodyup = '';

                     for (var i = 0; i < jsonData.length; i++) {
                            var counter = jsonData[i];

                            var recid = counter.id;
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
                            var signline = '-';

                            //remove all child nodes
                              for (var j = 0; j < resobj1.length; j++) {

                                   var phenome = resobj1[j].phenome;
                                   var phecode = resobj1[j].phecode.replace('X','');
                                   var model = resobj1[j].model;



                                   // console.log("input : " + prswt +" loop :"+phecode+";");
                                    //console.log("input : " + prswt.replace(/\s/g, "").length +" loop : "+phecode.replace(/\s/g, "").length);



                                    if (phecode === prswtsel && phenome === phenomesel)
                                        {
                                            console.log(resobj1[j].prsweb);
                                             if(resobj1[j].prsweb === 'TRUE')
                                                {
                                                    console.log("in prsweb loop");
                                                    //linkpage =  '<a class="intro"  href="<g:createLink action="showGraph" params="${[inputprscode:phecode, inprscat: prssrc ,inprsstudy:phenomes]}"/>">link</a></li>';
                                                    linkpagedr = '${createLink(action:'showGraph')}?phecode='+ phecode+'&model='+model+'&phenome='+phenome+'&id='+recid;

                                                   linkpage ='<a class="intro" href="'+linkpagedr +'">link</a>';

                                                   console.log(linkpage);



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
                                             pval=resobj1[j].pval;
                                             or=resobj1[j].orval;
                                             orci=resobj1[j].orcival;
                                             nomsig =resobj1[j].nomsig;
                                             warreveff = resobj1[j].warreveff;
                                             perunpow=resobj1[j].perunpow;
                                             quaanal=resobj1[j].quaanal;

                                             if(nomsig == "FALSE" || warreveff== "TRUE")
                                                 {
                                                     if(nomsig == "FALSE")
                                                         {

                                                             warn = 'No nominal significant association observed trait of interest and PRS ; ';
                                                         }
                                                     if(warreveff == "TRUE")
                                                         {

                                                             warn = 'PRS associated with decreased risk for trait of interest ; '+warn;
                                                         }

                                                 signline ='<a href="#" title="'+ warn+'"> <i class="fas fa-exclamation-triangle" style="color:#d39e00;"></i></a>';

                                                 }

                                             var filename = resobj1[j].prswebprefix;

                                            var filepathlink = '${createLink(action:'downloadFile')}?filename='+ filename;

                                             var filelinkpage ='<a class="intro" href="'+filepathlink +'">link</a>';




                                                    //onsole.log(signline);
                                            var str = '<tr>'
                                                +'<td>'+resobj1[j].model+'</td>'
                                                +'<td>'+resobj1[j].desc+'</td>'
                                                +'<td>'+resobj1[j].snp+'</td>'
                                                +'<td>'+resobj1[j].r2nag+'</td>'
                                                +'<td>'+resobj1[j].brier+'</td>'
                                                +'<td>'+resobj1[j].auc+'</td>'
                                                +'<td>'+resobj1[j].aucci+'</td>'
                                                +'<td>'+resobj1[j].hom_p+'</td>'
                                                +'<td>'+resobj1[j].hom_chi+'</td>'
                                                +'<td>'+resobj1[j].prsmethod+'</td>'

                                                +'<td>'+pval+'</td>'
                                                +'<td>'+or+'</td>'
                                                +'<td>'+orci+'</td>'
                                                +'<td>'+linkpage+'</td>'
                                                +'<td>'+ signline + filelinkpage+'</td>'

                                                +'</tr>';

                                            tbodyup = tbodyup+str;








                                        }


                              }

                    }

                                //console.log(tbodyup);

                                //$('#pheinfo tbody').html(tbodyup).tablesorter();
                              // document.getElementById('pheinfo').style.visibility = "visible";
                               //$('#pheinfo').tablesorter();
                                $("#pheinfo").find('tbody').empty()

                               $("#pheinfo").trigger("destroy").append(tbodyup).tablesorter();

                      document.getElementById('pheinfo').style.visibility = "visible";











                        }





        </g:javascript>

    </head>
    <body>
        <a href="#create-displayData" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">

        </div>
        <div id="create-displayData" class="content scaffold-create" role="main">
                        <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                    <div class="card"><div class="card-body">
                        This webpage provides detailed PheWAS results for three skin cancer subtypes: basal cell carcinoma, squamous cell carcinoma, and melanoma. PRS results are available for PRS constructed using different weights (from the latest GWAS or the NHGRI-EBI GWAS catalog). These results are provided for Michigan Genomics Initiative (MGI), a longitudinal biorepository effort within Michigan Medicine, and for the population-based UK Biobank dataset.</p>
                        For more information, see <a href="https://doi.org/10.1101/384909">our associated publication</a>.</p>
                        <p class="mb-0">Future developments of this web tool will include PheWAS results for additional cancers.</p>
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
                               <label for="select_desc" class="mb-0">PRS Weights</label>
                                    <g:select name="select_desc" id="select_desc" class="form-control" from="${resultJson}" noSelection="['':'-Choose Phenotype Category-']">
                                        <option value="">Choose Phenotype Category</option>
                                    </g:select>



                                </div>

                               <div class="drilldown mr-2">
                                   <label for="select_phenomes"  class="form-check-label">PRS Study</label>
                                    <g:select name="select_phenomes" id="select_phenomes" class="form-control" from="" noSelection="['':'- Choose PRS weights-']">
                                        <option value="${drilldown}">${drilldown.phenomes} </option>
                                    </g:select>
                                </div>




                            <div class="drilldown mr-2">
                                    %{--<g:submitButton name="Search" class="submit"/>--}%

                                    <button onclick="displayTable()">Show table</button>

                                </div>


                    </div>

                          <div class="table-responsive fixed-table-body">
                                <table class="table-striped table-light " id='pheinfo'>
                                    <thead class="thead-dark">
                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th colspan="2" align="center">Overall Performance</th>
                                        <th colspan="2" align="center">Discrimination/AUC</th>
                                        <th colspan="2" align="center">Calibration</th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                    <tr>
                                        <th>GWAS Source<br/> Phenotype Model</th>
                                        <th>Description</th>
                                        <th>N SNPS</th>
                                        <th>Pseudo-R2</th>
                                        <th>Brier Score</th>
                                        <th>Estimate</th>
                                        <th>95%CI</th>
                                        <th>P</th>
                                        <th>Chi-Square</th>
                                        <th>Method</th>
                                        <th>P</th>
                                        <th>Odds Ratio</th>
                                        <th>Odds Ratio CI</th>
                                        <th>PRS PheWAS</th>
                                        <th>Significance</th>
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
