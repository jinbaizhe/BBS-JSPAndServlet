<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="data.LoginBean"%>
<%@ page import="data.jdbcBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
 <jsp:include page="head.jsp"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Insert title here</title>

</head>
<body>
<div class="container">
    <div class="row">
<img src="image/hot.png" class="img-responsive"  width="1216"  height="944"> 
</div>


<%
	final int MAXSUBFORUMNUM=5;
   	String sql0 = "select title,id from bbs.main_forum";
    try{
   		jdbcBean db = new jdbcBean();
    	ResultSet rs = db.query(sql0);
    	while(rs.next()){   	
    
    		%>
    		 <div class="row">
        <div class="col-md-12">
            <ul class="list-group">
                <div class="row">
                    <div class="list-group-item active">
                        <%= rs.getString(1)%>
                        <a href="allForum.jsp?mainforumid=<%=rs.getString(2) %>" style="float: right ; color: white">更多>></a>
                    </div>
                </div>
                <div class="row">
    		
    		
    		<%  
    		 
    		String sql1 ="select * from (select bbs.sub_forum.main_id,bbs.post.post_type,bbs.sub_forum.id,bbs.post.user_id,bbs.post.post_title,bbs.post.send_time,bbs.post.view_num,bbs.post.reply_num,bbs.post.id as post_id,bbs.post.isTop,bbs.sub_forum.sub_forum_title from  bbs.post inner join  bbs.sub_forum on bbs.post.sub_id=bbs.sub_forum.id) as t left join bbs.user on bbs.user.id=user_id where main_id=? order by isTop desc, reply_num desc";
    		String []params1 = {rs.getString(2)}; //主板块号
    		 ResultSet rs1 = db.query(sql1, params1);
    		  int i = 0 ;
    		 while(rs1.next()){  
    		 
    		 		if(i>=MAXSUBFORUMNUM)
        				break;  		 
    		 		String title = rs1.getString(5);
    		 		String istop = rs1.getString(10);
    		 		String type = rs1.getString(2);
    				String postUserid =rs1.getString(4).trim(); 				 
    				String avatarPath = "avatar/"+postUserid+".jpg";
    				i++;
    				//out.print(avatarPath);
    		 	%>  
    		 	<%  
    		 	String path  = this.getServletContext().getRealPath("/")+"avatar\\"+postUserid+".jpg";
    		 	File f = new File(path);
    		 	if(!(f.exists())){
    		 		avatarPath = "avatar/default.jpg";
    		 	}
    		 	%>
    		 	
    		 		<a href="post.jsp?postid=<%=rs1.getString(9) %>" class="list-group-item">
                        <div> 
                         	 
                            <img  alt="<%=avatarPath %>"  align="left"  class="img-responsive" src="<%=avatarPath %>" style="margin:1px 1px;width: 40px;height: 40px;margin-right: 20px"/>
                            <div class="list-group-item-heading">
                                <div style="font-size: 18px;">
                                	<% if (istop.equals("1")){
                                	 		title = "[置顶]"+rs1.getString(5);
                                	 		}
                                	 	if(type.equals("1")){
                                	 		title = "[精华]"+title ;
                                	 	}
                                	 	
                                	 	
                                	 %>
                                    <%=title%>
                                    <div class="text-right" style="float: right;margin-right: 20px;font-size: 14px">回复/浏览：<%=rs1.getString(8) %>/<%=rs1.getString(7) %></div>
                                </div>
                            </div>
                           作者： <%=rs1.getString(13)%>
                            <p class="text-right" style="float: right;margin-right: 20px">发帖时间：<%=rs1.getString(6) %></p>
                        </div>
                    </a>
    		 	<%     		 		
    		 		
    		 
    		 }
    		%>
    			
    			</div>
    			</ul>
    			</div>
    			</div>
    			
    	<% 	
    	}
    	%>
    	
    	</div>
    	
    	<%
    	db.close();
    }catch(Exception e){}
   
 %>
</body>
</html>
<%@include file="bottom.jsp"%>