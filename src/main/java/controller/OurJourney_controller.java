package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // 🎯 Session စစ်ဖို့ ဒါလေး လိုအပ်ပါတယ်

@WebServlet("/our-journey")
public class OurJourney_controller extends HttpServlet {
    private static final long serialVersionUID = 1L; // 🎯 Servlet တိုင်းမှာ ထည့်လေ့ရှိတဲ့ ID ပါ

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
    	//ဒီကောင်က Broswer cache ကိုဖျက်ခိုင်းတာ (Sign out လုပ်လိုက်တာဖြစ်ဖြစ်ကွာ Back Key နှိပ်ရင်တောင်သူက Page ကိုပြန်မတက်စေဖို့ပေါ့)
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies
        
        HttpSession session = request.getSession(false);
        
        request.getRequestDispatcher("/Our_Journey.jsp").forward(request, response);
    }
}