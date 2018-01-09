<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="data.userBean" %>
<%@ page import="data.LoginBean" %>
<%@ page import="data.jdbcBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.sun.rowset.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Insert title here</title>
<jsp:include page="head.jsp"/>
</head>
<body>
<% 
	

	int userid = 2;//待定

	
	//得到 主题名，板块名，浏览数，回复数，发帖时间
	String sql ="select *  from (select bbs.favourite.userid,bbs.favourite.postid,bbs.post.post_title,bbs.post.reply_num,bbs.post.view_num,bbs.post.send_time,bbs.post.sub_id,bbs.sub_forum.sub_forum_title from bbs.favourite left join bbs.post on bbs.favourite.postid = bbs.post.id left join bbs.sub_forum on bbs.post.sub_id=bbs.sub_forum.id)as t where userid=?";
	String []params ={String.valueOf(userid)};
  	CachedRowSetImpl rowset=new CachedRowSetImpl() ;
    try
    {
    	jdbcBean db = new jdbcBean();
    	ResultSet rs = db.query(sql, params);
    	rowset.populate(rs);
    }catch(Exception e){}
    
	
%>

<div class="container" style="margin-top: 30px">
    <div class="row">
        <div class="col-xs-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="othersZone.jsp">我的信息</a></li>
                  <li role="presentation"><a href="othersSend.jsp">我的发帖</a></li>
                  <li role="presentation"><a href="othersReply.jsp">我的回帖</a></li>
                  <li role="presentation" class="active"><a href="othersCollect.jsp">我的收藏</a></li>
            </ul>
		</div>
	<div class="col-md-9">

            <ul class="list-group">
                <a class="list-group-item active">
                    我的回帖
                </a>        
<table class="table">

<thead>
<tr>

	<th width=400>主题</th>
	<th width=150>板块</th>
	<th width=100>回复/浏览</th>
	<th width=100>发帖时间</th>
</tr>
</thead>
<tbody>
<%
	String pageid=request.getParameter("pageid"); 
	if(rowset == null){
		out.print("没有任何查询消息，无法浏览！");
		return;
	}
	rowset.last();
	int totalRecord = rowset.getRow();
    int pageSize = 5;
    int totalPages = 1;
    int currentPage = 1;
    if(totalRecord%pageSize == 0){
    	totalPages = totalRecord/pageSize;
    }
	else
		totalPages = totalRecord/pageSize +1;
		
	if(totalPages >= 1)	{
		if(request.getParameter("pageid")==null||pageid.equals(""))
     		pageid="1";
		currentPage=Integer.parseInt(pageid);
		if(currentPage<1)
			currentPage = totalPages;
		if(currentPage > totalPages)
			currentPage = 1;
	int index =( currentPage -1 )*pageSize+1;
	rowset.absolute(index);
	boolean boo = true;
	for(int i = 0 ;i<pageSize && boo ; i++){
		String title = rowset.getString(3);
		String sub_forum = rowset.getString(8);
		String reply = rowset.getString(4);
		String view = rowset.getString(5);
		String send_time = rowset.getString(6);
		String postid = rowset.getString(2);
		String view_reply = view+"/"+reply;
		out.print("<tr>");
		
		out.print("<td>"+"<a href='"+"post.jsp?postid="+rowset.getString(2)+"'>"+title+"</a>"+"</td>");
		out.print("<td>"+"<a href='"+"sub_forum.jsp?subid="+rowset.getString(7)+"'>"+sub_forum+"</a>"+"</td>");
		out.print("<td>"+view_reply+"</td>");
		out.print("<td>"+send_time+"</td>");
		out.print("</tr>");
		boo = rowset.next();
	}
	}		
 %>
</tbody>
</table>




 <BR>当前显示第<Font color=blue>
    <%=currentPage %>
   </Font>页,共有
 <%=totalPages %>
   </Font>页。
 <a href="othersCollect.jsp?pageid=1">首页</a>
 <a href="othersCollect.jsp?pageid=<%=currentPage-1%>">上一页</a>
	<% 
  for(int j=1;j<=totalPages;j++)
  { 
    if(j==currentPage)
      out.print("[");
     %>
    <A href="othersCollect.jsp?pageid=<%=j %>"><%=j %></a>
    <%
    if(j==currentPage)
      out.print("]");
    out.print("  ");
  }
  /*-----------------------------------------------*/

%> 
   <a href="othersCollect.jsp?pageid=<%=currentPage+1%>">下一页</a>
 	<a href="othersCollect.jsp?pageid=<%=totalPages%>">末页</a>

</ul>
            
   <ul class="pagination pagination-lg" style="float:right">
	
    
   
</ul>
    </div>
</div>

</div>

</body>
</html>
