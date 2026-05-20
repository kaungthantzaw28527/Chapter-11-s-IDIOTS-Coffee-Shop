package controller; // မင်းရဲ့ လက်ရှိ package နာမည်အတိုင်း သေချာပြန်ပြင်ပေးပါဦး

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import util.DBUtil; // ⚠️ မင်းရဲ့ DBUtil ရှိတဲ့ package လမ်းကြောင်းအတိုင်း အမှန်ပြင်ပေးပါ (ဥပမာ- db.DBUtil စသဖြင့်)

@WebServlet("/AddMenuItem_controller")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class AddMenuItem_controller extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        try {
            // ၁။ Form ထဲက သာမန် Data များကို လက်ခံခြင်း
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String categoryIdStr = request.getParameter("category_id");
            String description = request.getParameter("description");
            
            Part filePart = request.getPart("image_file");
            String fileName = getFileName(filePart);
            
            String dbImagePath = "IMG/" + fileName;
            
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "IMG";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            
            File fileToSave = new File(uploadPath + File.separator + fileName);
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
            
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement pt = conn.prepareStatement("INSERT INTO menu_items (name, price, category_id, description, image_url) VALUES (?, ?, ?, ?, ?)")) {
                
                pt.setString(1, name);
                pt.setDouble(2, Double.parseDouble(priceStr));
                pt.setInt(3, Integer.parseInt(categoryIdStr));
                pt.setString(4, description);
                pt.setString(5, dbImagePath);
                
                pt.executeUpdate();
                System.out.println(">>> [SUCCESS] Item added via DBUtil: " + name);
            }
            
        } catch (Exception e) {
            System.out.println(">>> [ERROR] Database Insert Failed via DBUtil!");
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/admin-menu");
    }


    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                String fullPathName = token.substring(token.indexOf("=") + 2, token.length() - 1);
                return fullPathName.substring(fullPathName.lastIndexOf(File.separator) + 1)
                                   .substring(fullPathName.lastIndexOf("/") + 1);
            }
        }
        return null;
    }
}