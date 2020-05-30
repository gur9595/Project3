package model1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

public class MemberDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public MemberDAO(String driver , String url) {
		try {	
			Class.forName(driver);
			String id ="suamil_user";
			String pw = "1234";

			con = DriverManager.getConnection(url,id,pw);
			System.out.println("DB연결성공");

		} catch (Exception e) {
			System.out.println("DB연결실패");
			e.printStackTrace();
		}
	}
	
	public MemberDAO(ServletContext ctx) {
		try {	
			Class.forName(ctx.getInitParameter("MariaJDBCDriver"));
			String id ="suamil_user";
			String pw = "1234";

			con = DriverManager.getConnection(ctx.getInitParameter("MariaConnectURL"),id,pw);
			System.out.println("DB연결성공");

		} catch (Exception e) {
			System.out.println("DB연결실패");
			e.printStackTrace();
		}
	}
	
	public void close() {
		try {
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
		} catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}
	
	public int insertMember(MemberDTO dto) {
		int affected=0;
		try {
			String query= "insert into membership(id,name,pass,tel,mobile,email,zip,addr) values(?,?,?,?,?,?,?,?)";
			psmt=con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getPass());
			psmt.setString(4, dto.getTel());
			psmt.setString(5, dto.getMobile());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getZip());
			psmt.setString(8, dto.getAddr());
			
			affected = psmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("insert중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
	
	public Map<String, String> getMemberMap(String id, String pass) {
		Map<String, String> maps= new HashMap<String, String>();
		
		String query = "select id, pass, name from membership where id=? and pass=?";
		
		try {
			//prepared 객체 생성
			psmt =con.prepareStatement(query);
			//쿼리문의 인파라미터 설정
			psmt.setString(1, id);
			psmt.setString(2, pass);
			//오라클로 쿼리문 전송및 결과셋(ResultSet) 반환받음
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				maps.put("id", rs.getString(1));
				maps.put("pass", rs.getString(2));
				maps.put("name", rs.getString(3));
				
			} else {
				System.out.println("결과셋이없습니다");
			}
		} catch (Exception e) {
			System.out.println("getMemberMap 오류");
			e.printStackTrace();
			
		}
		return maps;
	}
	
	public Map<String, String> getIdFindMap(String name, String email) {
		Map<String, String> maps= new HashMap<String, String>();
		
		String query = "select id, name, email from membership where name=? and email=?";
		
		try {
			psmt =con.prepareStatement(query);
			psmt.setString(1, name);
			psmt.setString(2, email);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				maps.put("id", rs.getString(1));
				maps.put("name", rs.getString(2));
				maps.put("email", rs.getString(3));
				
			} else {
				System.out.println("결과셋이없습니다");
			}
		} catch (Exception e) {
			System.out.println("getMemberMap 오류");
			e.printStackTrace();
			
		}
		return maps;
	}
	
	public boolean idCheck(String id) {
		
		String query = "select id from membership where id=?";
		
		boolean x = false;
		
		try {
			//prepared 객체 생성
			psmt =con.prepareStatement(query);
			//쿼리문의 인파라미터 설정
			psmt.setString(1, id);
			//오라클로 쿼리문 전송및 결과셋(ResultSet) 반환받음
			rs = psmt.executeQuery();
			
			/*while(rs.next()) {
				if(rs.getString("id").equals(id)) {
					x= true;
				}else {
					return false;
				}
			}*/
			if(rs.next()) x = true;
			
		} catch (Exception e) {
			System.out.println("ID체크 오류");
			e.printStackTrace();
			
		}
		return x;
	}
	
public boolean idFind(String name, String email) {
		
		String query = "select id from membership where name=? and email=?";
		
		boolean x = false;
		
		try {
			//prepared 객체 생성
			psmt =con.prepareStatement(query);
			//쿼리문의 인파라미터 설정
			psmt.setString(1, name);
			psmt.setString(2, email);
			//오라클로 쿼리문 전송및 결과셋(ResultSet) 반환받음
			rs = psmt.executeQuery();
			
			/*while(rs.next()) {
				if(rs.getString("id").equals(id)) {
					x= true;
				}else {
					return false;
				}
			}*/
			if(rs.next()) x = true;
			
		} catch (Exception e) {
			System.out.println("ID체크 오류");
			e.printStackTrace();
			
		}
		return x;
	}
	
	
}



























