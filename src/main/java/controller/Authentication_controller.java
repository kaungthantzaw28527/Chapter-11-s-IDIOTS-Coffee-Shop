package controller;

import dao.UserDAO;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/login", "/signup"})
public class Authentication_controller extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        // Login ဝင်ပြီးသား အခြေအနေကြီးမှာ /login သို့မဟုတ် /signup လာခေါ်ရင် Home ဆီ ပြန်ကန်ထုတ်ခြင်း
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("email") != null && session.getAttribute("userRole") != null) {
            String userRole = (String) session.getAttribute("userRole");
            if ("ADMIN".equals(userRole)) {
                response.sendRedirect(request.getContextPath() + "/admin-home");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            return; 
        }

        if ("/signup".equals(servletPath)) {
            request.getRequestDispatcher("/SignupForm.jsp").forward(request, response);
        } else if ("/login".equals(servletPath)) {
            request.getRequestDispatcher("/LoginForm.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();
        if ("/login".equals(servletPath)) {
            handleLogin(request, response);
        } else if ("/signup".equals(servletPath)) {
            handleSignup(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameOrEmail = request.getParameter("username");
        String password = request.getParameter("password");
        
        // 💡 Session ယူမယ် (မရှိရင် အသစ်ဆောက်မယ်)
        HttpSession session = request.getSession(true);

        // 💡 ၁။ လက်ရှိ Session ထဲမှာ အကောင့် Lock ကျနေလား အရင်စစ်မယ်
        Long lockoutTime = (Long) session.getAttribute("lockoutTime");
        if (lockoutTime != null) {
            long currentTime = System.currentTimeMillis();
            long timePassed = (currentTime - lockoutTime) / 1000; // စက္ကန့်ပြောင်းခြင်း
            
            if (timePassed < 60) {
                // စက္ကန့် ၆၀ မပြည့်သေးရင် ကျန်တဲ့စက္ကန့်တွက်ပြီး LoginForm.jsp ဆီ ပြန်လွှတ်မယ်
                long remainingSeconds = 60 - timePassed;
                request.setAttribute("remainingSeconds", remainingSeconds);
                request.setAttribute("error", "Too many failed attempts. Please wait.");
                request.getRequestDispatcher("/LoginForm.jsp").forward(request, response);
                return; // အောက်က Login စစ်တဲ့အဆင့်တွေကို ဆက်မသွားတော့ဘဲ တားလိုက်ခြင်း
            } else {
                // စက္ကန့် ၆၀ ပြည့်သွားပြီဆိုရင် Lock ကို ပြန်ဖွင့်ပေးမယ်
                session.removeAttribute("lockoutTime");
                session.setAttribute("failedAttempts", 0);
            }
        }

        // ၂။ ပုံမှန်အတိုင်း DAO ကိုလှမ်းခေါ်ပြီး အကောင့် တိုက်စစ်ခြင်း
        User user = userDAO.authenticateUser(usernameOrEmail, password);

        if (user != null) {
            // Login အောင်မြင်သွားရင် လက်ရှိ Session ရဲ့ အမှားမှတ်တမ်းကို ၀ ပြန်လုပ်မယ်
            session.setAttribute("failedAttempts", 0);
            
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("email", user.getEmail()); 

            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin-home");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            // 💡 ၃။ Login မှားသွားရင် Session ထဲက Failed Attempts ကို ၁ တိုးမယ်
            Integer failedAttempts = (Integer) session.getAttribute("failedAttempts");
            if (failedAttempts == null) {
                failedAttempts = 0;
            }
            failedAttempts++;
            session.setAttribute("failedAttempts", failedAttempts);
            
            // 💡 ၄။ မှားတာ ၅ ကြိမ်ပြည့်သွားရင် စပြီး Lock ချမယ်
            if (failedAttempts >= 5) {
                session.setAttribute("lockoutTime", System.currentTimeMillis()); // လက်ရှိအချိန်ကို မီလီစက္ကန့်နဲ့ မှတ်ခြင်း
                request.setAttribute("remainingSeconds", 60);
                request.setAttribute("error", "Too many failed attempts. Login disabled for 60 seconds.");
            } else {
                // ၅ ကြိမ်မပြည့်သေးရင် ဘယ်နှစ်ကြိမ်ကျန်သေးလဲပါ ပြပေးလို့ရအောင် (Optional)
                request.setAttribute("error", "Invalid username/email or password. (" + failedAttempts + "/5 attempts used)");
            }
            
            request.getRequestDispatcher("/LoginForm.jsp").forward(request, response);
        }
    }

    private void handleSignup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match. Please try again.");
            request.getRequestDispatcher("/SignupForm.jsp").forward(request, response);
            return;
        }

        if (password.length() < 8) {
            request.setAttribute("error", "Password must be at least 8 characters long.");
            request.getRequestDispatcher("/SignupForm.jsp").forward(request, response);
            return;
        }

        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email Address already registered!");
            request.getRequestDispatcher("/SignupForm.jsp").forward(request, response);
            return;
        }

        User newUser = new User(name, email, password, "CUSTOMER");
        boolean isSuccess = userDAO.registerUser(newUser);

        if (isSuccess) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Something went wrong. Please try again.");
            request.getRequestDispatcher("/SignupForm.jsp").forward(request, response);
        }
    }
}