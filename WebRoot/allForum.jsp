<%--
  Created by IntelliJ IDEA.
  User: Parker
  Date: 2017/12/23
  Time: 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gb2312" language="java" %>
 <jsp:include page="head.jsp"/>
<%@include file="getForumInfo.jsp"%>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/allForum.css">
</head>

<body>
<div class="container">
    <div class="row">

<%
    String specificid=request.getParameter("mainforumid");
    if(specificid==null)
    {
%> 
 
    <!--     <h1>全部版块1</h1> -->
    <img src="image/allForum.png" class="img-responsive"  width="608"  height="472"> 
        
    </div>
    <%
    }
    else
    {
    %>
        <div class="container">  
    <div class="row">
<img src="image/subForum.png" class="img-responsive"  width="607"  height="472"> 
</div>

    </div>
    <%

    }
    if(specificid==null||specificid.equals(""))
        specificid="0";
    crs_main.beforeFirst();
    String mainForum_id,mainForum_title,subForum_id,subForum_title,subForum_info,subForum_main_id;
    while (crs_main.next())
    {
        mainForum_id=crs_main.getString("id");
        mainForum_title=crs_main.getString("title");

        if((!specificid.equals("0"))&&(!specificid.equals(mainForum_id)))
            continue;
%>
    <div class="row">
        <div class="col-md-12">
            <ul class="list-group">
                <div class="row">
                    <div class="list-group-item active">
                        <%=mainForum_title%>
                        <a href="allForum.jsp?mainforumid=<%=mainForum_id%>" style="float: right;color: white">更多>></a>
                    </div>
                </div>
                <div class="row">
    <%
        crs_sub.beforeFirst();
        while (crs_sub.next())
        {
            subForum_id=crs_sub.getString("id");
            subForum_title=crs_sub.getString("sub_forum_title");
            subForum_info=crs_sub.getString("info");
            subForum_main_id=crs_sub.getString("main_id");
            if (subForum_info.length()>40)
                subForum_info=subForum_info.substring(0,40)+"...";
            if(subForum_main_id.equals(mainForum_id))
            {
%>
                    <a href="sub_forum.jsp?subid=<%=subForum_id%>" class="list-group-item">
                        <div>
                            <img  alt=""  align="left" class="img-responsive" src="avatar/default.jpg"
                                  style="margin:1px 1px;width: 40px;height: 40px;margin-right: 20px"/>
                            <div class="list-group-item-heading">
                                <div style="font-size: 18px;">
                                    <%=subForum_title%>
                                    <div class="text-right" style="float: right;margin-right: 20px;font-size: 14px">主题：1232</div>
                                </div>
                            </div>
                            <%=subForum_info%>
                            <p class="text-right" style="float: right;margin-right: 20px">版主：</p>
                        </div>
                    </a>
<%
            }
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
</body>
</html>
 <jsp:include page="bottom.jsp"/>