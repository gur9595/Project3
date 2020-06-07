package model1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

public class RequestDAO {

	Connection con;
	PreparedStatement psmt;
	ResultSet rs;

	public RequestDAO(String driver , String url) {

		try {	
			Class.forName(driver);
			String id ="suamil_user";
			String pw = "1234";

			con = DriverManager.getConnection(url,id,pw);
			System.out.println("DB연결성공");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public RequestDAO(ServletContext ctx) {
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

	public int insertRequest(RequestDTO dto) {
		int affected = 0;
		try {
			String query = "INSERT INTO request_form(name , addr, tel, phone, email, cleanType, cleanArea, hopeDate, regiType, note, id, bname) "
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getAddr());
			psmt.setString(3, dto.getTel());
			psmt.setString(4, dto.getPhone());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getCleanType());
			psmt.setString(7, dto.getCleanArea());
			psmt.setString(8, dto.getHopeDate());
			psmt.setString(9, dto.getRegiType());
			psmt.setString(10, dto.getNote());
			psmt.setString(11, dto.getId());
			psmt.setString(12, dto.getBname());

			affected = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("insert중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}

	public int insertRequest2(RequestDTO dto) {
		int affected = 0;
		try {
			String query = "INSERT INTO request_form(disorder, disorderType, bojanggu, bojangguName, adminTel, cake, cookie, bname, hopeDate, regiType, note, id,name ,tel,email) "
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			psmt = con.prepareStatement(query);

			psmt.setString(1, dto.getDisorder());
			psmt.setString(2, dto.getDisorderType());
			psmt.setString(3, dto.getBojanggu());
			psmt.setString(4, dto.getBojangguName());
			psmt.setString(5, dto.getAdminTel());
			psmt.setString(6, dto.getCake());
			psmt.setString(7, dto.getCookie());
			psmt.setString(8, dto.getBname());
			psmt.setString(9, dto.getHopeDate());
			psmt.setString(10, dto.getRegiType());
			psmt.setString(11, dto.getNote());
			psmt.setString(12, dto.getId());
			psmt.setString(13, dto.getName());
			psmt.setString(14, dto.getTel());
			psmt.setString(15, dto.getEmail());
			

			affected = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("insert중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}

	public int getTotalRecordCount(Map<String , Object> map) {

		//게시물의 수는 0으로 초기화
		int totalCount=0;
		//기본쿼리문(전체레코드를 대상으로 함)
		String query= "select count(*) from request_form "
				+ " where bname='"+map.get("bname")+"'";
		//JSP페이지에서 검색어를 입력한 경우 where 절이 동적으로 추가됨
		if(map.get("Word")!=null) {
			query +=" and "+map.get("Column")+" "+" like '%"+map.get("Word")+"%'";
		}
		System.out.println("query= "+query);

		try {
			psmt=con.prepareStatement(query);
			rs=psmt.executeQuery();
			rs.next();
			//반환한 결과값(레코드수)을 저장
			totalCount= rs.getInt(1);
		} catch (Exception e) {
			System.out.println("getTotalRecordCount시 예외발생");
			e.printStackTrace();
		}

		return totalCount;
	}

	public List<RequestDTO> selectListPage(Map<String , Object> map){
		List<RequestDTO> bbs= new Vector<RequestDTO>();

		String query = " "
				+ "         SELECT * FROM request_form where bname='"+map.get("bname")+"'";

		if(map.get("Word")!=null) {
			query += " and " + map.get("Column") + " "
					+" LIKE '%" + map.get("Word") + "%' ";
		}

		query += " "
				+ "    ORDER BY num DESC limit ?,?";

		System.out.println("쿼리문:" + query);

		try {
			psmt= con.prepareStatement(query);
			psmt.setInt(1,Integer.parseInt(map.get("start").toString()));
			psmt.setInt(2, Integer.parseInt(map.get("end").toString()));

			rs= psmt.executeQuery();
			while(rs.next()) {
				RequestDTO dto =  new RequestDTO();
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setAddr(rs.getString("addr"));
				dto.setTel(rs.getString("tel"));
				dto.setPhone(rs.getString("phone"));
				dto.setEmail(rs.getString("email"));
				dto.setCleanType(rs.getString("cleanType"));
				dto.setCleanArea(rs.getString("cleanArea"));
				dto.setHopeDate(rs.getString("hopeDate"));
				dto.setRegiType(rs.getString("regiType"));
				dto.setNote(rs.getString("note"));
				dto.setId(rs.getString("id"));
				dto.setDisorder(rs.getString("disorder"));
				dto.setDisorderType(rs.getString("disorderType"));
				dto.setBojanggu(rs.getString("bojanggu"));
				dto.setBojangguName(rs.getString("bojangguName"));
				dto.setAdminTel(rs.getString("adminTel"));
				dto.setCake(rs.getString("cake"));
				dto.setCookie(rs.getString("cookie"));
				dto.setBname(rs.getString("bname"));
				dto.setRegiDate(rs.getString("regiDate"));
				bbs.add(dto);
			}
		} catch (Exception e) {
			System.out.println("selectListPage시 예외발생");
			e.printStackTrace();
		}
		return bbs;
	}

	//일련번호에 해당하는 게시물을 가져와서 DTO객체에 저장후 반환
	public RequestDTO selectView(String num) {
		RequestDTO dto =new RequestDTO();

		String query = "select * from request_form where num=?";
		try {
			psmt=con.prepareStatement(query);
			psmt.setString(1, num);
			rs=psmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setAddr(rs.getString("addr"));
				dto.setTel(rs.getString("tel"));
				dto.setPhone(rs.getString("phone"));
				dto.setEmail(rs.getString("email"));
				dto.setCleanType(rs.getString("cleanType"));
				dto.setCleanArea(rs.getString("cleanArea"));
				dto.setHopeDate(rs.getString("hopeDate"));
				dto.setRegiType(rs.getString("regiType"));
				dto.setNote(rs.getString("note"));
				dto.setId(rs.getString("id"));
				dto.setDisorder(rs.getString("disorder"));
				dto.setDisorderType(rs.getString("disorderType"));
				dto.setBojanggu(rs.getString("bojanggu"));
				dto.setBojangguName(rs.getString("bojangguName"));
				dto.setAdminTel(rs.getString("adminTel"));
				dto.setCake(rs.getString("cake"));
				dto.setCookie(rs.getString("cookie"));
				dto.setBname(rs.getString("bname"));
				dto.setRegiDate(rs.getString("regiDate"));
			}
		} catch (Exception e) {
			System.out.println("selectView시 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
}
