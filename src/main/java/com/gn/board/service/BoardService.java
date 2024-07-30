package com.gn.board.service;

import static com.gn.common.SessionTemplate.getSqlSession;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.gn.board.dao.BoardDao;
import com.gn.board.vo.Board;

public class BoardService {
	
	// 여러개 출력
	public List<Board> selectBoardList(Board option){
		SqlSession session = getSqlSession();
		List<Board> resultList = new BoardDao().selectBoardList(session,option);
		session.close(); // conn 닫아주듯이..
		return resultList;
		
	}
	
	// 하나만 출력
	public int selectBoardCount() {
		SqlSession session = getSqlSession();
		int count = new BoardDao().selectBoardCount(session);
		session.close();
		return count;
	}
	
	// 연습
	
	public Board selectBoardOne(int boardNo) {
		SqlSession session = getSqlSession();
		Board detail = new BoardDao().selectBoardOne(session,boardNo);
		session.close();
		return detail;
	}
	
	// 업데이트 과제
	
	public int updateBoard(Board vo) {
		SqlSession session = getSqlSession();
		int result = new BoardDao().updateBoard(session,vo);
		session.close();
		return result;
	}
	
	// 삭제 연습
	
	public int deleteBoard(int boardNo) {
		SqlSession session = getSqlSession();
		int result = new BoardDao().deleteBoard(session,boardNo);
		session.close();
		return result;
	}
	
}
