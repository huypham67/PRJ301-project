package controller;

import dao.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Course;

@WebServlet("/buyCheckbox")
public class BuyCheckboxServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String test = request.getParameter("selectedIds");
        String[] selectedIds = test.split(",");
        if (selectedIds != null && selectedIds.length > 0) {
            DAO dao = DAO.getInstance();
            Cookie[] cookies = request.getCookies();
            Cart cart = null;
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("cartC")) {
                        try {
                            cart = dao.decode(cookie.getValue());
                        } catch (ClassNotFoundException ex) {
                            Logger.getLogger(BuyCheckboxServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        break;
                    }
                }
            }

            if (cart != null) {
                List<Course> selectedCourses = new ArrayList<>();
                for (String id : selectedIds) {
                    Course course = dao.getCourseById(id);
                    selectedCourses.add(course);
                }
                request.setAttribute("mes", "Ready!Go to Checkout....");
                request.setAttribute("selectedCourses", selectedCourses);
                response.sendRedirect("checkout.jsp");
            }
        } else {
            request.setAttribute("mes", "Have some error for checkout for you. Plese contact with Fanpage.");
            response.sendRedirect("cart.jsp");
        }
    }
}
