package model2.mvcboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.print.attribute.standard.PresentationDirection;

import common.DBConnPool;
import dto.Criteria;

public class MvcFileDao {
// DB 커넥션풀로 생성하면 메인에서 사용X
//	public static void main(String[] args) {
//		MvcFileDao dao = new MvcFileDao();
//		List<MvcFileDto> list = dao.getMvcFileList();
//		
//		for(MvcFileDto d : list) {
//			System.out.println(d.getTitle());
//		}
//	}
	
	public MvcFileDao() {
		// TODO Auto-generated constructor stub
	}
	
	// 총건수 조회
	public int totalCount(Criteria criteria) {
		int res=0;
		
		String sql="SELECT COUNT(*) FROM mvcboard";
		
		// 검색어가 널이 아니라면 검색 조건 추가
		if(criteria.getSearchWord()!=null && !criteria.getSearchWord().equals("")) {
			sql+=" WHERE "+criteria.getSearchField()+" like '%"+criteria.getSearchWord()+"%'";
		}
		sql+=" ORDER BY idx DESC";
		
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			ResultSet rs = psmt.executeQuery();
			
			rs.next();
			res = rs.getInt(1);
		
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
	
	// 한건 조회
	public MvcFileDto selectOne(String num) {
		String sql = "SELECT idx, name, title, content, postdate, ofile, sfile, downcount, visitcount FROM mvcboard WHERE idx=?";
		MvcFileDto dto = new MvcFileDto();
		
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setString(1, num);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setIdx(rs.getString("idx"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setDowncount(Integer.parseInt(rs.getString("downcount")));
				dto.setVisitcount(Integer.parseInt(rs.getString("visitcount")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dto;
	}
	
	// 목록 조회
	public List<MvcFileDto> getMvcFileList(Criteria criteria){
		List<MvcFileDto> list = new ArrayList<>();
		String sql="SELECT idx, name, title, content, postdate, ofile, sfile, downcount, visitcount FROM mvcboard";
		
		// 검색어가 널이 아니라면 검색 조건 추가
		if(criteria.getSearchWord()!=null && !criteria.getSearchWord().equals("")) {
			sql+=" WHERE "+criteria.getSearchField()+" like '%"+criteria.getSearchWord()+"%'";
		}
		sql+=" ORDER BY idx DESC";
		
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				MvcFileDto dto = new MvcFileDto();
				dto.setIdx(rs.getString("idx"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setDowncount(Integer.parseInt(rs.getString("downcount")));
				dto.setVisitcount(Integer.parseInt(rs.getString("visitcount")));
				
				list.add(dto);
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}

	// 목록 조회
	public List<MvcFileDto> getMvcFileListPage(Criteria criteria){
		List<MvcFileDto> list = new ArrayList<>();
		
		String sql = "select * from ( select rownum rn, t.* from( select * from mvcboard ";

		// 검색어가 널이 아니라면 검색 조건 추가
		if(criteria.getSearchWord()!=null && !criteria.getSearchWord().equals("")) {
			sql+=" WHERE "+criteria.getSearchField()+" like '%"+criteria.getSearchWord()+"%'";
		}
		sql+=" order by idx desc ) t )where rn between "+criteria.getStartNo() +" and "+criteria.getEndNo();
		
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				MvcFileDto dto = new MvcFileDto();
				dto.setIdx(rs.getString("idx"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setDowncount(Integer.parseInt(rs.getString("downcount")));
				dto.setVisitcount(Integer.parseInt(rs.getString("visitcount")));
				
				list.add(dto);
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	// 게시글 비밀번호 확인
	public boolean confirmPassword(String idx, String pass) {
		boolean res = false;
		String sql = "SELECT * FROM mvcboard WHERE idx = ? and pass=?";
		
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setString(1, idx);
			psmt.setString(2, pass);
			
			ResultSet rs = psmt.executeQuery();
			
			res = rs.next();
			
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	public int delete(String idx) {
		// TODO Auto-generated method stub
		int res = 0;
		String sql = "DELETE FROM mvcboard WHERE idx = ?";
		
		
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setString(1, idx);
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}

	public int insert(MvcFileDto dto) {
		// TODO Auto-generated method stub
		int res = 0;
		String sql = "insert into mvcboard"
				+ " (idx, name, title, content, pass, ofile, sfile)"
				+ " values (seq_board_num.nextval, ?, ?, ?, ?, ?, ?)";
		
		try (Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);){
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getPass());
			psmt.setString(5, dto.getOfile());
			psmt.setString(6, dto.getSfile());
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("게시물 입력중 예외 발생");
			e.printStackTrace();
		}
		return res;
	}
	
	public void updateVisitcount(String idx) {
		String sql = "update mvcboard set visitcount=visitcount+1 where idx=?";

		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setString(1, idx);
			
			psmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void updateDownCount(String idx) {
		// TODO Auto-generated method stub
		String sql = "update mvcboard set downcount=downcount+1 where idx=?";

		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setString(1, idx);
			
			psmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public int updateWrite(MvcFileDto dto) {
		// TODO Auto-generated method stub
		String sql = "update mvcboard set name=?,title=?, content=?, ofile=?, sfile=? where idx=?";
		int res = 0;
	
		System.out.println(dto.getName());
		System.out.println(dto.getTitle());
		System.out.println(dto.getContent());
		System.out.println(dto.getOfile());
		System.out.println(dto.getSfile());
		System.out.println(dto.getIdx());
		
		
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getIdx());
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

}
