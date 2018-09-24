function fileUploadAction() {
	console.log("fileUploadAction");
	$("#input_imgs").trigger('click');
}

function handleImgFileSelect(e) {
	// 이미지 정보들을 초기화
	// sel_files = [];
	// 안에있는 내용 사라지는데 이거 때매 복수로 등록이 안됬었음
	// 근데 필요할거 같으니 전송한다음에 바꾸던가 하자으
	// $(".img_part").empty();

	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);

	filesArr.forEach(function(f) {
		if (!f.type.match("image.*")) {
			alert("확장자는 이미 지 확장자만 가능합니다.");
			return;
		}
		sel_files.push(f);

		var reader = new FileReader();

		reader.onload = function(e) {
			var html = "<a href=\"javascript:void(0);\" class=\"img_class_all\"  onclick=\"deleteImageAction("
					+ index + ")\" id=\"img_id_" + index + "\">";
			html += "<img src=\""
					+ e.target.result
					+ "\" data-file='"
					+ f.name
					+ "' class='selProductFile' title='Click to remove'></a>";
			$(".img_part").append(html);
			index++;
		}

		reader.readAsDataURL(f);
	});
}

function deleteImageAction(index) {
	console.log("index:" + index);
	sel_files.splice(index, 1);

	var img_id = "#img_id_" + index;
	$(img_id).remove();

	console.log(sel_files);
}

function deleteImageAll() {
	sel_files.splice(0, sel_files.length - 1);

	var img_id = ".img_class_all";
	$(img_id).remove();
}

// 깐트롤러에 보내는 메써어드
function feedWrite() {
	var formData = new FormData();
	var content = $(".feed_write_area").val();
	var tag = $("#feed_tag_area").val();
	var targetId = $("#feed_spread_targetid").val();
	console.log(sel_files.length);
	
	for (var i = 0; i < sel_files.length; i++) {
		formData.append('files', sel_files[i]);
		console.log(sel_files[i]);
	}
	
	formData.append('file_count', sel_files.length);
	formData.append('content', content);
	formData.append('tag', tag);
	formData.append('targetId', targetId);

	$.ajax({
		type : 'POST',
		enctype : 'multipart/form-data',
		processData : false,
		contentType : false,
		cache : false,
		timeout : 600000,
		url : 'feedWrite',
		data : formData,
		success : function(result) {
			$(".feed_write_area").val("");
			$("#feed_tag_area").val("");
			$("#feed_spread_targetid").val("");
			deleteImageAll();
		},
		error : function(requestObject, error, errorThrown) {
			alert(error);
			alert(errorThrown);
		}
	});
}

/*******************************************************************************
 * ***************************멘션을 달기 위해 필요한 친구를 따로 또 만들어보자잉********************
 */
var sel_files1 = [];
// 이렇게 하면 특정 이미지가 삭제되긴하는데 다 없어졌을때 배열이 0이 되는게 아니라 넘어가버림..
var index1 = 0;

function fileUploadAction1() {
	$("#mentionFileUpload").trigger('click');
}
function handleImgFileSelect1(e) {

	// 이미지 정보들을 초기화
	// sel_files = [];
	// 안에있는 내용 사라지는데 이거 때매 복수로 등록이 안됬었음
	// 근데 필요할거 같으니 전송한다음에 바꾸던가 하자으
	// $("#img_wrap1").empty();

	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);

	filesArr.forEach(function(f) {
		if (!f.type.match("image.*")) {
			alert("확장자는 이미 지 확장자만 가능합니다.");
			return;
		}
		sel_files1.push(f);

		var reader = new FileReader();

		reader.onload = function(e) {
			var html = "<a href=\"javascript:void(0);\" class=\"img_class_all1\"  onclick=\"deleteImageAction1("
					+ index1 + ")\" id=\"img_id1_" + index1 + "\">";
			html += "<img src=\""
					+ e.target.result
					+ "\" data-file='"
					+ f.name
					+ "' class='img_show_example' title='Click to remove'></a>";
			$("#img_wrap1").append(html);
			index1++;
		}
		reader.readAsDataURL(f);
	});
}

function deleteImageAction1(index1) {
	console.log("index:" + index1);
	sel_files1.splice(index1, 1);

	var img_id = "#img_id1_" + index1;
	$(img_id).remove();

	console.log(sel_files1);
}

function deleteImageAll1() {
	sel_files1.splice(0, sel_files.length - 1);
	
	var img_id = ".img_class_all1";
	$(img_id).remove();
}

