<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

    <asset:stylesheet src="application.css"/>
    <script src="https://kit.fontawesome.com/53d3e070e7.js"></script>
    <style>


.navbar-brand {
    background: url(http://disputebills.com/site/uploads/2015/10/dispute.png) center / contain no-repeat;
    transform: translateX(-50%);
    left: 50%;
    position: absolute;
    width: 200px; /* no height needed ... image will resize automagically */
}
</style>

    <g:layoutHead/>
</head>

<body>

<div class="navbar navbar-light navbar-static-top"  role="navigation">
    <div class="navbar-header">

        <a class="navbar-brand mx-auto" href="#" style="text-decoration:none;">Cancer-PRSweb</a>
        <a class="navbar-brand mx-aut" href="/#">
            <a class="navbar-center" href="${createLink(uri: '/')}"><img src="${resource(dir: 'images', file: 'umich-logo.png')}" alt="GSE" style="height:auto; width: 5em;" /></a>

        </a>

    </div>
    <br/>
    <br/>


</div>

<div class="nav" role="navigation" style="padding-top:1px;">
    <ul>

        <li><a  href="${createLink(uri: '/')}"><span class="glyphicon glyphicon-home"></span><i class="fas fa-home"></i> Home</a></li>
        <li><g:link controller="phecodeData" action="searchPhecode"><span class="glyphicon glyphicon-th-list"></span> <i class="fas fa-search"></i> SearchPhecode</g:link></li>
        <li><g:link controller="phecodeData" action="index"><span class="glyphicon glyphicon-th-list"></span> <i class="fas fa-search"></i> Phocode data lookup </g:link></li>


        %{--<li><g:link controller="jobque" action="tutorials">Tutorials</g:link></li>
        <li><g:link controller="jobque" action="news">News</g:link></li>
        <li><g:link controller="jobque" action="contact">Contact Us</g:link></li>
        <li><g:link controller="displayData" action="showGraph "><span class="glyphicon glyphicon-th-list"></span> Get Results</g:link></li>--}%
        <li><g:link controller="displayData" action="contact "><span class="glyphicon glyphicon-th-list"></span> <i class="far fa-address-card"></i> Contact</g:link></li>

        %{-- <li><g:link controller="publications" action="index"><span class="glyphicon glyphicon-list-alt"></span> Publications</g:link></li>
         --}%%{--<li><g:link controller="peptides" action="peptidesdataTables"><span class="glyphicon glyphicon-list-alt"></span> Peptides</g:link></li>--}%%{--
          <li><g:link controller="peptides" action="peptideServerCalls" params="[pubid :'',ondiff:'',q:'']">Novel Peptides</g:link></li>--}%
        %{-- <li><g:link controller="publications" action="index">Publications</g:link></li>--}%

    </ul>


    %{--<span class="navbar-center"  style="font-family: Righteous;text-align: center; padding-top: 25px;padding-bottom: 10px;"> Peptide Centric Protegenomics</span>--}%


</div>








<g:layoutBody/>
%{--

<div class="footer row" role="contentinfo">
    <div class="col">
        <a href="http://guides.grails.org" target="_blank">
            <asset:image src="advancedgrails.svg" alt="Grails Guides" class="float-left"/>
        </a>
        <strong class="centered"><a href="http://guides.grails.org" target="_blank">Grails Guides</a></strong>
        <p>Building your first Grails app? Looking to add security, or create a Single-Page-App? Check out the <a href="http://guides.grails.org" target="_blank">Grails Guides</a> for step-by-step tutorials.</p>

    </div>
    <div class="col">
        <a href="http://docs.grails.org" target="_blank">
            <asset:image src="documentation.svg" alt="Grails Documentation" class="float-left"/>
        </a>
        <strong class="centered"><a href="http://docs.grails.org" target="_blank">Documentation</a></strong>
        <p>Ready to dig in? You can find in-depth documentation for all the features of Grails in the <a href="http://docs.grails.org" target="_blank">User Guide</a>.</p>

    </div>

    <div class="col">
        <a href="https://grails-slack.cfapps.io" target="_blank">
            <asset:image src="slack.svg" alt="Grails Slack" class="float-left"/>
        </a>
        <strong class="centered"><a href="https://grails-slack.cfapps.io" target="_blank">Join the Community</a></strong>
        <p>Get feedback and share your experience with other Grails developers in the community <a href="https://grails-slack.cfapps.io" target="_blank">Slack channel</a>.</p>
    </div>
</div>
--}%


<div id="spinner" class="spinner" style="display:none;">
    <g:message code="spinner.alt" default="Loading&hellip;"/>
</div>

<asset:javascript src="application.js"/>

</body>
</html>
