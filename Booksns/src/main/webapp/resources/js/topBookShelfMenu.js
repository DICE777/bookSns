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
      var currentPage = $("#currentPage").val();
      if (currentPage == null || currentPage == "") {
         if(searchCategory == "") {
            alert("내용을 입력해주세요");
            return;
         }
         
         location.href = "/sns/search/" + searchCategory + "?keyword=" + keyword;
      } else {
         location.href = "/sns/bookFind/?searchIsbn=" + keyword;
      }
      
      
      
      
      
   });
});