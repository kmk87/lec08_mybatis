<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>
</head>
<body>
	<label for="board_title">제목</label>
	<input type="text" name="board_title" id="child_board_title"><br>
	<label for="board_content">내용</label>
	<textarea name="board_content" id="child_board_content"></textarea>
	<input type="button" value="등록" onclick="insertBoard();">
	<script>
	/* 자식에서 부모창으로 보내줌 list.jsp로 .. */
		const insertBoard = function(){
			const childTitle = document.getElementById("child_board_title").value;
			const childContent = document.getElementById("child_board_content").value;
			opener.document.getElementById("parent_board_title").value = childTitle;
			opener.document.getElementById("parent_board_content").value = childContent;
			window.close();
		
		}
		
		
		
		
	</script>
</body>
</html>