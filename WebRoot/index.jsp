<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="data.userBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*,javax.sql.*" %>
<jsp:include page="head.jsp"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
   <title>篮球BBS</title>
  <script> 
	 $(document).ready(function(){ 
	 $('#myCarousel').carousel({interval:3000});//每隔3秒自动轮播 
	 }); 
 </script>
  </head>
  <%
  	final int MAXIMAGENUM=5;
  	Context initCtx = new InitialContext();
    DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/db");
    Connection connection = ds.getConnection();
    PreparedStatement statement = connection.prepareStatement("select post.id as postid,post_title,image.id as imageid,post.last_followpost_time from post,image where image.post_id = post.id group by postid order by last_followpost_time desc");
    ResultSet rs = statement.executeQuery();
   %>
  <body>
	  <div class="container" style="margin-top: 50px" >
	  <div class="col-md-3"></div>
	  <div class="col-md-6">
	  	<div id="myCarousel" class="carousel slide">
			<!-- 轮播（Carousel）指标 -->
			<ol class="carousel-indicators">
				<%
					rs.last();
					int num =rs.getRow();
					rs.beforeFirst();
					for(int i=0;i<num&&i<MAXIMAGENUM;i++)
					{
						if(i==0)
						{
				%>
							<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<%
						}
						else{%>
							<li data-target="#myCarousel" data-slide-to="<%=i%>"></li>
				<%		}
					}
				 %>
			</ol>   
			<!-- 轮播（Carousel）项目 -->
			<div class="carousel-inner">
			<%
				String imgid,post_title,post_id;
				for(int i=0;rs.next()&&i<num&&i<MAXIMAGENUM;i++)
				{
					imgid=rs.getString("imageid");
					post_title=rs.getString("post_title");
					post_id=rs.getString("postid");
					if(i==0)
					{
			%>
					<div class="item active">
			<%
					}else{
			%>
					<div class="item">
			<%
					}
			%>			<a href='post.jsp?postid=<%=post_id%>'>
							<img style="width:100%;height:300px" class="center-block" src="showImageServlet?imgid=<%=imgid%>" alt="<%=post_title%>" >
							<div class="carousel-caption"><%=post_title%></div>
						</a>
					</div>
			<%
				}
				rs.close();
				statement.close();
				connection.close();
			 %>
			</div>
			<!-- 轮播（Carousel）导航 -->
			<a class="carousel-control left" href="#myCarousel" 
			   data-slide="prev">&lsaquo;</a>
			<a class="carousel-control right" href="#myCarousel" 
			   data-slide="next">&rsaquo;</a>
		</div> 
	</div>
	</div>

  </body>
</html>

 <jsp:include page="bottom.jsp"/>
