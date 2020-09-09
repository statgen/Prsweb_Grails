<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'displayData.label', default: 'DisplayData')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-displayData" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-displayData" class="content scaffold-show" role="main">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12 mt-2">
                        <div class="card"><div class="card-body text-justify">
                            <ul>

                                <li> <b>October 31, 2019 </b> : Added download image button and download the main table option</li>
                                <li><b>June 8, 2020  </b> :Updated PRS evaluation by splitting cohort into training (used to obtain tuning parameters) and testing set (used for evaluation). Also PRS evaluation is now adjusted for covariates.</li>
                                <li><b>August 25, 2020 </b>: Added PRS-CS for traits with full GWAS summary <statistics></statistics></li>
                            </ul>

                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
