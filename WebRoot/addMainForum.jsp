<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
 <jsp:include page="head.jsp"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Insert title here</title>

</head>
<body>

<div class="container" style="margin-top: 30px">
    <div class="row">
 <div class="col-xs-3">
            <ul class="nav nav-pills nav-stacked"> 
                <li role="presentation" class="active" ><a href="addMainForum.jsp">��������</a></li>
                  <li role="presentation"><a href="addSubForum.jsp">����Ӱ��</a></li>
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
                       ��������
                    </h3>
                </div>
                <div class="panel-body">
				
				<form id="form1" action="addMainForumServlet" method="post" >


                    
                        <div class="form-group">
                            <label for="name">��������ƣ�</label>
                            <input id="username" type="text" class="form-control" name="addMainForum" id="name" width="200px" height="80px" placeholder="����������"> <p class="help-block"></p>
                        </div>

                       <div class="form-group">
                            <dt><label for="user_profile_blog">����飺</label></dt>
                            <dd><textarea name="addMainForum_info" cols="70" rows="5"></textarea>
                            <p class="help-block"></p>
                            </dd>
                        </div>

 
                      
                        
                        <input type="submit" value="�ύ"> 
                    </form>
                </div>
            </div>
             </div>
           </div>
        </div>		
		</div>
		</div>


 


</body>
</html>