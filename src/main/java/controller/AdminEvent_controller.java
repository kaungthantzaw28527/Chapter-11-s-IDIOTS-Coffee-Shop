package controller;

import dao.EventDAO;
import entity.Event;
import util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/admin-events")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminEvent_controller extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try (Connection conn = DBUtil.getConnection()) {
            EventDAO dao = new EventDAO(conn);
            List<Event> allEvents = dao.getAllEvents();
            
            List<Event> upcoming = allEvents.stream().filter(e -> !e.isCompleted()).collect(Collectors.toList());
            List<Event> past = allEvents.stream().filter(e -> e.isCompleted()).collect(Collectors.toList());

            request.setAttribute("upcomingList", upcoming);
            request.setAttribute("pastList", past);
            request.getRequestDispatcher("/event.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        try (Connection conn = DBUtil.getConnection()) {
            EventDAO dao = new EventDAO(conn);

            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("eventId"));
                dao.deleteEvent(id);
            } 
            else if ("add".equals(action)) {
                String title = request.getParameter("title");
                String location = request.getParameter("location");
                int maxGuests = Integer.parseInt(request.getParameter("maxGuests"));
                String description = request.getParameter("description");
                LocalDateTime eventDate = LocalDateTime.parse(request.getParameter("eventDate"));
                
                Part filePart = request.getPart("eventImage");
                String fileName = filePart.getSubmittedFileName();
                String imageDbPath = "/IMG/default-event.jpg";

                if (fileName != null && !fileName.isEmpty()) {
                    String uploadPath = getServletContext().getRealPath("") + "IMG";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();
                    filePart.write(uploadPath + File.separator + fileName);
                    imageDbPath = "/IMG/" + fileName;
                }

                Event e = new Event();
                e.setTitle(title);
                e.setLocation(location);
                e.setMaxGuests(maxGuests);
                e.setDescription(description);
                e.setEventDate(eventDate);
                e.setImagePath(imageDbPath);
                e.setCompleted(false);

                dao.addEvent(e);
            }
            else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("eventId"));
                String title = request.getParameter("title");
                String location = request.getParameter("location");
                int maxGuests = Integer.parseInt(request.getParameter("maxGuests"));
                String description = request.getParameter("description");
                LocalDateTime eventDate = LocalDateTime.parse(request.getParameter("eventDate"));
                boolean isCompleted = request.getParameter("isCompleted") != null;

                // Image Upload Handling
                Part filePart = request.getPart("eventImage");
                String fileName = (filePart != null) ? filePart.getSubmittedFileName() : null;
                String imageDbPath = null;

                if (fileName != null && !fileName.isEmpty()) {
                    String uploadPath = getServletContext().getRealPath("") + "IMG";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();
                    filePart.write(uploadPath + File.separator + fileName);
                    imageDbPath = "/IMG/" + fileName;
                }

                Event e = new Event();
                e.setEventId(id);
                e.setTitle(title);
                e.setLocation(location);
                e.setMaxGuests(maxGuests);
                e.setDescription(description);
                e.setEventDate(eventDate);
                e.setCompleted(isCompleted);
                e.setImagePath(imageDbPath);

                dao.updateEvent(e);
            }

            response.sendRedirect(request.getContextPath() + "/admin-events");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-events?error=1");
        }
    }
}