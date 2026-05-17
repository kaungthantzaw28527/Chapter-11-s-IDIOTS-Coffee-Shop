package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.DashboardDAO;
import util.DBUtil;

@WebServlet("/home")
public class UserMain_controller extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Database နဲ့ ချိတ်ပြီး Stat Banner အတွက် Data ယူမယ်
        DashboardDAO dao = new DashboardDAO(DBUtil.getConnection());
        int totalBooks = dao.getTotalBooks();
        int totalMenu = dao.getTotalMenu();
        
        // JSP ဆီကို Data ပို့မယ်
        request.setAttribute("totalBooks", totalBooks);
        request.setAttribute("totalMenu", totalMenu);
        
        // အားလုံး အတူတူသုံးမယ့် main.jsp ဆီကို ပို့ပေးမယ်
        request.getRequestDispatcher("/main.jsp").forward(request, response);
    }
}