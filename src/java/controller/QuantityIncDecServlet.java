/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Course;

/**
 *
 * @author huypd
 */
@WebServlet(name = "QuantityIncDecServlet", urlPatterns = {"/quantity-inc-dec"})
public class QuantityIncDecServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAO dao = DAO.getInstance();
        Cart cart = new Cart();
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        Course course = dao.getCourseById(id);
        Cookie[] arr = request.getCookies();
        if (arr != null) {
            for (Cookie c : arr) {
                if (c.getName().equals("cartC")) {
                    try {
                        cart = dao.decode(c.getValue());
                    } catch (ClassNotFoundException ex) {
                        Logger.getLogger(QuantityIncDecServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        }
        Integer quantity = cart.getCartList().get(course);
        if (quantity != null) {
            if (action.equals("inc")) {
                quantity++;
                cart.addCourseToCart(course, quantity);
            }
            if (action.equals("dec")) {
                if (quantity == 1) 
                    cart.removeCourseToCart(course);
                else {
                    quantity--;
                    cart.addCourseToCart(course, quantity);
                }
            }
            String txt = dao.encode(cart);
            Cookie cartC = new Cookie("cartC", txt); //tạo lại cartC
            cartC.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(cartC);
            
            Cookie sizeC = new Cookie("sizeC", String.valueOf(cart.getCartList().size()));
            sizeC.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(sizeC);
        }
        double total = dao.getTotalCartPrice(cart);
        request.setAttribute("total", total);
        request.setAttribute("cart", cart.getCartList());
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
