<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<meta http-equiv="Content-Type" name="viewport"
	content="text/html, charset=EUC-KR , width=device-width, initial-scale=1, maximum-scale=1">

<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./resources/semanticUI/semantic.css">
<script src="./resources/semanticUI/semantic.js"></script>
<link rel="stylesheet" href="./resources/css/menubar.css">
<script src="./resources/js/menubar.js"></script>


<style type="text/css">

.AllContainer {

	margin-top: 80px;

}

.upload {

	display: none;

}

.profile {
    width: 200px; 
    height: 200px;
    object-fit: cover;
    object-position: top;
    border-radius: 50%;
 }
 
.outer {
  display: table;
  width: 100%;
  height: auto;
}

.inner {
  display: table-cell;
  vertical-align: middle;
  text-align: center;
}

.centered {
  position: relative;
  display: inline-block;
  width: 50%;
  padding: 1em;
  
}

#introduce {

	width: 701px;
	resize: none;

}

</style>

<script>
	var sel_file;
	$(document).ready(
			function() {
				var userpwd = $("#userPwd").val();
				var email = $("#email").val();
				var checkpwd = $("#confirmPwd").val();
				$("#userPwd").on(
						"keyup",
						function() {
							if ($("#userPwd").val().length < 3
									|| $("#userPwd").val().length > 10) {
								$("#p").text("비밀번호는 3글자 이상 10글자 이하 로 적어야 합니다.")
										.css("color", "red");
							} else {
								$("#p").text("사용가능한 패스워드입니다.").css("color",
										"red");
							}
						});

				$("#confirmPwd").on("keyup", function() {
					if ($("#confirmPwd").val() === $("#userPwd").val()) {
						$("#cp").text("비밀번호가 같습니다.").css("color", "red");
					} else {
						$("#cp").text("비밀번호가 다릅니다.").css("color", "red");
					}
				})

				$("#email").on(
						"keyup",
						function() {
							var email = $("#email").val()
							if (email.indexOf("@") == -1) {
								$("#ep").text("이메일은 @을 포함해야합니다.").css("color",
										"red");

							} else {

								$.ajax({
									url : "emailCheck",
									method : "GET",
									data : {
										email : email
									},
									success : function(data) {
										if (data === 0) {
											$("#ep").text("사용 가능한 이메일입니다.")
													.css("color", "red");
										} else {
											$("#ep").text("이미 존재하는 이메일입니다.")
													.css("color", "red");
										}
									}

								});
							}
						})

				$("#upload").on("change", handleImgFileSelect)
			});
	function handleImgFileSelect(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);

		filesArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("확장자는 이미지 확장자만 가능합니다.");
				return;
			}
			sel_file = f;

			var reader = new FileReader();
			reader.onload = function(e) {
				$("#img").attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
</script>
<script>
	$(function() {
		$("#finishing").on(
				"click",
				function() {
					if ($("#userPwd").val().length < 3
							|| $("#userPwd").val().length > 10) {
						alert("비밀번호는 3~10글자입니다");
						return;
					} else if ($("#confirmPwd").val() != $("#userPwd").val()) {
						alert("비밀번호가 다릅니다.");
						return;
					} else if ($("#email").val().indexOf("@") == -1) {
						alert(" 이메일은 @ 포함시켜야 합니다.");
						return;
					}
					$("#updateSubmit").submit();
				});
	});
</script>
<script src="resources/js/userUpdate.js"></script>
</head>
<body>


<!-- ====================================MENU================================================= -->

<jsp:include page="./topMenu.jsp" flush="false"/>
<input type="hidden" id="login" value="${sessionScope.userId }">

<!-- ========================================userUpadate============================================= -->
<div class="ui hidden divider"></div>
<div class="defaultMain ui bottom attached padded">
	<div class="ui main text container">	
        <div class="ui segment" align="center">
			<form id="updateSubmit" action="userUpdate" method="post" enctype="multipart/form-data">
                <input type="file" name="upload" class="upload"/>
                	
                <div class="ui list">
                	
	              	<div class="item">
		                 <c:if test="${user.saveFile == null }">
		                   	<img class="profile my_button" id="img" src="resources/images/defaultAvatar.png" onclick="fileUploadAction();">
		                 </c:if>
		                 <c:if test="${user.saveFile != null }">
			                   <img class="profile my_button" id="img" src="resources/images/FileRepo/${user.saveFile }" onclick="fileUploadAction();">
		                 </c:if>
	                </div>
	                     
	                <div class="item"> 
	                   	<h1 class="ui header">
	                   		${sessionScope.userId }
	                  	</h1>	
	                </div>
	                     
					<div class="item">
						<div class="ui fluid input">
							<input type="password" id="userPwd" name="userPwd" value="${user.userPwd }" palceholder="새 비밀번호"/>
						</div>
					</div>
						
					<div class="item">
						<div class="ui fluid input">
							<input type="password" id="confirmPwd" placeholder="비밀번호 확인"/>
						</div>
					</div>
						
					<div class="item">
						<div class="ui fluid input">
							<input type="email" id="email" name="email" value="${user.email }" />
						 </div>
					</div>
						
					<div class="item">
						<div class="ui fluid input">
							<textArea id="introduce" name="introduce">${user.introduce}</textArea>
						 </div>
					</div>
						
					<div class="item">
						<div class="right floated content">
							<button class="ui basic button" id="finishing">프로필수정</button>
						</div>
					</div>
				</div>
        	</form>
		</div>
	</div>
</div>

</body>
</html>