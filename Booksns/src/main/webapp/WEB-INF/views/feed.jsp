<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	<!-- semantic UI -->
	<link rel="stylesheet" type="text/css" href="http://localhost:8888/sns/resources/semanticUI/semantic.css">
	<script src="http://localhost:8888/sns/resources/semanticUI/semantic.js"></script>
	
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="http://localhost:8888/sns/resources/css/feed.css">

	<!-- JavaScript -->
	<script src="http://localhost:8888/sns/resources/js/modal.js"></script>
	<script src="http://localhost:8888/sns/resources/js/forFeedJSP.js"></script>

	<script type="text/javascript">
	
		function taraeMention(feedNum) {
			$(".mentionFeedTest").remove();
			//$("#mentionfeed"+feedNum).remove();   
		
			var mention ="";
			 
			mention += "<div id='mentionfeed"+feedNum+"' class='mentionFeedTest'>";
			mention += "<div class='feedWrite' align='center' class='feedWrote'>";
			mention += "<div class='inner ui padded segment' class='feedWrote'>";
			mention += "<h2 class='ui header left floated'>";
			 
			 if($("#userInfo").val()!=null) {
			    mention += "<img class='ui avatar image'  src='http://localhost:8888/sns/resources/images/FileRepo/"+$("#userInfo").val()+"'/>";
			 } else {
			    mention += "<img class='ui avatar image'  src='http://localhost:8888/sns/resources/images/defaultAvatar.png'/> "; 
			 }
			 
			 mention += "</h2>"
			 mention += "<div class='ui left icon input fluid'>";
			 mention += "<textArea class='feed_write_area' name='content' id='commentId2'></textArea>";
			 mention += "</div>"
			 mention += "<div class='ui search'>";
			 mention += "<div class='ui left icon input fluid'>";
			 mention += "<i class='users icon'></i>"
			 mention += "<input type='text'  id='mention_spread_targetid2' name='targetId' placeholder='placeholder='Search users...'/></div>";
			 
			 mention += "</div>";
			 mention += "<div class='results'></div>";
			 
			 mention += "<div class='ui left icon input fluid'>";
			 mention += "<i class='hashtag icon'></i>";
			 mention += "<input type='text' id='mention_tag_area2' name='tag' placeholder='Tags' /></div>";
			 
			 
			 mention += "<div id='img_wrap2'></div>";
			 mention += "<a href='javascript:' onclick='fileUploadAction2();' class='my_button'><button class='ui basic button right floated'><i class='images outline icon'></i>Photo</button></a>";
			 mention += "<input type='file' style='display:none;' id='mentionFileUpload2' name='mentionFileUpload' multiple/>";
			 mention += "<button class='ui basic button right floated' id='sending' onclick='writeMention2("+feedNum+")'>"; 
			 mention += "<i class='pencil alternate icon'></i>";
			 mention += "Write</button><br/>"
			    
			 mention += "</div>";
			 mention += "</div>";
			 mention += "</div>";
		
		 	$("#mfeed"+feedNum).append(mention);
		     
			$(function() {
				$("#mentionFileUpload2").on("change", handleImgFileSelect2);
			});
		}
	
	</script>
	
	<script type="text/javascript">
		//이미지 정보들을 담을 배열
		var sel_files = [];
		//이렇게 하면 특정 이미지가 삭제되긴하는데 다 없어졌을때 배열이 0이 되는게 아니라 넘어가버림..
		var index = 0;
		$(function() {
			$("#input_imgs").on("change", handleImgFileSelect);
		});
		
		var login = $('#login').val();
		var content = [];
		var followList = $('#follow').val();
		
		$(function() {
			$.each(followList, function(ind, follow) {
				var tmp = "{ title: '" + follow.followId + "' }";
				content.push(tmp);
			});
		
			$('.ui.search').search({
				source: content
			});
		});
	
		$(function() {
			$('.ui.top.left.pointing.dropdown').dropdown({
				action: 'hide',
				onChange: function($selectedItem, value) {
					if (value == 'Follow') {
			 			location.href="follow?followId=" + $selectedItem;
					}
					if (value == 'Unfollow') {
						location.href="unfollow?followId=" + $selectedItem;
					}
				}
			});
		});
	
		function mentionWriteFunction(feedNum) {
			$.ajax({
				url : "mentionForm",
				method : "get",
				data : {
					feedNum : feedNum
				},
				success : output
			});
		}
	
		function output(resp) {
		    var mention="";
		    
		    mention += "<div class='mfeed' align='center'>";
		    mention += "<div class='inner ui padded segment'>";
		    
		    if(resp.user.saveFile != null) {
		       mention += "<h3> <img class='ui circular image' style='width:70px; height:50px;float:left; ' src='http://localhost:8888/sns/resources/images/FileRepo/"+resp.user.saveFile+"' />";
		    } else {
		       mention += "<h3> <img class='ui circular image' style='float:left; ' src='http://localhost:8888/sns/resources/images/defaultAvatar.png' />";
		    }
		    
		    mention += resp.user.userId+"</h3>"
		    
		    mention += "<div class='mentionWriteContent' align='center'>";
		    mention += resp.feed.content+"<br/>"+resp.feed.targetId+"<br/>"+resp.feed.tag;
		 	/* var photo = resp.feed.saveFile;
		       if (photo != null) {
		       var saveFile = photo.split(",");
		       for(var k=0; k<saveFile.length; k++){
		          mention += "<img class='mention_img' src='./resources/images/FileRepo/"+saveFile[k]+"'>";
		          }
		    } */
		    mention +="</div>";
		    mention +="<div class='feedWrite' align='center'>";
		    
		    mention +="<h2 class='ui header left floated'>"
		    if($("#userInfo").val()!=null) {
		       mention += "<img class='ui circular image'  src='http://localhost:8888/sns/resources/images/FileRepo/"+$("#userInfo").val()+"'/>";
		    }else{
		       mention += "<img class='ui circular image'  src='http://localhost:8888/sns/resources/images/defaultAvatar.png'/> "; 
		    }
		    
		    mention += "</h2>"
		    mention += "<div class='ui left icon input fluid'>";
		    mention += "<textArea class='feed_write_area' name='content' id='commentId'></textArea>";
		    mention += "</div>"
		    mention += "<div class='ui search'>";
		    mention += "<div class='ui left icon input fluid'>";
		    mention += "<i class='users icon'></i>"
		    mention += "<input type='text'  id='mention_spread_targetid' name='targetId' placeholder='placeholder='Search users...'/></div>";
		    
		    mention += "</div>";
		    mention += "<div class='results'></div>";
		    
		    mention += "<div class='ui left icon input fluid'>";
		    mention += "<i class='hashtag icon'></i>";
		    mention += "<input type='text' id='mention_tag_area' name='tag' placeholder='Tags' /></div>";
		    
		    mention += "<div id='img_wrap1'></div>";
		    mention += "<a href='javascript:' onclick='fileUploadAction1();' class='my_button'><button class='ui basic button right floated'><i class='images outline icon'></i>Photo</button></a>";
		    mention += "<input type='file' style='display:none;' id='mentionFileUpload' name='mentionFileUpload' multiple/>";
		    mention += "<button class='ui basic button right floated' id='sending' onclick='writeMention("+resp.feed.feedNum+")'>"; 
		    mention += "<i class='pencil alternate icon'></i>";
		    mention += "Write</button><br/>"
		    mention += "</div>";
		    mention += "</div>";
		    mention += "</div>";
		    mention += "</div>";
		    
		    mention += "<input type='hidden' id='feed_userid' name='feed_userid' value='"+resp.feed.userId+"'>";
		    
		    $('.ui.write.modal').append(mention);
		    
			$('.ui.write.modal').modal({
				onHide : function() {
					$('.ui.write.modal').html('');
				},
				closable : true
			}).modal('show');
			
			$(function() {
				$("#mentionFileUpload").on("change", handleImgFileSelect1);
			});
		}
		
		
		<!-- 페이징 처리를 위한 아이~!!!! 10개씩 나눔. -->
		var page = 1;
		$(window).on("scroll", function() {
		   
		   
		       var scrollHeight = $(document).height(); 
		        var scrollPosition = $(window).height() + $(window).scrollTop();
		        console.log(scrollHeight + ", " + scrollPosition);
		    
		       if(scrollHeight==Math.ceil(scrollPosition) || scrollHeight<Math.ceil(scrollPosition)){
		          
		    	   total=$("#getTotal").val();
		           page =page + 1; 
		            if(total == page || total < page){
		              return;
		           }
		          
		          $.ajax({
		             url : "upcomingFeed",
		             method : "get",  
		             data : {page : page},
		             success : upcomigFeed,
		             error: function(requestObject, error, errorThrown) {
		                     alert(error); 
		                     alert(errorThrown);
		                }
		             
		             
		             
		          })
		       }
		    }); 
		    function upcomigFeed(resp){
		        /* if(resp.total <page){
		          break
		       }  */
		       var login = $('#login').val();
		       var mention = "";
		       //<!-- ============================================= feed(div) ================================================ -->
		       $.each(resp.feed,function(index,item){
		         mention +=  "<div class='feed' align='left'>";
		         mention += "<div class='feedInner ui segment'>";
		         mention += "<div class='ui list'>";
		         //===================== userid ===========================
		         mention += "<div class='item'>";
		         mention += "<div class='feedUser'>";
		         if(item.profilePic == null){
		            mention += "<img class='ui avatar image' src='./resources/images/defaultAvatar.png'>";
		         }else{
		            mention += "<img class='ui avatar image' src='./resources/images/FileRepo/"+item.profilePic+"'>";
		         }
		         //<!-- 로그인한 아이디랑 feed userid랑 같을때 -->
		         if(login==item.userId){
		            mention += "<div class='ui top left pointing floating dropdown'>";
		            mention += "<div class='content'>"+item.userId+"</div>";
		            mention += "<div class='menu'>";
		            mention += "<div class='item'>";
		            mention += "<a href='profileForm?userid="+item.userId+"'>"+item.userId+"</a>";
		            mention += "</div>";
		            mention += "</div>";
		            mention += "</div>";
		         }//<!-- 로그인한 아이디랑 feed userid랑 다를때 -->
		         else{
		            mention += "<div class='ui top left pointing dropdown'>";
		            mention += "<div class='content'>"+item.userId+"</div>";
		            mention += "<div class='menu'>";
		            mention += "<div class='item'>";
		            mention += "<a href='profileForm?userid="+item.userId+"'>"+item.userId+"</a>";
		            mention += "</div>";
		            mention += "<div class='item' data-value='"+item.userId+"'>";
		            if(resp.follow==0){
		               mention += "<a href='follow?followId="+item.userId+"'> Follow </a>";
		            }else if(resp.follow==1){
		               mention += "<a href='follow?followId="+item.userId+"'> UnFollow </a>";
		            }
		            mention += "</div>";
		            mention +="<div class='item'><a href='dmGo'>DM</div>";
		            mention +="</div>"
		               mention +="</div>"
		         }
		            mention +="</div>";
		            mention +="</div>";
		//=================================== targetId ==========================
		      mention += "<div class='item'>";
		      mention += "<div class='feedTarget'>";
		         if(item.viewTargetId !=null){
		            
		            $.each(item.viewTargetId,function(index,targetId){
		               if(index>0){
		                  mention += "<a href='profileForm?userid='"+targetId+"><b>@"+targetId+"</b></a>";
		            }
		            });
		            
		         };
		         mention += "</div>";
		         mention += "</div>";
		         //============================= content+photo+regDate ====================
		         mention += "<div class='item'>";
		         mention += "<div id='feedContent"+index+"' onclick='ajax("+index+")'>";
		         mention += "<input type='hidden' id='feedNum"+index+"' value='"+item.feedNum+"'>";
		         mention += "<input type='hidden' id='targetFeedNum"+index+"' value='"+item.targetFeedNum+"'>";
		         mention += "<input type='hidden' id='originalFeedNum"+index+"' value='"+item.originalFeedNum+"'></br>";
		         mention += "<br>"+item.content +"<br>";
		         if(item.photoYN === 'Y'){
		         var photo = item.saveFile;
		             
		               
		              var saveFile = photo.split(",");
		              for(var k=0; k<saveFile.length; k++){
		                 mention += "<img class='img_show_example' src='./resources/images/FileRepo/"+saveFile[k]+"'>";
		                }
		         };
		         mention += "<br><font color='#c7c7c7'>"+item.regDate+"</font><br>";
		         mention +="</div>";
		         mention +="</div>";
		         
		          //================ tag =====================
		           mention += "<div class='item'>";
		           mention += "<div class='feedTag'>"+item.tag+"</div>";
		           mention += "<div class='feedMenu'>";
		           mention += "</div>";
		           
		           //================= feedMenu ===================
		           mention += "<div class='item'>";
		           mention += "<div class='feedMenu'>";
		           mention += "<i class='large comment outline icon' onclick='mentionWriteFunction("+item.feedNum+")'></i>";
		           mention += " <input type='hidden' class='feedNum' value='"+item.feedNum+"'>";
		        if(item.favoriteCheck==0){
		           mention +="<i class='large heart outline icon' data-num='"+item.feedNum+"'></i>"+item.likeCount;
		        }else if(item.favoriteCheck==1){
		           mention +="<i class='large heart icon' data-num='"+item.feedNum+"'></i>"+item.likeCount;
		        }
		        
		         
		           mention += "<i class='large paper plane outline icon'></i>"+item.spreadCount;
		           mention +="</div>";
		           mention +="</div>";
		          //=========================end=======================
		           mention +="</div>";
		           mention +="</div>";
		           mention +="</div>";
		       });
		      
		       $("#feedWrapBox").append(mention);
		       
		    }
		    

	</script>
	
	<title>Feed</title>
