package control;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import data.getTime;
import data.jdbcBean;

import java.sql.*;

public class HandleRegister extends HttpServlet {

	public void init(ServletConfig config) throws ServletException {
		// Put your code here
		super.init(config);
	}

	public String handleString(String s) {
		try{
			byte bb[] = s.getBytes("iso-8859-1");
			s = new String (bb);
		}catch(Exception e){}
		return s;
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String logname =handleString(request.getParameter("logname").trim());
		String logpassword = handleString(request.getParameter("logpassword").trim());
		String againpassword = handleString(request.getParameter("againpassword").trim());		
		
		String sql = "select username from bbs.user where username=?";
		String []params={logname};
		//判定用户名是否已经被使用		
		try{
			jdbcBean db = new jdbcBean();
				ResultSet rs = db.query(sql, params);
		if(rs.next()){
				response.sendRedirect("register.jsp?error=duplicate");
					}
				
		//判定是否输入完整
		else if(logname.length()==0||logpassword.length() == 0){
			response.sendRedirect("register.jsp?error=illegal");
		}
		//再判定两次密码是否一致
		else if(!(logpassword.equals(againpassword))){
			response.sendRedirect("register.jsp?error=notequal");
		}
		
		
		else{//判定结束，开始存入数据库
		getTime gt = new getTime();
		String insert = "insert into bbs.user(username,userpassword,register_time) values(?,?,?)";
		String []params1 = {logname,logpassword,gt.getCurrentTime()};
		boolean flag;//判断是否插入成功
		
			
			flag = db.update(insert,params1);
			if(flag){
				response.sendRedirect("index.jsp");
			}
			else{
				response.sendRedirect("register.jsp?error=failregister");
			}
		
		}
				}catch(Exception e){}
		
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
		
	}

	

}
