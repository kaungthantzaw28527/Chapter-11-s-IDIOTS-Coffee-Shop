package controller;

import dao.UserDAO; // 🎯 U အကြီးဖြင့် မှန်ကန်စွာ Import လုပ်ထားသည်
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updatePassword")
public class UpdatePassword_controller extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO(); // 🎯 'UserDAO' (U အကြီး) ဖြင့် ကွက်တိပြင်ဆင်ပြီး

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String email = (String) session.getAttribute("email");
        String currentPasswordInput = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String userRole = (String) session.getAttribute("userRole");

        String dbPassword = userDAO.getPasswordByEmail(email);

        if (dbPassword == null || !dbPassword.equals(currentPasswordInput)) {
            session.setAttribute("errorMessage", "လက်ရှိ အသုံးပြုနေသော Password (အဟောင်း) မှာ မှားယွင်းနေပါသည်။");
        } 
        else if (newPassword == null || newPassword.length() < 8) {
            session.setAttribute("errorMessage", "Password အသစ်သည် အနည်းဆုံး စာလုံး ၈ လုံး ရှိရပါမည်။");
        } 
        else if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("errorMessage", "Password အသစ်နှင့် အတည်ပြု Password တို့ ကိုက်ညီမှု မရှိပါ။");
        } 
        else {
            boolean success = userDAO.updatePassword(email, newPassword);
            if (success) {
                HttpSession newSession = request.getSession(true);
                newSession.setAttribute("successMessage", "Password ပြောင်းလဲခြင်း အောင်မြင်ပါသည်။ ကျေးဇူးပြု၍ Login ပြန်ဝင်ပေးပါ။");
                session.invalidate(); 
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            } else {
                session.setAttribute("errorMessage", "စနစ်ချို့ယွင်းမှုကြောင့် Password ပြောင်းလဲခြင်း မအောင်မြင်ပါ။");
            }
        }

        String redirectUrl = "ADMIN".equals(userRole) ? "/admin-settings" : "/user-settings";
        response.sendRedirect(request.getContextPath() + redirectUrl);
    }
}