package controller;

import dao.DAO;
import i18n.LanguageManager;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LanguageManager lang = new LanguageManager();
        String langParam = null;
        String previousURL = request.getHeader("referer");
        if (previousURL != null) {
            int langIndex = previousURL.lastIndexOf("?lang=");
            if (langIndex != -1) {
                langParam = previousURL.substring(langIndex + 6);
            }
        }

        String jspFile, mes;
        if ("vi".equals(langParam)) {
            lang.setLanguage(request, "vi_VN");
            jspFile = "loginVie.jsp";
            mes = "Sai email hoặc mật khẩu";
        } else {
            lang.setLanguage(request, "en_US");
            jspFile = "login.jsp";
            mes = "Email or password is wrong";
        }
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        DAO dao = DAO.getInstance();
        User acc = dao.login(email, password);
        if (acc == null) {
            request.setAttribute("mes", mes);
            request.getRequestDispatcher(jspFile).forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("acc", acc);
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
