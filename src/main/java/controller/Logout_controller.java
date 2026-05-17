package controller; // မင်းရဲ့ Package အမည်အတိုင်း ပြင်ပေးပါ

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout") // 🎯 URL လမ်းကြောင်းကို ကွက်တိ ဖမ်းထားတာပါ
public class Logout_controller extends HttpServlet {
    private static final long serialVersionUID = 102831973239L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // ၁။ လက်ရှိ ရှိနေတဲ့ Session ကို လှမ်းယူမယ်
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // ၂။ Session ထဲက ဒေတာတွေ (userRole အပါအဝင်) အကုန်လုံးကို ဖျက်ဆီးပစ်လိုက်မယ် (Clear လုပ်တာ)
            session.invalidate(); 
        }
        
        // ၃။ အကုန်လုံး ပျက်သွားပြီဆိုတော့ စစခြင်း Guest မြင်ရမယ့် Home Page သို့မဟုတ် Login Page ဆီ ပြန်မောင်းထုတ်မယ်
        response.sendRedirect(request.getContextPath() + "/home"); 
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}