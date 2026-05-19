package dao;

import java.sql.*;

public class DashboardDAO {
    private Connection conn;

    public DashboardDAO(Connection conn) {
        this.conn = conn;
    }

//    // စာအုပ်အရေအတွက် စစ်ရန်
//    public int getTotalBooks() {
//        int count = 0;
//        try {
//            String sql = "SELECT COUNT(*) FROM library_books"; // သင့် Table name စစ်ပါ
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) count = rs.getInt(1);
//        } catch (Exception e) { e.printStackTrace(); }
//        return count;
//    }

    // Menu အရေအတွက် စစ်ရန်
    public int getTotalMenu() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM menu_items"; // သင့် Table name စစ်ပါ
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return count;
    }
}