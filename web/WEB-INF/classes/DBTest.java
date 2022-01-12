package myPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class DBTest{
    public static void main(String[] args) throws SQLException {
        Connection conn = DBUtil.getMySQLConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        String query = "";

        //키워드 받아오기
        query = "select * from KEYWORD";
        pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();
        HashMap<String, String> keyword = new HashMap<String, String>();
        while(rs.next()) {
            keyword.put(rs.getString("Id"), rs.getString("Name"));
        }
        pstmt.close();

    }
}