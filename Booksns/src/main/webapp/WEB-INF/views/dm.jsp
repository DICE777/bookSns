<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>책 SNS </title>


   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <link rel="stylesheet" type="text/css" href="./resources/semanticUI/semantic.css">
   <script src="./resources/semanticUI/semantic.js"></script>
   <link rel="stylesheet" href="./resources/css/menubar.css">
   <script src="./resources/js/menubar.js"></script>
	
	<!-- css -->
	<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.css">

<style type="text/css">
body{
    font-family: 'Raleway', sans-serif;
	background-color: #ACCEDC;
	margin: 50px 0px;
}
.dmContainer small{
	font-size: 12px;
}
.dmContainer h3, .dmContainer h5{
	margin: 0px;
}
.dmContainer{
	width: 650px;
	background-color: #fff;
	margin: auto;
}
.head-section{
	border-bottom:1px solid #E6E6E6;
	clear: both;
	overflow: hidden;
	width: 100%;
}

.headRight-section{
	width: 70%;
	float: left;
}
.headRight-sub{
	padding: 10px 15px 0px 15px;
}

.body-section{
	clear: both;
	overflow: hidden;
	width: 100%;
}

.mCustomScrollBox, .mCSB_container{
	overflow: unset !important;
}

.right-section{
	width: 100%;
	float: left;
	height: 500px;
	background-color: #F6F6F6; /*배경색  #F6F6F6 */
	position: relative;
}
.message{
	height: calc(100% - 68px);
	word-break:break-all;
}
.message ul{
	padding: 0px;
	list-style: none;
	margin: 0px auto;
	width: 95%;
	overflow:hidden;
}
.message ul li{
	position: relative;
	width: 95%;
	padding: 15px 0px;
	clear: both;
}
.message ul li.msg-left{
	float: left;
}
.message ul li.msg-left img{
	position: absolute;
	width: 40px;
	bottom: 30px;
}
.message ul li.msg-left .msg-desc{
	margin-left: 70px;
	font-size: 12px;
	background: #E8E8E8; /*채팅내용 #E8E8E8; */
	padding:5px 10px;
	border-radius: 5px 5px 5px 0px;
	position: relative;
}
.message ul li.msg-left .msg-desc:before{
	position: absolute;
	content: '';
	border:10px solid transparent;
	border-bottom-color: #E8E8E8; /* 화살표 #E8E8E8; */
	bottom: 0px;
	left: -10px;
}
.message ul li.msg-left small{
	float: right;
	color: #c1c1c1;
}

.message ul li.msg-right{
	float: right;
}
.message ul li.msg-right img{
	position: absolute;
	width: 40px;
	right: 0px;
	bottom: 30px;
}
.message ul li.msg-right .msg-desc{
	margin-right: 70px;
	font-size: 12px;
	background: #cce5ff;
	color: #004085;
	padding:5px 10px;
	border-radius: 5px 5px 5px 0px;
	position: relative;
}
.message ul li.msg-right .msg-desc:before{
	position: absolute;
	content: '';
	border:10px solid transparent;
	border-bottom-color: #cce5ff;
	bottom: 0px;
	right: -10px;
}
.message ul li.msg-right small{
	float: right;
	color: #c1c1c1;
	margin-right: 70px;
}
.message ul li.msg-day{
	border-top:1px solid #EBEBEB;
	width: 100%;
	padding: 0px;
	margin: 15px 0px;
}
.message ul li.msg-day small{
	position: absolute;
	top: -10px;
	background: #F6F6F6;
	color: #c1c1c1;
	padding: 3px 10px;
	left: 50%;
	transform: translateX(-50%);
}
.right-section-bottom{
	background: #fff;
	padding: 15px;
	position: absolute;
	bottom: 0px;
	border-top:1px solid #E6E6E6;
	text-align: center;
}
.right-section-bottom input{
	border:0px;
	padding:8px 5px;
	width: 550px;
}
.right-section-bottom .btn-send{
	border:0px;
	padding: 8px 10px;
	float: right;
	margin-left : 5px;
	margin-right: 30px;
	color: #009EF7;
	font-size: 18px;
	background: #fff;
	cursor: pointer;
}
</style>

