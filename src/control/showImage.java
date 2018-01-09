package control;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.IOException;

import java.io.InputStream;
import java.io.OutputStream;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
@WebServlet(name = "showImage")
public class showImage extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String image_id=request.getParameter("imgid");
        response.setContentType("image/jpeg");
        try
        {
            Context initCtx = new InitialContext();
            DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/db");
            Connection connection = ds.getConnection();
            OutputStream os = response.getOutputStream();
            String sql ="select image.image from image where id=?";
            PreparedStatement ps=connection.prepareStatement(sql);
            ps.setString(1,image_id);
            ResultSet rs =ps.executeQuery();
            if (rs.next())
            {
                InputStream is = rs.getBinaryStream("image");
                BufferedInputStream bis = new BufferedInputStream(is);
                int capacity=256;
                byte[] bytes=new byte[capacity];
                int num;
                while ((num=bis.read(bytes))!=-1)
                    os.write(bytes,0,num);
                bis.close();
                is.close();
            }
            os.close();
            ps.close();
            connection.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
