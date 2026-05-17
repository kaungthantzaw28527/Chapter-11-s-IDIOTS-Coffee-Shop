package controller;

import dao.EventDAO;
import entity.Event;
import util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/event") // 🎯 User တွေ ဝင်ကြည့်မယ့် လမ်းကြောင်း
public class UserEvent_controller extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try (Connection conn = DBUtil.getConnection()) {
            EventDAO dao = new EventDAO(conn);
            List<Event> allEvents = dao.getAllEvents(); // ငါတို့ ပြင်ခဲ့တဲ့ LEFT JOIN နဲ့ မက်သတ်ကြီး
            
            // Stream သုံးပြီး Upcoming နဲ့ Past ခွဲထုတ်မယ်
            List<Event> upcoming = allEvents.stream().filter(e -> !e.isCompleted()).collect(Collectors.toList());
            List<Event> past = allEvents.stream().filter(e -> e.isCompleted()).collect(Collectors.toList());

            request.setAttribute("upcomingList", upcoming);
            request.setAttribute("pastList", past);
            
            // 🎯 User ကြည့်မယ့် View စာမျက်နှာဆီ ပို့မယ် (Admin panel ထဲ မဟုတ်ဘူးနော်)
            request.getRequestDispatcher("/event.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading events for users.");
        }
    }
}