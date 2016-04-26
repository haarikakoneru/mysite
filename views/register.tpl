<!--%rebase('base.tpl', Page_Title='Sudoku Game')-->
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Dashboard">
        <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

        <title>Sudoku Semstar - Create Account</title>

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
<div id="login-page">
    <div class="container">
        <form class="form-login" id="frmRegister" action="#" data-toggle="validator" id="regi_form" role="form" method="post">
            <h2 class="form-login-heading">Register now</h2>
            <label id="msg" style="color:red;"></label>
            <div class="login-wrap">
                <div class="form-group">
                    <!--<label>Email:</label>-->
                    <input type="email" name="txtRegEmail" placeholder="Email" class="form-control" id="txtRegEmail" data-error="Please enter Email ID" required pattern="([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+">
                    <span class="help-block with-errors"></span>
                </div>
                <div class="form-group">
                    <!--<label>Name</label>-->
                    <input type="text" name="txtRegName" placeholder="Name" class="form-control" id="txtRegName" data-error="Please enter your name" required>
                    <span class="help-block with-errors"></span>
                </div>
                <div class="form-group">
                    <!--<label>Password:</label>-->
                    <input type="password" name="txtRegPass" placeholder="Password" class="form-control" id="txtRegPass" data-error="Please enter New password" required pattern="(?=.*[a-zA-Z0-9]).{8,}" onchange="form.txtRegConfPass.pattern = this.value;">
                    <span class="help-block with-errors"></span>
                </div>
                <div class="form-group">
                    <!--<label>Confirm Password:</label>-->
                    <input type="password" name="txtRegConfPass" placeholder="Confirm Password" class="form-control" id="txtRegConfPass" data-error="Please Confirm password" required>
                    <span class="help-block with-errors"></span>
                </div>
                <div class="form-group">
                    <!--<label>Zip Code:</label>-->
                    <input type="text" name="txtRegZip" placeholder="Zip Code" class="form-control" id="txtRegZip" data-error="Please enter zipcode" required>
                    <span class="help-block with-errors"></span>
                </div>
                <div class="form-group">
                    <!--<label>Secret Question:</label>-->
                    <input type="text" name="txtRegScrQ" placeholder="Secret Question" class="form-control" id="txtRegScrQ" data-error="Please enter Secret Question" required>
                    <span class="help-block with-errors"></span>
                </div>
                <div class="form-group">
                    <!--<label>Secret Answer:</label>-->
                    <input type="text" name="txtRegScrA" placeholder="Secret Answer" class="form-control" id="txtRegScrA" data-error="Please enter Secret Answer" required>
                    <span class="help-block with-errors"></span>
                </div>
                <button class="btn btn-theme btn-block" id="btnRegister" href="" type="button"><i class="fa fa-lock"></i> Register</button>
            </div>
        </form>	  	

    </div>
</div>
        <script src="static/js/jquery.js"></script>
        <script src="static/js/bootstrap.min.js"></script>
        <script src="static/js/validator.min.js"></script>
        <script src= "/static/js/login-reg.js"></script>
       
        <!--BACKSTRETCH-->
        <!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
        <script type="text/javascript" src="static/js/jquery.backstretch.min.js"></script>
        <script>
            $.backstretch("static/img/background_page.jpg", {speed: 500});
        </script>


    </body>
</html>
