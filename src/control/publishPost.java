package control;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;

@WebServlet(name = "publishPost")
public class publishPost extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=GB2312");
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = format.format(Calendar.getInstance().getTime());
        PrintWriter out=response.getWriter();
        String title="",content="",user_id="",info="",sub_forum_id="",post_id="";
        List<FileItem> list=null;
        try {
            //使用Apache文件上传组件处理文件上传步骤：
            //1、创建一个DiskFileItemFactory工厂
            DiskFileItemFactory factory = new DiskFileItemFactory();
            //2、创建一个文件上传解析器
            ServletFileUpload upload = new ServletFileUpload(factory);
            //解决上传文件名的中文乱码
            upload.setHeaderEncoding("gb2312");
            //3、判断提交上来的数据是否是上传表单的数据
            if (!ServletFileUpload.isMultipartContent(request)) {
                //按照传统方式获取数据
                return;
            }
            //4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项

            list = upload.parseRequest(request);
            for (FileItem item : list)
            {
                //如果fileitem中封装的是普通输入项的数据
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    //解决普通输入项的数据的中文乱码问题
                    String value = item.getString("gb2312");
                    if (name.equals("title"))
                        title = value;
                    else if (name.equals("content"))
                        content = value;
                    else if (name.equals("userid"))
                        user_id = value;
                    else if (name.equals("info"))
                        info = value;
                    else if (name.equals("sub_forumid"))
                        sub_forum_id = value;
                }
            }
            if (title.equals(""))
            {
                out.println("<h2>标题不能为空！</h2>");
            }
            else
            {
                Context initCtx = new InitialContext();
                DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/db");
                Connection connection = ds.getConnection();
                PreparedStatement statement = connection.prepareStatement("insert into post(sub_id,user_id,post_title,content,send_time,update_time,last_followpost_time) values(?,?,?,?,?,?,?)");
                statement.setString(1, sub_forum_id);
                statement.setString(2, user_id);
                statement.setString(3, title);
                statement.setString(4, content);
                statement.setString(5, time);
                statement.setString(6, time);
                statement.setString(7, time);
                statement.execute();
                statement.close();

                statement = connection.prepareStatement("select id from post where user_id=? and send_time=?");
                statement.setString(1, user_id);
                statement.setString(2, time);
                ResultSet rs = statement.executeQuery();
                if (rs.next()) {
                    post_id = rs.getString("id");
                }
                statement.close();
                for (FileItem item : list)
                {
                    if (!item.isFormField()) {
                        //如果fileitem中封装的是上传文件
                        //得到上传的文件名称，
                        String filename = item.getName();
                        if (filename == null || filename.trim().equals("")) {
                            continue;
                        }

                        //注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如：  c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
                        //处理获取到的上传文件的文件名的路径部分，只保留文件名部分
                        filename = filename.substring(filename.lastIndexOf("\\") + 1);
                        //获取item中的上传文件的输入流
                        InputStream in = item.getInputStream();
                        //创建一个文件输出流
                        PreparedStatement preparedStatement = connection.prepareStatement("insert into image(user_id,name,post_id,upload_time,image,info) values (?,?,?,?,?,?)");
                        preparedStatement.setString(1, user_id);
                        preparedStatement.setString(2, filename);
                        preparedStatement.setString(3, post_id);
                        preparedStatement.setString(4, time);
                        preparedStatement.setBinaryStream(5, in);
                        preparedStatement.setString(6, info);
                        preparedStatement.executeUpdate();
                        //关闭输入流
                        in.close();
                        //删除处理文件上传时生成的临时文件
                        item.delete();
                        preparedStatement.close();
                    }
                }
                connection.close();
                out.println("<h2>发帖成功</h2>");
            }
        }
        catch (Exception e)
        {
            out.println("<h2>发帖失败</h2>");
            e.printStackTrace();
        }
        out.println("<a href='posting.jsp?subforumid="+sub_forum_id+"'>继续发帖</a>");
        out.println("<br><a href='sub_forum.jsp?subid="+sub_forum_id+"'>返回版块首页</a>");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