// 깐트롤러에 보내는 메써어드
function writeMention(num) {
	var formData = new FormData();
	var userId = $("#feed_userid").val();
	var feedNum = num;
	var content = $("#commentId").val();
	var tag = $("#mention_tag_area").val();
	var targetId = $("#mention_spread_targetid").val();
	console.log(sel_files1.length);
	
	for (var i = 0; i < sel_files1.length; i++) {
		formData.append('files', sel_files1[i]);
		console.log(sel_files1[i]);
	}
	
	formData.append('userId', userId);
	formData.append('feedNum', feedNum);
	formData.append('file_count', sel_files1.length);
	formData.append('content', content);
	formData.append('tag', tag);
	formData.append('targetId', targetId);

	$.ajax({
		type : 'POST',
		enctype : 'multipart/form-data',
		processData : false,
		contentType : false,
		cache : false,
		timeout : 600000,
		url : 'mentionInsert',
		data : formData,
		success : function(result) {
			$(".feed_write_area").val("");
			$("#feed_tag_area").val("");
			$("#feed_spread_targetid").val("");
			// deleteImageAll1();
			$('.ui.write.modal').modal('hide');
			alert(userId + "님에게 멘션달기 완료!!!");
		},
		error : function(requestObject, error, errorThrown) {
			console.log(error);
			console.log(errorThrown);
		}
	});
}

/*******************************************************************************
 * ***************************타xxx멘xx션을 달기 위해 필요한 친구를 따로 또 또
 * 만들어보자잉********************
 */

var sel_files2 = [];
var index2 = 0;

function fileUploadAction2() {
	$("#mentionFileUpload2").trigger('click');
}
function handleImgFileSelect2(e) {
	// 이미지 정보들을 초기화
	// sel_files = [];
	// 안에있는 내용 사라지는데 이거 때매 복수로 등록이 안됬었음
	// 근데 필요할거 같으니 전송한다음에 바꾸던가 하자으
	// $("#img_wrap1").empty();

	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);

	filesArr.forEach(function(f) {
		if (!f.type.match("image.*")) {
			alert("확장자는 이미 지 확장자만 가능합니다.");
			return;
		}
		sel_files2.push(f);

		var reader = new FileReader();

		reader.onload = function(e) {
			var html = "<a href=\"javascript:void(0);\" class=\"img_class_all2\"  onclick=\"deleteImageAction2("
					+ index1 + ")\" id=\"img_id2_" + index1 + "\">";
			html += "<img src=\""
					+ e.target.result
					+ "\" data-file='"
					+ f.name
					+ "' class='img_show_example' title='Click to remove'></a>";
			$("#img_wrap2").append(html);
			index2++;
		}

		reader.readAsDataURL(f);
	});
}

function deleteImageAction2(index1) {
	console.log("index:" + index2);
	sel_files2.splice(index1, 1);

	var img_id = "#img_id2_" + index1;
	$(img_id).remove();

	console.log(sel_files2);
}

function deleteImageAll2() {
	var img_id = ".img_class_all2";
	$(img_id).remove();
}

// 깐트롤러에 보내는 메써어드
function writeMention2(feedNumber) {
	var formData = new FormData();
	var userId = $("#feed_userid2").val();
	var feedNum = feedNumber;
	var content = $("#commentId2").val();
	var tag = $("#mention_tag_area2").val();
	var targetId = $("#mention_spread_targetid2").val();
	console.log(sel_files2.length);
	
	for (var i = 0; i < sel_files2.length; i++) {
		formData.append('files', sel_files2[i]);
		console.log(sel_files2[i]);
	}
	
	formData.append('userId', userId);
	formData.append('feedNum', feedNum);
	formData.append('file_count', sel_files2.length);
	formData.append('content', content);
	formData.append('tag', tag);
	formData.append('targetId', targetId);

	$.ajax({
		type : 'POST',
		enctype : 'multipart/form-data',
		processData : false,
		contentType : false,
		cache : false,
		timeout : 600000,
		url : 'mentionInsert2',
		data : formData,
		success : modalTaraeOutput,
		error : function(requestObject, error, errorThrown) {
			alert(error);
			alert(errorThrown);
		}
	});
}

function modalTaraeOutput(resp) {
	// $("#mentionfeed"+resp.feedNum).remove();

	var mention = "";
	mention += "<div class='mfeed' align='center'>";
	mention += "<div class='inner ui padded segment'>";
	
	if (resp.user.saveFile != null) {
		mention += "<h3> <img class='ui avatar image' style='width:70px; height:50px;float:left; ' src='./resources/images/FileRepo/"
				+ resp.user.saveFile + "' />";
	} else {
		mention += "<h3> <img class='ui avatar image' style='float:left; ' src='./resources/images/defaultAvatar.png' />";
	}

	mention += resp.user.userId + "</h3>"

	mention += "<div class='mentionWriteContent' align='center'>";
	mention += resp.feed.content + "<br/>" + resp.feed.targetId + "<br/>"
			+ resp.feed.tag;
	/*
	 * var photo = resp.feed.saveFile; if (photo != null) { var saveFile =
	 * photo.split(","); for(var k=0; k<saveFile.length; k++){ mention += "<img
	 * class='mention_img' src='./resources/images/FileRepo/"+saveFile[k]+"'>"; } }
	 */
	$.each(resp.photo, function(index, item) {
		mention += "<img class='img_show_example' src='./resources/images/FileRepo/" + item.saveImg + "'>";

	});
	
	mention += "</div>";
	mention += "</div>";
	mention += "</div>";
	// $(".feedWrote").remove();

	$("#mfeed" + resp.feedNum).append(mention);
	$("#mentionfeed" + resp.feedNum).remove();
}