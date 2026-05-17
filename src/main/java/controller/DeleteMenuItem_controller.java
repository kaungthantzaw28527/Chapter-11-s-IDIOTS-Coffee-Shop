package controller; // မင်းရဲ့ လက်ရှိ package နာမည်အတိုင်း သေချာပြန်ပြင်ပေးပါဦး

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DBUtil; // ⚠️ မင်းရဲ့ DBUtil package လမ်းကြောင်းအတိုင်း ပြန်ပြင်ပေးပါဦး

@WebServlet("/DeleteMenuItem_controller")
public class DeleteMenuItem_controller extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        
        if (idStr != null && !idStr.isEmpty()) {
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement pt = conn.prepareStatement("DELETE FROM menu_items WHERE id = ?")) {
                
                pt.setInt(1, Integer.parseInt(idStr));
                pt.executeUpdate();
                System.out.println(">>> [SUCCESS] Item Deleted ID: " + idStr);
                
            } catch (Exception e) {
                System.out.println(">>> [ERROR] Database Delete Failed!");
                e.printStackTrace();
            }
        }
        
        // Delete ပြီးသွားရင် မူရင်း Admin Menu စာမျက်နှာဆီ ပြန်မောင်းနှင်မည်
        response.sendRedirect(request.getContextPath() + "/admin-menu");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}