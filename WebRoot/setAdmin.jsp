<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="data.jdbcBean" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Insert title here</title>
 <jsp:include page="head.jsp"/>
</head>
<body>

<%
	jdbcBean db = new jdbcBean();
	String sql  = "select id,sub_forum_title from bbs.sub_forum";
	List<String> list1=new ArrayList<String>();
	List<String> list2=new ArrayList<String>();   
	try{
		ResultSet rs = db.query(sql);
		while(rs.next()){
			list1.add(rs.getString(1)); //id
			list2.add(rs.getString(2)); //title
		
		}
		
	}catch(Exception e){}
	

 %>
 
 <div class="container" style="margin-top: 30px">
    <div class="row">
 <div class="col-xs-3">
            <ul class="nav nav-pills nav-stacked"> 
                <li role="presentation" class="active"> <a href="setAdmin.jsp">��ӹ���Ա</a></li>
                  <li role="presentation"><a href="lookAdmin.jsp">�鿴����Ա</a></li>
               
            </ul>
		</div>
 
 
 
		<div class="col-xs-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                       ��ӹ���Ա
                    </h3>
                </div>
                <div class="panel-body">
 	
 
 
<form action="setAdminServlet" method="post">
	<div class="form-group">
 	<label for="name">�û�����</label> 	
	<input type="text" name="username"><br>
	</div>
	<div class="form-group">
 	<label for="name">�������Ӱ�����ƣ�</label> 
	<select name="subForumTitle">
		<%for(int i=0;i<list2.size();i++){%>  
  
					<option value="<%=list1.get(i)%>"><%=list2.get(i)%></option>  
  
				<%}%>  
	</select>
	</div>
	<br>
	<input type="submit" value="���">
	
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
  var errori ='<%=request.getParameter("error")%>';
  if(errori=='empty'){
   alert("�û�������Ϊ�գ�");
  }
 else if(errori=='unexist'){
 	alert("�û��������ڣ�");
 }
 else if(errori=='exist')
 {
 	alert("�û��Ѿ��ǹ���Ա�ˣ������ظ����ã�");
 }
 else if(errori=='success')
 {
 	alert("���óɹ���");
 }
 else if(errori=='false'){
 	alert("����ʧ�ܣ�");
 }
  else {
  
  }
</script>