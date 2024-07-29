<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세 페이지</title>
</head>
<body>
	<form>
		<input type="hidden" id="board_no" value="<c:out value='${detail.board_no }'/>">
		<label for="board_title">제목</label>
		<input type="text" id="board_title" value="<c:out value='${detail.board_title }'/>"><br>
		<label for="board_content">내용</label>
		<textarea id="board_content"><c:out value='${detail.board_content }'/></textarea><br>
		<input type="button" value="수정" onclick="boardUpdate();">
		<input type="reset" value="초기화">
	</form>
	<script>
		/* 수정버튼 누르면 일어날 일들..  */
		const boardUpdate = function(){
			const no = document.getElementById("board_no").value;
			const title = document.getElementById("board_title").value;
			const content = document.getElementById("board_content").value;
			
			const xhr = new XMLHttpRequest();
			/* boardUpdate 서블릿 url 명칭 */
			xhr.open("post","<%=request.getContextPath()%>/boardUpdate",true);
			/* 응답이 갔다 오면 어떻게?? */
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					const resp = xhr.responseText;
				}
			}
			/* 환경설정 */
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8");
			xhr.send("board_no="+no+"&board_title="+title+"&board_content="+content);
		}
	
	</script>
</body>
</html>