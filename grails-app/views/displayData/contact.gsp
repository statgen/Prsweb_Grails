<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'displayData.label', default: 'DisplayData')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="create-displayData" class="content scaffold-create mt-5" role="main">
        <div class="container-fluid">
            <div class="card">
        <div class="row">

            <div class="col-12 col-md-10">

                <h3>CONTACT</h3>
                <p>Site created by Snehal Patil, snehal@med.umich.edu</p>
                <p>Contributors: Lars Fritsche, Lauren J Beesley, and Bhramar Mukherjee</p>
                <p class="mb-0">Contact: Bhramar Mukherjee (bhramar@umich.edu) and Lars Fritsche (larsf@umich.edu), 1415 Washington Heights, Ann Arbor MI, 48109</p>
                <p>University of Michigan Center for Precision Health Data Science</p>

                <form class="form-horizontal" action="" method="post">
                    <fieldset>
                        <legend class="text-center">Contact us</legend>

                        <!-- Name input-->
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="name">Name</label>
                            <div class="col-md-9">
                                <input id="name" name="name" type="text" placeholder="Your name" class="form-control">
                            </div>
                        </div>

                        <!-- Email input-->
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="email">Your E-mail</label>
                            <div class="col-md-9">
                                <input id="email" name="email" type="text" placeholder="Your email" class="form-control">
                            </div>
                        </div>

                        <!-- Message body -->
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="message">Your message</label>
                            <div class="col-md-9">
                                <textarea class="form-control" id="message" name="message" placeholder="Please enter your message here..." rows="5"></textarea>
                            </div>
                        </div>

                        <!-- Form actions -->
                        <div class="form-group">
                            <div class="col-md-12 text-right">
                                <button type="submit" class="btn btn-primary btn-lg">Submit</button>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div></div>





        </div>
            </div>
        </div>
    </div>
    </body>
</html>
