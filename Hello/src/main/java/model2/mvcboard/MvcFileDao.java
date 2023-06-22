package model2.mvcboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;

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
	public int totalCount() {
		int res=0;
		
		return res;
	}
	
	// 목록 조회
	public List<MvcFileDto> getMvcFileList(){
		List<MvcFileDto> list = new ArrayList<>();
		String sql="SELECT idx, name, title, content, postdate, ofile, sfile, downcount, visitcount FROM mvcboard ORDER BY idx DESC";
		
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

}
