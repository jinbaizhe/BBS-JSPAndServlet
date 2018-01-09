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

import data.LoginBean;
import data.jdbcBean;
import data.userBean;

public class HandleAlterInformation extends HttpServlet {
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
		
		response.setContentType("text/html;charset=GB2312");
		PrintWriter out=response.getWriter();
		String altername = handleString(request.getParameter("username").trim());
		String altersex = handleString(request.getParameter("sex").trim());//返回的是man 或 women
		String alterinfo = handleString(request.getParameter("info").trim());
		
		HttpSession session = request.getSession(true);
		LoginBean login = (LoginBean)session.getAttribute("loginBean");
		String logname = login.getLogname();
		String oldname = handleString(login.getLogname().trim());
		//判断填入的用户名是否合法或者被占用
		boolean flag =true;
		if(altername.length()==0){
			flag=false;
			response.sendRedirect("MyZone.jsp?error=illegal");			
		}
		else{ 
		String sql0 = "select username from bbs.user where username=?";
		String []params0={altername};
		try{
			jdbcBean db = new jdbcBean();
			ResultSet rs = db.query(sql0, params0);
			while(rs.next()){
				String name = rs.getString(1); //数据库中的名字
					if( (!(altername.equals(logname))) && (name.equals(altername)) ){	
						flag=false;
						response.sendRedirect("MyZone.jsp?error=duplicate");
					}
				}
		}catch(Exception e){}
		}
		if(flag){ //如果前面的都满足条件，则进行插入数据库
		String sql = "update user set username=?,info=?,sex=?where username=?";
		String []params = {altername,alterinfo,altersex,oldname};
		userBean  user = new userBean();
		user = (userBean)session.getAttribute("user");
		user.setUsername(altername);
		login.setLogname(altername);
		boolean flag1 = false;
		try{
			jdbcBean db = new jdbcBean();
			flag1 = db.update(sql, params);
			if(flag1){
				response.sendRedirect("MyZone.jsp");
			}
		}catch(Exception e){}
		
	}
	}
}