<script>
   //주소에서 파라미터 값을 가져옴. 내가 get으로 설정해줘서.
   $.urlParam = function(name){
       var results = new RegExp('[\?&amp;]' + name + '=([^&amp;#]*)').exec(window.location.href);
       return results[1] || 0;
   }
   
   /* DM  */
   $(function(){
      $('#send').on('click',function(){
         submitFunction();
      });
   });
   
   //메시지 보내는 submit 기능
   function submitFunction(){
      
      var dmNum = "<%=session.getAttribute("dmNum")%>";
      var userId= "<%=session.getAttribute("userId")%>";
      var dmContent = $('#dmContent').val();
      
      var sendData = {
            "dmNum" : dmNum,
            "dmUserId" : userId,
            "dmContent" : dmContent            
      }
      
      $.ajax({
         method: "POST",
         url : "dmSubmit",
         data : JSON.stringify(sendData),
         dataType : 'json',
         contentType : 'application/json; charset=UTF-8'
      });
      //성공적으로 값을 보냈든 아니든 메시지 보냈으니 값을 비워줘.
      $('#dmContent').val('');
   }
   
   //dm내용 출력
   function dmContentList() {
      var userId = "<%=session.getAttribute("userId")%>";
      var followId = "<%=session.getAttribute("followId")%>";
      var dmNum ="<%=session.getAttribute("dmNum")%>";
      
      $.ajax({
         
         method: 'POST',
         url : 'dmContentList',
         data : {
            "followId" : followId,
            "dmUserId" : userId,
            "dmNum"   : dmNum
         },
          
         success : function(data){
            
             if(data==null){
                return;
             }else{
               $('#dmList').html('');
               
               
               for(i in data){
                  if(data[i].dmNum != null && data[i].dmUserId !=null && data[i].dmContent != null){
                	 
                		  addDm(data[i].dmNum,
                				data[i].dmUserId,
                				data[i].dmContent,
                				data[i].dmRegdate);  
                	  
                	  
                  }
               }   
             }
            
         }
         
      });
   }
    

   function addDm(dmNum,userid,dmContent,dmRegdate){
	 
	 var userId = "<%=session.getAttribute("userId")%>";
	 var followId = "<%=session.getAttribute("followId")%>";
	 
		 if(userid==userId){
			
			 $('#dmList').append(
					 '<li class="msg-right" style="margin-top:10px;">'+
		              '<div class="msg-right-sub">'+
		              '<img src="./resources/images/defaultAvatar.png" style="width: 50px; height: 50px; border-radius: 50%;">'+
		              '<div class="msg-desc">'+
		              dmContent+
		              '</div>'+
		              '<small>'+dmRegdate+'</small>'+
		              '</div>'+
		              '</li>'
			 );
			 
		 }else if(userid==followId){
			 
			 $('#dmList').append(
	    			 '<li class="msg-left">'+
	    	         '<div class="msg-left-sub">'+
	    	         '<img src="./resources/images/defaultAvatar.png" style="width: 50px; height: 50px; border-radius: 50%;">'+
	    	         '<label style="margin-left:70px;">'+'@'+userid+'<label>'+
	    	         '<div class="msg-desc">'+
	    	         dmContent+
	    	         '</div>'+
	    	         '<small>'+dmRegdate+'</small>'+
	    	         '</div>'+
	    	         '</li>'
	    	 );   
		 }
     
     $('#dmList').scrollTop($('#dmList')[0].scrollHeight);
   } 
    
    function getInfiniteDm(){ //몇 초 간격으로 새로운 메시지 가져오는 걸 의미
         
         setInterval(function(){
            dmContentList();
         },100); //3초에 1번씩 실행됨
      }
    
    function enterkey() {
        if (window.event.keyCode == 13) {
 
             // 엔터키가 눌렸을 때 실행할 내용
             submitFunction();
        }
	}
</script>
   
</head>
<body>
<!-- ====================================MENU================================================= -->

	<jsp:include page="./topMenu.jsp" flush="false"/>

<!-- ==============================================contetnt====================================================== -->

   <div class="dmContainer"  style="margin-top: 10px;">
         <div class="head-section" style="background: #231f20;">
            <div class="headRight-section">
				<div class="headRight-sub" style="height: 35px; color: white;">
            		@${sessionScope.followId}
				</div>
			</div>
         </div>
         
         <div class="body-section">
         	<div class="right-section">
         		<div class="message mCustomScrollbar" data-mcs-theme="minimal-dark">
		             <ul id="dmList" class="dmList">
						<!-- dm내용들어가는 곳 -->
					</ul>
	            </div>
            </div>
         </div>
         
 		<div class="right-section-bottom" id="dmInput">
			<form autocomplete=off>
				<input type="text" name="" id="dmContent" class="dmContent" placeholder="type here..." onkeypress="enterkey();">
				<input type="text" style="display: none;" />
				<button type="button" class="btn-send" name="send" id="send"><i class="fa fa-send"></i></button>
			</form> 
		</div>
   </div>
   
   
   
   
   <script type="text/javascript">
   $(document).ready(function(){
      dmContentList();
      getInfiniteDm();
   });
   </script>
   
   <!-- custom scrollbar plugin -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
</body>
</html>