<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>${sessionScope.userId}</title>

	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	<!-- semantic UI -->
	<link rel="stylesheet" type="text/css" href="./resources/semanticUI/semantic.css">
	<script src="./resources/semanticUI/semantic.js"></script>
	
	<!-- AnyChart -->
	<link rel="stylesheet" href="https://cdn.anychart.com/releases/8.3.0/css/anychart-ui.min.css" />
	<link rel="stylesheet" href="https://cdn.anychart.com/releases/8.3.0/fonts/css/anychart-font.min.css" />
	<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-base.min.js"></script>
	<script src="https://cdn.anychart.com/releases/8.3.0/themes/monochrome.js"></script>
	<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-ui.min.js"></script>
	<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-exports.min.js"></script>
	<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-radar.min.js"></script>
	
	<!-- CSS & JavaScript -->
	<link rel="stylesheet" type="text/css" href="./resources/css/feed.css">
	<script src="./resources/js/modal.js"></script>
	<script src="./resources/js/chart.js"></script>
	<script src="./resources/js/forFeedJSP.js"></script>

	<style type="text/css">
		#introduce {
			resize: none;
			width: 100%;
			height: 100%;
		}

		#file {
			display: none;
		}
		
		/* .profileContent {
			width: 800px;
		} */

		/* .profileContainer {
			margin-top: 80px;
		} */

		/* .feed {
			margin-top: 50px;
		} */

		#container {
			/* width: 800px; */
			height: 400px;
			padding: 0;
			z-index: 1;
		}
    
		#tareModal {
			position: relative;
			padding: 30px;
			display: none;
		}

		.ui.tare.modal {
			padding: 1rem;
		}

		.img_show_example {
			width:50px;
			height:30px;
		}
		
		.tarae_img {
			width:50px;
			height:30px;
		}

		.feed .ui .segment {
			width: 40%;
		}

		.profile {
		    width: 100px; 
		    height: 100px;
		    object-fit: cover;
		    object-position: top;
		    border-radius: 50%;
		 }
		 textarea {
		 	border: none;
		 }
	</style>

	<script>

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
		
		/* 
		//define api somewhere once globally with all endpoints
		$.fn.api.settings.api = {
			'follow': '/follow?followId={id}/'
		};
		
		// add event handler, triggers '/follow/22'
		$('.follow.button')
			.api({
				action: 'follow user'
			})
			.state({
				onActivate: function() {
					$(this).state('flash text');
		    	},
		    	text: {
					inactive   : 'Follow',
		      		active     : 'Followed',
					deactivate : 'Unfollow',
					flash      : 'Added follower!'
		    	}
			});
		*/



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
		       mention += "<h3> <img class='mentionWriteProfile' style='width:70px; height:50px;float:left; ' src='./resources/images/FileRepo/"+resp.user.saveFile+"' />";
		    } else {
		       mention += "<h3> <img class='mentionWriteProfile' style='float:left; ' src='./resources/images/defaultAvatar.png' />";
		    }
	    
	   	 	mention += resp.user.userId+"</h3>"
	    
		    mention += "<div class='mentionWriteContent' align='center'>";
		    mention += resp.feed.content + "<br/>" + resp.feed.targetId+"<br/>" + resp.feed.tag;
		 	/*    
			var photo = resp.feed.saveFile;
			if (photo != null) {
				var saveFile = photo.split(",");
				for(var k=0; k<saveFile.length; k++){
					mention += "<img class='mention_img' src='./resources/images/FileRepo/"+saveFile[k]+"'>";
				}
			} 
			*/
		    mention += "</div>";
		    mention += "<div class='feedWrite' align='center'>";
		    
		    mention += "<h2 class='ui header left floated'>"
		    
		    if($("#userInfo").val()!=null) {
		       mention += "<img class='ui circular image'  src='./resources/images/FileRepo/"+$("#userInfo").val()+"'/>";
		    } else {
		       mention += "<img class='ui circular image'  src='./resources/images/defaultAvatar.png'/> "; 
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
		    mention += "<button class='ui basic button right floated' id='sending' onclick='writeMention()'>"; 
		    mention += "<i class='pencil alternate icon'></i>";
		    mention += "Write</button><br/>"
		    mention += "</div>";
		    mention += "</div>";
		    mention += "</div>";
		    mention += "</div>";
		    mention += "<input type='hidden' id='feedNum1' name='feedNum' value='"+resp.feed.feedNum+"'>";
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
	</script>
	
</head>

<body>


<!-- ================================================= MENU ================================================= -->

<jsp:include page="./topMenu.jsp" flush="false"/>
<input type="hidden" id="login" value="${sessionScope.userId }">

<!-- ============================================= User Profile ============================================= -->

<div class="defaultMain ui bottom attached padded">
	<div class="ui main text container">
	
		<div class="profileContainer" align="center">

			<div class="ui compact segment"  style="width: 100%;">
				<input type="hidden" id="followId" value="${user.userId }">
				<input type="hidden" id="followList" value="${follow }">
			
<!-- ============================================= follow button ============================================ -->

				<div class="ui list">
					
					<div class="item">
						<c:if test="${sessionScope.userId != user.userId }">
							<c:if test="${follow == false }">
								<a href="follow?followId=${user.userId }">
									<button class="ui right floated brown basic toggle button">Follow</button>
								</a>
							</c:if>
								
							<c:if test="${follow == true }">
								<a href="unfollow?followId=${user.userId }">
									<button class="ui right floated brown basic toggle button">Unfollow</button>
								</a>
							</c:if>
						</c:if>
					</div>
<!-- ============================================= profile photo ============================================ -->
						
					<div class="item">
						<div class="ui horizontal list">
							<c:if test="${user.saveFile == null }">
								<div class="item">
									<img class="profile" src="./resources/images/defaultAvatar.png">
									<h2>${user.userId }</h2>
								</div>
								<div class="item">
									<textarea id="introduce" name="introduce" readonly="readonly" placeholder="${user.introduce }"></textarea>
								</div>
							</c:if>
						</div>
							
						<div class="ui horizontal list">
							<c:if test="${user.saveFile != null }">
								<div class="item">
									<img class="profile" src="./resources/images/FileRepo/${user.saveFile }">
									<h2>${user.userId }</h2>
								</div>
								<div class="item">
									<textarea id="introduce" name="introduce" readonly="readonly" cols="50">${user.introduce }</textarea>
								</div>
							</c:if>
						</div>
					</div>
				
<!-- =============================================== statistics ============================================= -->

					<div class="item">
						<div id="container"></div>
					</div>
				
<!-- ================================================= button =============================================== -->
					
					<div class="item">
						<c:if test="${sessionScope.userId == user.userId}">
							
							<div class="ui left floated">
								<a href="followerList?userId=${user.userId }">팔로워 ${follower }</a>
								<a href="followingList?userId=${user.userId }">팔로잉 ${following }</a>
							</div>
							
							<a href="userUpdateForm">
								<button class="ui basic right floated button">
									<i class="address card outline icon"></i>
									프로필 수정
								</button>
							</a>
							<a href="storage">
			               		<button class="ui basic right floated button">
			               			<i class="heart icon"></i>
			               			보관함
			               		</button>
			           		 </a>
						</c:if>
						
						<c:if test="${sessionScope.userId != user.userId }">
							
							<div class="item">
								<a href="followerList?userId=${user.userId }">팔로워 ${follower }</a>
								<a href="followingList?userId=${user.userId }">팔로잉 ${following }</a>
							</div>						
						
							<a href="bookShelf?userId=${user.userId }">
								<button class="ui basic right floated button">
									<i class="book icon"></i>
									책장보기
								</button>
							</a>
						</c:if>
					</div>
				</div>
			</div>	
		</div>
		
		<div class="ui hidden divider"></div>
		    
<!-- ============================================= feed(div) ================================================ -->
		     
		<c:forEach varStatus="num" var="feed" items="${feed }">
		   	<div class="feed" align="left">	
		   		<div class="feedInner ui segment">
		   			<div class="ui list">
		
<!-- =============================================== userid ================================================== -->		    
				   
						<div class="item">
						   	<div class="feedUser">
						    	<c:if test="${feed.profilePic == null}">
									<img class="ui avatar image" src="./resources/images/defaultAvatar.png">
						    	</c:if>
						    	<c:if test="${feed.profilePic != null }">
									<img class="ui avatar image" src="./resources/images/FileRepo/${feed.profilePic }">
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
											<%-- <div class="item">
												<c:if test="${follow == false }">
													<a href="follow?followId=${feed.userId }">
														Follow
													</a>
												</c:if>
											
												<c:if test="${follow == true }">
													<a href="unfollow?followId=${feed.userId }">
														Unfollow
													</a>
												</c:if>
											</div> --%>
											<div class="item">DM</div>
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
<!-- ==============================================content+photo+regDate ================================================= -->	
    		
			    		
						<div class="item">
				    		<div id="feedContent${num.index}" onclick="ajax(${num.index})">
				    		<input type="hidden" id="feedNum${num.index }" value="${feed.feedNum }">
				    		<input type="hidden" id="targetFeedNum${num.index }" value="${feed.targetFeedNum }">
				    		<input type="hidden" id="originalFeedNum${num.index }" value="${feed.originalFeedNum }">
				    			<br>${feed.content }<br>
				    			<c:if test="${feed.photoYN eq 'Y'}">
					    			<c:forTokens items="${feed.saveFile }" delims="," var="photo">
										<img class="img_show_example" src="./resources/images/FileRepo/${photo}">
					    			</c:forTokens>
				    			</c:if>
				    			<br><font color="#c7c7c7">${feed.regDate }</font><br>
				    		</div>
				    	</div>
<!-- ============================================== tag ================================================= -->	

					   	<div class="item">	
					   		<div class="feedTag">
					   			${feed.tag }
					   		</div>
					   	</div>
					   		
<!-- ==============================================feedMenu ================================================= -->			    		

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
				    	
<!-- ==============================================end ================================================= -->			    	

		    		</div>
		    	</div>
		   	</div>
		</c:forEach> 
<!-- ==============================================타래 modal ================================================= -->		    

			
		<div class="ui tare modal" class="scrolling"></div>
		<div class="ui write modal" class="scrolling"></div>
	</div>
</div>	
<!-- ========================================== statistics value ============================================ -->
	
<c:if test="${ps != null }">
	<c:forEach varStatus="num" var="cg" items="${ps }">
		<input type="hidden" id="cg${num.index }" value="${cg.categories }">
		<input type="hidden" id="cnt${num.index }" value="${cg.cnt }">
		<input type="hidden" id="number" value="number${num.index }"><br>
	</c:forEach>
</c:if>
	
</body>
</html>