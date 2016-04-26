%rebase('game_base.tpl', Page_Title='Sudoku Game')
<div id="edit_profile-page">
	<label id="msg" style="display:block; text-align:center; padding-top: 20px;"></label>
    <div class="container" id="profileContainer">

        <form class="form-edit" action="#" id="editPro_form" data-toggle="validator" role="form" method="post">
        	
            <h2 class="form-edit-heading">Edit Profile</h2>
            <div class="edit-wrap">
                <div class="form-group">
                    <label>Name:</label>
                    <div class="input-group">
                        <input type="text" name="txtEditName" class="form-control" id="txtEditName" data-error="Please enter your name" required disabled="true" value="{{session['userName']}}">
                        <span class="input-group-addon"><label class="glyphicon glyphicon-edit" id="btnEditName"></label></span>
                    </div>
                    <span class="help-block with-errors"></span>
                </div>
                
                <div class="form-group">
                    <label>Email:</label>
                    <div class="input-group">
                        <input type="Email" name="txtEditEmail" class="form-control" id="txtEditEmail" data-error="Please enter your Email ID" required disabled="true" pattern="([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+" value="{{session['email']}}">
                        <span class="input-group-addon"><label class="glyphicon glyphicon-edit" id="btnEditEmail"></label></span>
                    </div>
                    <span class="help-block with-errors"></span>
                </div>
                <div class="form-group">
                    <label>Password:</label>
                    <div class="input-group">
                        <input type="password" name="txtEditPass" class="form-control" id="txtEditPass" data-error="Please enter new password (Min 8 chars)" required  value="{{session['password']}}" 
                               disabled="true" pattern="(?=.*[a-zA-Z0-9]).{8,}" onchange="form.txtEditConfPass.pattern = this.value;">
                        <span class="input-group-addon"><label class="glyphicon glyphicon-edit" id="btnEditPass"></label></span>
                    </div>
                    <span class="help-block with-errors"></span>
                </div>
                <div class="form-group">
                    <label>Confirm Password:</label>
                    <div class="input-group">
                        <input type="password" name="txtEditConfPass" class="form-control" id="txtEditConfPass" data-error="Please confirm password" required disabled="true"  value="{{session['password']}}">
                        <span class="input-group-addon"><label class="glyphicon glyphicon-edit" id="btnEditConfPass" disabled="true" equalTo ="txtEditPass"></label></span>
                    </div>
                    <span class="help-block with-errors"></span>
                </div>
                <div class="form-group">
                    <label>Zip Code:</label>
                    <div class="input-group">
                        <input type="text" name="txtEditZip" class="form-control" id="txtEditZip" data-error="Please enter zip code" required disabled="true"  value="{{session['zipCode']}}">
                        <span class="input-group-addon"><label class="glyphicon glyphicon-edit" id="btnEditZipcode"></label></span>
                    </div>
                    <span class="help-block with-errors"></span>
                </div>
                <div class="form-group">
                    <label>Secret Question:</label>
                    <div class="input-group">
                        <input type="text" name="txtEditScrQ" class="form-control" id="txtEditScrQ" data-error="Please enter secret question" required disabled="true" value="{{session['sQue']}}">
                        <span class="input-group-addon"><label class="glyphicon glyphicon-edit" id="btnEditSQ"></label></span>
                    </div>
                    <span class="help-block with-errors"></span>
                </div>
                <div class="form-group">
                    <label>Secret Answer:</label>
                    <div class="input-group">
                        <input type="text" name="txtEditScrA" class="form-control" id="txtEditScrA" data-error="Please enter secret answer" required disabled="true" value="{{session['sAns']}}">
                        <span class="input-group-addon"><label class="glyphicon glyphicon-edit" id="btnEditSA"></label></span>
                    </div>
                    <span class="help-block with-errors"></span>
                </div>
                <button class="btn btn-theme" id="btnUpdate" type="button"><i class="fa fa-lock"></i> Update</button>
            </div>
        </form>	  	
    </div>
</div>