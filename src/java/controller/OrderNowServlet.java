/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Course;
import model.Order;
import model.User;

/**
 *
 * @author huypd
 */
@WebServlet(name = "OrderNowServlet", urlPatterns = {"/order-now"})
public class OrderNowServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAO dao = DAO.getInstance();
        Cart cart = new Cart();
        Cookie[] arr = request.getCookies();
        if (arr != null) {
            for (Cookie c : arr) {
                if (c.getName().equals("cartC")) {
                    try {
                        cart = dao.decode(c.getValue());
                    } catch (ClassNotFoundException ex) {
                        Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        }

        String id = request.getParameter("id");
        String quantityS = request.getParameter("quantity");
        int quantity = Integer.parseInt(quantityS);
        Course course = dao.getCourseById(id);
        String activationCode = DAO.generateRandomCode("activation");
        String endDate = "";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("acc");
        if (user != null) {
            List<Order> orders = new ArrayList<>();
            Order o = new Order(course, quantity, activationCode, endDate);
            orders.add(o);
            dao.insertTransaction(orders, user);
            cart.removeCourseToCart(course);
            
            String txt = dao.encode(cart);
            Cookie cartC = new Cookie("cartC", txt); //tạo lại cartC
            cartC.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(cartC);

            Cookie sizeC = new Cookie("sizeC", String.valueOf(cart.getCartList().size()));
            sizeC.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(sizeC);

            response.sendRedirect("orders");
        } else {
            response.sendRedirect("login.jsp");
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
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
