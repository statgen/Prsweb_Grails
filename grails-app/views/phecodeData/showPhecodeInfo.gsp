<%--
  Created by IntelliJ IDEA.
  User: snehalpatil
  Date: 2019-09-25
  Time: 16:22
--%>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <asset:javascript src="jquery-3.3.1.js"/>
    <asset:javascript src="jquery.tablesorter.min.js"/>
    <asset:javascript src="jquery.tablesorter.widgets.js"/>
    <asset:stylesheet src="theme.blue.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script>

        /* Documentation for this tablesorter FORK can be found at
 * http://mottie.github.io/tablesorter/docs/
 */
        $(function() {
            $('#icdinfo').tablesorter({

                // *** APPEARANCE ***
                // Add a theme - 'blackice', 'blue', 'dark', 'default', 'dropbox',
                // 'green', 'grey' or 'ice' stylesheets have all been loaded
                // to use 'bootstrap' or 'jui', you'll need to include "uitheme"
                // in the widgets option - To modify the class names, extend from
                // themes variable. Look for "$.extend($.tablesorter.themes.jui"
                // at the bottom of this window
                // this option only adds a table class name "tablesorter-{theme}"
                sortList: [[5, 1]],
                widthFixed: true,

                // initialize zebra striping and filter widgets
                widgets: ["zebra", "filter"],

                widgetOptions: {
                    filter_cssFilter: '',

                    // If there are child rows in the table (rows with class name from "cssChildRow" option)
                    // and this option is true and a match is found anywhere in the child row, then it will make that row
                    // visible; default is false
                    filter_childRows: false,

                    // if true, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                    // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                    filter_hideFilters: false,

                    // Set this option to false to make the searches case sensitive
                    filter_ignoreCase: true,

                    // jQuery selector string of an element used to reset the filters
                    filter_reset: '.reset',

                    // Use the $.tablesorter.storage utility to save the most recent filters
                    filter_saveFilters: true,

                    // Delay in milliseconds before the filter widget starts searching; This option prevents searching for
                    // every character while typing and should make searching large tables faster.
                    filter_searchDelay: 300,

                    // Set this option to true to use the filter to find text from the start of the column
                    // So typing in "a" will find "albert" but not "frank", both have a's; default is false
                    filter_startsWith: false,



                }


            });


        });


</script>
    <g:set var="entityName" value="${message(code: 'phecodeData.label', default: 'PhecodeData')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>

<div id="show-phecodeData" class="content scaffold-show" role="main">
    <div class="container-fluid">
        <div class="card">
            <div class="row">
                <div class="table-bordered table-responsive fixed-table-body text-center mt-5">
                    <table class="table-striped table-bordered table-light " style="border: 1px solid #ddd !important;" id='icdinfo'>
                        <thead class="thead-light">
                            <th> Phecode ID</th>
                            <th> Phecode Description</th>
                            <th> Range</th>
                            <th> Sex</th>
                            <th> Phecode Category</th>
                            <th> ICD code</th>
                            <th> ICD Description</th>
                            <th> ICD Type</th>
                            <th> Phenome</th>
                            </thead>
                            <tbody>
                            <g:each in="${phecoreres}" var="ph">
                                <tr>
                                <td>${ph.phecodeid}</td>
                                <td>${ph.pdesc}</td>
                                    <td>${ph.prange}</td>
                                <td>${ph.sex}</td>
                                <td>${ph.pcategory}</td>
                                <td>${ph.icdcode}</td>
                                <td>${ph.icddesc}</td>
                                <td>${ph.icdtype}</td>
                                <td>${ph.phenome}</td>
                                </tr>

                            </g:each>
                            </tbody>
                    </table>
                </div>
            </div>



            </div>
        </div>
    </div>


  <g:if test="${fil.equals("icd")}">




  </g:if>
  <g:else>



  </g:else>


</div>
</body>
</html>
