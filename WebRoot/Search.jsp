<%@ page language="java" contentType="text/html; charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sun.rowset.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="data.jdbcBean" %>
<jsp:include page="head.jsp"/>
<jsp:useBean id="pageBean" class="data.ByPageShowBean" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Insert title here</title>

  <link href="css/bootstrap.min.css" rel="stylesheet">
   <script src="js/jquery.min.js"></script>
   <script src="js/bootstrap.min.js"></script>
</head>   
<body> 
<div class="col-md-9">

            <ul class="list-group">
                <a class="list-group-item active">
                    帖子搜索
                </a>            




<%
		request.setCharacterEncoding("gb2312");
		String searchContent = request.getParameter("searchContent");
		//byte bb[] = searchContent.getBytes("iso-8859-1");
		//searchContent = new String(bb);
		//out.print(searchContent);	
		if(searchContent == null)
			searchContent ="";
		
%>
<%
	  List<String> list1=new ArrayList<String>();  
	  List<String> list2=new ArrayList<String>();  
	  String sql = "select id,sub_forum_title from sub_forum";
	  try{
	     jdbcBean db = new jdbcBean();
	  	 ResultSet rs0 = db.query(sql);
	  	 while(rs0.next()){
	  	 	list1.add(rs0.getString(1));//id
	  	 	list2.add(rs0.getString(2));//title
	  	 }
	  	 
	  }catch(Exception e){}
	  
	
 %>

 
 
<form role="form" action="searchServlet" method="post">
<div class="form-group">
<br>
<table>
	<tr>
		
		<td><label for="name">关键字:</label></td>
		<td><input type="text" class="form-group" name="search"  placeholder="文本输入" value="<%=searchContent%>"></td>
	</tr>
	<tr><td>	
		<label for="name">类型:</label></td>
	<div class="radio"> 
		<td><label><input name="type" type="radio" value="postTitle" />帖子标题</label> 
			<label><input name="type" type="radio" value="postContent" />主题帖内容</label> 
			<label><input name="type" type="radio" value="all" checked="checked" />全部</label> 
	</div>
		</td>
	</tr>
	<tr>
		<td><label for="name">板块:</label></td>
		<td><select name="subForum" class="form-control">
  				<%for(int i=0;i<list2.size();i++){%>  
  
					<option value="<%=list1.get(i)%>"><%=list2.get(i)%></option>  
  
				<%}%>  
				<option value="all"  selected = "selected" >所有板块</option>
			</select>
		</td>
	</tr>
	<tr>
		<td><label for="name">排序:</label></td>
		<td>
			<label><input name="sort" type="radio" value="send_time" checked="checked"/>按发帖时间</label> 
			<label><input name="sort" type="radio" value="reply_num" />按回帖数</label> 
		</td>
	</tr>
	<tr>
	</tr>
	<tr>
	 
		<td><button type="submit" class="btn btn-default">提交</button></td>
		 
	</tr>
	</table>
</div>
</form>
<hr width=1200	></hr> <br>
<jsp:setProperty name="pageBean" property="pageSize" param="pageSize"/>
<jsp:setProperty name="pageBean" property="currentPage" param="currentPage"/>

<%
	 CachedRowSetImpl rowSet=pageBean.getRowset();
      if(rowSet==null) {
         out.print("请提交搜索的内容！");
         return;  
      }%>
      <table>
 	<tr>
    <th width="300">主题</th>
    <th width="100">板块</th>
    <th width="100">回复/浏览</th>
    <th width="200">发帖时间</th>
  </tr>
      <% 
      rowSet.last(); 
      int totalRecord=rowSet.getRow();
      int pageSize=pageBean.getPageSize();  //每页显示的记录数
      int totalPages = pageBean.getTotalPages();
      if(totalRecord%pageSize==0)
           totalPages = totalRecord/pageSize;//总页数
      else
           totalPages = totalRecord/pageSize+1;
      pageBean.setPageSize(pageSize);
      pageBean.setTotalPages(totalPages);
      if(totalPages>=1) {
         if(pageBean.getCurrentPage()<1)
              pageBean.setCurrentPage(pageBean.getTotalPages());
         if(pageBean.getCurrentPage()>pageBean.getTotalPages())
              pageBean.setCurrentPage(1);
         int index=(pageBean.getCurrentPage()-1)*pageSize+1;
         rowSet.absolute(index);  //查询位置移动到currentPage页起始位置
         boolean boo=true;
         for(int i=1;i<=pageSize&&boo;i++) { 
            String title=rowSet.getString(4);
            String subForum=rowSet.getString(8);
            String reply=rowSet.getString(7);
            String view=rowSet.getString(6);
         	String sendTime=rowSet.getString(5); 
         	String reply_view =reply+"/"+view;
            out.print("<tr>");
            out.print("<td>"+"<a href='"+"post.jsp?postid="+rowSet.getString(9)+"'>"+title+"</a>"+"</td>");
            out.print("<td>"+"<a href='"+"sub_forum.jsp?subid="+rowSet.getString(2)+"'>"+subForum+"</a>"+"</td>");
            out.print("<td>"+reply_view+"</a>"+"</td>");
            out.print("<td>"+sendTime+"</td>");        
            out.print("</tr>");
            boo=rowSet.next();
         }
     }

 %>

</table>

 <BR>
 <BR>当前显示第<Font color=blue>
     <jsp:getProperty name="pageBean" property="currentPage"/>
   </Font>页,共有
   <Font color=blue><jsp:getProperty name="pageBean" property="totalPages"/>
   </Font>页。
 <ul class="pagination">
<table>
  <tr>
  		<li><td><FORM action="" method=post>
         <Input type=hidden name="currentPage" value=
         "<%=pageBean.getCurrentPage()-1 %>">
           <Input type=submit name="g" value="上一页"></FORM></td></li>
      <td><FORM action="" method=post>
          <Input type=hidden name="currentPage"
           value="<%=pageBean.getCurrentPage()+1 %>">
          <Input type=submit name="g" value="下一页"></FORM></td></tr>

</table>
</ul>
</ul>
</div>
</body>
</html>
