$(document).ready(function(){
    $('#btnEditName').click(function(){
        $("#txtEditName").prop('disabled', false);
    });
    $('#btnEditEmail').click(function(){
        $("#txtEditEmail").prop('disabled', false);
    });
    $('#btnEditPass').click(function(){
        $("#txtEditPass,#txtEditConfPass").prop('disabled', false);
    });
    $('#btnEditZipcode').click(function(){
        $("#txtEditZip").prop('disabled', false);
    });
    $('#btnEditSQ').click(function(){
        $("#txtEditScrQ").prop('disabled', false);
    });
    $('#btnEditSA').click(function(){
        $("#txtEditScrA").prop('disabled', false);
    });
    
    $("#btnUpdate").on("click",function(e){
    	$("#editPro_form input").prop("disabled", false);
		$.ajax({
			url:'/editProfile',
			type:'post',
			data: $("#editPro_form").serialize(),
			dataType:'json'
		}).done(function(data, textStatus,jqXHR ){
			if(data["success"]){
				$("#msg").html(data["msg"]).css({"color": "green"});
				$("#userName").html(data['data'][0][1]);
				// window.location.href = data["redirect"];
			}else{
				$("#txtRegScrA").focus();
				$("#msg").html(data["msg"]).css({"color": "red"});
			}
		}).always(function(p1, p2, p3) {
			$("#editPro_form input").prop("disabled", true);
		});
	});
});