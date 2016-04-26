$(document).ready(function(){
			$("#btnReset").hide();
			
			// $("#btnLoginUser").on("click",function(){
			$("#frmLogin").validator().on('submit', function (e) {
				
				if (!e.isDefaultPrevented()) {
					e.preventDefault();
					$.ajax({
						url:'/userLogin',
						type:'post',
						data:'txtLogEmail=' + $("#txtLogEmail").val() +"&txtLogPass=" + $("#txtLogPass").val(),					
						dataType:'json'
					}).done(function(data, textStatus,jqXHR ){
						redirectUrl = data["redirect"];
						if(data["success"]){
							window.location.href = redirectUrl;
						}else{
							$("#txtLogEmail").focus();
							$("#msg").html("Username and/or password wrong. Please try again.");
						}
					});
				}
			});
          
		  
		  $("#btnGetEmail").on("click",function(){			
				$.ajax({
					url:'/forgotPassword',
					type:'post',
					data:'email=' + $("#email").val(),
					dataType:'json'
				}).done(function(data, textStatus,jqXHR ){
					
					if(data["success"]){
						$(".secretq").show();
						$(".secreta").show();
						$("#txtRegScrQ").val(data['data'][1]);
						$("#btnReset").show();
						$("#btnGetEmail").hide();
					}else{
						$("#email").focus();
						$("#forgotEmailErr").html("Emai not match Please try again.");
					}
				});
			});
			$("#btnReset").on("click",function(e){
				$.ajax({
					url:'/submitSecrets',
					type:'post',
					data:'txtRegScrA=' + $("#txtRegScrA").val(),
					dataType:'json'
				}).done(function(data, textStatus,jqXHR ){
					
					if(data["success"]){
						window.location.href = data["redirect"];
					}else{
						$("#txtRegScrA").focus();
						$("#forgotEmailErr").html(data["msg"]);
					}
				});
			});
			
			// $("#reset_password").on("click", function(e){
			$("#resetPass_form").validator().on("submit", function(e) {
				if (!e.isDefaultPrevented()) {
					e.preventDefault();
					
					$.ajax({
						url:'/setNewPassword',
						type:'post',
						data:'txtResetPass=' + $("#txtResetPass").val(),
						dataType:'json'
					}).done(function(data, textStatus,jqXHR ){
						
						if(data["success"]){
							window.location.href = data["redirect"];
						}else{
							$("#txtResetPass").val("");
							$("#txtResetPass").focus();
							$("#msg").html(data["msg"]);	
						}
					});
				}
				
			});
			
			$("#btnRegister").on("click", function(e){
				$.ajax({
					url:'/registerUser',
					type:'post',
					data:$("#frmRegister").serialize(),
					dataType:'json'
				}).done(function(data, textStatus,jqXHR ){
					
					if(data["success"]){
						window.location.href = data["redirect"];
					}else{
						$("#msg").html(data["msg"]);	
					}
				});
			}).done(function(data, textStatus, jqXHR){
				
			});
			
			
          });