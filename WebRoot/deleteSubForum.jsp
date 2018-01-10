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
	
    String sql = "select id,title from main_forum";
	try{
		jdbcBean db = new jdbcBean();
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
                <li role="presentation"><a href="addMainForum.jsp">添加主板快</a></li>
                  <li role="presentation"><a href="addSubForum.jsp">添加子版块</a></li>
                  <li role="presentation" ><a href="deleteMainForum.jsp">删除主版块</a></li>
                  <li role="presentation" class="active" ><a href="deleteSubForum.jsp">删除子版块</a></li>
                  <li role="presentation"><a href="changeMainForum.jsp">修改主版块</a></li>
                  <li role="presentation"><a href="changeSubForum.jsp">修改子版块</a></li>
               
            </ul>
		</div>
 
<div class="col-xs-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                       删除子板块
                    </h3>
                </div>
                <div class="panel-body">
  <div class="form-group">
  <label for="name">请选择要删除的子版块所属主板快名称：</label>
  <form action="deleteSubForum2.jsp" method="post">
  	<select name="mainForumTitle">
  		<%for(int i=0;i<list2.size();i++){%>  
  	
					<option value="<%=list1.get(i)%>"><%=list2.get(i)%></option>  
  
				<%}%>  
  	</select><br>
  	<input type="submit" value="确定">
  </form>
  </div>
  </div>
  </div>
  </div>
  </div>
  </div>
  
</body>
</html>
<script> 
//取出传回来的参数error比较
  var infoi ='<%=request.getParameter("info")%>';
  if(infoi=='success'){
   alert("删除成功");
  }
  else if(infoi=='fail'){
  	alert("删除失败！")
  }
  else {
  
  }
</script>
