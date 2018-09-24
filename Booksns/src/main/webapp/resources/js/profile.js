
/*****modal******/
function ajax(num) {
	
	$('.ui.tare.modal').modal({
		onHide : function() {
			$('.ui.tare.modal').empty();
		}
	}).modal('hide');
	
	
	var feedNum = $('#feedNum'+num).val();
	var targetFeedNum = $('#targetFeedNum'+num).val();
	var originalFeedNum = $('#originalFeedNum'+num).val();
	
	
	$.ajax({
		url: "selectMention",
		data: {
			"feedNum" : feedNum,
			"targetFeedNum" : targetFeedNum,
			"originalFeedNum" : originalFeedNum
		},
		method : "get",
		success : function(list) {
			
			$.each(list, function(i, data){
				
				var tare = "";
				
						    	
		//=======================================userid======================================================		    
				tare += "<div class='ui segment>";
				tare += "<div class='mfeed' align='center'>";
				tare += "<div class='mfeedUser'>";
				if (data.saveFile == null) {
					tare += "<div class='label'><img class='profileImg' src='./resources/images/defaultAvatar.png'></div>";
				}
				if (data.saveFile != null) {
					tare += "<div class='label'>";
					tare += "<img src='" + data.saveFile + "'></div>";
				}
				tare += "<a href='profileForm?userId=" + data.userId + "'>";
				tare += data.userId;
				tare += "</a>";
				tare += "</div>";

		// ================================== targetId ======================================================= 	    
		
				tare += "<div class='mtarget'>"
				 if (data.viewTargetId != null) {
					 $.each(data.viewTargetId, function(j, item){
						if (j == 0) return;
			    		tare += "<a href='profileForm?userId=" + item + "'>@" + item + "</a>";
					 });
				} 			     	
			    tare += "</div>";
			    		
		// ================================== content+photo+regDate ========================================== 	    		
			     	
					tare += "<div id='mfeedContet" + i + "' align='center'>";
					tare += "<br>" + data.content + "<br>";
					tare += "<input type='hidden' id='feedNum" + i + "' value='" + data.feedNum + "'>";
					tare += "<input type='hidden' id='targetFeedNum" + i + "' value='" + data.targetFeedNum + "'>";
					tare += "<input type='hidden' id='originalFeedNum" + i + "' value='" + data.originalFeedNum + "'>";

	    			var photo = data.saveFile;
			   		if (photo != null) {
		    			var saveFile = photo.split(",");
		    			for(var k=0; k<saveFile.length; k++){
		    				tare += "<div class='image content'>";
    						tare += "<img class='tarae_img' src='./resources/images/FileRepo/"+saveFile[k]+"'>";
    						tare += "</div>";
				   		}
    				}
					tare += "<br>" + data.regDate + "<br>";
			    	tare += "</div>";
			
			    	
 		// ========================================= tag ======================================================== 	    		
			    		 
 					tare += "<div class='mfeedTag' align='center'>";
 					tare += data.tag;
 					tare += "</div>";
			    		 
			    		

		// ========================================= feedMenu =================================================== 	    		
			    	 
		
					tare += "<div class='mfeedMenu' align='center'>";
					tare += "<i class='large comment outline icon'/>";
					tare += "<i class='large heart outline icon'/>" + data.likeCount;
					tare += "<i class='large paper plane outline icon'/>" + data.spreadCount;
					tare += "</div>";
					tare += "</div>";
					tare += "</div>";
					
					$('.ui.tare.modal').append(tare);

	
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
