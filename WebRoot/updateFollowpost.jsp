<%--
  Created by IntelliJ IDEA.
  User: Parker
  Date: 2017/12/22
  Time: 22:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gb2312" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*,javax.sql.*" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="ckeditor/ckeditor.js"></script>
    <link href="css/post-detail.css" rel="stylesheet">
    <link href="css/index.css" rel="stylesheet">
</head>
 <jsp:include page="head.jsp"/>
<body>
<script type="text/javascript">
    function getTitleAndContent(){
        deleteImage1.content.value=CKEDITOR.instances.content.getData();
        deleteImage2.content.value=CKEDITOR.instances.content.getData();
        deleteImage3.content.value=CKEDITOR.instances.content.getData();
    }
</script>
<%
    final int max_upload_image_num=3;
    String post_id=request.getParameter("postid");
    String followpost_id=request.getParameter("followpostid");
    Context initCtx = new InitialContext();
    DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/db");
    Connection connection = ds.getConnection();
    PreparedStatement statement = connection.prepareStatement("select followpost.*,post.post_title from followpost,post where followpost.post_id = post.id and followpost.followpost_id=?");
    statement.setString(1,followpost_id);
    ResultSet rs = statement.executeQuery();
    String content="",post_title="11";
    if(rs.next())
    {
        post_title=rs.getString("post.post_title");
        content=rs.getString("content");
    }

    if(session.getAttribute("replyPost")!=null) {
        content = (String) session.getAttribute("replyPost");
        session.setAttribute("replyPost",null);
    }

    statement = connection.prepareStatement("select id from image where followpost_id=?");
    statement.setString(1,followpost_id);
    ResultSet rs_image = statement.executeQuery();
    String div_upload_image="",div_show_image="",image_id;
    int count=0;
    while(rs_image.next())
    {
        image_id=rs_image.getString("id");
        count++;
        div_show_image+="<div class=\"col-md-3\">\n" +
                "<img src='showImageServlet?imgid="+image_id+"' width='120' height=100 style='margin-bottom: 10px'>\n" +
                "<br>\n" +
                "<form action='deleteUploadedImageServlet?postid="+post_id+"&followpostid="+followpost_id+"&imgid="+image_id+"' method='post' name='deleteImage"+count+"' onclick='getTitleAndContent()'>\n" +
                "<input type=\"hidden\" name=\"content\">\n" +
                "<input type='submit' class='btn btn-primary' style='width: 60px;' value='删除'>\n" +
                "</form>\n" +
                "</a>\n" +
                "</div>";
    }
    div_show_image+="<br>";
    rs_image.close();
    statement.close();
    connection.close();
    while(count<max_upload_image_num)
    {
        div_upload_image+="<div style='float: left;margin-top: 3px;margin-right: 5px;'><input type='file' name='uploadFile'></div>";
        count++;
    }
%>
<div class="container" style="margin-top: 50px" >
    <div class="row">
        <div class="col-md-1">
        </div>
        <div class="col-md-11">
            <ul class="list-group">
                <form action='updateFollowpostServlet' method="post" enctype="multipart/form-data" name="updateFollowpostForm">
                    <li class="list-group-item" style="background-color: #F5F5F5">
                        <h3>修改回帖
                        </h3>
                    </li>
                    <li class="list-group-item">
                        <h4><b>帖子标题</b></h4>
                        <p style="font-size: 16px;color: grey "><%=post_title%></p>
                    </li>
                    <li class="list-group-item">
                        <h4><b>回帖内容</b></h4>
                        <textarea id="content" name="content" cols="20" rows="1" class="ckeditor" ><%=content%></textarea>
                    </li>
                    <li class="list-group-item">
                        <h4>上传图片</h4>
                        <div>
                            <%=div_upload_image%>
                            <br><br>
                        </div>

                    </li>
                    <div style="float:right;margin: 20px auto">
                        <input type="hidden" name="followpostid" value=<%=followpost_id%>>
                        <input type="hidden" name="postid" value=<%=post_id%>>
                        <input type="submit" class="btn btn-primary" style="width: 80px;" value="提交修改">
                    </div>
                    <div style="float:right;margin: 20px auto;margin-right: 50px">
                        <a href='post.jsp?postid=<%=post_id%>'>
                            <button type="button" class="btn btn-primary">返回</button>
                        </a>
                    </div>
                </form>
                <%=div_show_image%>
            </ul>
        </div>
        <div class="col-md-1">
        </div>
    </div>
</div>
</body>
</html>
 <jsp:include page="bottom.jsp"/>