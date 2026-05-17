package entity;

import java.sql.Timestamp;

/**
 * EventRegistration Entity Class
 * Updated to include totalBooked for event-wide capacity validation.
 */
public class EventRegistration {
    // Database Table Fields
    private int regId;
    private int eventId;
    private String fullName;
    private String email;
    private String phone;
    private int numGuests;
    private String specialRequests;
    private Timestamp regDate;
    
    private String eventTitle;  // Event အမည်
    private int maxGuests;      // Event ၏ အများဆုံး လက်ခံနိုင်သော Limit
    private int totalBooked;    // အဆိုပါ Event တွင် လက်ရှိ Register လုပ်ထားပြီးသမျှ စုစုပေါင်းလူဦးရေ

    public EventRegistration() {}

    // --- Standard Getters and Setters ---

    public int getRegId() {
        return regId;
    }

    public void setRegId(int regId) {
        this.regId = regId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getNumGuests() {
        return numGuests;
    }

    public void setNumGuests(int numGuests) {
        this.numGuests = numGuests;
    }

    public String getSpecialRequests() {
        return specialRequests;
    }

    public void setSpecialRequests(String specialRequests) {
        this.specialRequests = specialRequests;
    }

    public Timestamp getRegDate() {
        return regDate;
    }

    public void setRegDate(Timestamp regDate) {
        this.regDate = regDate;
    }

    // --- Join & Logic Fields Getters and Setters ---

    public String getEventTitle() {
        return eventTitle;
    }

    public void setEventTitle(String eventTitle) {
        this.eventTitle = eventTitle;
    }

    public int getMaxGuests() {
        return maxGuests;
    }

    public void setMaxGuests(int maxGuests) {
        this.maxGuests = maxGuests;
    }

    public int getTotalBooked() {
        return totalBooked;
    }

    public void setTotalBooked(int totalBooked) {
        this.totalBooked = totalBooked;
    }
}