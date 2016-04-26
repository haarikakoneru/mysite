<!--%rebase('base.tpl', Page_Title='Sudoku Game')-->
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Dashboard">
        <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

        <title>Sudoku Semstar - Reset Passwrod</title>

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
    </head>

    <body>

        <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->

        <div id="login-page">
            <div class="container">

                <form class="form-login" id="resetPass_form" data-toggle="validator" role="form" >
                    <h2 class="form-login-heading">Change Password</h2>
                    <label id="msg" style="color:red;"></label>
                    <div class="login-wrap">
                        <div class="form-group">
                            <label>New Password:</label>
                            <input type="password" name="txtResetPass" placeholder="Enter new Password" class="form-control" id="txtResetPass" data-error="Please enter New password (Min 8 chars)" pattern="(?=.*[a-zA-Z0-9]).{8,}" onchange="form.txtResetConfPass.pattern = this.value;" required>
                            <span class="help-block with-errors"></span>
                        </div>
                        <div class="form-group">
                            <label>Confirm Password:</label>
                            <input type="password" name="txtResetConfPass" placeholder="Enter new Password again" class="form-control" id="txtResetConfPass" data-error="Please confirm password" required>
                            <span class="help-block with-errors"></span>
                        </div>
                        
                        <button class="btn btn-theme btn-block" name="reset_password" id="reset_password" type="submit"><i class="fa fa-lock"></i> Submit</button>
                        <hr>
                        

                    </div>

                </form>	  	

            </div>
        </div>

        <!-- js placed at the end of the document so the pages load faster -->
        <script src="static/js/jquery.js"></script>
        <script src="static/js/bootstrap.min.js"></script>
        <script src="static/js/validator.min.js"></script>
        <script src= "static/js/login-reg.js"></script>

        <!--BACKSTRETCH-->
        <!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
        <script type="text/javascript" src="static/js/jquery.backstretch.min.js"></script>
        <script>
            $.backstretch("static/img/background_page.jpg", {speed: 500});
        </script>


    </body>
</html>
