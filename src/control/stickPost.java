package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import data.LoginBean;

/**
 * Servlet implementation class stickPost
 */
@WebServlet("/stickPost")
public class stickPost extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=GB2312");
        String user_id = "";
        String postid = request.getParameter("postid");
        String type = request.getParameter("type");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(true);
        LoginBean login = (LoginBean)session.getAttribute("loginBean");
        if(login==null)
        	response.sendRedirect("Login.jsp");
        else
        	user_id=String.valueOf(login.getId());
        try
        {
            Context initCtx = new InitialContext();
            DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/db");
            Connection connection = ds.getConnection();
            PreparedStatement statement = connection.prepareStatement("update post set isTop =? where id = ?");
            statement.setString(1, type);
            statement.setString(2, postid);
            statement.execute();
            statement.close();
            connection.close();
            if(type.equals("1"))
            	out.println("<h2>置顶成功</h2>");
            else
            	out.println("<h2>取消置顶成功</h2>");
        }
        catch (Exception e)
        {
        	if(type.equals("1"))
        		out.println("<h2>置顶失败：<small>"+e+"</small></h2>");
            else
            	out.println("<h2>取消置顶失败：<small>"+e+"</small></h2>");
            
        }
        out.println("<a href='post.jsp?postid="+postid+"'>返回帖子</a>");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
