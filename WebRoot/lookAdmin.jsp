<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="data.jdbcBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.sun.rowset.*" %>
 <jsp:include page="head.jsp"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Insert title here</title>

</head>
<body>
<%
	jdbcBean db = new jdbcBean();
	CachedRowSetImpl rowset=new CachedRowSetImpl() ;
	String sql = "select sub_forum_title,userid,forumid,username from bbs.admin inner join bbs.user on bbs.user.id=bbs.admin.userid left join bbs.sub_forum on bbs.sub_forum.id=bbs.admin.forumid";
 	try{
 		ResultSet rs = db.query(sql);
 		rowset.populate(rs);
 	}catch(Exception e){}
 	
 	%>
 	<div class="container" style="margin-top: 30px">
    <div class="row">
 <div class="col-xs-3">
            <ul class="nav nav-pills nav-stacked"> 
                <li role="presentation"> <a href="setAdmin.jsp">��ӹ���Ա</a></li>
                  <li role="presentation" class="active"><a href="lookAdmin.jsp">�鿴����Ա</a></li>
               
            </ul>
		</div>
 
 
 
		<div class="col-xs-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                       �鿴����Ա
                    </h3>
                </div>
                <div class="panel-body">
 	
 	
 	
 	


	<form action="deleteAdminServlet" method="post">
	<table  class="table table-striped">
	<thead>
		<tr>
			<td>����Ա����</td>
			<td>�������Ӱ��</td>
			<td>����</td>
		</tr>
		</thead>
		<tbody>  
		<% 
			while(rowset.next()){
				out.print("<tr><td>"+rowset.getString(4)+"</td>");
				out.print("<td>"+rowset.getString(1)+"</td>");		
				out.print("<td>"+"<input type='hidden' name='userid' value='"+rowset.getString(2)+"'>"+
				"<div style='float:left;width: 50%;padding: 1px; margin: 1px'><input type='submit' class='btn btn-primary' value='ɾ��'style='margin:auto;width: 100%;height: 40px;padding: 4px;'></input></div>"+"</td>"+"</tr>");
				
			}
		 %>
		 </tbody>
	</table>
	</form>
	</div>
	</div>
	</div>
	</div>
	</div>
	
</body>
</html>
<script> 
//ȡ���������Ĳ���error�Ƚ�
  var infoi ='<%=request.getParameter("info")%>';
  if(infoi=='success'){
   alert("ɾ���ɹ���");
  }
  else if(infoi=='fail'){
  	alert("ɾ��ʧ�ܣ�")
  }
  else {
  
  }
</script>