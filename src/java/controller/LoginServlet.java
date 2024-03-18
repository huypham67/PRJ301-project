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
        HttpSession session = request.getSession();
        String mes;
        String lang = (String) session.getAttribute("language");
        if (lang.equals("en_US")){
            mes = "Wrong email or password!";
        } else {
            mes = "Sai email hoặc là mật khẩu!";
        }

        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        DAO dao = DAO.getInstance();
        User acc = dao.login(email, password);
        if (acc == null) {
            request.setAttribute("mes", mes);
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else {
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
