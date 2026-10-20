import java.sql.*;

public class App {
    public static void main(String[] args) throws Exception {
    
       Connection con=DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/college","root","Himanshu@123");
       System.out.println(con);
       System.out.println("Connection Created");

       PreparedStatement ps =con.prepareStatement( "insert into student values(?,?,?)" );
       ps.setInt(1,101);
       ps.setString(2,"Rahul");
       ps.setString(3,"CSE");
       ps.executeUpdate();
       System.out.println("Record Inserted");

       Statement st =con.createStatement();
       ResultSet rs =st.executeQuery( "select * from student" );

       while(rs.next()){
        int id = rs.getInt(1);      
        String name = rs.getString(2);  
        String dept = rs.getString(3);  
        System.out.println("ID: " + id + ", Name: " + name + ", Dept: " + dept);
       }

       con.close();

    }
}
