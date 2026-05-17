package controller;

import dao.EventDAO;
import util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/adminRegisterEvent")
public class AdminEventRegistration_controller extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int requestedGuests = Integer.parseInt(request.getParameter("guests")); 
        String specialRequests = request.getParameter("requests");

        try (Connection conn = DBUtil.getConnection()) {
            EventDAO eventDao = new EventDAO(conn);
            
            // ၁။ လူပြည့်နေခြင်း ရှိ/မရှိ အရင်ဆုံး စစ်ဆေးခြင်း
            if (eventDao.isEventFull(eventId, requestedGuests)) {
                int availableSlots = eventDao.getAvailableSlots(eventId); // လက်ကျန် Slot တွက်ထုတ်ခြင်း
                
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Registration failed! Total requested guests exceeds the limit. Only " + availableSlots + " slots left.");
                
                response.sendRedirect(request.getContextPath() + "/admin-events");
                return; 
            }
            
            // ၂။ လူမပြည့်သေးပါက event_registrations table ထဲသို့ Insert သွင်းခြင်း
            String sql = "INSERT INTO event_registrations (event_id, full_name, email, phone, num_guests, special_requests) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, eventId);
                ps.setString(2, fullName);
                ps.setString(3, email);
                ps.setString(4, phone);
                ps.setInt(5, requestedGuests);
                ps.setString(6, specialRequests);
                
                int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    request.getSession().setAttribute("successMessage", "Registration completed successfully!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Something went wrong. Please try again.");
                }
            }
            
            response.sendRedirect(request.getContextPath() + "/admin-events");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-events?error=1");
        }
    }
}