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

public class HandleAddSubForum extends HttpServlet {

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
		 String mainForum_id = handleString(request.getParameter("addSubForum_mainId").trim());
		 String subForum_title = handleString(request.getParameter("addSubForum_subTitle").trim());
		 String info = handleString(request.getParameter("addSubForum_info").trim());
		 getTime gt = new getTime();
		 
		 String sql0 = "select sub_forum_title from bbs.sub_forum";
		 String title = "";
		 String sql = "insert into bbs.sub_forum(sub_forum_title,info,main_id,time) values(?,?,?,?)";
		 String []params={subForum_title,info,mainForum_id,gt.getCurrentTime()};
		 boolean flag = true; //≈–∂œ «∑Ò÷ÿ√˚
		 
		 try{
			 jdbcBean db = new jdbcBean();
			 ResultSet rs  = db.query(sql0);
			 while(rs.next()){
				 title = rs.getString(1);
				 if(title.equals(subForum_title)){
					 flag=false;
					 break;
				 }
			 }
		 }catch(Exception e){
			 
		 }
		 if(flag){
		 try{
			 jdbcBean db = new jdbcBean();
			 boolean flag0 = false;
			 flag0 = db.update(sql, params);
			 if(flag0 == true) {
				 response.sendRedirect("managerForum.jsp?info=success");
			 }
		 }catch(Exception e) {
			  response.sendRedirect("managerForum.jsp?info=fail");
		 }
		 
	}
		 else{
			 response.sendRedirect("managerForum.jsp?info=duplicate");
		 }
		 
	}

}