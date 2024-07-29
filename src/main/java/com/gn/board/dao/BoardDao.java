package com.gn.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.gn.board.vo.Board;

public class BoardDao {
	
	public List<Board> selectBoardList(SqlSession session, Board option){
		return session.selectList("boardMapper.selectBoardList", option);
		
		
	}
	
	public int selectBoardCount(SqlSession session) {
		return session.selectOne("boardMapper.selectBoardCount"); // 하나만 가져올거라서 One
	}
	
	public Board selectBoardOne(SqlSession session, int boardNo) {
		return session.selectOne("boardMapper.selectBoardOne", boardNo);
				
	}
	
	public int selectUpdate(SqlSession session, Board b) {
		return session.update("boardMapper.selectUpdate", b);
	}
}
