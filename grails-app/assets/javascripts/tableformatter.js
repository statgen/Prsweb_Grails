
function displayTable() {
    var jsonData = JSON.parse('${resultJson}');


    var prswtsel = $("#select_desc").val();
    var phenocatsel = $("#select_PRS_code").val();
    var phenomesel = $('#select_phenomes').val();

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

                    +'<td>'+resobj1[j].topor+'</td>'
                    +'<td>'+resobj1[j].topci+','+resobj1[j].topci2+'</td>'

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

