package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import common.DBConnPool;
import dto.Board;

public class BoardDao {
	
	public BoardDao() {
		// TODO Auto-generated constructor stub
	}

	// 게시물의 개수를 반환하는 메서드
	public int getTotalCount() {
		int totalCount=0;
		String sql = "select count(*) from board order by num desc";
		
		
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			ResultSet rs = psmt.executeQuery();
			
			rs.next();
			totalCount=rs.getInt(1); // 첫번째 컬럼의 값을 반환
			
			
			rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("총 게시물의 수를 조회 하던중 예외 발생");
		}
		
		return totalCount;
	};
	
	/**
	 * 게시글을 조회합니다.
	 * @return
	 */
	public List<Board> getList() {
		String sql="select * from board order by num desc";
		List<Board> boardList = new ArrayList<Board>();
		
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			ResultSet rs = psmt.executeQuery();
			
			// 게시글의 수만큼 반복
			while(rs.next()) {
				Board board = new Board();
				
				// 게시물의 한 행을 DTO에 저장 후 boardList에 추가
				board.setNum(rs.getString("num"));
				board.setTitle(rs.getString(2));
				board.setContent(rs.getString(3));
				board.setId(rs.getString(4));
				board.setPostDate(rs.getString(5));
				board.setVisitCount(rs.getString(6));
	
				boardList.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("게시물 조회 중 예외 발생");
		}
		
		return boardList;
		
	}
	
}
