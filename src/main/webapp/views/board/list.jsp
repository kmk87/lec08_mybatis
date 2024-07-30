<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
</head>
<body>
	<input type="button" value="등록" onclick="openInsert();">
	<table border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>등록일</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty resultList }">
					<tr>
						<td colspan="5">게시글이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${resultList }" var="b" varStatus="status">
						<%-- <tr onclick="location.assign('<c:url value="/boardDetail?boardNo=${b.board_no }"/>')"> --%>
						<tr data-no="${b.board_no }">
							<%-- <td><c:out value="${status.count }"/></td> --%>
							<td><c:out value="${paging.numPerPage*(paging.nowPage-1)+status.count }"/></td>
							<!-- jstl에서 지정해준 b  -->
							<td><c:out value="${b.board_title }"/></td>
							<td><c:out value="${b.board_content }" /></td>
							<td><fmt:formatDate pattern="yy-MM-dd" value="${b.reg_date }"/> </td>
							<td>
								<button onclick="deleteBoard('${b.board_no}')">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	<c:if test="${not empty paging }">
		<div>
			<div>
				<c:if test="${paging.prev }">
				<!-- < 의 유니코드 -->
					<a href="<c:url value='/boardList?nowPage=${paging.pageBarStart-1 }'/>">&laquo;</a>
				</c:if>
				<c:forEach begin="${paging.pageBarStart }" end="${paging.pageBarEnd }" var="idx">
					<a href="<c:url value='/boardList?nowPage=${idx }'/>">${idx }</a>
				</c:forEach>
				<c:if test="${paging.next }">
				<!-- > 의 유니코드 -->
					<a href="<c:url value='/boardList?nowPage=${paging.pageBarEnd+1 }'/>">&raquo;</a>
				</c:if>
			</div>
		</div>
	</c:if>
<script>
/* 게시글 등록 */
	const openInsert = function(){
		let newWin = window.open("<%=request.getContextPath()%>/boardInsert","_blank","width=300,height=300");
	}


/* delete하기 위해 만들어줌 */
	const tds = document.querySelectorAll("table tr td:not(:last-child)");
	for(let i = 0; i < tds.length ; i++){
		tds[i].onclick = function(){
			const parent = this.parentNode;
			const boardNo = parent.dataset.no;
			location.href="<%=request.getContextPath()%>/boardDetail?boardNo="+boardNo;
		}
	}
	
	
	
	const deleteBoard = function(boardNo){
		const xhr = new XMLHttpRequest();
		/*boardNo 각 각:  url의 키값 / 매개변수의 값 */
		xhr.open('get','<%=request.getContextPath()%>/boardDelete?boardNo='+boardNo);
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				const resp = xhr.responseText; // 서블릿에서 받아오는 resp
				if(resp=='200'){
					alert("성공적으로 삭제되었습니다.");
					/* 화면전환 */
					location.href="<%=request.getContextPath()%>/boardList"; 
				} else{
					alert("게시글 삭제 중 오류가 발생하였습니다.");
				}
			} 
			
		}
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8");
		xhr.send();
		
		
	}
</script>
</body>
</html>