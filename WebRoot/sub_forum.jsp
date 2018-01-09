<%--
  Created by IntelliJ IDEA.
  User: Parker
  Date: 2017/12/21
  Time: 15:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gb2312" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*,javax.sql.*" %>

<html>
  <head>
    <title>$Title$</title>
    <link href="css/index.css" rel="stylesheet">
  </head>
   <jsp:include page="head.jsp"/>
  <body>
  <%
    int totalPostNum,totalPageNum,pageSize=2,pageNum,sub_id;
    String temp = request.getParameter("subid");
    if(temp==null||temp.equals(""))
      sub_id=1;
    else
      sub_id=Integer.parseInt(temp);
    temp = request.getParameter("pageNum");
    if(temp==null||temp.equals(""))
      pageNum=1;
    else
      pageNum=Integer.parseInt(temp);
    String postingURL="posting.jsp?subforumid="+sub_id;
    Context initCtx = new InitialContext();
    DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/db");
    Connection connection = ds.getConnection();

    PreparedStatement statement = connection.prepareStatement("select sub_forum.*,main_forum.title from sub_forum,main_forum where sub_forum.main_id=main_forum.id and sub_forum.id=?");
    statement.setString(1,""+sub_id);
    ResultSet rs = statement.executeQuery();
    String mainForumid="",mainForumTitle="",subForumTitle="",subForumContent="";
    if (rs.next())
    {
      mainForumid=rs.getString("sub_forum.main_id");
      mainForumTitle=rs.getString("main_forum.title");
      subForumTitle=rs.getString("sub_forum.sub_forum_title");
      subForumContent=rs.getString("sub_forum.info");

    }
    String mainforumURL="allForum.jsp?mainforumid="+mainForumid;
  %>


    <div style="width: 100%;">
      <div class="container" style="margin-top: 30px;">
        <div class="row">
          <div class="col-md-12">
            <div style='font-size: 20px'><a href='allForum.jsp'>全部版块</a>>><a href=<%=mainforumURL%>><%=mainForumTitle%></a></div>
            <p style="font-size: 20pt"><%=subForumTitle%></p>
            <p style="font-size: 12pt"><%=subForumContent%> </p>
            <ul class="list-group">
              <div class="list-group-item active">
                帖子列表
                &nbsp;&nbsp;&nbsp;
                <%
                  String order=(String)session.getAttribute("postOrder");
                  if(order!=null&&order!=""&&order.equals("send_time desc"))
                  {
                %>
                <a href="setPostOrderServlet?postOrder=0&subForumid=<%=sub_id%>" class="btn btn-primary btn-xs">按回帖时间排序</a>
                &nbsp;&nbsp;&nbsp;
                <a href="setPostOrderServlet?postOrder=1&subForumid=<%=sub_id%>" class="btn btn-primary btn-xs active">按发帖时间排序</a>
                <%
                  }
                  else
                  {
                %>
                <a href="setPostOrderServlet?postOrder=0&subForumid=<%=sub_id%>" class="btn btn-primary btn-xs active">按回帖时间排序</a>
                &nbsp;&nbsp;&nbsp;
                <a href="setPostOrderServlet?postOrder=1&subForumid=<%=sub_id%>" class="btn btn-primary btn-xs">按发帖时间排序</a>
                <%
                  }
                %>
                <a href="<%=postingURL%>" style="float: right;color: white">发帖>></a>
                <!--<p style="float: right"></p>-->
              </div>
    <%
    statement = connection.prepareStatement("select * from post,user where post.user_id=user.id and sub_id =? order by "+order);
    statement.setString(1,""+sub_id);
    rs = statement.executeQuery();
    rs.last();
    totalPostNum=rs.getRow();
    totalPageNum=totalPostNum%pageSize==0?totalPostNum/pageSize:totalPostNum/pageSize+1;
    rs.beforeFirst();
    int pageFirstPost=(pageNum-1)*pageSize+1;
    rs.absolute(pageFirstPost-1);
    String title,author,postTime,lastFollowPostTime,postid,content;
    int replyNum,viewNum;
    for(int i=pageFirstPost;i<=(pageFirstPost-1+pageSize)&&rs.next();i++)
    {
      postid = rs.getString("id");
      title = rs.getString("post_title");
      author = rs.getString("username");
      content = rs.getString("content");
      replyNum = Integer.parseInt(rs.getString("reply_num"));
      viewNum = Integer.parseInt(rs.getString("view_num"));
      postTime = rs.getString("send_time");
      postTime=postTime.substring(0,postTime.length()-2);
      lastFollowPostTime = rs.getString("last_followpost_time");
      lastFollowPostTime =lastFollowPostTime.substring(0,lastFollowPostTime.length()-2);

      if(content.length()>30)
        content=content.substring(0,30)+"...";
      %>

          <a href="post.jsp?postid=<%=postid%>&subid=<%=sub_id%>" class="list-group-item">
            <h4 class="list-group-item-heading"><%=title%></h4>
            <%=content%>
            <p class="text-right" style="float: right;margin-right: 20px">作者:<%=author%>&nbsp;浏览量:<%=viewNum%>&nbsp;评论量:<%=replyNum%>&nbsp;发表日期:<%=postTime%></p>
            <br>
          </a>

  <%}%>
    </ul>
            <ul class="pagination">
            <%
              rs.close();
              statement.close();
              connection.close();
              if(pageNum!=1)
                out.println("<li><a href='sub_forum.jsp?subid="+sub_id+"&pageNum="+(pageNum-1)+"'>&laquo;</a></li>");
              for(int i=1;i<=totalPageNum;i++)
              {
                  if(i!=pageNum)
                    out.println("<li><a href='sub_forum.jsp?subid="+sub_id+"&pageNum="+i+"'>"+i+"</a></li>");
                  else
                    out.println("<li class='active'><a href='sub_forum.jsp?subid="+sub_id+"&pageNum="+i+"'>"+i+"</a></li>");
              }
              if(pageNum<totalPageNum)
                out.println("<li><a href='sub_forum.jsp?subid="+sub_id+"&pageNum="+(pageNum+1)+"'>&raquo;</a></li>");

            %>
            </ul>
      </div>
    </div>
  </div>
</div>
  </body>
</html>
 <jsp:include page="bottom.jsp"/>