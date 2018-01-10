<%--
  Created by IntelliJ IDEA.
  User: Parker
  Date: 2017/12/22
  Time: 9:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gb2312" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*,javax.sql.*" %>
<%@ page import="data.LoginBean" %>

<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="ckeditor/ckeditor.js"></script>
    <link href="css/post-detail.css" rel="stylesheet">
    <link href="css/index.css" rel="stylesheet">
</head>
 <jsp:include page="head.jsp"/>
<body>

<%
	LoginBean login = new LoginBean();
	login = (LoginBean)session.getAttribute("loginBean");
	int userid0 = login.getId();//用户id
	
//////////////////////////

    String post_id,sub_id;
    Boolean isStar=false;
    post_id = request.getParameter("postid");
    int totalFollowpostNum,totalPageNum,pageSize=2,pageNum;
    sub_id = request.getParameter("subid");
    if(sub_id==null||sub_id.equals(""))
        sub_id="1";
    String temp;
    temp = request.getParameter("pageNum");
    if(temp==null||temp.equals(""))
        pageNum=1;
    else
        pageNum=Integer.parseInt(temp);

    Context initCtx = new InitialContext();
    DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/db");
    Connection connection = ds.getConnection();
    PreparedStatement statement = connection.prepareStatement("select post.*,user.id,user.username,user.sex,sub_forum.id,sub_forum.sub_forum_title,main_forum.id,main_forum.title from post,user,sub_forum,main_forum where post.user_id = user.id and post.sub_id=sub_forum.id and main_forum.id=sub_forum.main_id and post.id = ?");
    statement.setString(1,post_id);
    ResultSet rs = statement.executeQuery();
    
    
    LoginBean loginBean = (LoginBean)session.getAttribute("loginBean");
    String user_id="";
	if(loginBean!=null)
	{
		user_id=String.valueOf(loginBean.getId());
		statement = connection.prepareStatement("select * from favourite where userid=? and postid =?");
    	statement.setString(1,user_id);
    	statement.setString(2,post_id);
    	ResultSet rs_star = statement.executeQuery();
    	if(rs_star.next())
    	{
   			isStar=true;
    	}
    	rs_star.close();
    	statement.close();
	}
    
    
    String title,author,content,postTime;
    String subforum_id="",subforum_title="";
    String mainforum_id="",mainforum_title="";
    String user_sex="",authorID="",post_type="0",post_isTop="0";
    int replyNum,viewNum;
    PreparedStatement statement_post_img = connection.prepareStatement("select image.id from image where post_id =?");
    statement_post_img.setString(1,post_id);
    ResultSet rs_post_img = statement_post_img.executeQuery();
    String div_img="";
    while (rs_post_img.next())
    {
        div_img+="<img src='showImageServlet?imgid="+rs_post_img.getString("id")+"'width='120' height=100>&nbsp;&nbsp;";
    }
    if(rs.next())
    {
        sub_id=rs.getString("sub_id");
        title = rs.getString("post_title");
        author = rs.getString("username");
		authorID = rs.getString("user.id");
        user_sex=rs.getString("user.sex");
        replyNum = Integer.parseInt(rs.getString("reply_num"));
        viewNum = Integer.parseInt(rs.getString("view_num"));
        postTime = rs.getString("send_time");
        postTime=postTime.substring(0,postTime.length()-2);
        content=rs.getString("content");
        post_isTop=rs.getString("post.isTop");
        post_type=rs.getString("post_type");

        subforum_id=rs.getString("sub_forum.id");
        subforum_title=rs.getString("sub_forum.sub_forum_title");
        mainforum_id=rs.getString("main_forum.id");
        mainforum_title=rs.getString("main_forum.title");
        %>
    <div style="height:auto">

            <%
//        if(pageNum==1)
        {
%>
    <div class="container" style="margin-top: 50px" >
        <div class="row">
            <div class="col-md-1 post-border">
            </div>
            <div style='font-size: 20px'><a href='allForum.jsp'>全部版块</a>>>&nbsp;<a href='allForum.jsp?mainforumid=<%=mainforum_id%>'><%=mainforum_title%></a>>>&nbsp;<a href='sub_forum.jsp?subid=<%=sub_id%>'><%=subforum_title%></a></div>

            <div class="col-md-2 post-head">
            <%
            	if(authorID.equals(user_id))
            	{
             %>
             	<a href="MyZone.jsp">
             <%
             	}else{
             %>
				<a href="othersInformation.jsp?userid=<%=authorID%>">
			<%
				}
				%>
	                <img  alt="" class="img-responsive img-circle" src="avatar/<%=authorID%>.jpg"
	                      style="margin:1px 1px;width: 120px;height: 120px;margin: 30px auto;"/>
	
	                <span class="badge" style="background: #f1c40f;margin-top: 5px">发帖者:<%=author%></span>
	                <br/>
	                <span class="badge" style="background: #2ecc71;margin-top: 5px">性别:<%=user_sex %></span>
	                <br/>
	                <span class="badge" style="background: #ff6927;margin-top: 5px">论坛等级:LV1</span>
			</a>
                <br>
            </div>
            <div class="col-md-8 post-content">
                <div class="post-title">
                    <h2 style="margin-left:20px;color:black"><%=title%></h2>
                    <div style="margin-left:20px" >
                        <span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;回复数:<%=replyNum%> &nbsp;|&nbsp;<span>发表于:<%=postTime%></span>
                        <%
                            String post_update_url="updatePost.jsp?userid=1"+"&postid="+post_id;
                            String post_delete_url="deletePostServlet?userid=1"+"&postid="+post_id+"&subid="+sub_id;
                        %>
                        <strong style=" float:right;margin-right:10px">
                            <span class="badge" style="background: #ff6927;width: 50px;">楼主</span>
                        </strong>

                        <a style="float:right;margin-right: 20px;" href="<%=post_delete_url%>">删除</a>
                        <a style="float:right;margin-right: 20px;" href="<%=post_update_url%>">编辑</a>
                        <%if(!isStar)
                        { %>
                        <a style="float:right;margin-right: 20px;" href="starServlet?postid=<%=post_id%>">收藏</a>
                        <%}else{ %>
                        <a style="float:right;margin-right: 20px;" href="unstarServlet?postid=<%=post_id%>">取消收藏</a>
                        <%} if(post_isTop.equals("0")){%>
                        <a style="float:right;margin-right: 20px;" href="stickPostServlet?postid=<%=post_id%>&type=1">置顶</a>
                        <%}else{ %>
                        <a style="float:right;margin-right: 20px;" href="stickPostServlet?postid=<%=post_id%>&type=0">取消置顶</a>
                        <%} if(post_type.equals("0")){%>
                        <a style="float:right;margin-right: 20px;" href="highlightPostServlet?postid=<%=post_id%>&type=1">加精</a>
						<%}else{ %>
						<a style="float:right;margin-right: 20px;" href="highlightPostServlet?postid=<%=post_id%>&type=0">取消加精</a>
						<%} %>
                    </div>

                </div>
                <div style="margin: 20px">
                    <%=content%>
                </div>
                <div style="margin: 20px">
                    <%=div_img%>
                </div>

            </div>
            <div class="col-md-1 post-border">
            </div>
        </div>


    <%
        }
    rs.close();
    statement.close();

    statement = connection.prepareStatement("SELECT followpost.*,user.username,user.id,user.sex FROM followpost,user where followpost.followpost_user_id=user.id and post_id =? order by follow_time asc;");
    statement.setString(1,post_id);
    rs = statement.executeQuery();
    rs.last();
    totalFollowpostNum=rs.getRow();
    totalPageNum=totalFollowpostNum%pageSize==0?totalFollowpostNum/pageSize:totalFollowpostNum/pageSize+1;
    rs.beforeFirst();
    int pageFirstPost=(pageNum-1)*pageSize+1;
    rs.absolute(pageFirstPost-1);
    String followpostUserName,followpostId,followpostContent,follow_time,followpostUserSex,followpostUserID;
    for(int i=pageFirstPost;i<=(pageFirstPost-1+pageSize)&&rs.next();i++)
    {
        followpostId=rs.getString("followpost_id");
        followpostUserName=rs.getString("username");
		followpostUserID=rs.getString("user.id");
        followpostUserSex=rs.getString("user.sex");
        followpostContent=rs.getString("content");
        follow_time=rs.getString("follow_time");
        follow_time=follow_time.substring(0,follow_time.length()-2);
        PreparedStatement statement_followpost_img = connection.prepareStatement("select image.id from image where followpost_id =?");
        statement_followpost_img.setString(1,followpostId);
        ResultSet rs_followpost_img = statement_followpost_img.executeQuery();
        String div_followpost_img="";
        while (rs_followpost_img.next())
        {
            div_followpost_img+="<img src='showImageServlet?imgid="+rs_followpost_img.getString("id")+"'width='120' height=100>&nbsp;&nbsp;";
        }
        rs_followpost_img.close();
        statement_followpost_img.close();
%>
    <!-- 回复内容 -->


        <div class="row" style="margin-top: 5px">
            <div class="col-md-1 reply-border">
            </div>

            <div class="col-md-2 reply-head">
            <%
            	if(user_id.equals(followpostUserID))
            	{
             %>
             		<a href="MyZone.jsp">
             <%
             	}else{
             %>
				<a href="othersInformation.jsp?userid=<%=followpostUserID%>">
			<%
				} 
			%>
	                <img  alt="" class="img-responsive img-circle" src="avatar/<%=followpostUserID%>.jpg"
	                      style="margin:1px 1px;width: 120px;height: 120px;margin: 30px auto;"/>
	
	                <span class="badge" style="background: #f1c40f;margin-top: 5px">回帖者:<%=followpostUserName%></span>
	                <br/>
	                <span class="badge" style="background: #2ecc71;margin-top: 5px">性别:<%=followpostUserSex %></span>
	                <br/>
	                <span class="badge" style="background: #ff6927;margin-top: 5px">论坛等级:LV1</span>
				 </a>
                <br>
            </div>
            <div class="col-md-8 reply-content">

                <div class="reply-time">
                    <span style="color: gray">回复于:<%=follow_time%></span>
                    <%
                        String followpost_update_url="updateFollowpost.jsp?userid=1"+"&postid="+post_id+"&followpostid="+followpostId;
                        String followpost_delete_url="deleteFollowpostServlet?userid=1"+"&postid="+post_id+"&followpostid="+followpostId;

                    %>
                    <div style="float:right;margin-right:10px">
                        <span class="badge" style="float:right;margin-right:10px;background: #4b9ded;width: 50px;"><%=i%>楼</span>
                    </div>
                    <a style="float:right;margin-right: 20px;" href="<%=followpost_delete_url%>">删除</a>
                    <a style="float:right;margin-right: 20px;" href="<%=followpost_update_url%>">编辑</a>

                    <!--<span class="badge" style="float:right;margin-right:10px;background: #ff6927;width: 50px;">沙发</span>-->

                    <!--<span class="badge" style="float:right;margin-right:10px;background: #ff5959;width: 50px;">板凳</span>-->

                    <!--<span class="badge" style="float:right;margin-right:10px;background: #4b9ded;width: 50px;">地板</span>-->

                    </div>

                <div style="margin: 20px;">
                    <%=followpostContent%>
                </div>
                <div style="margin: 20px">
                    <%=div_followpost_img%>
                </div>
            </div>
            <div class="col-md-1 reply-border">
            </div>

        </div>


    <%
        }
        rs.close();
        statement.close();
        connection.close();
    %>


        <div class="row">
            <div class="col-md-1">
            </div>
            <div class="col-md-10">
            <ul class="pagination">
<%
            if(pageNum!=1)
                out.println("<li><a href='post.jsp?postid="+post_id+"&pageNum="+(pageNum-1)+"'>&laquo;</a></li>");
              for(int i=1;i<=totalPageNum;i++)
              {
                  if(i!=pageNum)
                    out.println("<li><a href='post.jsp?postid="+post_id+"&pageNum="+i+"'>"+i+"</a></li>");
                  else
                    out.println("<li class='active'><a href='post.jsp?postid="+post_id+"&pageNum="+i+"'>"+i+"</a></li>");
              }
              if(pageNum<totalPageNum)
                                out.println("<li><a href='post.jsp?postid="+post_id+"&pageNum="+(pageNum+1)+"'>&raquo;</a></li>");
    }
%>
            </ul>
                <form action="replyPostServlet" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="postid" value=<%=post_id%>>
                    <textarea id="TextArea1" cols="20" rows="1" name="content" class="ckeditor"></textarea>
                    <br>
                    <div>
                        <div style="float: left;margin-top: 3px;margin-right: 5px;">
                            <input type="file" name="uploadFile">
                        </div>
                        <div style="float: left;margin-top: 3px;margin-right: 5px;">
                            <input type="file" name="uploadFile">
                        </div>
                        <div style="float: left;margin-top: 3px;margin-right: 5px;">
                            <input type="file" name="uploadFile">
                        </div>
                        <br>
                        <div style="float:right;margin: 30px auto">
                            <input type="submit" class="btn btn-primary" style="width: 60px;" value="回复"></input>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>
</body>
</html>
     <jsp:include page="bottom.jsp"/>