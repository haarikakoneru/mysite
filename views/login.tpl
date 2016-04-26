<!--%rebase('base.tpl', Page_Title='Sudoku Game')-->
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Dashboard">
        <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

        <title>Sudoku Semstar - Login</title>

        <!-- Bootstrap core CSS -->
        <link href="static/css/bootstrap.css" rel="stylesheet">
        <!--external css-->
        <link href="static/font-awesome/css/font-awesome.css" rel="stylesheet" />

        <!-- Custom styles for this template -->
        <link href="static/css/style.css" rel="stylesheet">
        <link href="static/css/style-responsive.css" rel="stylesheet">


        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
          <script src="/static/js/jquery-1.8.3.min.js"></script>
          <script src= "/static/js/login-reg.js"></script>
        
    </head>

    <body>

        <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->

        <div id="login-page">
            <div class="container">

                <form class="form-login" id="frmLogin" data-toggle="validator" role="form">
                    <h2 class="form-login-heading">sign in now</h2>
                    <div class="login-wrap">
						<label id="msg" style="color:red;"></label>
                        <div class="form-group">
                            <label>Email:</label>
                            <input type="email" name="txtLogEmail" placeholder="Email" class="form-control" id="txtLogEmail" data-error="Please enter Email ID" required>
                            <span class="help-block with-errors"></span>
                        </div>
                        <div class="form-group">
                            <label>Password:</label>
                            <input type="password" name="txtLogPass" placeholder="Password" class="form-control" id="txtLogPass" data-error="Please enter password" required>
                            <span class="help-block with-errors"></span>
                        </div>
                        <label class="checkbox">
                            <span class="pull-right">
                                <a data-toggle="modal" href="login.tpl#myModal">Forgot Password?</a>

                            </span>
                        </label>
                        <button class="btn btn-theme btn-block"  id="btnLoginUser" type="submit"><i class="fa fa-lock"></i> Log In</button>
                        <hr>		           
                        <div class="registration">
                            Don't have an account yet?<br/>
                            <a class="" href="register">
                                Create an account
                            </a>
                        </div>

                    </div>
                </form>
                    <!-- Modal -->
                    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title">Forgot Password ?</h4>
                                </div>
                                <div class="modal-body">
                                    <form class="form-forgot" id="frmForgot" action="#" data-toggle="validator" role="form" method="post">
                                    <label id="forgotEmailErr" style="color:red";></label><br>
									<p>Enter your e-mail address below to reset your password.</p>
                                    <div class="form-group">
                                    <input type="email" id="email" name="email" placeholder="Email" autocomplete="off" class="form-control placeholder-no-fix" data-error="Please enter Email ID" pattern="([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+" required>
                                    <span class="help-block with-errors"></span>
                                    </div>
                                    <div class="form-group secretq" hidden="true">
                                        <label>Secret Question:</label>
                                        <input type="text" name="txtRegScrQ" class="form-control" id="txtRegScrQ" disabled="disabled"></label>
                                        <span class="help-block with-errors"></span>
                                    </div>
                                    <div class="form-group secreta" hidden="true">
                                        <label>Secret Answer:</label>
                                        <input type="text" name="txtRegScrA" placeholder="Secret Answer" class="form-control" id="txtRegScrA" data-error="Please enter Secret Answer" required>
                                        <span class="help-block with-errors"></span>
                                    </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button data-dismiss="modal" class="btn btn-default" type="button">Cancel</button>
                                    <button class="btn btn-theme" type="submit" id="btnGetEmail">Submit</button>
									<button class="btn btn-theme"  type="submit" id="btnReset">Reset</button>
                                </div>
                            </div>
                            </div>
                        
                    </div>
                    <!-- modal -->

                </form>	  	

            </div>
        </div>

        <!-- js placed at the end of the document so the pages load faster -->
        <script src="static/js/jquery.js"></script>
        <script src="static/js/bootstrap.min.js"></script>
        <script src="static/js/validator.min.js"></script>

        <!--BACKSTRETCH-->
        <!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
        <script type="text/javascript" src="static/js/jquery.backstretch.min.js"></script>
        <script>
            $.backstretch("static/img/background_page.jpg", {speed: 500});
        </script>


    </body>
</html>
