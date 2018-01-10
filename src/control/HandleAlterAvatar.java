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
		 login = (LoginBean)session.getAttribute("loginBean"); //�õ���ǰ��¼ ���û�
		 String username = login.getLogname(); //�õ��û���
		 int userid = login.getId();//�õ��û�id
		 String path = this.getServletContext().getRealPath("/")+"avatar\\";
		 String newFilename = userid+".jpg"; //ͷ��ͼƬ�������û�������
		 SmartUpload smartUpload = new SmartUpload();
	        // ��ʼ��
	        ServletConfig config = this.getServletConfig();
	        smartUpload.initialize(config, request, response);
	        try {
	            smartUpload.setAllowedFilesList("jpg,png");  //�趨�����ϴ����ļ����ͣ���������ֻ�����ϴ�jpg,png  
		        smartUpload.setDeniedFilesList("exe,bat,jsp,htm,html,,"); 
		        //�趨��ֹ�ϴ����ļ���ͨ����չ�����ƣ�,��ֹ�ϴ�����exe,bat,jsp,htm,html��չ�����ļ���û����չ�����ļ���  
	            // �ϴ��ļ�
	            smartUpload.upload();
	            // �õ��ϴ����ļ�����
	            File smartFile = smartUpload.getFiles().getFile(0);
	            // �����ļ�
	            smartFile.saveAs(path + newFilename,
	                    SmartUpload.SAVE_PHYSICAL);// �����ļ�
	        } catch (SmartUploadException e) {
	            e.printStackTrace();
	        } catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    //��ͼƬ·���浽���ݿ���
	        
	        String sql = "update user set avatar=? where username=?";
	        String []params={newFilename,username};
	        try{
	        	jdbcBean db = new jdbcBean();
	        	db.update(sql, params);
	        }catch(Exception e){}
	        
	        response.sendRedirect("MyZone.jsp");
	    }
	
		
	}

