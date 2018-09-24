<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Book add </title>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="./resources/semanticUI/semantic.css">
	<script src="./resources/semanticUI/semantic.js"></script>
	<link rel="stylesheet" href="./resources/css/menubar.css">
	<script src="./resources/js/menubar.js"></script>
	<link rel="stylesheet" href="./resources/css/bookAdd.css">
	
	<link rel="stylesheet" href="./resources/css/feed2.css">
	<script src="./resources/js/topMenu.js"></script>
<script>



//adding form value
/* $(function(){
	var category = '';
	
	$('.ui.fluid.search.selection.dropdown').dropdown({
		action: function($selectedItem) {
			category = $selectedItem;
		}
	});
	
}); */



$(function(){
	

	var category = '';
	
	$('.ui.fluid.search.selection.dropdown').dropdown({
		onChange: function($selectedItem) {
			category = $selectedItem;
		}
	});
	
	$('#bookAddBtn').click(function(){
		
		if ($('#title').val() == '' || $('#authors').val() == '') {
			alert("필수항목을 입력해주세요");
			return;
		}
		
		var memo = $('#memo').val();
		$('#memoInput').val(memo);
		var read = $('input[name="readYN"]:checked').val();
		$('#readYN').val(read);
		$('#categories').val(category);
		
		$('#bookAdd').submit();
		
	});
});


var sel_files ="";

$(function(){
   $("#selfThum").on("change",handleImgFileSelect);
});
function fileUploadAction(){
   console.log("fileUploadAction");
   $("#selfThum").trigger('click');
}

function handleImgFileSelect(e){
   //이미지 정보들을 초기화
   sel_files="";
   //안에있는 내용 사라지는데 이거 때매 복수로 등록이 안됬었음 
   //근데 필요할거 같으니 전송한다음에 바꾸던가 하자으
   //$(".img_part").empty();
   
   var files = e.target.files;
   var filesArr =  Array.prototype.slice.call(files);
   
   var index = 0;
   filesArr.forEach(function(f){
      if(!f.type.match("image.*")){
         alert("확장자는 이미 지 확장자만 가능합니다.");
         return;
      }
      sel_file = f;
      
      var reader = new FileReader();
   /*    reader.onload =function(e){
         var html = "/ <a href=\"javascript:void(0) /"; 
         html+= "onclick=\"deleteImageAction("+index+")\" id=\img_id_"+index+"\">"; 
         html+= "<img src=\""+e.target.result+"\" data-file='"+f.name+"' class='selProductFile' title='Click to remove'></a>";
         
         $("#img_part").append(html);
         index++;
      
      } */
      reader.onload = function(e){
         $("#thumbnail").attr("src",e.target.result)
      }
      reader.readAsDataURL(f);
   });
}

</script>

</head>
<body>

<!-- ====================================MENU================================================= -->

<jsp:include page="./topMenu.jsp" flush="false"/>
<input type="hidden" id="login" value="${sessionScope.userId }">

