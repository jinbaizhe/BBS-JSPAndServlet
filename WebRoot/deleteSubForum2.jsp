<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="data.jdbcBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Insert title here</title>
 <jsp:include page="head.jsp"/>
</head>
<body>
	<%	
		
		String mainForumid = request.getParameter("mainForumTitle").trim(); //得到主板块id
		byte bb[] = mainForumid.getBytes("iso-8859-1");
		mainForumid= new String (bb);
		List<String> list1=new ArrayList<String>();
		List<String> list2=new ArrayList<String>();  
		try{
		
			jdbcBean db = new jdbcBean();
			String sql = "select id,sub_forum_title from bbs.sub_forum where main_id=?";
			String []params={mainForumid};
			ResultSet rs = db.query(sql,params);
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
  <label for="name">请选择您要删除的子版块：</label>

	 <form action="deleteSubForumServlet" method="post">
	<select name="deleteSubForum">
	<%for(int i=0;i<list2.size();i++){%>  
  
					<option value="<%=list1.get(i)%>"><%=list2.get(i)%></option>  
  
				<%}%>  
	
	</select><br>
	<input type="submit" value="删除">
	</form>
	</div>
	</div>
	</div>
	</div>
	</div>
	</div>
	
</body>
</html>