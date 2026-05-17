package entity;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class Event {
    private int eventId;
    private String title;
    private String description;
    private LocalDateTime eventDate;
    private String location;
    private int maxGuests;
    private String imagePath;
    private boolean isCompleted;
    private Timestamp createdAt;

    public Event() {}

    // Getters and Setters
    public int getEventId() { return eventId; }
    public void setEventId(int eventId) { this.eventId = eventId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public LocalDateTime getEventDate() { return eventDate; }
    public void setEventDate(LocalDateTime eventDate) { this.eventDate = eventDate; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public int getMaxGuests() { return maxGuests; }
    public void setMaxGuests(int maxGuests) { this.maxGuests = maxGuests; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public boolean isCompleted() { return isCompleted; }
    public void setCompleted(boolean isCompleted) { this.isCompleted = isCompleted; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    private int currentGuests; 

    public int getCurrentGuests() { 
        return currentGuests; 
    }

    public void setCurrentGuests(int currentGuests) { 
        this.currentGuests = currentGuests; 
    }
}