package data;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Validate {
    Context initCtx;
    DataSource ds;
    Connection connection;
    public Validate()
    {
        try
        {
            initCtx = new InitialContext();
            ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/db");
            connection = ds.getConnection();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
    public void close()
    {
        try{
            connection.close();
        }catch (Exception e)
        {
            e.printStackTrace();
        }

    }

    public boolean isAdmin(LoginBean user,String subid)
    {
        boolean isValid=false;
        try
        {
            PreparedStatement statement = connection.prepareStatement("select * from admin where userid=? and forumid=?");
            statement.setString(1, user.getId()+"");
            statement.setString(2, subid);
            ResultSet rs = statement.executeQuery();
            if(rs.next()||(user.getType().equals("1")))
            {
                isValid=true;
            }
            rs.close();
            statement.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return isValid;
    }

    public boolean hasDeletePostPermission(LoginBean user,String postid)
    {
        boolean isValid=false;
        try
        {
            PreparedStatement statement = connection.prepareStatement("select * from post where id=?");
            statement.setString(1, postid);
            ResultSet rs = statement.executeQuery();
            if(rs.next())
            {
                String postAuthorID=rs.getString("user_id");
                String subid= rs.getString("sub_id");
                if(postAuthorID.equals(user.getId()+"")||isAdmin(user, subid))
                    isValid=true;
            }
            rs.close();
            statement.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return isValid;
    }

    public boolean hasUpdatePostPermission(String userid,String postid)
    {
        boolean isValid=false;
        try
        {
            PreparedStatement statement = connection.prepareStatement("select * from post where id=?");
            statement.setString(1, postid);
            ResultSet rs = statement.executeQuery();
            if(rs.next())
            {
                String postAuthorID=rs.getString("user_id");
                if(postAuthorID.equals(userid))
                    isValid=true;
            }
            rs.close();
            statement.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return isValid;
    }

    public boolean hasDeleteFollowpostPermission(LoginBean user,String followpostid)
    {
        boolean isValid=false;
        try
        {
            PreparedStatement statement = connection.prepareStatement("select post.user_id as postAuthor,followpost.followpost_user_id as followpostAuthor,post.sub_id as sub_id from followpost,post where followpost.post_id=post.id and followpost.followpost_id=?");
            statement.setString(1, followpostid);
            ResultSet rs = statement.executeQuery();
            if(rs.next())
            {
                String postAuthorID=rs.getString("postAuthor");
                String followpostAuthorID=rs.getString("followpostAuthor");
                String subid=rs.getString("sub_id");
                if(postAuthorID.equals(user.getId())||followpostAuthorID.equals(user.getId())||isAdmin(user,subid))
                    isValid=true;
            }
            rs.close();
            statement.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return isValid;
    }

    public boolean hasUpdateFollowpostPermission(String userid,String followpostid)
    {
        boolean isValid=false;
        try
        {
            PreparedStatement statement = connection.prepareStatement("select * from followpost where followpost_id=?");
            statement.setString(1, followpostid);
            ResultSet rs = statement.executeQuery();
            if(rs.next())
            {
                String followpostAuthorID=rs.getString("followpost_user_id");
                if(followpostAuthorID.equals(userid))
                    isValid=true;
            }
            rs.close();
            statement.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return isValid;
    }
}
