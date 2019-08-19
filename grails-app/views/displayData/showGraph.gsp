<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>PRSweb</title>
        <meta name="layout" content="main" />
        <asset:stylesheet href="locuszoom.css"/>


        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-121436353-1"></script>
        <script>window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','UA-121436353-1')</script>

        <asset:javascript src="locuszoom.vendor.min.js"/>
        <asset:javascript  src="locuszoom.app.js"/>
        <asset:javascript src="jquery-3.3.1.min.js" />
        <asset:javascript src="bootstrap.bundle.js"/>
        <asset:javascript  src="underscore.min.js"/>
        <asset:javascript src="utils.js"/>
        <babel:webpack src="handledata.es6" />
        <asset:stylesheet src ="datatables.css" />
        <asset:javascript src="datatables.js" />





        <script type="text/javascript">
            $(document).ready(function () {


               // var test = ${raw(phewasdf_json)};
               // console.log(test);

                //var test2 = ${raw(dataRes)};
                //console.log(test2);

                handle_data(${raw(dataRes)});

                $('#example').DataTable({
                    "order": [[ 2, "asc" ]]
                });
                $('#exclusion').DataTable({
                    "order": [[ 2, "asc" ]]
                });






        });






    </script>



        <r:require module="export"/>

    </head>
    <body>
        <a href="#list-displayData" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-displayData" class="content scaffold-list" role="main">

            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <div class="container-fluid">

                <div class="row"><div class="col-12"><div id="phewas">Loading...</div></div></div>
                <div class="row">
                    <div class="col-12 col-lg-9"><div id="phewas_ex">Loading...</div></div>
                    <div class="col-12 col-lg-3"><div id="forest" class="forest_plot">Loading...</div></div>
                </div>



                        <div class="row">
                            <div class="col-md-12">
                                <g:set var="dataRes" value="${(grails.converters.JSON.parse(dataRes))}" />

                                <export:formats formats="['csv', 'excel']" params="${[phecode:dataRes.PRS_code, model:dataRes.PRS_source, phenome:dataRes.PRS_study]}"  />
                                <nav>
                                    <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
                                        <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Phewas df</a>
                                        <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Exclusion</a>
                                    </div>
                                </nav>

                                %{--<g:each var="question" in="${(grails.converters.JSON.parse(dataRes)).phewas_df}" index="i">
                                    <tr>
                                        <td>${question.getKey()}</td>
                                        <td>${question.getValue().get(i)}</td>
                                    </tr>
                                </g:each>
    --}%



                                <div class="tab-content" id="nav-tabContent">
                                    <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                                        <table class="table" cellspacing="0"  id="example">

                                                    <thead>
                                                    <tr>
                                                        <th>PRS String</th>
                                                        <th>Category</th>
                                                        <th>P value</th>
                                                        <th>BETA</th>
                                                        <th>SEBETA</th>
                                                        <th>N Cases</th>
                                                        <th>Num Controls</th>
                                                        <th>Sex</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="insertfirsttable">
                                                    <g:each var="prop" in="${prsobjlist}" index="i">
                                                        <tr>
                                                            <td>${prop.getPstring()}</td>
                                                            <td>${prop.getCategory()}</td>
                                                            <td>${prop.getPrsp()}</td>
                                                            <td>${prop.getCbeta()}</td>
                                                            <td>${prop.getCsebata()}</td>
                                                            <td>${prop.getNumcases()}</td>
                                                            <td>${prop.getNumcont()}</td>
                                                            <td>${prop.getSex()}</td>
                                                        </tr>
                                                    </g:each>
                                                    </tbody>
                                        </table>
                                    </div>
                                    <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">

                                        <table class="table" cellspacing="0"  id="exclusion">

                                            <thead>
                                            <tr>
                                                <th>PRS String</th>
                                                <th>Category</th>
                                                <th>P value</th>
                                                <th>BETA</th>
                                                <th>SEBETA</th>
                                                <th>N Cases</th>
                                                <th>Num Controls</th>
                                                <th>Sex</th>
                                            </tr>
                                            </thead>
                                            <tbody id="insertfirsttable1">
                                            <g:each var="prop" in="${prsexobjlist}" index="i">
                                                <tr>
                                                    <td>${prop.getPstring()}</td>
                                                    <td>${prop.getCategory()}</td>
                                                    <td>${prop.getPrsp()}</td>
                                                    <td>${prop.getCbeta()}</td>
                                                    <td>${prop.getCsebata()}</td>
                                                    <td>${prop.getNumcases()}</td>
                                                    <td>${prop.getNumcont()}</td>
                                                    <td>${prop.getSex()}</td>
                                                </tr>
                                            </g:each>
                                            </tbody>
                                        </table>
                                    </div>

                                </div>
                            </div>
                        </div>





                </div>
                <div class="row"><div class="col-12"><div id="weights"></div></div></div>
                <div class="row my-2"><div class="col-12">
                    <div class="card"><div class="card-body">
                        <h3>LEGENDS</h3>
                        <p><b>Figure 1: PheWAS results</b><br>
                            P-values correspond to associations between the polygenic risk score (PRS) and the electronic health record-derived phenotype obtained using Firth’s logistic regression and also adjusting for age, gender, genotyping array, and the first four genotype principal components.<br>
                            Upward (downward)-pointing triangles indicate a positive (negative) association.<br>
                            Additional details are available by hovering the cursor over a particular triangle and by clicking the triangle. The horizontal dashed line indicates phenome-wide significance. Results are color-coded by disease category.</p>
                        <p><b>Figure 2: Exclusion PheWAS results</b><br>
                            Results from a PheWAS performed using only subjects who never had a skin cancer diagnosis. The results are obtained as in Figure 1 but using the reduced dataset.</p>
                        <p class="mb-0"><b>Figure 3: Associations between PRS and Selected Phenotype</b><br>
                            This figure shows results for the selected phenotype in Figure 1.<br>
                            This figure provides the beta estimate for the adjusted association between the PRS and the selected phenotype from Firth-corrected logistic regression. The corresponding confidence intervals are also shown. Results are presented for models using either a continuous or a categorical version of the PRS.<br>
                            Q1 through Q4 represent the four quartiles of the PRS.</p>
                    </div></div>
                </div></div>



                <div class="row my-2"><div class="col-12">
                    <div class="card"><div class="card-body">
                        <div class="row">
                            <div class="col-12 col-md-10">
                            <asset:image class="rounded mx-auto d-block" style="width:100%; max-width:11em; height:auto" src="umich-logo.png" alt="University of Michigan logo"/>
                            <p>University of Michigan Center for Precision Health Data Science</p>
                        <h3>CONTACT</h3>
                        <p>Site created by Peter VandeHaar, last updated on {{ today }}.</p>
                        <p>Contributors: Lars Fritsche, Lauren J Beesley, and Bhramar Mukherjee</p>
                        <p class="mb-0">Contact: Bhramar Mukherjee (bhramar@umich.edu) and Lars Fritsche (larsf@umich.edu), 1415 Washington Heights, Ann Arbor MI, 48109</p>
                    </div></div>
                </div></div>
            </div>






        </div>
    </body>
</html>