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

public class HandleChangeSubForum extends HttpServlet {

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
		String subForum_id = handleString(request.getParameter("changeSubForum_id").trim());
		String changedTitle = handleString(request.getParameter("changeSubForum_title").trim());
		
		 String sql0 = "select sub_forum_title from bbs.sub_forum";
		 String title = "";
		 
		 String sql = "UPDATE bbs.sub_forum SET sub_forum_title =? WHERE id=? ";
		 String []params={changedTitle,subForum_id};
		 boolean flag = true; //�ж��Ƿ����� 
		 
		 try{
			 jdbcBean db = new jdbcBean();
			 ResultSet rs  = db.query(sql0);
			 while(rs.next()){
				 title = rs.getString(1);
				 if(title.equals(changedTitle)){
					 flag=false;
					 break;
				 }
			 }
		 }catch(Exception e){
			 
		 }
		 
	   if(flag){
		   boolean flag0 = false;

			 try{
				 jdbcBean db = new jdbcBean();
				 flag0 = db.update(sql, params);
				 if(flag0 == true) {
					 response.sendRedirect("managerForum.jsp?info=success");
				 }
			 }catch(Exception e){
				  response.sendRedirect("managerForum.jsp?info=fail");
			 }
			 
	   }
	   else{
		   response.sendRedirect("managerForum.jsp?info=duplicate");
	   }
		 
		 
	}

}