package com.gn.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gn.board.service.BoardService;
import com.gn.board.vo.Board;


@WebServlet("/boardInsertEnd")
public class BoardInsertEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public BoardInsertEndServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String boardTitle = request.getParameter("board_title");
		String boardContent = request.getParameter("board_content");
		
		Board vo = new Board();
		
		vo.setBoard_title(boardTitle);
		vo.setBoard_content(boardContent);
		
		int result = new BoardService().boardInsert(vo);
		System.out.println(result);
		
		String resp_code = "500";
		if(result > 0) {
			resp_code = "200";
		}
		
		System.out.println(result);
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().append(resp_code);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
