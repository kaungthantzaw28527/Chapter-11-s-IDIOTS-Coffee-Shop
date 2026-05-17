package controller;

import dao.EventDAO; 
import dao.RegistrationDAO;
import entity.EventRegistration;
import util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/registerEvent") 
public class Reg_controller extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        // 🎯 ပြင်ဆင်ချက် - Context Path မပါဘဲ လမ်းကြောင်းသက်သက်ကိုပဲ အရင်သတ်မှတ်မယ်
        String redirectPath = "/event"; 
        if ("ADMIN".equals(userRole)) {
            redirectPath = "/admin-events"; 
        }
        
        try (Connection conn = DBUtil.getConnection()) {
            // ၁။ Form က ဒေတာတွေကို ဖမ်းယူမယ်
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            int guests = Integer.parseInt(request.getParameter("guests"));
            String requests = request.getParameter("requests");

            // ၂။ Capacity Guard Logic: စာရင်းမသွင်းခင် လူပြည့်/မပြည့် အရင်စစ်ဆေးမယ်
            EventDAO eventDao = new EventDAO(conn);
            if (eventDao.isEventFull(eventId, guests)) {
                int availableSlots = eventDao.getAvailableSlots(eventId);
                
                session.setAttribute("errorMessage", "တောင်းဆိုထားသော လူဦးရေသည် သတ်မှတ်ချက်ထက် ကျော်လွန်နေပါသည်။ လက်ရှိတွင် " + availableSlots + " ခုံသာ လွတ်ပါတော့သည်။");
                
                // 🎯 ပြင်ဆင်ချက် - forward မသုံးတော့ဘဲ sendRedirect သို့ လုံးဝပြောင်းလဲခြင်း
                response.sendRedirect(request.getContextPath() + redirectPath);
                return; 
            }

            // ၃။ လူမပြည့်သေးရင် Entity ထဲ ဒေတာထည့်မယ်
            EventRegistration reg = new EventRegistration();
            reg.setEventId(eventId);
            reg.setFullName(fullName);
            reg.setEmail(email);
            reg.setPhone(phone);
            reg.setNumGuests(guests);
            reg.setSpecialRequests(requests);

            // ၄။ RegistrationDAO သုံးပြီး DB ထဲ သိမ်းမယ်
            RegistrationDAO dao = new RegistrationDAO(conn);
            boolean success = dao.addRegistration(reg);

            if (success) {
                session.setAttribute("successMessage", "Event စာရင်းသွင်းခြင်း အောင်မြင်ပါသည်!");
            } else {
                session.setAttribute("errorMessage", "Database ထဲသို့ စာရင်းသွင်းရာတွင် အမှားအယွင်းရှိခဲ့ပါသည်။");
            }
            
            // 🎯 ပြင်ဆင်ချက် - အောင်မြင်သွားရင်လည်း POST method ကြီး ဆက်မပါသွားအောင် သန့်သန့်ရှင်းရှင်း Redirect လွှတ်ပစ်မယ်
            response.sendRedirect(request.getContextPath() + redirectPath);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "System Error တစ်ခုခု တက်သွားပါသည်။");
            response.sendRedirect(request.getContextPath() + redirectPath);
        }
    }
}