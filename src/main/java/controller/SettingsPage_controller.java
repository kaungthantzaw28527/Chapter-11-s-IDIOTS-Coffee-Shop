package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/admin-settings", "/user-settings"})
public class SettingsPage_controller extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        
        HttpSession session = request.getSession(false);
        String servletPath = request.getServletPath();

        // ၁။ Login မဝင်ရသေးရင် မောင်းထုတ်မည်
        if (session == null || session.getAttribute("email") == null || session.getAttribute("userRole") == null) {
            session = request.getSession(true);
            session.setAttribute("errorMessage", "Please Login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");

        if ("/admin-settings".equals(servletPath) && !"ADMIN".equals(userRole)) {
            session.setAttribute("errorMessage", "Access Denied! သင်သည် Admin မဟုတ်သဖြင့် ဤကဏ္ဍသို့ ဝင်ခွင့်မရှိပါ။");
            response.sendRedirect(request.getContextPath() + "/user-settings");
            return;
        } 
        
        if ("/user-settings".equals(servletPath) && "ADMIN".equals(userRole)) {
            response.sendRedirect(request.getContextPath() + "/admin-settings");
            return;
        }

        // ၃။ အားလုံး ကိုက်ညီပါက ကာစတမ် ဖိုင်ဆီသို့ Forward လုပ်ပေးသည်
        request.getRequestDispatcher("/Account_setting.jsp").forward(request, response);
    }
}