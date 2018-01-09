package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.rowset.CachedRowSetImpl;

import data.ByPageShowBean;
import data.jdbcBean;


public class HandleSearch extends HttpServlet {

	public void init(ServletConfig config) throws ServletException{
	      super.init(config);
	   }
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 doPost(request,response);
	
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		PrintWriter out=response.getWriter();
		request.setCharacterEncoding("gb2312");
		response.setContentType("text/html;charset=gb2312");  
		String searchByContent = request.getParameter("search");
		String searchByType = request.getParameter("type");
		String searchBySubForum = request.getParameter("subForum"); //得到的是子版块id
		String searchBySort = request.getParameter("sort");
		CachedRowSetImpl rowSet = null;		
		
		//out.print(searchBySubForum);
		
		
		String sql = "";
		String []params=null;
		if(searchBySubForum.equals("all")) //所有板块
		{
		if(searchByType.equals("postTitle")){ //按帖子标题搜索
			sql="select * from (select bbs.post.content,bbs.sub_forum.id,bbs.post.user_id,bbs.post.post_title,bbs.post.send_time,bbs.post.view_num,bbs.post.reply_num,bbs.sub_forum.sub_forum_title from  bbs.post inner join  bbs.sub_forum on bbs.post.sub_id=bbs.sub_forum.id)as t where t.post_title like ? order by ?";
			params = new String[]{"%"+searchByContent+"%",searchBySort};
		}
		else if(searchByType.equals("postContent")){ //按帖子内容搜索
			sql="select * from (select bbs.post.content,bbs.sub_forum.id,bbs.post.user_id,bbs.post.post_title,bbs.post.send_time,bbs.post.view_num,bbs.post.reply_num,bbs.sub_forum.sub_forum_title from  bbs.post inner join  bbs.sub_forum on bbs.post.sub_id=bbs.sub_forum.id)as t where t.content like ? order by ?";
			params = new String[]{"%"+searchByContent+"%",searchBySort};
		}
		else if(searchByType.equals("all")){ //按全部内容搜索
			sql="select * from (select bbs.post.content,bbs.sub_forum.id,bbs.post.user_id,bbs.post.post_title,bbs.post.send_time,bbs.post.view_num,bbs.post.reply_num,bbs.sub_forum.sub_forum_title from  bbs.post inner join  bbs.sub_forum on bbs.post.sub_id=bbs.sub_forum.id)as t where t.post_title like ? or t.content like ? order by ?";
			params = new String[]{"%"+searchByContent+"%","%"+searchByContent+"%",searchBySort};
	
		}
		}
		else{ //在某子版块搜索
			if(searchByType.equals("postTitle")){
				sql="select * from (select bbs.post.content,bbs.sub_forum.id,bbs.post.user_id,bbs.post.post_title,bbs.post.send_time,bbs.post.view_num,bbs.post.reply_num,bbs.sub_forum.sub_forum_title from  bbs.post inner join  bbs.sub_forum on bbs.post.sub_id=bbs.sub_forum.id)as t where t.post_title like ? and t.id=? order by ?";
				params = new String[]{"%"+searchByContent+"%",searchBySubForum,searchBySort};
			}
			else if(searchByType.equals("postContent")){
				sql="select * from (select bbs.post.content,bbs.sub_forum.id,bbs.post.user_id,bbs.post.post_title,bbs.post.send_time,bbs.post.view_num,bbs.post.reply_num,bbs.sub_forum.sub_forum_title from  bbs.post inner join  bbs.sub_forum on bbs.post.sub_id=bbs.sub_forum.id)as t where t.content like ? and t.id=? order by ?";
				params = new String[]{"%"+searchByContent+"%",searchBySubForum,searchBySort};
			}
			else if(searchByType.equals("all")){
				sql="select * from (select bbs.post.content,bbs.sub_forum.id,bbs.post.user_id,bbs.post.post_title,bbs.post.send_time,bbs.post.view_num,bbs.post.reply_num,bbs.sub_forum.sub_forum_title from  bbs.post inner join  bbs.sub_forum on bbs.post.sub_id=bbs.sub_forum.id)as t where t.post_title like ? or t.content like ? and t.id=? order by ?";
				params = new String[]{"%"+searchByContent+"%","%"+searchByContent+"%",searchBySubForum,searchBySort};
		
			}
		}
		
		
		HttpSession session = request.getSession(true);
		ByPageShowBean pageBean = null;
		//pageBean = (ByPageShowBean)session.getAttribute("pageBean");
		//if(pageBean == null){
			pageBean = new ByPageShowBean();
			session.setAttribute("pageBean", pageBean);
		//}
		try{
			if(searchByContent == null || searchByContent == ""){
				out.print("请输入搜索内容！");
			}
			else{
				jdbcBean db = new jdbcBean();
			ResultSet rs = db.query(sql, params);
			rowSet = new CachedRowSetImpl();
			rowSet.populate(rs);
			pageBean.setRowset(rowSet);
			}
		}catch(Exception e){}
		
		response.sendRedirect("Search.jsp");
		
	}


}
