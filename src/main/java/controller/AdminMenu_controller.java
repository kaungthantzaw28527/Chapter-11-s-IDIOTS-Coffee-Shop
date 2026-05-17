package controller;

import dao.MenuDAO;
import entity.Category;
import entity.MenuItem;

import java.io.IOException;
import java.util.List;
// javax နေရာမှာ jakarta သို့ ပြောင်းလဲလိုက်ပါပြီ
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin-menu")
public class AdminMenu_controller extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MenuDAO dao = new MenuDAO();
        
        List<MenuItem> menuItems = dao.getAllMenuItems();
        List<Category> categories = dao.getAllCategories();
        
        request.setAttribute("menuItems", menuItems);
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("/menu.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}