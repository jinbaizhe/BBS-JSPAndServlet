<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="data.jdbcBean" %>
<%@ page import="java.sql.*" %>
 <jsp:include page="head.jsp"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Insert title here</title>

</head>
<body>

<%
	request.setCharacterEncoding("gb2312");
	List<String> list1=new ArrayList<String>();
	List<String> list2=new ArrayList<String>();   
	jdbcBean db = new jdbcBean();
    String sql = "select id,title from main_forum";
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
                <li role="presentation"><a href="addMainForum.jsp">��������</a></li>
                  <li role="presentation" class="active"><a href="addSubForum.jsp">����Ӱ��</a></li>
                  <li role="presentation"><a href="deleteMainForum.jsp">ɾ�������</a></li>
                  <li role="presentation"><a href="deleteSubForum.jsp">ɾ���Ӱ��</a></li>
                  <li role="presentation"><a href="changeMainForum.jsp">�޸������</a></li>
                  <li role="presentation"><a href="changeSubForum.jsp">�޸��Ӱ��</a></li>
               
            </ul>
		</div>
		<div class="col-xs-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                       ����Ӱ��
                    </h3>
                </div>
                <div class="panel-body">
				
		<form id="form1" action="addSubForumServlet" method="post" >

<div class="form-group">
	 <label for="name">��������죺</label>
	<select name="addSubForum_mainId">
		<%for(int i=0;i<list2.size();i++){%>  
  
					<option value="<%=list1.get(i)%>"><%=list2.get(i)%></option>  
  
				<%}%>  
	</select>
</div>	

<div class="form-group">
 <label for="name">�Ӱ�����ƣ�</label>
	<input type="text" name="addSubForum_subTitle">
	
</div> 

<div class="form-group">
 <label for="name">�Ӱ����Ϣ��</label><br>
	<textarea name="addSubForum_info" cols="70" rows="5"></textarea>
	
</div>
	
    <div style="float:left;width: 50%;padding: 10px;">
                <input type="submit" class="btn btn-primary" value="���"
                   style="margin:auto;width: 40%;height: 60px;padding: 6px;"></input>
            </div>
                     


</form>
</body>
</html>