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
import data.userBean;

import java.sql.*; 

public class HandleAlterPassword extends HttpServlet {

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
	
		String oldPassword = handleString(request.getParameter("oldPassword").trim());
		String newPassword = handleString(request.getParameter("newPassword").trim());
		HttpSession session = request.getSession(true);
		LoginBean login= (LoginBean)session.getAttribute("loginBean");
		int userid = login.getId(); //得到当前登录的用户id 
		//判断是否为空
		boolean empty =( (oldPassword.length() == 0 || oldPassword ==null )||( newPassword.length() == 0 || newPassword == null)) ; //为空时为true
		//判断新旧密码是否重复
		boolean duplicate = oldPassword.equals(newPassword);
		
		//判断旧密码是否输入正确
		String sql0 = "select userpassword from bbs.user where id=?";
		String []params0={String.valueOf(userid)};
		String password_db = "";
		boolean iswrong = true;
		try{
			jdbcBean db = new jdbcBean();
			ResultSet rs  = db.query(sql0,params0);
			while(rs.next()){
			password_db = rs.getString(1);
			}
			if(password_db.equals(oldPassword)){
				iswrong = false;
			}
			
		}catch(Exception e){}
		
		if(empty){
			
			response.sendRedirect("alterPassword.jsp?info=empty");
		}
		else if(duplicate){
			response.sendRedirect("alterPassword.jsp?info=duplicate");

		}
		else if(iswrong){
			response.sendRedirect("alterPassword.jsp?info=wrong");

		}
		else{ //满足条件
			
			String sql = "update bbs.user set userpassword=? where id=?";
			String []params={newPassword,String.valueOf(userid)};
			boolean flag = false;
			try{
				jdbcBean db = new jdbcBean();
				flag = db.update(sql, params);
				if(flag){
					
					response.sendRedirect("alterPassword.jsp?info=success");
				}
				else{
					response.sendRedirect("alterPassword.jsp?info=fail");
					
				}
			}catch(Exception e){
				System.out.print(e.toString());
				response.sendRedirect("alterPassword.jsp?info=fail");
			}
			
		}
		
	}
	
	
	
}