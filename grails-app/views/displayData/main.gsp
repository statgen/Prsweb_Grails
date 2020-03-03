<!DOCTYPE html>
<html>
<head>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-143045158-2"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'UA-143045158-2');
    </script>

    <meta name="layout" content="main" />
    <asset:javascript src="jquery-3.3.1.js"/>
    <asset:javascript src="jquery.tablesorter.min.js"/>
    <asset:javascript src="jquery.tablesorter.widgets.js"/>
    <asset:javascript src="select2.min.js"/>
    <asset:stylesheet src="theme.blue.css" />
    <asset:stylesheet src="select2.css" />

    <asset:stylesheet src="magnific-popup.css"/>
    <asset:javascript src="jquery.magnific-popup.js" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>


    <g:set var="entityName" value="${message(code: 'displayData.label', default: 'DisplayData')}" />
    <title>PRSweb</title>
    <STYLE>

    .row:before, .row:after {display: none !important;}
    div.drilldown { display: inline-block; }

    .center {
        display: flex;
        justify-content: space-between;

    }

    a {
        text-decoration: none;
    }


    </STYLE>
    <g:javascript library='jquery'>


            $(function () {


                $("#select_desc").select2({
                theme: "classic"
                });
                $("#select_phenomes").select2({theme: "classic",minimumResultsForSearch: -1});
                $("#select_odds").select2({theme: "classic",minimumResultsForSearch: -1});

                 $('.image-link').magnificPopup({
              type:'image'
                 });

                var pcode= '${inputprscode}';
                var pstudy = '${inprsstudy}';
                //console.log(pstudy);


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


               //document.getElementById('pheinfo').style.visibility = "hidden";
           $('[data-toggle="popover"]').popover();

               $("#pheinfo").tablesorter({
                             theme : 'jui',
                            sortList: [[4,1]]

                          });


                 var jsonData = JSON.parse('${resultJson}');



                $("#select_desc").change(function () {
                var prswt = $(this).val();
                console.log("User selection");
                console.log(prswt);
                 console.log($("#select_phenomes").val().length);

                 var phenlen = $("#select_phenomes").val().length;
                 var phenval = $("#select_phenomes").val();
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
                                                    if(phenlen == 0 )
                                                        {
                                                            console.log("zero legth loop");

                                                             var line = '<option value="'+phenome+'">'+phenome+'</option>';

                                                        }
                                                    else
                                                        {
                                                            console.log("else loop");
                                                            console.log(phenome);
                                                            console.log($("#select_phenomes").val());
                                                            if(phenval == phenome )
                                                                {

                                                                    var line = '<option selected value="'+phenome+'">'+phenome+'</option>';

                                                                }
                                                            else
                                                                {
                                                                    var line = '<option value="'+phenome+'">'+phenome+'</option>';

                                                                }

                                                        }

                                                var newOption = line;

                                                //console.log(newOption);
                                                $('#select_phenomes').append(newOption);
                                                $('#select_phenomes').trigger("chosen:updated");


                                            }




                                    }

                         }


                    }

                });


                $("#select_phenomes").change(function () {
                      var cohort = $(this).val();
                console.log("**********************************************");
                console.log(cohort);
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



                            // var jsonData =JSON.parse('${json}');

                              console.log(typeof jsonData);







                            var tbodyup = '';

                             for (var i = 0; i < json.length; i++) {
                                    var counter = json[i];
                                   // console.log(counter);


                                     var phecodeid = counter.phecodeid;
                                        var phecodedesc = counter.phdesc;
                                        console.log(phecodedesc);

                                         console.log(descval);
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


                /*  for (var i = 0; i < jsonData.length; i++) {
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
                                console.log("phenome: "+phenome +" phecode : "+phecode);



                                if (prsmethod == cohort)
                                    {
                                        if(!phelist.includes(phenome))
                                            {
                                                phelist.push(phenome);
                                                var line = '<option value="'+phecode+'">'+phenome+'</option>';
                                                var newOption = line;

                                                //console.log(newOption);
                                                $('#select_phenomes').append(newOption);
                                                $('#select_phenomes').trigger("chosen:updated");


                                            }




                                    }

                         }


                    }*/


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
    // +'<td>'+resobj1[j].r2nag.toPrecision(2)+'</td>'
    +'<td>'+resobj1[j].r2nag+'</td>'
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
                theme: 'blue',
                widthFixed: true,
                  sortList: [[6,1]],

                widgets: ['zebra', 'stickyHeaders', 'filter'],
                widgetOptions : {
                    // Use the $.tablesorter.storage utility to save the most recent filters
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

                      document.getElementById('pheinfo').style.visibility = "visible";











                        }


            function createLink(response){
                     var prswtsel = $("#select_desc").val();
                    var phenocatsel = $("#select_PRS_code").val();
                    var phenomesel = $('#select_phenomes').val();
                     var oddssel = $('#select_odds').val();

                      var filepathlink = '${createLink(action:'displayTableOld')}?select_desc='+ prswtsel+'&select_phenomes='+phenomesel+'&select_odds='+oddssel;
                      window.location.href =filepathlink;



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
<div id="create-displayData" class="content scaffold-create" role="main">
    %{--<div class="container-fluid">

        <h1 class="font-weight-light text-center text-lg-left mt-4 mb-0">Overview</h1>


        <div class="row text-center text-lg-left">

            <div class="col-lg-3 col-md-4 col-6">
                <a href="#" class="d-block mb-4 h-200">
                    <img class="img-fluid img-thumbnail" src="${resource(dir: 'images', file: 'tabledata.png')}" alt="">
                </a>
            </div>
            <div class="col-lg-3 col-md-4 col-6">
                <a href="#" class="d-block mb-4 h-100">
                    <img class="img-fluid img-thumbnail" src="${resource(dir: 'images', file: 'prs.png')}" alt="">
                </a>
            </div>
            <div class="col-lg-3 col-md-4 col-6">
                <a href="#" class="d-block mb-4 h-100">
                    <img class="img-fluid img-thumbnail" src="${resource(dir: 'images', file: 'weightfile.png')}" alt="">
                </a>
            </div>


        </div>

    </div>--}%
    <!-- /.container -->
    <div class="container-fluid text-center" style="background-color: white; margin-left: 5px;">

        <h1>Overview</h1>









        <div class="row mx-auto my-auto" >


                <div class="col-sm-4 col-md-4 col-lg-4">
                    <div class="card border-dark">
                        <a href="${createLink(action:'displayTableOld')}?select_desc=174.1&select_phenomes=MGI&select_odds=1" class="btn stretched-link" target="_blank">​<picture> <img  src="${resource(dir: 'images', file: 'tabledata.png')}" alt="GSE" class="img-fluid img-thumbnail"   /></picture></a>
                        <div class="card-block">

                        </div>
                        <div class="card-footer">
                            <a href="${createLink(action:'displayTable')}?select_desc=174.1&select_phenomes=MGI&select_odds=1" class="btn stretched-link" target="_blank">PRS Evaluation Table </a>

                        </div>
                    </div>
                </div>
                <div class="col-sm-4 col-md-4 col-lg-4">
                    <div class="card border-dark" >

                        <a href="${createLink(action:'showGraphSep')}?phecode=174.1&model=PUBMED-29059683&phenome=MGI&id=578" class="btn stretched-link" target="_blank"><picture><img src="${resource(dir: 'images', file: 'prs2.png')}" alt="GSE" class="img-fluid img-thumbnail"   /></picture></a>

                        <div class="card-block">

                        </div>
                        <div class="card-footer">
                            <a href="${createLink(action:'showGraphSep')}?phecode=174.1&model=PUBMED-29059683&phenome=MGI&id=578" class="btn stretched-link" target="_blank">PRS PheWAS </a>



                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4 col-lg-4">
                    <div class="card border-dark" >
                        <a href="${resource(dir: 'images', file: 'weightfile.png')}" class="image-link" class="btn stretched-link" ><picture><img src="${resource(dir: 'images', file: 'weightimage.png')}" alt="GSE" class="img-fluid img-thumbnail" /></picture></a>


                        <div class="card-block">

                        </div>
                        <div class="card-footer">
                            <a href="${resource(dir: 'images', file: 'weightfile.png')}" class="image-link" class="btn stretched-link" >PRS Weight File</a>


                        </div>
                    </div>
                </div>

        </div>
    </div>

    <div class="container-fluid">
        <div class="row">
            <div class="col-12 mt-2">
                <div class="card"><div class="card-body">

                    Integrating published and freely available genome-wide association studies (GWAS) summary statistics from multiple sources (published GWAS, the NHGRI-EBI GWAS Catalog, or UKB-based GWAS), we created an online repository for polygenic risk scores (PRS) for common cancer traits. Our framework condenses these summary statistics into PRS using linkage disequilibrium pruning and p-value thresholding (fixed or data-adaptively optimized thresholds) or penalized, genome-wide effect size weighting. We evaluate them in the cancer-enriched cohort of the Michigan Genomics Initiative (MGI), a longitudinal biorepository effort at Michigan Medicine, and in the population-based UK Biobank Study (UKB). For each PRS construct, measures on performance, calibration, and discrimination are provided. Beyond the cancer PRS evaluation in MGI and UKB, the PRSweb platform features construct downloads, risk evaluation in the top percentiles, and phenome-wide PRS association studies (PRS-PheWAS) for a subset of PRS that are predictive for the primary cancer. <br/>
                    For more information, see our bioRxiv preprint  <a href="https://www.biorxiv.org/content/10.1101/2020.01.22.915751v1" target="_blank"> here  </a> and the "Method" tab on top of this page.
                </div>
                </div>
            </div>
        </div>


        <div class="row">
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
                        <label for="select_desc" class="form-check-label"> Cancer Trait</label><br/>

                        <select name="select_desc" id="select_desc" class="form-control">
                            <option value="">Select Cancer Site/Trait</option>
                            <g:each in="${phecodeuniquedata}" status="i" var="dm">
                                <option value="${dm.phecodeid}">${dm.phecodedesc} &nbsp;(${dm.phecodeid})</option>
                            </g:each>
                        </select>

                    </div>

                    <div class="drilldown mr-2">
                        <label for="select_phenomes"  class="form-check-label">Evaluation Cohort</label><br/>
                        <select name="select_phenomes" id="select_phenomes" class="form-control" >
                            <option value="">Select Cohort</option>
                            <option value="UKB">UKB</option>
                            <option value="MGI">MGI</option>
                        </select>
                    </div>

                    <div class="drilldown mr-2">
                        <label for="select_odds"  class="form-check-label">Odds Ratio Top</label><br/>
                        <select name="select_odds" id="select_odds" class="form-control">
                            <option value="1"> 1% vs Rest </option>
                            <option value="2"> 2% vs Rest </option>
                            <option value="5"> 5% vs Rest </option>
                            <option value="10"> 10% vs Rest </option>
                            <option value="25"> 25% vs Rest </option>
                        </select>
                    </div>





                    <div class="drilldown mr-2">
                        <button onclick="createLink()">Show table with PRS</button>
                        %{--<g:submitButton name="Search" class="submit"/>--}%
                        %{--  <g:submitButton name="submit" onclick="validateForm()" class="upload" value="upload"
                                          style="color: #0F226E;padding: 10px 32px; font-family: Georgia, serif;border-radius: 8px;box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19); font-size: 15px;;font-style:bold;"/>
                    --}%

                    </div>




                </div>


                </div>




            </div>
        </div></div>


</div>


</div>





</body>
</html>
