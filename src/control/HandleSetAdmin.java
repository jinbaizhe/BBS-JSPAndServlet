package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.jdbcBean;

public class HandleSetAdmin extends HttpServlet {

	public void init(ServletConfig config) throws ServletException{
	      super.init(config);
	   }
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 doPost(request,response);
	
	}

	public String handleString(String s) {
		try{
			byte bb[] = s.getBytes("iso-8859-1");
			s = new String (bb);
		}catch(Exception e){}
		return s;
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		String username = handleString(request.getParameter("username").trim());
		String subForumid = handleString(request.getParameter("subForumTitle").trim());
		String userId = "";
		
		
	
	
		boolean flag = false;
		if(username.length()>0){
			
			String sql="select username,id from bbs.user where username=?";//判断该用户是否存在
			String []params = {username};
			try{
				jdbcBean db = new jdbcBean();
				ResultSet rs = db.query(sql,params);
				if(rs.next()){
					flag = true;
					userId= rs.getString(2);
				}
			}catch(Exception e){}
			
			if(flag){
				
				String sql2 = "select userid from bbs.admin where userid=?";//判断admin表中是否已经存在该用户
				String []params2 = {userId};
				 try{
					 jdbcBean db = new jdbcBean();
					ResultSet rs1 = db.query(sql2, params2); 
					if(rs1.next()){
						response.sendRedirect("setAdmin.jsp?error=exist"); //提示已经是管理员
					}
					else{
						boolean f = false;
						String sql3 = "insert into bbs.admin values(?,?)";
						String []params3 = {userId,subForumid};
						f = db.update(sql3, params3);
						if(f){
							response.sendRedirect("setAdmin.jsp?error=success"); 
						}
						else{
							response.sendRedirect("setAdmin.jsp?error=false"); 
						}
					}
				 }catch(Exception e){}
				
				
			}
			else{
				response.sendRedirect("setAdmin.jsp?error=unexist");
			}
			}
		
		else{
			response.sendRedirect("setAdmin.jsp?error=empty");
		}
		
		
		
	}

}

