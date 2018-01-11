package control;

import data.LoginBean;
import data.Validate;
import data.transferToGB2312;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

@WebServlet(name = "updateFollowpost")
public class updateFollowpost extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=GB2312");

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        String time = format.format(Calendar.getInstance().getTime());

        PrintWriter out=response.getWriter();

        String content="",user_id="",post_id="",info="", followpost_id="";
        HttpSession session = request.getSession(true);
        LoginBean login = (LoginBean)session.getAttribute("loginBean");
        if(login==null)
        	response.sendRedirect("Login.jsp");
        else
        	user_id=String.valueOf(login.getId());
        List<FileItem> list=null;
        try {
            Context initCtx = new InitialContext();
            DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/db");
            Connection connection = ds.getConnection();
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
            for (FileItem item : list) {
                //如果fileitem中封装的是普通输入项的数据
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    //解决普通输入项的数据的中文乱码问题
                    String value = item.getString("gb2312");
                    if (name.equals("content"))
                        content = value;
                    else if (name.equals("postid"))
                        post_id = value;
                    else if (name.equals("followpostid"))
                        followpost_id = value;
                    else if (name.equals("info"))
                        info = value;
                }
            }
            Validate validate = new Validate();
            if(!validate.hasUpdateFollowpostPermission(user_id, followpost_id))
            {
            	validate.close();
            	response.sendRedirect("error.jsp");
            }
            for (FileItem item : list) {
                //如果fileitem中封装的是上传文件
                if (!item.isFormField()) {
                    {
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
                        PreparedStatement preparedStatement = connection.prepareStatement("insert into image(user_id,name,followpost_id,upload_time,image,info) values (?,?,?,?,?,?)");
                        preparedStatement.setString(1, user_id);
                        preparedStatement.setString(2, filename);
                        preparedStatement.setString(3, followpost_id);
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
            }
            PreparedStatement statement = connection.prepareStatement("update followpost set content=?,update_time=? where followpost_id = ?");
            statement.setString(1,content);
            statement.setString(2,time);
            statement.setString(3,followpost_id);
            statement.execute();
            statement.close();
            connection.close();
            out.println("<h2>修改回帖成功</h2>");
        }
        catch (Exception e)
        {
            out.println("<h2>修改回帖失败:"+e+"</h2>");
        }

        out.println("<br><a href='post.jsp?postid="+post_id+"'>返回帖子</a>");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
