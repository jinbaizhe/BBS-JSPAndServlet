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
 	userBean user = new userBean();
	user = (userBean)session.getAttribute("user");
	LoginBean login = new LoginBean();
	login = (LoginBean)session.getAttribute("loginBean");
	int userid = login.getId();//�û�id
	jdbcBean db = new jdbcBean();
 	String sql="select * from (select bbs.followpost.follow_time,bbs.sub_forum.sub_forum_title,bbs.followpost.post_id,bbs.followpost.content,bbs.followpost.followpost_user_id,bbs.post.post_title,bbs.post.sub_id from bbs.followpost left join bbs.post on followpost.post_id=post.id left join bbs.sub_forum on bbs.post.sub_id=bbs.sub_forum.id)as t where followpost_user_id=?";
 	String []params={String.valueOf(userid)};
 
  	CachedRowSetImpl rowset=new CachedRowSetImpl() ;

    try
    {
    	ResultSet rs = db.query(sql, params);    	
    	rowset.populate(rs);
    }catch(Exception e){}
 	
  %>
<div class="container" style="margin-top: 30px">
    <div class="row">
        <div class="col-xs-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation" ><a href="MyZone.jsp">�ҵ���Ϣ</a></li>
                  <li role="presentation"><a href="mySend.jsp">�ҵķ���</a></li>
                  <li role="presentation" class="active"><a href="myReply.jsp">�ҵĻ���</a></li>
                  <li role="presentation"><a href="myCollect.jsp">�ҵ��ղ�</a></li>
            </ul>
		</div>
	<div class="col-md-9">

            <ul class="list-group">
                <a class="list-group-item active">
                    �ҵĻ���
                </a>            
            <table class="table">   
            <tbody>
<% 
	String pageid=request.getParameter("pageid"); 
	if(rowset == null){
		out.print("û���κβ�ѯ��Ϣ���޷������");
		return;
	}
	rowset.last();
	int totalRecord = rowset.getRow();
    int pageSize = 2;
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
		String post_title = rowset.getString(6);
		String reply_content = rowset.getString(4);
		String sub_forum_title = rowset.getString(2);
		String follow_time = rowset.getString(1);
		out.print("<tr>");
		out.print("<td width=400>"+"Re:"+"<a href='"+"post.jsp?postid="+rowset.getString(3)+"'>"+post_title+"</a>"+"   ����"+
						"<a href='"+"sub_forum.jsp?subid="+rowset.getString(7)+"'>"+sub_forum_title+"</a>"+"   "+follow_time+"</td>");
		out.print("</tr>");
		out.print("<br>");
		out.print("<tr>");
		out.print("<td width=400>"+reply_content+"<td>");
		out.print("</tr>");
		out.print("<br>");
		boo = rowset.next();
	}
	}		
 %>
 
 </tbody>
 
 
</table>
<BR>��ǰ��ʾ��<Font color=blue>
    <%=currentPage %>
   </Font>ҳ,����
 <%=totalPages %>
   </Font>ҳ��
 <a href="myReply.jsp?pageid=1">��ҳ</a>
 <a href="myReply.jsp?pageid=<%=currentPage-1%>">��һҳ</a>
	<% 
  for(int j=1;j<=totalPages;j++)
  { 
    if(j==currentPage)
      out.print("[");
     %>
    <A href="myReply.jsp?pageid=<%=j %>"><%=j %></a>
    <%
    if(j==currentPage)
      out.print("]");
    out.print("  ");
  }
  /*-----------------------------------------------*/

%> 
   <a href="myReply.jsp?pageid=<%=currentPage+1%>">��һҳ</a>
 	<a href="myReply.jsp?pageid=<%=totalPages%>">ĩҳ</a>

 </ul>
            
   <ul class="pagination pagination-lg" style="float:right">
	
    
   
</ul>
    </div>
</div>

</div>



</body>
</html>