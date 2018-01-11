package control;

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
import data.Validate;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "deleteFollowpost")
public class deleteFollowpost extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=GB2312");
        String followpost_id =request.getParameter("followpostid");
        String user_id ="";
        String post_id =request.getParameter("postid");

        PrintWriter out=response.getWriter();
        HttpSession session = request.getSession(true);
        LoginBean login = (LoginBean)session.getAttribute("loginBean");
        if(login==null)
        	response.sendRedirect("Login.jsp");
        else
        	user_id=String.valueOf(login.getId());
        Validate validate = new Validate();
        if(!validate.hasDeleteFollowpostPermission(login, followpost_id))
        {
        	validate.close();
        	response.sendRedirect("error.jsp");
        }
        try {
            Context initCtx = new InitialContext();
            DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/db");
            Connection connection = ds.getConnection();
            PreparedStatement statement = connection.prepareStatement("delete from followpost where followpost_id=?");
            statement.setString(1,followpost_id);
            statement.execute();
            statement.close();
            
            statement = connection.prepareStatement("update post set reply_num=reply_num-1 where id = ?");
            statement.setString(1, post_id);
            statement.execute();
            statement.close();
            
            connection.close();
            out.println("<h2>É¾³ý»ØÌû³É¹¦</h2>");
        }
        catch (Exception e)
        {
            out.println("<h2>É¾³ý»ØÌûÊ§°Ü:"+e+"</h2>");
        }
        out.println("<a href='post.jsp?postid="+post_id+"'>·µ»ØÌû×Ó</a>");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
