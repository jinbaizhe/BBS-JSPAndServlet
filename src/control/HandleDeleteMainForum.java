package control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import data.getTime;
import data.jdbcBean;

public class HandleDeleteMainForum extends HttpServlet {

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
	 
		 
		 boolean flag = false;
		 String id = handleString(request.getParameter("deleteMainForum").trim());
		 String sql = "delete from bbs.main_forum where id=?";
		 String []params={id};
		 try{
			 jdbcBean db = new jdbcBean ();
			 flag = db.update(sql, params);
			 if(flag == true) {
				 response.sendRedirect("managerForum.jsp?info=success");
			 }
		 }catch(Exception e){
			  response.sendRedirect("managerForum.jsp?info=fail");
		 }
	
		 	
	}


}