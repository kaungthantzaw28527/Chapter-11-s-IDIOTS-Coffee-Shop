package dao;

import entity.Category;
import entity.MenuItem;
import util.DBUtil; // မင်းဆောက်ထားတဲ့ DBUtil ကို ချိတ်ဆက်လိုက်တာပါ

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO {

    // ==========================================
    // ၁။ CATEGORY OPERATIONS
    // ==========================================
    
    // Category အားလုံးကို ဆွဲထုတ်ပြီး List အနေနဲ့ ပြန်ပေးမယ့်ပတ်လမ်း (Dropdown တွေမှာ သုံးဖို့)
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories";
        
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(new Category(
                    rs.getInt("category_id"),
                    rs.getString("category_name")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ==========================================
    // ၂။ MENU ITEM OPERATIONS
    // ==========================================
    
    // Menu Item အားလုံးကို Database ထဲက ဆွဲထုတ်မယ်
    public List<MenuItem> getAllMenuItems() {
        List<MenuItem> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_items";
        
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                MenuItem item = new MenuItem();
                item.setId(rs.getInt("id"));
                item.setName(rs.getString("name"));
                item.setDescription(rs.getString("description"));
                item.setPrice(rs.getDouble("price"));
                item.setImageUrl(rs.getString("image_url"));
                item.setCategoryId(rs.getInt("category_id"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Item အသစ်ထည့်သွင်းမည့် နေရာ
    public boolean addMenuItem(MenuItem item) {
        String sql = "INSERT INTO menu_items (name, description, price, image_url, category_id) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, item.getName());
            ps.setString(2, item.getDescription());
            ps.setDouble(3, item.getPrice());
            ps.setString(4, item.getImageUrl());
            ps.setInt(5, item.getCategoryId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Item ရဲ့ အချက်အလက်တွေကို ပြန်ပြင်မည့် နေရာ
    public boolean updateMenuItem(MenuItem item) {
        // ပုံအသစ် ရွေးမထားရင် Database ထဲက Image Path ဟောင်းကို မထိခိုက်စေဖို့ စစ်တာပါ
        String sql;
        boolean hasNewImage = item.getImageUrl() != null && !item.getImageUrl().isEmpty();
        
        if (hasNewImage) {
            sql = "UPDATE menu_items SET name=?, description=?, price=?, image_url=?, category_id=? WHERE id=?";
        } else {
            sql = "UPDATE menu_items SET name=?, description=?, price=?, category_id=? WHERE id=?";
        }

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, item.getName());
            ps.setString(2, item.getDescription());
            ps.setDouble(3, item.getPrice());
            
            if (hasNewImage) {
                ps.setString(4, item.getImageUrl());
                ps.setInt(5, item.getCategoryId());
                ps.setInt(6, item.getId());
            } else {
                ps.setInt(4, item.getCategoryId());
                ps.setInt(5, item.getId());
            }
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Item တစ်ခုကို ဖျက်ပစ်မည့် နေရာ
    public boolean deleteMenuItem(int id) {
        String sql = "DELETE FROM menu_items WHERE id=?";
        
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}