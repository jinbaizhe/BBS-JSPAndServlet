package control;

import data.transferToGB2312;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "deleteUploadedImage")
public class deleteUploadedImage extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session =request.getSession(true);
        String image_id = request.getParameter("imgid");
        String post_id = request.getParameter("postid");
        String followpost_id = request.getParameter("followpostid");
        String title = transferToGB2312.getString(request.getParameter("title"));
        String content = transferToGB2312.getString(request.getParameter("content"));
        try {
            Context initCtx = new InitialContext();
            DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/db");
            Connection connection = ds.getConnection();
            PreparedStatement statement = connection.prepareStatement("delete from image  where id=?");
            statement.setString(1, image_id);
            statement.execute();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (title == null)//删除回帖里的图片
        {
            session.setAttribute("replyPost",content);
            request.getRequestDispatcher("updateFollowpost.jsp?followpostid=" + followpost_id + "&postid=" + post_id).forward(request, response);
        }
        else {//删除帖子里的图片
            session.setAttribute("post_title",title);
            session.setAttribute("post_content",content);
            request.getRequestDispatcher("updatePost.jsp?postid=" + post_id).forward(request, response);
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
