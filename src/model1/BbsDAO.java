package model1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import model1.BbsDTO;

public class BbsDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	public BbsDAO(String driver , String url) {
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
	
	public BbsDAO(ServletContext ctx) {
		
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
	
	
	public int insertWrite(BbsDTO dto) {
		int affected=0;
		try {
			
			String query= "insert into multi_board(title,content,id,visitcount,bname) values(?,?,?,0,?)";
			psmt=con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			psmt.setString(4, dto.getBname());
			
			affected = psmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("insertWrite중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
	
	//자료실 글쓰기 처리
		public int insert(BbsDTO dto) {
			
			int affected = 0;
			try {
				String sql = "insert into multi_board (id,bname,title,content,attachedfile) values( ?, ?, ?, ?, ?)";
				psmt = con.prepareStatement(sql);
				
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getBname());
				psmt.setString(3, dto.getTitle());
				psmt.setString(4, dto.getContent());
				psmt.setString(5, dto.getAttachedfile());
			
				//insert성공시 1반환, 실패시 0반환
				affected = psmt.executeUpdate();
			}catch (Exception e) {
			
				e.printStackTrace();
			}
			
			return affected;
		}
	
	//일련번호 num에 해당하는 게시물의 조회수 증가 
		public void updateVisitCount(String num) {
			String query = "update multi_board set visitcount = visitcount+1 where num=?";
			try {
				psmt= con.prepareStatement(query);
				psmt.setString(1, num);
				psmt.executeQuery();
			} catch (Exception e) {
				System.out.println("updateVisitCount시 예외발생");
				e.printStackTrace();
			}
		}
		
		//일련번호에 해당하는 게시물을 가져와서 DTO객체에 저장후 반환
		public BbsDTO selectView(String num) {
			BbsDTO dto =new BbsDTO();
			//시존쿼리문 : member테이블과 join없을때
			//String query = "select * from board where num=?";
			
			//변형된쿼리문 : member테이블과 join하여 사용자이름 가져옴.
			String query = "SELECT B.*, M.name " + 
					" FROM membership M inner JOIN multi_board B ON M.id=B.id " + 
					" WHERE num=?";
			try {
				psmt=con.prepareStatement(query);
				psmt.setString(1, num);
				rs=psmt.executeQuery();
				if(rs.next()) {
					dto.setNum(rs.getString("num"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setPostDate(rs.getDate("postdate"));
					dto.setId(rs.getString("id"));
					dto.setVisitcount(rs.getString("visitcount"));
					dto.setName(rs.getString("name"));
					dto.setOfile(rs.getString("ofile"));
					dto.setSfile(rs.getString("sfile"));
					dto.setImg(rs.getString("img"));
					dto.setAttachedfile(rs.getString("attachedfile"));
					dto.setBname(rs.getString("bname"));
					System.out.println("selectView num : "+rs.getString("num"));
				}
			} catch (Exception e) {
				System.out.println("selectView시 예외발생");
				e.printStackTrace();
			}
			return dto;
		}
		
		public int updateEdit(BbsDTO dto) {
			int affected = 0;
			try {
				String query="update multi_board set title=?, content=? where num=?";
				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getTitle());
				psmt.setString(2, dto.getContent());
				psmt.setString(3, dto.getNum());
				
				
				affected=psmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("update중 예외 발생");
				e.printStackTrace();
			}
			return affected;
		}
		
		public int update(BbsDTO dto) {
			int affected=0;
			try {
				String query="update multi_board set title=?, content=?, attachedfile=?, bname=? where num=?";
				
				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getTitle());
				psmt.setString(2, dto.getContent());
				psmt.setString(3, dto.getAttachedfile());
				psmt.setString(4, dto.getBname());
				psmt.setString(5, dto.getNum());
				
				System.out.println(dto.getTitle());
				System.out.println(dto.getContent());
				System.out.println(dto.getAttachedfile());
				System.out.println(dto.getBname());
				System.out.println(dto.getNum());

				affected=psmt.executeUpdate();
				
				
			} catch (Exception e) {
				System.out.println("update중 예외");
				e.printStackTrace();
			}
			return affected;
		}
		
		//게시물 삭제 처리
		public int delete(BbsDTO dto) {
			int affected = 0;
			try {
				String query= "delete from multi_board where num=?";
				
				psmt=con.prepareStatement(query);
				psmt.setString(1, dto.getNum());
				
				affected=psmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("delete중 예외발생");
				e.printStackTrace();
			}
			return affected;
		}
		
		public int delete2(String num) {
			int affected = 0;
			try {
				String query="delete from multi_board where num=?";
				psmt = con.prepareStatement(query);
				psmt.setString(1, num);
				
				affected = psmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("delete중 예외발생");
				e.printStackTrace();
			}
			return affected;
		}
		
		
		//DB자원해제 
		public void close() {
			try {
				if(rs!=null) rs.close();
				if(psmt!=null) psmt.close();
				if(con!=null) con.close();
			} catch (Exception e) {
				System.out.println("자원반납시 예외발생");
			}
		}
		
		/*
		 게시판 리스트에서 게시물의 갯수를 count()함수를 통해 구해서 반환함
		 가상번호 , 페이지번호 처리를 위해 사용됨. 
		 */
		public int getTotalRecordCount(Map<String , Object> map) {
			
			//게시물의 수는 0으로 초기화
			int totalCount=0;
			//기본쿼리문(전체레코드를 대상으로 함)
			String query= "select count(*) from multi_board "
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
		
		/*
		 게시판 리스트에서 조건에 맞는 레코드를 select하여 ResultSet(결과셋)을
		 List커렉션에 저장후 반환하는 메소드 
		 */
		public List<BbsDTO> selectList(Map<String , Object> map){
			List<BbsDTO> bbs= new Vector<BbsDTO>();
			String query = "select * from multi_board ";
			//검색어가 있는경우 조건절 동적 추가
			if(map.get("Word")!=null) {
				query += " where " +map.get("Column")+" "+ " like '%"+map.get("Word")+"%'"; 
			}
			
			//최근게시물의 항상 위로 노출되야 하므로 작성된 순서의 역순으로 정렬한다.
			query += "order by num desc";
			try {
				psmt= con.prepareStatement(query);
				rs= psmt.executeQuery();
				//오라클이 반환해준 ResultSet의 갯수만큼 반복한다.
				while(rs.next()) {
					//하나의 레코드를 DTO객체에 저장하기 위해 새로운 객체 생성
					BbsDTO dto= new BbsDTO();
					//setter()메소드를 사용하여 컬럼에 데이터 저장
					dto.setNum(rs.getString(1));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString(3));
					dto.setPostDate(rs.getDate("postdate"));
					dto.setId(rs.getString("id"));
					dto.setVisitcount(rs.getString(6));
					dto.setAttachedfile(rs.getString("attachedfile"));
					
					//저장된 DTO객체를 List컬렉션에 추가
					bbs.add(dto);
				}
			} catch (Exception e) {
				System.out.println("selectList시 예외발생");
				e.printStackTrace();
			}
			return bbs;
		}
		
		//게시판 리스트 페이지 처리
		public List<BbsDTO> selectListPage(Map<String , Object> map){
			List<BbsDTO> bbs= new Vector<BbsDTO>();
		
			String query = " "
		            + "         SELECT * FROM multi_board where bname='"+map.get("bname")+"'";
		      
		      if(map.get("Word")!=null) {
		         query += " and " + map.get("Column") + " "
		               +" LIKE '%" + map.get("Word") + "%' ";
		      }
		      
		      query += " "
		            + "    ORDER BY num DESC limit ?,?";
		      
		      System.out.println("쿼리문:" + query);
			
			try {
				psmt= con.prepareStatement(query);
				//JSP에서 계산한 페이지 범위값을 이용해 인파라미터를 설정함
				/*
				 setString() 으로 인파라미터를 설정하면 문자형이 되므로
				 여기서는 setInt()를 통해 정수 형태로 설정해야한다 
				 */
				psmt.setInt(1,Integer.parseInt(map.get("start").toString()));
				psmt.setInt(2, Integer.parseInt(map.get("end").toString()));
				
				rs= psmt.executeQuery();
				//오라클이 반환해준 ResultSet의 갯수만큼 반복한다.
				while(rs.next()) {
					//하나의 레코드를 DTO객체에 저장하기 위해 새로운 객체 생성
					BbsDTO dto= new BbsDTO();
					//setter()메소드를 사용하여 컬럼에 데이터 저장
					dto.setNum(rs.getString("num"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setPostDate(rs.getDate("postdate"));
					dto.setId(rs.getString("id"));
					dto.setVisitcount(rs.getString("visitcount"));
					dto.setOfile(rs.getString("ofile"));
					dto.setSfile(rs.getString("sfile"));
					dto.setImg(rs.getString("img"));
					dto.setBname(rs.getString("bname"));
					dto.setAttachedfile(rs.getString("attachedfile"));
					//저장된 DTO객체를 List컬렉션에 추가
					bbs.add(dto);
				}
			} catch (Exception e) {
				System.out.println("selectListPage시 예외발생");
				e.printStackTrace();
			}
			return bbs;
		}
	
		public int myfileInsert(BbsDTO dto) {
			int affeced = 0;
			try {
				
				String query= "insert into multi_board(title,content,id,visitcount,bname,ofile,sfile) values(?,?,?,0,?,?,?)";
				System.out.println("id : "+ dto.getId());
				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getTitle());
				psmt.setString(2, dto.getContent());
				psmt.setString(3, dto.getId());
				psmt.setString(4, dto.getBname());
				psmt.setString(5, dto.getOfile());
				psmt.setString(6, dto.getSfile());
				
				affeced = psmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("myfileInsert중 예외발생");
				
				e.printStackTrace();
			}
			return affeced;
		}
	
		public int myfileEdit(BbsDTO dto) {
			int affected = 0;
			try {
				String query="update multi_board set title=?, content=?, ofile=?, sfile=?, bname=? where num=?";
				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getTitle());
				psmt.setString(2, dto.getContent());
				psmt.setString(3, dto.getOfile());
				psmt.setString(4, dto.getSfile());
				psmt.setString(5, dto.getBname());
				psmt.setString(6, dto.getNum());
				
				System.out.println(dto.getTitle());
				System.out.println(dto.getContent());
				System.out.println(dto.getOfile());
				System.out.println(dto.getSfile());
				System.out.println(dto.getBname());
				System.out.println(dto.getNum());
				
				affected=psmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("myfileEdit중 예외 발생");
				e.printStackTrace();
			}
			return affected;
		}
	
		public int imgUpload(BbsDTO dto) {
			int affected=0;
			try {
				
				String query= "insert into multi_board(id,bname,title,content,img) values(?,?,?,?,?)";
				psmt=con.prepareStatement(query);
				
				System.out.println("img : "+dto.getImg());
				
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getBname());
				psmt.setString(3, dto.getTitle());
				psmt.setString(4, dto.getContent());
				psmt.setString(5, dto.getImg());
				
				affected = psmt.executeUpdate();
			}catch (Exception e) {
				System.out.println("imgUpload중 예외발생");
				e.printStackTrace();
			}
			return affected;
		}
		
		public int imgEdit(BbsDTO dto) {
			int affected = 0;
			try {
				String query="update multi_board set id=?, title=?, content=?, bname=?, img=? where num=?";
				psmt = con.prepareStatement(query);
				
				System.out.println(dto.getId());
				System.out.println(dto.getTitle());
				System.out.println(dto.getContent());
				System.out.println(dto.getBname());
				System.out.println(dto.getImg());
				System.out.println(dto.getNum());
				
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getTitle());
				psmt.setString(3, dto.getContent());
				psmt.setString(4, dto.getBname());
				psmt.setString(5, dto.getImg());
				psmt.setString(6, dto.getNum());
				
				affected=psmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println("imgEdit중 예외 발생");
				e.printStackTrace();
			}
			return affected;
		}
	
	
	
	
	
	
	
}




















