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
	
	public int insert(Board board) {
		// 쿼리가 날아가기전에 유효성을 확실하게 체크하자
		int res=0;
		
		String sql = "insert into board (num, title, content, id, postdate, visitcount) values ("
				+ "seq_board_num.nextval"
				+ ", ?, ?, ?, sysdate, 0)";
		
		// 톰캣이 커넥션을 만들어줌 
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setString(1, board.getTitle());
			psmt.setString(2, board.getContent());
			psmt.setString(3, board.getId());
			// insert, update, delete 실행 후 몇건이 처리 되었는지 반환됨
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("게시물 등록 중 예외 발생");
			e.printStackTrace();
		}
		return res;
	}

	// 게시물의 개수를 반환하는 메서드
	public int getTotalCount(String searchField, String searchWord) {
		int totalCount=0;
		String sql = "select count(*) from board ";
		
		if(searchWord!=null && !"".equals(searchWord)) {
			sql += "where "+searchField+" like '%"+searchWord+"%' ";
		}
		
		sql += "order by num desc";
		
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
	 * 게시글 목록을 조회합니다.
	 * @param searchField : 검색조건
	 * @param searchWord : 검색어
	 * @return List<Board> : 게시글 목록
	 */
	public List<Board> getList(String searchField, String searchWord) {
		List<Board> boardList = new ArrayList<Board>();
		String sql="select * from board ";
		
		// 검색어가 입력 되었으면 검색 조건을 추가합니다.
		if(searchWord!=null && !"".equals(searchWord)) {
			sql += "where " + searchField + " like '%"+searchWord+"%' ";
		}
		sql += "order by num desc";
		
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
	
	public Board selectOne(String num) {
		// 게시글이 없을경우 null을 반환
		Board board = null;
		String sql = "select * from board where num=?";
		
		// num가 null이거나 빈문자열일 경우 메서드 종료
		if(num==null||"".equals(num)) {
			return null;
		}
		
		try (Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);){
			psmt.setString(1, num);
			ResultSet rs = psmt.executeQuery();
			
			// 1건의 게시글을 조회하여 있으면 board 객체에 담아줍니다.
			if(rs.next()) {
				board = new Board();
				board.setNum(rs.getString("num"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString(3));
				board.setId(rs.getString(4));
				board.setPostDate(rs.getString(5));
				board.setVisitCount(rs.getString(6));
			}
			
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return board;
	}
	
	/**
	 * 게시물의 조회수를 1증가시킵니다.
	 * @param num : 게시물번호
	 * @return 업데이트된 게시물 건수
	 */
	public int updateVisitCount(String num) {
		String sql="update board set visitcount = visitcount+1 where num=?";
		int res = 0;
		
		try (Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);){
			psmt.setString(1, num);
			// 조회수 업데이트
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
	
	public int update(Board board) {
		int res = 0;
		String sql = "update board set title=?, content=? where num=?";
		
		System.out.println(board.getTitle());
		try (Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);){
			psmt.setString(1, board.getTitle());
			psmt.setString(2, board.getContent());
			psmt.setString(3, board.getNum());
			
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return res;
	}
	
	public int delete(String num) {
		int res = 0;
		String sql = "delete board where num=?";
	
		try (Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);){
			psmt.setString(1, num);
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
}
