package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.DashboardDAO;
import util.DBUtil;

@WebServlet("/admin-home") 
public class AdminMain_controller extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Database နဲ့ ချိတ်ပြီး Data ယူမယ်
        DashboardDAO dao = new DashboardDAO(DBUtil.getConnection());
        
//        int totalBooks = dao.getTotalBooks();
        int totalMenu = dao.getTotalMenu();
        
        // JSP ဆီကို Data ပို့မယ်
//        request.setAttribute("totalBooks", totalBooks);
        request.setAttribute("totalMenu", totalMenu);
        
        // Admin Page ကို တန်းပို့မယ်
        request.getRequestDispatcher("main.jsp").forward(request, response);
    }
}