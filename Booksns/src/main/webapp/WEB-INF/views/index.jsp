<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="./resources/semanticUI/semantic.css">
	<script src="./resources/semanticUI/semantic.js"></script>

<style type="text/css">

#introduce {

	resize: none;
	width: 335px;

}

.form {

	margin-top: 60px;

}

.front {

	width: 100%;
	margin-top: 5%;

}

</style>

<script>

$(function(){

	// 유효성검사
	$("#join").on('click', function() {
		
		var userId = $('#userId').val();
		var userPwd = $('#userPwd').val();
		var email = $('#email').val();
		var introduce = $('#introduce').val();
		
		if(userId.length==0||userId.length<3||userId.length>7){
			alert("아이디의 길이는 3~7입니다.");
			return false;
		}
		
		if(userPwd.length==0||userPwd.length<3||userPwd.length>7){
			alert("비밀번호의 길이는 3~7입니다.");
			return false;
		}
		
		if(email.length==0){
			alert("이메일을 입력해주세요.");
			return false;
		}
		
		if(introduce.length==0){
			alert("자기소개를 입력해주세요.");
			return false;
		}
		
		$('#user_join').submit();
	});
 
 	//회원가입 아이디 중복확인
	 $('#idcheck').on('click',function(){

		$('#join').attr('disabled', 'disabled');
		
		var userId = $('#userId').val();
		
		$.ajax({
			url: "user_idCheck",
			type: "get",
			data: {"userId":userId},
			success: function(result){
				if(result==0) {
					alert("아이디를 사용할 수 있습니다."); 
					$('#join').removeAttr('disabled');
					return;
				}else{
					alert("중복된 아이디입니다.");
					return;
				}
			}
		});
	}); 
	
});

//login validation
$(function(){
   $('#loginUser').on('click',function(){
      var userId = $('#loginUserId').val();
      var userPwd = $('#loginUserPwd').val();
      var returnVar = false;
      if(userId.trim().length == 0){
         alert("아이디를 입력해주세요");
         return false;
      }
      if(userPwd.trim().length == 0){
         alert("비밀번호를 입력해주세요");
         return false;
      }
      
   
      $.ajax({
         url: "login_Check",
         type: "get",
         data: {"userId":userId,"userPwd":userPwd},
         success: function(result2){
            if(result2==0) {
               alert("사용자 정보를 확인해주세요."); 
               returnVar = false;
            }if(result2==1)   {
               $('#loginCheck').submit();
            }
         }
      });
   
      return returnVar;
   });
});

</script>

</head>
<body>

<div class="ui two column grid">

	<div class="ten wide column">
		<img src="./resources/images/front.jpg" class="ui front disabled">
	</div>



		<div class="four wide column">
			<div class="form">
				<div class="joinForm ui attached segment">
				
				<h2 class="ui header">
					<i class="user outline icon"></i>
					<div class="content">
						회원가입
					</div>
				</h2>
				
				<form action="user_join" method="post">
			
					<div class="ui list">
						
						<div class="item">	
							<div class="ui fluid right action input">
								<input type="text" name="userId" id="userId" placeholder="ID">
									<button type="button" class="ui right button" id="idcheck">
										중복확인
									</button>
							</div>
						</div>
						
						<div class="item">
							<div class="ui fluid input">
								<input type="password" name="userPwd" id="userPwd" placeholder="Password">
							</div>
						</div>
						
						<div class="item">
							<div class="ui fluid input">
								<input type="email" name="email" id="email" placeholder="Email">
							</div>
						</div>
						
						<div class="item">
							<div class="ui fluid input">
								<textarea rows="7" cols="40" name="introduce" id="introduce" placeholder="Say hello"></textarea>
							</div>
						</div>
						
						<div class="item">
							<button class="ui brown basic button right floated" id="join">
								<i class="user outline icon"></i>
								회원가입
							</button>
							<br>
						</div>
						
						</div>
				</form>	
			</div>
	
				 <div class="ui horizontal divider">
					Or
				</div>
				
				<div class="loginForm ui attached segment">
				
				<h2 class="ui header">
					<div class="content">
						로그인
					</div>
				</h2>
				
					<form action="loginForm" id="loginCheck" method="post">
					
						<div class="ui list">
							<div class="item">
								<div class="ui fluid input">
									<input id="loginUserId" name="userId" type="text" placeholder="ID">
								</div>
							</div>
							
							<div class="item">
								<div class="ui fluid input">
									<input id="loginUserPwd" name="userPwd" type="password" placeholder="Password">
								</div>
							</div>
							
							<div class="item">
								<button class="ui brown basic button right floated" id="loginUser">
									로그인
								</button>
							</div>
						</div>	
					</form>
				</div>
			</div>
		</div>
</div>
</html>