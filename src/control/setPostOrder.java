package control;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "setPostOrder")
public class setPostOrder extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String postOrder=request.getParameter("postOrder");
        String subForumid=request.getParameter("subForumid");
        HttpSession session=request.getSession(true);
        if(postOrder.equals("1"))//按发帖时间
        {
            session.setAttribute("postOrder","send_time desc");
        }
        else//按最后回复时间
        {
            session.setAttribute("postOrder","last_followpost_time desc");
        }
        response.sendRedirect("sub_forum.jsp?subid="+subForumid);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
