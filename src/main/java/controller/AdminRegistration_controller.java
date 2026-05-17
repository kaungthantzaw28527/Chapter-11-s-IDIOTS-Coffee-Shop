package controller;

import dao.RegistrationDAO;
import entity.EventRegistration;
import util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin-registrations")
public class AdminRegistration_controller extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try (Connection conn = DBUtil.getConnection()) {
            RegistrationDAO dao = new RegistrationDAO(conn);
            
            List<EventRegistration> list = dao.getAllRegistrations();
            
            request.setAttribute("registrationList", list);
            
            request.getRequestDispatcher("Admin_Registrations.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try (Connection conn = DBUtil.getConnection()) {
            RegistrationDAO dao = new RegistrationDAO(conn);

            if ("update".equals(action)) {
                // Update Logic
                EventRegistration reg = new EventRegistration();
                reg.setRegId(Integer.parseInt(request.getParameter("regId")));
                reg.setFullName(request.getParameter("fullName"));
                reg.setEmail(request.getParameter("email"));
                reg.setPhone(request.getParameter("phone"));
                reg.setNumGuests(Integer.parseInt(request.getParameter("numGuests")));
                
                dao.updateRegistration(reg);
                
            } else if ("delete".equals(action)) {
                // Delete Logic
                int regId = Integer.parseInt(request.getParameter("regId"));
                dao.deleteRegistration(regId);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin-registrations");
    }
}