</head>

<body>

<!-- ================================================= MENU ================================================= -->

	<jsp:include page="./topMenu.jsp" flush="false"/>
	<input type="hidden" id="login" value="${sessionScope.userId }">
	
<!-- =============================================== FeedList =============================================== -->

	<div class="defaultMain ui bottom attached padded" id="main">
		<div class="ui main text container">

<!-- ==================================== 밑에 피드 부분 시작은 글쓰기 부분부터 ====================================== -->		
			
			<div class="feedWrite fluid" align="center">
				<div class="ui padded segment">
					<input type="hidden" id="follow" value="${follow}">
						<c:if test="${user.saveFile != null }">
							<img src="http://localhost:8888/sns/resources/images/FileRepo/${user.saveFile }" class="profile">
							<b>${sessionScope.userId }</b>
						</c:if>
						<c:if test="${user.saveFile == ''}">
							<img src="http://localhost:8888/sns/resources/images/defaultAvatar.png" class="profile">
							<b>${sessionScope.userId }</b>
						</c:if>
						
						<div class="ui list">
						
							<div class="item">
								<div class="ui left icon input fluid">
									<textArea name="content" class="feed_write_area" placeholder="write here"></textArea>
								</div>
							</div>
							
							<div class="item">
								<div class="ui search">
									<div class="ui left icon input fluid">
										<input class="prompt" type="text" placeholder="Search users..." id="feed_spread_targetid" name="targetId">
											<i class="users icon"></i>
									</div>
									<div class="results"></div>
								</div>
							</div>
							
							<div class="item">
								<div class="ui left icon input fluid">
									<input type="text" placeholder="Tags" id="feed_tag_area" name="tag">
									<i class="hashtag icon"></i>
								</div>
							</div>
							
							<div class="img_part"></div>
							
							<div class="item">
								<button class="ui basic button right floated" id="feed_write" onclick="feedWrite()">
									<i class="pencil alternate icon"></i>
									Write
								</button>
								<a href="javascript:" onclick="fileUploadAction();" class="my_button">
									<button class="ui basic button right floated">
										<i class="images outline icon"></i>
										Photo
									</button>
								</a> 
								<input type="file" id="input_imgs" class="input_imgs" name="upload" multiple />
							</div>
						</div>
				</div>
			</div>
			
			<div class="ui hidden divider"></div>
			<div id="feedWrapBox"></div>
