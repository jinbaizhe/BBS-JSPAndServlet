package control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.jdbcBean;

public class HandleDeleteAdmin extends HttpServlet {

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
		
		
		String userid = handleString(request.getParameter("userid"));
		String sql = "delete from bbs.admin where userid=?";
		String []params={userid};
		boolean flag = false;
		try{
			jdbcBean db = new jdbcBean();
			flag = db.update(sql, params);
			if(flag){
				response.sendRedirect("lookAdmin.jsp?info=success");
			}
			else{
				response.sendRedirect("lookAdmin.jsp?info=fail");
			}
		}catch(Exception e){
			response.sendRedirect("lookAdmin.jsp?info=fail");
		}
	}


}
