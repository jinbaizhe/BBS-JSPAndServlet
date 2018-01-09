<%--
  Created by IntelliJ IDEA.
  User: Parker
  Date: 2017/12/22
  Time: 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gb2312" language="java" %>
<%@ include file="getForumInfo.jsp"%>
<%
    String post_title,post_content;
    post_title=request.getParameter("post_title");
    post_content=request.getParameter("post_centent");
    if (post_title==null)
        post_title="";
    if (post_content==null)
        post_content="";
    String sub_forum_id=request.getParameter("subforumid");
    String main_forum_id="",main_forum="",sub_forum="";
    if(sub_forum_id==null||sub_forum_id.equals(""))
        sub_forum_id="1";

    crs_sub.beforeFirst();
    while (crs_sub.next())
    {
        if(sub_forum_id.equals(crs_sub.getString("id")))
        {
            sub_forum=crs_sub.getString("sub_forum_title");
            main_forum=crs_sub.getString("main_id");
            break;
        }
    }

    crs_main.beforeFirst();
    while (crs_main.next())
    {
        if(main_forum_id.equals(main_forum_id))
        {
            main_forum=crs_main.getString("title");
            break;
        }
    }
%>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="ckeditor/ckeditor.js"></script>
    <link href="css/post-detail.css" rel="stylesheet">
    <link href="css/index.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container" style="margin-top: 50px" >
    <div class="row">
        <div class="col-md-1">
        </div>
        <div class="col-md-11">
            <form action="publishPostServlet"  method="post" enctype="multipart/form-data" >
                <ul class="list-group">
                    <li class="list-group-item" style="background-color: #F5F5F5">
                        <h3>发表帖子
                            <small><%=sub_forum%></small>
                        </h3>
                    </li>
                    <li class="list-group-item">
                        <h4><b>帖子标题</b></h4>
                        <input type="text" name="title" value="<%=post_title%>" class="form-control" placeholder="请输入标题">
                    </li>
                    <li class="list-group-item">
                        <h4><b>帖子内容</b></h4>
                        <textarea id="TextArea1" name="content" cols="20" rows="1" name="content" class="ckeditor" style="width: 2000px" ><%=post_content%></textarea>
                    </li>
                    <li class="list-group-item">
                        <h4>上传图片</h4>
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
                            <br><br>
                        </div>

                    </li>
                    <div style="float:right;margin: 20px auto">
                        <input type="hidden" name="sub_forumid" value=<%=sub_forum_id%>>
                        <input type="hidden" name="userid" value='1'>
                        <input type="submit" class="btn btn-primary" style="width: 60px;" value="发表">
                    </div>
                    <div style="float:right;margin: 20px auto;margin-right: 50px">
                        <a href='sub_forum.jsp?subid=<%=sub_forum_id%>'>
                            <button type="button" class="btn btn-primary">返回</button>
                        </a>
                    </div>
                </ul>
            </form>
        </div>
        <div class="col-md-1">
        </div>
    </div>
</div>
</body>
</html>
