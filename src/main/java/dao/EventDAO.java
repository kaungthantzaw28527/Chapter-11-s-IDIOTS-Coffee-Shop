package dao;

import entity.Event;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {
    private Connection conn;

    public EventDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Event> getAllEvents() throws SQLException {
        List<Event> events = new ArrayList<>();
        
        // 🎯 LEFT JOIN နှင့် GROUP BY ကို သုံးပြီး လက်ရှိ စာရင်းပေးထားသော လူဦးရေ (current_guests) ကို တစ်ပါတည်း တွက်ထုတ်ယူခြင်း
        String sql = "SELECT e.*, COALESCE(SUM(er.num_guests), 0) AS current_guests " +
                     "FROM events e " +
                     "LEFT JOIN event_registrations er ON e.event_id = er.event_id " +
                     "GROUP BY e.event_id " +
                     "ORDER BY e.event_date DESC";
                     
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("event_id"));
                e.setTitle(rs.getString("title"));
                e.setDescription(rs.getString("description"));
                
                Timestamp ts = rs.getTimestamp("event_date");
                if (ts != null) e.setEventDate(ts.toLocalDateTime());
                
                e.setLocation(rs.getString("location"));
                e.setMaxGuests(rs.getInt("max_guests"));
                e.setImagePath(rs.getString("image_path"));
                e.setCompleted(rs.getBoolean("is_completed"));
                
                // 🎯 တွက်ထုတ်လိုက်သော စုစုပေါင်းလူဦးရေကို Entity ရဲ့ currentGuests ထဲ ထည့်သွင်းခြင်း (JSP အတွက် အသက်ပဲဗျ)
                e.setCurrentGuests(rs.getInt("current_guests"));
                
                events.add(e);
            }
        }
        return events;
    }

    public boolean updateEvent(Event e) throws SQLException {
        String sql;
        boolean hasNewImage = (e.getImagePath() != null && !e.getImagePath().isEmpty());
        
        if (hasNewImage) {
            sql = "UPDATE events SET title=?, description=?, event_date=?, location=?, max_guests=?, is_completed=?, image_path=? WHERE event_id=?";
        } else {
            sql = "UPDATE events SET title=?, description=?, event_date=?, location=?, max_guests=?, is_completed=? WHERE event_id=?";
        }

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, e.getTitle());
            ps.setString(2, e.getDescription());
            ps.setTimestamp(3, Timestamp.valueOf(e.getEventDate()));
            ps.setString(4, e.getLocation());
            ps.setInt(5, e.getMaxGuests());
            ps.setBoolean(6, e.isCompleted());
            
            if (hasNewImage) {
                ps.setString(7, e.getImagePath());
                ps.setInt(8, e.getEventId());
            } else {
                ps.setInt(7, e.getEventId());
            }
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteEvent(int eventId) throws SQLException {
        String sql = "DELETE FROM events WHERE event_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean addEvent(Event e) throws SQLException {
        String sql = "INSERT INTO events (title, description, event_date, location, max_guests, image_path, is_completed) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, e.getTitle());
            ps.setString(2, e.getDescription());
            ps.setTimestamp(3, Timestamp.valueOf(e.getEventDate()));
            ps.setString(4, e.getLocation());
            ps.setInt(5, e.getMaxGuests());
            ps.setString(6, e.getImagePath());
            ps.setBoolean(7, e.isCompleted());
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * COALESCE ထည့်သွင်းပြီး NULL ပြဿနာကို ဖြေရှင်းထားသော လူပြည့်/မပြည့် စစ်ဆေးသည့် Method
     */
    public boolean isEventFull(int eventId, int requestedGuests) throws SQLException {
        int totalBooked = 0;
        int maxGuests = 0;
        
        String checkBookedSql = "SELECT COALESCE(SUM(num_guests), 0) FROM event_registrations WHERE event_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(checkBookedSql)) {
            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalBooked = rs.getInt(1); 
                }
            }
        }
        
        String checkMaxSql = "SELECT max_guests FROM events WHERE event_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(checkMaxSql)) {
            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    maxGuests = rs.getInt("max_guests");
                }
            }
        }
        
        return (totalBooked + requestedGuests) > maxGuests;
    }

    /**
     * ကျန်ရှိသော လက်ကျန် Slot ဦးရေကို တွက်ချက်ပေးရန် Method
     */
    public int getAvailableSlots(int eventId) throws SQLException {
        int totalBooked = 0;
        int maxGuests = 0;

        String checkBookedSql = "SELECT COALESCE(SUM(num_guests), 0) FROM event_registrations WHERE event_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(checkBookedSql)) {
            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) totalBooked = rs.getInt(1);
            }
        }

        String checkMaxSql = "SELECT max_guests FROM events WHERE event_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(checkMaxSql)) {
            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) maxGuests = rs.getInt("max_guests");
            }
        }

        return maxGuests - totalBooked;
    }
}