/**
 * 
 */
		var sel_files ="";
	
	$(function(){
		$(".upload").on("change",handleImgFileSelect);
	});
	function fileUploadAction(){
		console.log("fileUploadAction");
		$(".upload").trigger('click');
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
		/* 	reader.onload =function(e){
				var html = "/ <a href=\"javascript:void(0) /"; 
				html+= "onclick=\"deleteImageAction("+index+")\" id=\img_id_"+index+"\">"; 
				html+= "<img src=\""+e.target.result+"\" data-file='"+f.name+"' class='selProductFile' title='Click to remove'></a>";
				
				$("#img_part").append(html);
				index++;
			
			} */
			reader.onload = function(e){
				$("#img").attr("src",e.target.result)
			}
			reader.readAsDataURL(f);
		});
	}