<!-- ==============================================contetnt====================================================== -->
<div class="ui hidden divider"></div>
<div class="defaultMain ui bottom attached padded">
	<div class="ui main text container">
		<div class="container" >
			<div class="outer">
				<div class="inner">
					<div class="centered">
									
						<div class="ui segment">
										
							<div class="ui list">
								<form action="selfAdd" method="post" id="bookAdd" enctype="multipart/form-data">
								
									<div class="item">
										<img id="thumbnail" src="./resources/images/bookmark.png" style="width: 100px;" onclick="fileUploadAction()"/>
                              			<input type="file" name="thumb" id="selfThum" style="display:none;"/>
									</div>
									
									<div class="item">
										<div class="ui fluid left corner labeled input">
											<input type="text" id="title" name="title" placeholder="Title">
											<div class="ui left corner label">
												<i class="asterisk icon"></i>
											</div>
										</div>
									</div>
											
									<div class="item">
										<div class="ui fluid left corner labeled input">
											<input type="text" id="authors" name="authors" placeholder="Author">
											<div class="ui left corner label">
												<i class="asterisk icon"></i>
											</div>
										</div>
									</div>
											
									<div class="item">
										<div class="ui fluid left corner labeled input">
										<input type="text" id="publisher" name="publisher" placeholder="Publisher">
										</div>
									</div>
											
									<div class="item">
										<div class="ui fluid left corner labeled input">
											<input type="text" id="isbn" name="isbn" placeholder="isbn">
										</div>
									</div>
											
									<div class="item">
										<div class="ui fluid left corner labeled input">
											<input type="text" id="contents" name="contents" placeholder="Description">
										</div>
									</div>
											
									<div class="item">
										<div class="field">
										    <div class="ui fluid search selection dropdown" id="categoryDropdown">
											    <input type="hidden" name="categories" id="categories">
												<div class="default text">Search Category</div>
													<i class="dropdown icon"></i>
												<div class="menu">
											      	<div class="item">소설</div>
											      	<div class="item">시/에세이</div>
											      	<div class="item">인문</div>
											      	<div class="item">가정/생활</div>
											      	<div class="item">요리</div>
											      	<div class="item">건강</div>
											      	<div class="item">취미/스포츠</div>
											      	<div class="item">경제/경영</div>
											      	<div class="item">자기계발</div>
											      	<div class="item">정치/사회</div>
											      	<div class="item">정부간행물</div>
											      	<div class="item">역사/문화</div>
											      	<div class="item">종교</div>
											      	<div class="item">예술/대중문화</div>
											      	<div class="item">중/고등학습</div>
											      	<div class="item">기술/공학</div>
											      	<div class="item">외국어</div>
											      	<div class="item">과학</div>
											      	<div class="item">취업/수험서</div>
											      	<div class="item">여행/기행</div>
											      	<div class="item">컴퓨터/IT</div>
											      	<div class="item">잡지</div>
											      	<div class="item">사전</div>
											      	<div class="item">청소년</div>
											      	<div class="item">초등참고서</div>
											      	<div class="item">유아</div>
											      	<div class="item">아동</div>
											      	<div class="item">어린이영어</div>
											      	<div class="item">만화</div>
											      	<div class="item">대학교재</div>
											      	<div class="item">어린이전집</div>
											      	<div class="item">한국소개도서</div>
											      	<div class="item">장르소설</div>
											      	<div class="item">로맨스/무협/판타지</div>
											      	<div class="item">가정/생활</div>
											      	<div class="item">외국도서</div>
											      	<div class="item">개인출판</div>
											      	<div class="item">오디오북</div>
											      	<div class="item">한국관련도서</div>
											      	<div class="item">UMI</div>
											      	<div class="item">ELT/영어교재</div>
											      	<div class="item">중국관련도서</div>
											      	<div class="item">일서메인</div>
											      	<div class="item">엔터테인먼트</div>
											      	<div class="item">라이트노벨</div>
											      	<div class="item">문고(포켓북)</div>
											      	<div class="item">신서(포켓북)</div>
											      	<div class="item">프랑스종합</div>
											      	<div class="item">독일종합</div>
											      	<div class="item">스페인종합</div>
											      	<div class="item">미분류</div>
												</div>
											</div>
										</div>
									</div>
									
									<div class="item">
										<input type="radio" name="readYN" id="readYN" value="Y">읽음
										<input type="radio" name="readYN" id="readYN" value="N" checked="checked">안읽음
									</div>
									
									<div class="item">
										<textarea rows="10" name="memo" id="memo" placeholder="Memo"></textarea>
									</div>
		
								</form>
											
									<div class="item">
										<button class="ui right floated basic button" id="bookAddBtn">
											<i class="plus icon"></i>
											책장에 넣기
										</button>
									</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>		
</body>
</html>