<!-- ============================================= feed(div) ================================================ -->
			     
			     <c:forEach varStatus="num" var="feed" items="${feed }">
			    	<div class="feed" align="left">	
			    		<div class="feedInner ui segment">
			    			<div class="ui list">
			
<!-- =============================================== userid ================================================== -->
					   
					   		<div class="item">
						    	<div class="feedUser">
							    	<c:if test="${feed.profilePic == null}">
										<img class="ui avatar image" src="http://localhost:8888/sns/resources/images/defaultAvatar.png">
							    	</c:if>
							    	<c:if test="${feed.profilePic != null }">
										<img class="ui avatar image" src="http://localhost:8888/sns/resources/images/FileRepo/${feed.profilePic }">
							    	</c:if>
							    
							    	<!-- 로그인한 아이디랑 feed userid랑 같을때 -->
							    	<c:if test="${sessionScope.userId == feed.userId }">
								    	<div class="ui top left pointing floating dropdown">
									    	<div class="content">
									    		${feed.userId }
									    	</div>
											<div class="menu">
												<div class="item"><a href="profileForm?userId=${feed.userId}">${feed.userId }</a></div>
											</div>
										</div>
							    	</c:if>
					    	
							    	<!-- 로그인한 아이디랑 feed userid랑 다를때 -->
							    	<c:if test="${sessionScope.userId != feed.userId }">
								    	<div class="ui top left pointing dropdown">
									    	<div class="content">
									    		${feed.userId }
									    	</div>
											<div class="menu">
												<div class="item"><a href="profileForm?userId=${feed.userId}">${feed.userId }</a></div>
	<%-- 											<div class="item" data-value="${feed.userId }">
													<c:if test="${follow == false }">
														<a href="follow?followId=${user.userId }">
															Follow
														</a>
													</c:if>
												
													<c:if test="${follow == true }">
														<a href="follow?followId=${user.userId }">
															Unfollow
														</a>
													</c:if>
												</div> --%>
												<div class="item">
													<a href="dmGo">
														DM
													</a>
												</div>
											</div>
										</div>
							    	</c:if>
				    			</div>
				    		</div>	
			
