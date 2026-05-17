package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {
    "/admin-home", 
    "/admin-menu",
    "/admin-events", 
    "/AddMenuItem_controller",
    "/adminRegisterEvent",
    "/admin-registrations",
    "/DeleteMenuItem_controller",
    "/UpdateMenuItem_controller"
})
public class AdminAuthFilter_controller implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Filter စတင် run ချိန်တွင် အသုံးပြုရန်
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false); // Session အဟောင်းရှိမှ ဆွဲယူမည်

        boolean isAdmin = false;

        // Session ရှိပြီး ထို Session ထဲတွင် userRole က ADMIN ဖြစ်နေမှသာ ခွင့်ပြုမည်
        if (session != null) {
            String userRole = (String) session.getAttribute("userRole");
            if ("ADMIN".equals(userRole)) {
                isAdmin = true;
            }
        }

        if (isAdmin) {
            // တကယ် Admin ဖြစ်ပါက သွားလိုသော Admin Page များဆီသို့ ဆက်သွားခွင့်ပြုမည်
            chain.doFilter(request, response);
        } else {
            // 🚨 Admin မဟုတ်ဘဲ ခွဝင်ရန် ကြိုးစားပါက ရိုက်ထုတ်ပြီး Login.jsp သို့ ပို့မည်
            if (session == null) {
                session = httpRequest.getSession(true); // Session မရှိသေးပါက Error Message သယ်ရန် အသစ်ဆောက်သည်
            }
            session.setAttribute("errorMessage", "Access Denied! အုပ်ချုပ်သူ (Admin) သီးသန့် ကဏ္ဍဖြစ်သဖြင့် Login အရင်ဝင်ပေးပါ။");
            
            // Login.jsp သို့ လမ်းကြောင်းလွှဲပစ်ခြင်း
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // Filter ဖျက်သိမ်းချိန်တွင် လုပ်ဆောင်ရန်
    }
}