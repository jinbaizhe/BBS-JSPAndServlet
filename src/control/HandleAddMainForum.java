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
import data.getTime;
import data.jdbcBean;

public class HandleAddMainForum extends HttpServlet {

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
		 HttpSession session=request.getSession(true); 
		 getTime gt = new getTime();
		 String mainForum_title = handleString(request.getParameter("addMainForum").trim());
		 String info = handleString(request.getParameter("addMainForum_info"));
		 String sql0 = "select title from bbs.main_forum";
		
		 String title = "";
		 boolean flag = true; //≈–∂œ «∑Ò÷ÿ√˚
		 
		 try{
			 jdbcBean db = new jdbcBean ();
			 ResultSet rs  = db.query(sql0);
			 while(rs.next()){
				 title = rs.getString(1);
				 if(title.equals(mainForum_title)){
					 flag=false;
					 break;
				 }
			 }
			
		 }catch(Exception e){
			 
		 }
		 
		 if(flag){
		boolean flag0 = false;
		 String sql = "INSERT INTO bbs.main_forum (title, info, time) VALUES (?, ?, ?);";
		 String []params={mainForum_title,info,gt.getCurrentTime()};
		 
		 
		
		 try{
			 jdbcBean db = new jdbcBean ();
			 flag0 = db.update(sql, params);
			 if(flag0 == true) {
				
				 response.sendRedirect("managerForum.jsp?info=success");
			 }
			 
		 }catch(Exception e){
			  response.sendRedirect("managerForum.jsp?info=fail");
			  System.out.print(e.toString()+e.getStackTrace());
		 }
		 
		 
		 }
		 else{
			 response.sendRedirect("managerForum.jsp?info=duplicate");
		 }
		 
	}
}