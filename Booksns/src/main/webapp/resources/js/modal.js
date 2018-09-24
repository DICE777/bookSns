

$(function(){
   
   $('.heart').on('click',function(){
      var heart = $(this);
      
      like(heart);
   });
   
});

function like(heart){
   
   var feedNum = heart.attr('data-num');

   
   $.ajax({
      url : 'goFavorite',
      method : 'post',
      data : {"feedNum" : feedNum},
   
      success : function(data){
         if(data ==1){
            heart.prop("class","large heart icon"); 
            window.location.reload();
         }else{
            heart.prop("class","large heart outline icon"); 
            window.location.reload();
         }
         
      }
      
   });
}


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
             tare += "<div id='mfeedContet" + i + "' align='center'>";
             tare += "<br>" + data.content + "<br>";
             tare += "<input type='hidden' id='feedNum" + i + "' value='" + data.feedNum + "'>";
             tare += "<input type='hidden' id='targetFeedNum" + i + "' value='" + data.targetFeedNum + "'>";
             tare += "<input type='hidden' id='originalFeedNum" + i + "' value='" + data.originalFeedNum + "'>";

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
                   like(heart);
                   window.location.reload();
                });
   
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


