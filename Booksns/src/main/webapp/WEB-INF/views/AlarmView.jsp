<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- CSS -->
<link rel="stylesheet" type="text/css"
   href="http://localhost:8888/sns/resources/css/feed.css">
<!-- JavaScript -->
<script>

   function ajax(num) {
      
      $('.ui.tare.modal').modal({
         onHide : function() {
            $('.ui.tare.modal').empty();
         }
      }).modal('hide');
      
      
      var feedNum = $('#feedNum'+num).val();
      
      
      
      $.ajax({
         url: "AlarmFeed",
         data: {
            feedNum : feedNum,
           
         },
         method : "get",
         success : function(data) {
            
           
               
               var tare = "";
               
                            
         <!-- ================================= userid ===================================================== -->          
                 tare += "<div id='mfeed"+data.feedNum+"'>";
                 
               tare += "<div class='mfeed' align='center'>";
               tare += "<div class='ui list'>";
               tare += "<div class='item'>";
               tare += "<div class='mfeedUser'>";
               if (data.profilePic == null) {
                  tare += "<img src='./resources/images/defaultAvatar.png' class='ui avatar image'>";
               }
               if (data.profilePic != null) {
                  tare += "<img src='./resources/images/FileRepo/" + data.profilePic + "' class='ui avatar image'>";
               }
               tare += "<a href='profileForm?userId=" + data.userId + "'>";
               tare += "<b>" + data.userId + "</b>";
               tare += "</a>";
               tare += "</div>";
               tare += "</div>";

         <!-- ================================== targetId ======================================================= -->       
            
               tare += "<div class='item'>";
               tare += "<div class='mtarget'>"
                if (data.viewTargetId != null) {
                   $.each(data.viewTargetId, function(j, item){
                     if (j == 0) return;
                      tare += "<a href='profileForm?userId=" + item + "'><b>@" + item + "</b></a>";
                   });
               }                  
                tare += "</div>";
                tare += "</div>";
                      
         <!-- ================================== content+photo+regDate ========================================== -->             
                  
                tare += "<div class='item'>";
                tare += "<div id='mfeedContet' align='center'>";
                tare += "<br>" + data.content + "<br>";
                tare += "<input type='hidden' id='feedNum' value='" + data.feedNum + "'>";
                tare += "<input type='hidden' id='targetFeedNum' value='" + data.targetFeedNum + "'>";
                tare += "<input type='hidden' id='originalFeedNum' value='" + data.originalFeedNum + "'>";

                var photo = data.saveFile;
                  if (photo != null) {
                  var saveFile = photo.split(",");
                  for(var k=0; k<saveFile.length; k++){
                     tare += "<img class='tarae_img' src='./resources/images/FileRepo/"+saveFile[k]+"'>";
                    }
                }
                tare += "<br>" + data.regDate + "<br>";
                tare += "</div>";
                tare += "</div>";
                   
          <!-- ========================================= tag ======================================================== -->             
                   
             tare += "<div class='item'>";
               tare += "<div class='mfeedTag' align='center'>";
               tare += data.tag;
               tare += "</div>";
               tare += "</div>";
                      

         <!-- ========================================= feedMenu =================================================== -->             
                    
               tare +="<div class='item'>";
               tare += "<div class='mfeedMenu' align='center'>";
               tare += "<input type='hidden' id='feedNum' value=" + data.feedNum + "'>";
               tare += "<i class='large comment outline icon' onclick='taraeMention("+data.feedNum+")'/>";
               if(data.favoriteCheck == 0){
               tare += "<i class='large heart modalheart outline icon ' id='heart' data-num="+data.feedNum+"/>" + data.likeCount;
               }else if(data.favoriteCheck == 1){
               tare += "<i class='large heart modalheart icon' data-num="+data.feedNum+"/>" + data.likeCount;
               }
               tare += "<i class='large paper plane outline icon'/>" + data.spreadCount;
               tare += "</div>";
               tare += "</div>";
               tare += "</div>";
              
               tare += "</div>";
               tare += "<div class='ui divider'></div>";
                  
                  $('.ui.tare.modal').append(tare);
                  $('.modalheart').on('click',function(){
                      var heart = $(this);
                      like(하트);
                      window.location.reload();
                   });
      
            
            
            
            $('.ui.tare.modal').modal({
               onHide : function() {
                  $('.ui.tare.modal').html('');
               }
            }).modal('show');
            
         },
         error : function(data) {
            
         }
      });
         
      
   }
   
   </script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Alarm list</title>

</head>
<body>


   <!-- ====================================MENU================================================= -->

   <jsp:include page="./topMenu.jsp" flush="false" />

   <!-- ============================================= List ================================================ -->
   <div class="ui hidden divider"></div>
   <div class="defaultMain ui bottom attached padded">
      <div class="ui main text container" align="center">

		<c:if test="${alarmList == null }">
			아무것도 없음
		</c:if>
		
		
		<c:if test="${alarmList != null }">
	         <c:forEach varStatus="num" var="al" items="${alarmList}">
	
	            <div class="ui feed" align="center">
	               <div class="event">
	                  <div class="label">
	                     <c:if test="${al.profilePic == null}">
	                        <img class="ui avatar image"
	                           src="./resources/images/defaultAvatar.png">
	                     </c:if>
	                     <c:if test="${al.profilePic != null }">
	                        <img class="ui avatar image"
	                           src="./resources/images/FileRepo/${al.profilePic }">
	                     </c:if>
	                  </div>
	                  <div class="content" id="feedContent${num.index}" onclick="ajax(${num.index})">
	                     <input type="hidden" id="feedNum${num.index }" value="${al.fkNum }">
	                        
	                     <c:if test="${al.noticeType == 'mention'}">
	           			    <a>${al.loginId}</a> mentioned you &nbsp; ${al.regDate}
	             		 </c:if>
	                     <c:if test="${al.noticeType == 'like'}">
	               			<a>${al.loginId}</a> like your feed &nbsp; ${al.regDate}
	               		 </c:if>
	               		 <c:if test="${al.noticeType == 'unfollow' }">
	               		 	${al.loginId} Unfollow you &nbsp; ${al.regDate}
	               		 </c:if>
	               		 <c:if test="${al.noticeType == 'follow' }">
	               		 	${al.loginId} Follow you &nbsp; ${al.regDate}
	               		 </c:if>
	               		  <c:if test="${al.noticeType == 'book' }">
	               		 	you have a unread book in your library
	               		 </c:if>
	               <div class="extra text">
	               ${al.content}<br/>
	               ${al.tag}
	               <c:if test="${al.saveFile !=null }">
	               <c:forTokens var="photo" items="${al.saveFile}" delims=",">
	               <c:if test="${ al.noticeType == 'book'}">
	               <img style="width:50px;height:30px;" class="imgAlarm" src="${photo}"/>
	               </c:if>
	               <c:if test="${ al.noticeType != 'book'}">
	               <img style="width:50px;height:30px;" class="imgAlarm" src="./resources/images/FileRepo/${photo}"/> 
	               </c:if>
	              
	               </c:forTokens>
	               </c:if>
	               </div>
	
	
	
	                  </div>
	               </div>
	            </div>
	         </c:forEach>
		</c:if>

      </div>
   </div>

   <div class="ui tare modal" class="scrolling"></div>

</body>
</html>