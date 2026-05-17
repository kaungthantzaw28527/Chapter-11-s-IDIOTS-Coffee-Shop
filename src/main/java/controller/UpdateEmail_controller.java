package controller;

import dao.UserDAO; // 🎯 U အကြီးဖြင့် မှန်ကန်စွာ Import လုပ်ထားသည်
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateEmail")
public class UpdateEmail_controller extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO(); // 🎯 'UserDAO' (U အကြီး) ဖြင့် ကွက်တိပြင်ဆင်ပြီး

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String currentEmail = (String) session.getAttribute("email");
        String newEmail = request.getParameter("newEmail");
        String userRole = (String) session.getAttribute("userRole");

        if (newEmail != null && !newEmail.trim().isEmpty()) {
            boolean success = userDAO.updateEmail(currentEmail, newEmail);
            
            if (success) {
                HttpSession newSession = request.getSession(true);
                newSession.setAttribute("successMessage", "Email ပြောင်းလဲခြင်း အောင်မြင်ပါသည်။ ကျေးဇူးပြု၍ Login ပြန်ဝင်ပေးပါ။");
                session.invalidate(); 
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            } else {
                session.setAttribute("errorMessage", "Email ပြောင်းလဲခြင်း မအောင်မြင်ပါ။ ဤအီးမေးလ်ရှိပြီးသား ဖြစ်နိုင်ပါသည်။");
            }
        } else {
            session.setAttribute("errorMessage", "Email အသစ်ကို သေချာ ထည့်သွင်းပေးပါ။");
        }

        String redirectUrl = "ADMIN".equals(userRole) ? "/admin-settings" : "/user-settings";
        response.sendRedirect(request.getContextPath() + redirectUrl); 
    }
}