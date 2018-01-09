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

@WebServlet(name = "deletePost")
public class deletePost extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=GB2312");
        String user_id =request.getParameter("userid");
        String post_id =request.getParameter("postid");
        String sub_id =request.getParameter("subid");

        PrintWriter out=response.getWriter();

        try {
            Context initCtx = new InitialContext();
            DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/db");
            Connection connection = ds.getConnection();
            PreparedStatement statement = connection.prepareStatement("delete from post where id=?");
            statement.setString(1,post_id);

            statement.execute();
            statement.close();
            connection.close();
            out.println("<h2>ɾ�����ӳɹ�</h2>");
        }
        catch (Exception e)
        {
            out.println("<h2>ɾ������ʧ��:"+e+"</h2>");
        }
        out.println("<a href='sub_forum.jsp?subid="+sub_id+"'>����</a>");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
