package dao;

import entity.EventRegistration;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RegistrationDAO {
    private Connection conn;

    public RegistrationDAO(Connection conn) {
        this.conn = conn;
    }

    public List<EventRegistration> getAllRegistrations() {
        List<EventRegistration> list = new ArrayList<>();
        
        //total လေးကိုပါထည့်တွက်
        String sql = "SELECT r.*, e.title as event_title, e.max_guests, " +
                     "(SELECT SUM(num_guests) FROM event_registrations WHERE event_id = r.event_id) as total_booked " +
                     "FROM event_registrations r " +
                     "JOIN events e ON r.event_id = e.event_id " +
                     "ORDER BY r.reg_id DESC";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                EventRegistration reg = new EventRegistration();
                reg.setRegId(rs.getInt("reg_id"));
                reg.setEventId(rs.getInt("event_id"));
                reg.setFullName(rs.getString("full_name"));
                reg.setEmail(rs.getString("email"));
                reg.setPhone(rs.getString("phone"));
                reg.setNumGuests(rs.getInt("num_guests"));
                reg.setSpecialRequests(rs.getString("special_requests"));
                reg.setEventTitle(rs.getString("event_title")); 
                reg.setMaxGuests(rs.getInt("max_guests")); 
                reg.setTotalBooked(rs.getInt("total_booked")); 
                
                list.add(reg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateRegistration(EventRegistration reg) {
        String sql = "UPDATE event_registrations SET full_name=?, email=?, phone=?, num_guests=? WHERE reg_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reg.getFullName());
            ps.setString(2, reg.getEmail());
            ps.setString(3, reg.getPhone());
            ps.setInt(4, reg.getNumGuests());
            ps.setInt(5, reg.getRegId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteRegistration(int regId) {
        String sql = "DELETE FROM event_registrations WHERE reg_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, regId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
 // ပုံမှန် User တွေ စာရင်းသွင်းဖို့အတွက် သုံးမယ့် method
    public boolean addRegistration(EventRegistration reg) {
        String sql = "INSERT INTO event_registrations (event_id, full_name, email, phone, num_guests, special_requests) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reg.getEventId());
            ps.setString(2, reg.getFullName());
            ps.setString(3, reg.getEmail());
            ps.setString(4, reg.getPhone());
            ps.setInt(5, reg.getNumGuests());
            ps.setString(6, reg.getSpecialRequests());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}