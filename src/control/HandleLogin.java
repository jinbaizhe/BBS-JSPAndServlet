package control;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.LoginBean;
import data.jdbcBean;


import java.sql.*; 

public class HandleLogin extends HttpServlet {

	public void init(ServletConfig config) throws ServletException {
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
	
		String logname = handleString(request.getParameter("logname").trim());
		String logpassword = handleString(request.getParameter("logpassword").trim());
		String preurl=request.getParameter("preurl");
		boolean boo  = (logname.length()>0)&&(logpassword.length()>0);
		String sql = "select * from user where username=? and userpassword=?";		
		String []params = {logname,logpassword};
		try{
			jdbcBean db = new jdbcBean();
			if(boo){
				ResultSet rs = db.query(sql, params);
				if(rs.next()){
					success(request,response,logname);
					if(preurl==null||preurl.equals("")||preurl.equals("Login.jsp"))
						response.sendRedirect("index.jsp");
					else
						response.sendRedirect(preurl);
				}
				else{
					response.sendRedirect("Login.jsp?error=unexist");
				}
			}
			else{
				response.sendRedirect("Login.jsp?error=illegal");
			}
		}catch(Exception e){
			response.sendRedirect("Login.jsp");
			
		}
	}
	
	public void success(HttpServletRequest request,HttpServletResponse response,String logname){
		LoginBean login = new LoginBean();
		HttpSession session = request.getSession(true); 
		String find_id = "select id,type from user where username=?";
		String []params={logname};
		
		int id=-1;
		String type="0";
		try{
			jdbcBean db = new jdbcBean();
		    ResultSet rs = db.query(find_id,params);
		    if(rs.next()){
		    	id=rs.getInt(1);
		    	type=rs.getString("type");
		    }
			login = (LoginBean)session.getAttribute("loginBean");
			if(login == null){
				login = new LoginBean();
				session.setAttribute("loginBean",login);
				login = (LoginBean)session.getAttribute("loginBean");
			}
			login.setId(id);
			login.setLogname(logname);
			login.setType(type);
		}catch(Exception e){
			login = new LoginBean();
			session.setAttribute("loginBean", login);
			login.setId(id);
			login.setLogname(logname);
			login.setType(type);
		}
	}
	
}