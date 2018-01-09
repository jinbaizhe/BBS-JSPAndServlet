package control;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Calendar;

@WebServlet(name = "unstar")
public class unstar extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=GB2312");
        String userid = "1";
        String postid = request.getParameter("postid");
        PrintWriter out = response.getWriter();
        try
        {
            Context initCtx = new InitialContext();
            DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/db");
            Connection connection = ds.getConnection();
            PreparedStatement statement = connection.prepareStatement("delete from favourite where userid=? and postid=?");
            statement.setString(1, userid);
            statement.setString(2, postid);
            statement.execute();
            statement.close();
            connection.close();
            out.println("<h2>ȡ���ղسɹ�</h2>");
        }
        catch (Exception e)
        {
            out.println("<h2>ȡ���ղ�ʧ�ܣ�</h2>");
        }
        out.println("<a href='post.jsp?postid="+postid+"'>��������</a>");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
