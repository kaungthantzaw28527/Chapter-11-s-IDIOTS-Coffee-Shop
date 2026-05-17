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
import util.DBUtil; // ⚠️ မင်းရဲ့ DBUtil package လမ်းကြောင်းအတိုင်း ပြန်ပြင်ပေးပါဦး

@WebServlet("/UpdateMenuItem_controller")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class UpdateMenuItem_controller extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        try {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String categoryIdStr = request.getParameter("category_id");
            String description = request.getParameter("description");
            
            // ပုံဖိုင်အသစ် ပါမပါ စစ်ဆေးခြင်း
            Part filePart = request.getPart("image_file");
            String fileName = getFileName(filePart);
            
            Connection conn = DBUtil.getConnection();
            PreparedStatement pt = null;
            
            if (fileName != null && !fileName.isEmpty()) {
                // က) အသုံးပြုသူက ပုံအသစ် ရွေးချယ်လိုက်သည့်အခြေအနေ (ပုံအသစ်ကို IMG ထဲသိမ်းပြီး DB ပါ Update လုပ်မည်)
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
                
                String sql = "UPDATE menu_items SET name=?, price=?, category_id=?, description=?, image_url=? WHERE id=?";
                pt = conn.prepareStatement(sql);
                pt.setString(1, name);
                pt.setDouble(2, Double.parseDouble(priceStr));
                pt.setInt(3, Integer.parseInt(categoryIdStr));
                pt.setString(4, description);
                pt.setString(5, dbImagePath);
                pt.setInt(6, Integer.parseInt(id));
                
            } else {
                // ခ) ပုံအသစ် မရွေးထားသည့်အခြေအနေ (နဂိုပုံဟောင်းအတိုင်း ထားရှိမည်)
                String sql = "UPDATE menu_items SET name=?, price=?, category_id=?, description=? WHERE id=?";
                pt = conn.prepareStatement(sql);
                pt.setString(1, name);
                pt.setDouble(2, Double.parseDouble(priceStr));
                pt.setInt(3, Integer.parseInt(categoryIdStr));
                pt.setString(4, description);
                pt.setInt(5, Integer.parseInt(id));
            }
            
            pt.executeUpdate();
            System.out.println(">>> [SUCCESS] Item updated via Update Controller: " + name);
            
            if (pt != null) pt.close();
            if (conn != null) conn.close();
            
        } catch (Exception e) {
            System.out.println(">>> [ERROR] Database Update Failed!");
            e.printStackTrace();
        }
        
        // ပြင်ဆင်ပြီးပါက မူရင်း Menu စာမျက်နှာသို့ ပြန်လည်မောင်းနှင်မည်
        response.sendRedirect(request.getContextPath() + "/admin-menu");
    }

    private String getFileName(Part part) {
        if (part == null) return null;
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                String fullPathName = token.substring(token.indexOf("=") + 2, token.length() - 1);
                if (fullPathName.isEmpty()) return null;
                return fullPathName.substring(fullPathName.lastIndexOf(File.separator) + 1)
                                   .substring(fullPathName.lastIndexOf("/") + 1);
            }
        }
        return null;
    }
}