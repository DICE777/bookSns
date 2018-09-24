

//validation
$(function(){
	$('#searchbtn').click(function(){
		
		var searchIsbn = $('#searchIsbn').val();
		var login = $('#login').val();
		
		
		if(login == '') {
			alert("로그인해주세요");
			return;
		}
		
		if(searchIsbn == '') {
			alert("ISBN을 입력해주세요");
			return;
		}
		
		
	 		$('#bookFind').submit();
		
		
	});
});


$(function(){

	var isbn = $('#isbn').val();
	var title = $('#title').val();
	var authors = $('#authors').val();
	
	$('#bookAddBtn').click(function(){
		
		$.ajax({
			url: "dbBookFind",
			method: "post",
			data: {
				"isbn": isbn,
				"title": title,
				"authors": authors
			},
			success: function(resp) {
				if (resp == false) {
					alert("이미 등록된 책입니다!");
					return;
				}else {
					
					var memo = $('#memo').val();
					$('#memoInput').val(memo);
					var read = $('input[name="readYN"]:checked').val();
					$('#readYN').val(read);
					
					$('#bookAdd').submit();
				}
			}
		});
		
		
		
	});
});