<!-- ============================================== targetId ================================================= -->
				    
						    <div class="item">	
						    	<div class="feedTarget">
						    		<c:if test="${feed.viewTargetId != null }">
						    			<c:forEach var="targetId" items="${feed.viewTargetId }" begin="1">
									    	<a href="profileForm?userId=${targetId}"><b>@${targetId}</b></a>
						    			</c:forEach>
						    		</c:if>
						    	</div>	
						    </div>
						    
<!-- ======================================== content+photo+regDate ========================================== -->	
				    		
							<div class="item">
					    		<div id="feedContent${num.index}" onclick="ajax(${num.index})">
					    		<input type="hidden" id="feedNum${num.index }" value="${feed.feedNum }">
					    		<input type="hidden" id="targetFeedNum${num.index }" value="${feed.targetFeedNum }">
					    		<input type="hidden" id="originalFeedNum${num.index }" value="${feed.originalFeedNum }">
					    			<br>${feed.content }<br>
					    			<c:if test="${feed.photoYN eq 'Y'}">
						    			<c:forTokens items="${feed.saveFile }" delims="," var="photo">
											<img class="img_show_example" src="http://localhost:8888/sns/resources/images/FileRepo/${photo}">
						    			</c:forTokens>
					    			</c:if>
					    			<br><font color="#c7c7c7">${feed.regDate }</font><br>
					    		</div>
					    	</div>
		
