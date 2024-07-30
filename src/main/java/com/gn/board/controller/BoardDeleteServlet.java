package com.gn.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gn.board.service.BoardService;


@WebServlet("/boardDelete")
public class BoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public BoardDeleteServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		int result = new BoardService().deleteBoard(boardNo);
//		[연습] 게시글 삭제 로직 구성
//		전달받은 pk정보를 가지고 데이터베이스에서 게시글 삭제
//		삭제 성공시 목록 화면으로 이동
//		삭제 실패시 "게시글 삭제 중 오류가 발생하였습니다." alert창 띄우기
		String resp_code="500";
		if(result > 0) {
			resp_code = "200";
		} 
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().append(resp_code);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
