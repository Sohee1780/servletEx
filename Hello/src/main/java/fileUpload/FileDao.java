package fileUpload;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;
import dto.Criteria;

public class FileDao {

	public static void main(String[] args) {
		FileDao dao = new FileDao();
		
		List<FileDto> list = dao.getFileList();
		
		for(FileDto f : list) {
			System.out.println(f.getOfile());
		}
	}
	
	public FileDao() {
		// TODO Auto-generated constructor stub
	}
	
	// 파일 정보를 저장
	public int insertFile(FileDto dto) {
		int res = 0;
		String sql = "INSERT INTO myfile(idx, name, title, cate, ofile, sfile) VALUES(seq_file_board_num.nextval, ?, ?, ?, ?, ?)";
		
		// 커넥션
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			// 쿼리 실행
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getCate());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	// 파일 목록을 조회
	public List<FileDto> getFileListPage(Criteria criteria){
		List<FileDto> list = new ArrayList<>();
		String sql="SELECT * FROM myfile ORDER BY idx DESC";
		
		// 커넥션 생성
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			ResultSet rs = psmt.executeQuery();
			// 쿼리 실행
			while(rs.next()) {
				FileDto dto = new FileDto();
				
				dto.setIdx(rs.getString("idx"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setCate(rs.getString("cate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setPstdate(rs.getString("pstdate"));
				
				// 결과 집합을 list에 담기
				list.add(dto);
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}

	
	// 파일 목록을 조회
	public List<FileDto> getFileList(){
		List<FileDto> list = new ArrayList<>();
		String sql="SELECT * FROM myfile ORDER BY idx DESC";
		
		// 커넥션 생성
		try(Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			ResultSet rs = psmt.executeQuery();
			// 쿼리 실행
			while(rs.next()) {
				FileDto dto = new FileDto();
				
				dto.setIdx(rs.getString("idx"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setCate(rs.getString("cate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setPstdate(rs.getString("pstdate"));
				
				// 결과 집합을 list에 담기
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
