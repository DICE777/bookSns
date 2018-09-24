$(function(){
	var userId = $('#login').val();
	$('.ui.selection.dropdown').dropdown({
		action: 'hide',
		onChange: function(value, $selectedItem) {
			if ($selectedItem == '프로필') {
				location.href = "profileForm?userId=" + userId;
			}
			if ($selectedItem == '책 등록') {
				location.href = "bookFind"
			}
			if ($selectedItem == 'Home') {
				location.href = "getFeed?userId=" + userId;
			}
			if ($selectedItem == '로그아웃') {
				location.href = "userLogout";
			}
			if ($selectedItem == '서재') {
	            location.href = "bookShelf?userId=" + userId;
	        }
			if ($selectedItem == '쪽지') {
				location.href = "dmGo";
			}
		}
	});
});
