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

public class HandleDeleteCollect extends HttpServlet {
	public void init(ServletConfig config) throws ServletException{
	      super.init(config);
	   }
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 doPost(request,response);
	
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=GB2312");
	    PrintWriter out=response.getWriter();
		request.setCharacterEncoding("gb2312");
		String cbox[]=request.getParameterValues("cbox");
		HttpSession session = request.getSession(true);
		LoginBean login = (LoginBean)session.getAttribute("loginBean");
		int userid = login.getId();
		
		if(cbox == null){
			response.sendRedirect("myCollect.jsp?error=empty");;
		}
		else if (cbox!=null)      
				//前端的使用者,如果没打勾的话      
			//request.getParameterValues("langtype")会接收到null值      
		{      
			int size=java.lang.reflect.Array.getLength(cbox);      
			//	取得这个阵列大小      
			//for (int i=0;i<size;i++)      
			//	{      
				//	out.println(cbox[i]+"<br>");      
			//	}   
		String sql = "delete from bbs.favourite where (userid=? and postid=?)";
		String []params=null;
		boolean flag=false;
		for (int i=0;i<size;i++)  
		{
		params = new String[]{String.valueOf(userid),cbox[i]};
		try{
			jdbcBean db = new jdbcBean();
			flag = db.update(sql, params);
			
		}catch(Exception e){}
		}
		if(flag == true){
			response.sendRedirect("myCollect.jsp");
		}
		else{
			response.sendRedirect("myCollect.jsp?error=fail");
		}
		}
	}
	
	
}
