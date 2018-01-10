package control;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.jspsmart.upload.File;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

import data.LoginBean;
import data.jdbcBean;

public class HandleAlterAvatar extends HttpServlet {
	public void init(ServletConfig config) throws ServletException{
	      super.init(config);
	   }
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 doPost(request,response);
	
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		 HttpSession session = request.getSession(true);
		 LoginBean login = new LoginBean();
		 login = (LoginBean)session.getAttribute("loginBean"); //得到当前登录 的用户
		 String username = login.getLogname(); //得到用户名
		 int userid = login.getId();//得到用户id
		 String path = this.getServletContext().getRealPath("/")+"avatar\\";
		 String newFilename = userid+".jpg"; //头像图片名字以用户名来存
		 SmartUpload smartUpload = new SmartUpload();
	        // 初始化
	        ServletConfig config = this.getServletConfig();
	        smartUpload.initialize(config, request, response);
	        try {
	            smartUpload.setAllowedFilesList("jpg,png");  //设定允许上传的文件类型，如下面是只允许上传jpg,png  
		        smartUpload.setDeniedFilesList("exe,bat,jsp,htm,html,,"); 
		        //设定禁止上传的文件（通过扩展名限制）,禁止上传带有exe,bat,jsp,htm,html扩展名的文件和没有扩展名的文件。  
	            // 上传文件
	            smartUpload.upload();
	            // 得到上传的文件对象
	            File smartFile = smartUpload.getFiles().getFile(0);
	            // 保存文件
	            smartFile.saveAs(path + newFilename,
	                    SmartUpload.SAVE_PHYSICAL);// 保存文件
	        } catch (SmartUploadException e) {
	            e.printStackTrace();
	        } catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    //把图片路径存到数据库中
	        
	        String sql = "update user set avatar=? where username=?";
	        String []params={newFilename,username};
	        try{
	        	jdbcBean db = new jdbcBean();
	        	db.update(sql, params);
	        }catch(Exception e){}
	        
	        response.sendRedirect("MyZone.jsp");
	    }
	
		
	}

