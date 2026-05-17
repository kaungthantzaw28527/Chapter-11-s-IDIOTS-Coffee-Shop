package controller;

import dao.MenuDAO;
import entity.Category;
import entity.MenuItem;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class UserMenu_controller extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // MenuDAO သုံးပြီး DB မှ Menu ဒေတာများ ဆွဲထုတ်ခြင်း
        MenuDAO dao = new MenuDAO();
        
        List<MenuItem> menuItems = dao.getAllMenuItems();
        List<Category> categories = dao.getAllCategories();
        
        // JSP ဆီသို့ Data များ ပို့ပေးခြင်း
        request.setAttribute("menuItems", menuItems);
        request.setAttribute("categories", categories);
        
        // အားလုံး အတူတူသုံးမည့် menu.jsp ဆီသို့ ပို့ပေးမည် (အရှေ့တွင် / ပါရမည်)
        request.getRequestDispatcher("/menu.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}