<!-- ================================================= tag =================================================== -->
				    		
					    	<div class="item">	
					    		<div class="feedTag">
					    			${feed.tag }
					    		</div>
					    	</div>	
					    	
<!-- =============================================== feedMenu ================================================= -->				    		
				    	
				    		<div class="item">
				    		
					  	        <div class="feedMenu">
					                <input type="hidden" class="feedNum" value="${feed.feedNum }">
					              	<i class="large comment outline icon" onclick="mentionWriteFunction(${feed.feedNum})"></i>
					                <c:if test="${feed.favoriteCheck == 0}">
					                <i class="large heart outline icon" data-num="${feed.feedNum }"></i>${feed.likeCount }
					                </c:if>
					                <c:if test="${feed.favoriteCheck == 1}">
					                <i class="large heart icon" data-num="${feed.feedNum }"></i> ${feed.likeCount }
					                </c:if>
						   			<i class="large paper plane outline icon"></i>${feed.spreadCount }
						    	</div>
				    		</div>
				    		
<!-- ================================================= end ==================================================== -->
				    		
				    	</div>
			    	</div>
			   	</div>
		    </c:forEach> 
			    
<!-- ============================================== 타래 modal ================================================= -->
			
			<div class="ui tare modal" class="scrolling"></div>
			<div class="ui write modal" class="scrolling"></div>
					
		</div>
	</div>
	<input type="hidden" id="getTotal" value="${total}"/>
</body>
</html>