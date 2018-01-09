<%--
  Created by IntelliJ IDEA.
  User: Parker
  Date: 2017/12/22
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*,javax.sql.*" %>
<%@ page import="com.sun.rowset.CachedRowSetImpl" %>
<jsp:useBean id="forum_info" class="data.allForum" scope="session"></jsp:useBean>
<%
    if(forum_info.getRs_mainForum()==null||forum_info.getRs_sub_forum()==null)
    {
        Context initCtx = new InitialContext();
        DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/db");
        Connection connection = ds.getConnection();
        PreparedStatement statement = connection.prepareStatement("select * from main_forum");
        ResultSet rs = statement.executeQuery();
        CachedRowSetImpl crs = new CachedRowSetImpl();
        crs.populate(rs);
        forum_info.setRs_mainForum(crs);
        rs.close();
        statement.close();
        statement = connection.prepareStatement("select * from sub_forum");
        rs = statement.executeQuery();
        crs = new CachedRowSetImpl();
        crs.populate(rs);
        forum_info.setRs_sub_forum(crs);
        rs.close();
        statement.close();
        connection.close();
    }
    CachedRowSetImpl crs_main =forum_info.getRs_mainForum();
    crs_main.beforeFirst();
    CachedRowSetImpl crs_sub =forum_info.getRs_sub_forum();
    crs_sub.beforeFirst();
%>
