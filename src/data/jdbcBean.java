package data;
import java.sql.*;
public class jdbcBean {
	 private String DBDriver="com.mysql.jdbc.Driver";  
     private String DBUrl="jdbc:mysql://localhost:3306/bbs?characterEncoding=GB2312&useSSL=true";  
     private String DBUser="test";  
     private String DBPassword="123456";  
     public Connection conn=null;  
     public ResultSet rs=null;  
     public jdbcBean() throws ClassNotFoundException{
    	try{
    		 Class.forName(DBDriver);  
             conn=DriverManager.getConnection(DBUrl,DBUser,DBPassword);  
    		
    	}catch(SQLException e){
    		
    	}
     }
     public ResultSet query(String sql,String []params)throws Exception{  
         try{  
        	
             PreparedStatement  ps =conn.prepareStatement(sql);  
             for(int i=0;i<params.length;i++)
  			{
  				ps.setString(i+1, params[i]);
  			}
             rs=ps.executeQuery();
             return rs;  
         }  
         catch(SQLException e){  
             System.out.println(e.getMessage());  
         }  
        //close();
         return null;  
         
     }  
     public ResultSet query(String sql)throws Exception{
    	 try{
    		
             PreparedStatement  ps =conn.prepareStatement(sql);  
             rs = ps.executeQuery();
             return rs;
    	 }catch(Exception e){e.printStackTrace();}
    	 //close();
		return null;  
		
            
     }  
    
     public boolean update(String sql,String []params)throws Exception{  
    	 boolean b = true;
    	 try{ 
            
             PreparedStatement  ps =conn.prepareStatement(sql);  
             for(int i=0;i<params.length;i++)
  			{
  				ps.setString(i+1, params[i]);
  			}
             if(ps.executeUpdate()!=1){
            	 b=false;
             }
            
         }  
         catch(SQLException e){  
             System.out.println(e.getMessage());  
             b = false;
         }  
    	// close();
         return b; 
     }  
     public void close(){
    	 try {
			conn.close();
			rs.close();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
    	 
     }
}
