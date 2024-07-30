package com.gn.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gn.board.service.BoardService;
import com.gn.board.vo.Board;

@WebServlet("/boardList")
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public BoardListServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 2. 
		Board option = new Board(); // option : 전체 목록의 개수
		
		// 검색 하기
		String boardTitle = request.getParameter("board_title");
		option.setBoard_title(boardTitle);
		
		
		String nowPage = request.getParameter("nowPage");
		if(nowPage != null) {
			option.setNowPage(Integer.parseInt(nowPage));
		}
		
		option.setTotalData(new BoardService().selectBoardCount(option));
		
		// 1. Board 목록 조회(mybatis)해서 화면으로 전달(jstl)
		List<Board> resultList = new BoardService().selectBoardList(option);
		request.setAttribute("paging", option);
		request.setAttribute("resultList", resultList);
		RequestDispatcher view = request.getRequestDispatcher("/views/board/list.jsp");
		view.forward(request,response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
