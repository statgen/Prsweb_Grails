<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
            <asset:stylesheet src="jquery-ui.min.css"/>
            <asset:stylesheet src="jquery-ui.theme.css"/>
        <asset:javascript src="jquery-3.3.1.js"/>
        <script
        src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"
        integrity="sha256-0YPKAwZP7Mp3ALMRVB2i8GXeEndvCq3eSl/WsAl1Ryk="
        crossorigin="anonymous"></script>
        <g:set var="entityName" value="${message(code: 'phecodeData.label', default: 'PhecodeData')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <style>
        * {
            -webkit-border-radius: 1px !important;
            -moz-border-radius: 1px !important;
            border-radius: 1px !important;
        }
        #top #searchform>div {
            max-width: 800px;
        }

        #top #s {
            font-size: 32px;
            padding: 80px 60px 20px 20px; }

        #logo {
            color: #666;
            width:100%;
        }
        #logo h1 {
            font-size: 60px;
            text-shadow: 1px 2px 3px #999;
            font-family: Roboto, sans-serif;
            font-weight: 700;
            letter-spacing: -1px;
        }
        #logo p{
            padding-bottom: 20px;
        }


        #form-buscar >.form-group >.input-group > .form-control {
            height: 40px;
        }
        #form-buscar >.form-group >.input-group > .input-group-btn > .btn{
            height: 40px;
            font-size: 16px;
            font-weight: 300;


        }
        #form-buscar >.form-group >.input-group > .input-group-btn > .btn .glyphicon{
            margin-right:12px;
        }


        #form-buscar >.form-group >.input-group > .form-control {
            font-size: 16px;
            font-weight: 300;

        }

        #form-buscar >.form-group >.input-group > .form-control:focus {
            border-color: #33A444;
            outline: 0;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 1px rgba(0, 109, 0, 0.8);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 1px rgba(0, 109, 0, 0.8);
        }
        </style>
        <script>
        $(document).ready(function() {

            var select = doExport();

         });
            var sel ;
        function doExport() {

						   var id= $('input:radio[name=fil]:checked').val();
						   console.log('inside do exprt');
						   console.log(id);
			  if(id == "icd")
			      {
			          $('#city').autocomplete({
                          source: '<g:createLink controller="phecodeData" action="ajaxFindCity" params="[radio:'icd']"/>'

			          });
				  }
			  else
                  {
                      console.log("phecode loop");
                      $('#city').autocomplete({
                          source: '<g:createLink controller="phecodeData" action="ajaxFindCity" params="[radio:'phecode']"/>'

                      });
                  }
                       jQuery(function () {
                            jQuery("[name='passsel']").submit(function () {
                                jQuery("[name='id']").val(id);
                            });
	            });



			}



</script>
    </head>
    <body>

    <div class="container h-80">
        <div class="row h-100 justify-content-center align-items-center mt-5 p-5">

            <div class="container-fluid">
                <div class="card mt-3 p-5">
                    <div class="row">




                            <g:form action="showPhecodeInfo" method="post" id="upform" name="upform" enctype="multipart/form-data">
                    Search By :  <g:radioGroup name="fil" id="radio" values="['icd','phecode']"  value="phecode" labels="[' ICD ','  Phecode ']" onClick="doExport()">${it.radio} <g:message code="${it.label}" />
                </g:radioGroup></span>
                <div class="form-group mt-2" >
                    %{--<label for="formGroupExampleInput">Example label</label>--}%
                    <g:textField name="q" class="form-control" placeholder="Type ID here" id="city" value="${params.q}"/>
                </div>
                    <g:submitButton name="Search" class="submit" value="Show Informtation"/>
                    <br/>
                </g:form>

                    </div>
                </div>
            </div>


        </div>
    </div>







    </body>
</html>
