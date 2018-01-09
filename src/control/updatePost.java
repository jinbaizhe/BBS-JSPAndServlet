package control;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import data.transferToGB2312;
import org.apache.commons.fileupload.FileItem;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

@WebServlet(name = "updatePost")
public class updatePost extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=GB2312");

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        String time = format.format(Calendar.getInstance().getTime());

        PrintWriter out=response.getWriter();

        String title="",content="",user_id="",post_id="",info="";
        List<FileItem> list=null;
        try {
            Context initCtx = new InitialContext();
            DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/db");
            Connection connection = ds.getConnection();
            //ʹ��Apache�ļ��ϴ���������ļ��ϴ����裺
            //1������һ��DiskFileItemFactory����
            DiskFileItemFactory factory = new DiskFileItemFactory();
            //2������һ���ļ��ϴ�������
            ServletFileUpload upload = new ServletFileUpload(factory);
            //����ϴ��ļ�������������
            upload.setHeaderEncoding("gb2312");
            //3���ж��ύ�����������Ƿ����ϴ�����������
            if (!ServletFileUpload.isMultipartContent(request)) {
                //���մ�ͳ��ʽ��ȡ����
                return;
            }
            //4��ʹ��ServletFileUpload�����������ϴ����ݣ�����������ص���һ��List<FileItem>���ϣ�ÿһ��FileItem��Ӧһ��Form������������

            list = upload.parseRequest(request);
            for (FileItem item : list) {
                //���fileitem�з�װ������ͨ�����������
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    //�����ͨ����������ݵ�������������
                    String value = item.getString("gb2312");
                    if (name.equals("title"))
                        title = value;
                    else if (name.equals("content"))
                        content = value;
                    else if (name.equals("userid"))
                        user_id = value;
                    else if (name.equals("postid"))
                        post_id = value;
                    else if (name.equals("info"))
                        info = value;
                }
            }
            for (FileItem item : list) {
                //���fileitem�з�װ�����ϴ��ļ�
                if (!item.isFormField()) {
                    {
                        //�õ��ϴ����ļ����ƣ�
                        String filename = item.getName();
                        if (filename == null || filename.trim().equals("")) {
                            continue;
                        }
                        //ע�⣺��ͬ��������ύ���ļ����ǲ�һ���ģ���Щ������ύ�������ļ����Ǵ���·���ģ��磺  c:\a\b\1.txt������Щֻ�ǵ������ļ������磺1.txt
                        //������ȡ�����ϴ��ļ����ļ�����·�����֣�ֻ�����ļ�������
                        filename = filename.substring(filename.lastIndexOf("\\") + 1);
                        //��ȡitem�е��ϴ��ļ���������
                        InputStream in = item.getInputStream();
                        //����һ���ļ������
                        PreparedStatement preparedStatement = connection.prepareStatement("insert into image(user_id,name,post_id,upload_time,image,info) values (?,?,?,?,?,?)");
                        preparedStatement.setString(1, user_id);
                        preparedStatement.setString(2, filename);
                        preparedStatement.setString(3, post_id);
                        preparedStatement.setString(4, time);
                        preparedStatement.setBinaryStream(5, in);
                        preparedStatement.setString(6, info);
                        preparedStatement.executeUpdate();
                        //�ر�������
                        in.close();
                        //ɾ�������ļ��ϴ�ʱ���ɵ���ʱ�ļ�
                        item.delete();
                        preparedStatement.close();
                    }
                }
            }
            PreparedStatement statement = connection.prepareStatement("update post set post_title=?,content=?,update_time=? where id = ?");
            statement.setString(1,title);
            statement.setString(2,content);
            statement.setString(3,time);
            statement.setString(4,post_id);
            statement.execute();
            statement.close();
            connection.close();
            out.println("<h2>�޸����ӳɹ�</h2>");
        }
        catch (Exception e)
        {
            out.println("<h2>�޸�����ʧ��:"+e+"</h2>");
        }
        out.println("<br><a href='post.jsp?postid="+post_id+"'>��������</a>");
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}