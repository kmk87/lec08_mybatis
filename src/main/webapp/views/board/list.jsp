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
	<form action="<c:url value='/boardList'/>" method="get" id="searchFrm">
		<select name="order_type" id="order_type">
			<option value="1" <c:if test="${paging.order_type == '1' }">selected </c:if>>최신순</option>
			<option value="2" <c:if test="${paging.order_type == '2' }">selected </c:if>>오래된순</option>
		</select>
		<input type="text" name="board_title" placeholder="검색 제목을 입력하세요"
		value="<c:out value='${paging.board_title }'/>">
		<input type="text" name="board_content" placeholder="검색 내용을 입력하세요"
		value="<c:out value='${paging.board_content }'/>">
		<input type="submit" value="검색">
	
	</form>
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
							<td><fmt:formatDate pattern="yy-MM-dd hh:mm:ss" value="${b.reg_date }"/> </td>
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
	<!-- 자식창의 도착지 -->
	<form style="display:none;" action="<c:url value='/boardInsertEnd'/>" method="post" id="insertFrm">
		<label for="parent_board_title">제목</label>
		<input type="text" id="parent_board_title" name="board_title">
		<label for="parent_board_content">내용</label>
		<textarea name="board_content" id="parent_board_content"></textarea>
		<input type="button" value="등록" onclick="insertBoard();">
	</form>
<script>
/* 검색한 목록 정렬 */
 	const orderType = document.getElementById("order_type");
 	orderType.onchange = function(){
 		document.getElementById("searchFrm").submit();
 	}
 


/* 게시글 등록 */
	const openInsert = function(){
		let newWin = window.open("<%=request.getContextPath()%>/boardInsert","_blank","width=300,height=300");
		let timer = setInterval(function(){
			if(newWin.closed){
				clearInterval(timer);
				const title = document.getElementById("parent_board_title").value;
				const content = document.getElementById("parent_board_content").value;
				// ajax로 /boardInsertEnd(post) 경로에 데이터 전달해서 insert
				// insert 잘 수행되었을 때 : 목록 화면 전환
				// insert 실패 : "게시글 등록 중 오류가 발생하였습니다."
				const xhr = new XMLHttpRequest();
				
				xhr.open("post","<%=request.getContextPath()%>/boardInsertEnd",true);
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const resp = xhr.responseText;
						if(resp == '200'){
							alert("게시글이 등록 되었습니다.");
							location.href="<%=request.getContextPath()%>/boardList";
						} else{
							alert("게시글 등록 중 오류가 발생하였습니다.");
						}
					}
				}
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8");
				xhr.send("board_title="+title+"&board_content="+content);
	
			} 
		},1000);
	
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