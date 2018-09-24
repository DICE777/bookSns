$(function() {
	var userId = $('#login').val();
	var searchCategory = "";
	console.log(userId);
	
	$('.allMenu').dropdown({
		action: 'hide',
		onChange: function(value, $selectedItem) {
			/* 우측 메뉴 dropdown */
			if ($selectedItem == 'Home') {
				location.href = "/sns/getFeed?userId=" + userId;
			} else if ($selectedItem == '프로필') {
				location.href = "/sns/profileForm?userId=" + userId;
			} else if ($selectedItem == '서재') {
				location.href = "/sns/bookShelf?userId=" + userId;
			} else if ($selectedItem == '책 등록') {
				location.href = "/sns/bookFind";
			} else if ($selectedItem == '쪽지') {
				location.href = "/sns/dmGo";
			} else if ($selectedItem == '로그아웃') {
				location.href = "/sns/userLogout";
			}
		}
	});
	
	$('.searchCategory').dropdown({
		onChange: function(value, $selectedItem) {
			var searcyKeyword = $('#searchKeyword').val();
			if(searcyKeyword == "") return;
			
			/* 검색 카테고리 dropdown */
			if ($selectedItem == '책') {
				searchCategory = "book";
			} else if ($selectedItem == '피드') {
				searchCategory = "feed";
			} else if ($selectedItem == '사용자') {
				searchCategory = "user";
			} else if ($selectedItem == '태그') {
				searchCategory = "tag";
			}
		}
	});
	
	$("#btnSearch").click(function() {
		var keyword = $("#keyword").val();
		var nowPage = $("#nowPage").val();
		if (nowPage == null || nowPage == "") {
			if(searchCategory == "") {
				alert("검색 카테고리를 선택해주세요");
				return;
			}
			
			location.href = "/sns/search/" + searchCategory + "?keyword=" + keyword;
		} else {
			/* $.ajax({
	                url: "https://dapi.kakao.com/v2/search/book?target=title&target=isbn&target=publisher&query=" + keyword,
	                type: "get",
	                beforeSend: function(xhr) {
	                	 xhr.setRequestHeader("Authorization", "KakaoAK 62f3a956ce11a4820b9408378304d68d");
	                     xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	                },
	                dataType: "jsonp",
	                success: function(data) {
	                	alert(data);
	                },
	                error: function(data){
	                    alert(data.code); 
	                }
	            });*/
			
			
			/*$('#bookFind').submit();*/
			
			location.href = "bookFind?searchIsbn=" + keyword + "&page=1";
		}
		
		
	});
	
	$('#home').click(function(){
		location.href = "/sns/getFeed?userId=" + userId;
	});
	
	$('#profile').click(function(){
		location.href = "/sns/profileForm?userId=" + userId;
	});
	
	$('#library').click(function(){
		location.href = "/sns/bookShelf?userId=" + userId;
	});
	
	$('#add').click(function(){
		location.href = "/sns/bookFind";
	});
	
	$('#dm').click(function(){
		location.href = "/sns/dmGo";
	});
	
	$('#logout').click(function(){
		location.href = "/sns/userLogout";
	});
	
});

$(function(){
	   
    $.ajax({
       method : 'get',
       url : 'conutAlarm',
       success : function(data){
          if(data>0){
             $('.notification-counter').html(data);
          }else if(data==0){
             $('.notification-counter').remove();
    }
       }
       
    });
 
});


$(function(){
	   
	$.ajax({
       method : 'get',
       url : 'dmAlarm',
       success : function(data){
          if(data>0){
             $('.dmAlarmBox').html('<div><img src="./resources/images/problem_icon.png" style="position: absolute; top: 10px ;  left: 38px;  width: 15px; height: 15px;"></div>');
          }else if(data==0){
             $('.dmAlarmBox').remove();
    }
       }
       
    });
 
});







$(document).ready(function(){
	  $(".slideBtn").click(function(){    
	    if($("#sidenav").width() == 0){      
	        document.getElementById("sidenav").style.width = "250px";
	        document.getElementById("main").style.paddingRight = "250px";
	        document.getElementById("slidebtn").style.paddingRight = "250px";
	    }else{
	        document.getElementById("sidenav").style.width = "0";
	        document.getElementById("main").style.paddingRight = "0";
	        document.getElementById("slidebtn").style.paddingRight = "0";
	    }
	  });
	});