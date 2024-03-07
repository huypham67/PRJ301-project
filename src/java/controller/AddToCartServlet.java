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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Category;
import model.Course;

/**
 *
 * @author huypd
 */
@WebServlet(name = "AddToCartServlet", urlPatterns = {"/add-to-cart"})
public class AddToCartServlet extends HttpServlet {

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
        String idS = request.getParameter("id");
        String quantityS = request.getParameter("quantity");
        int quantity = Integer.parseInt(quantityS);
        Cart cart = new Cart();
        DAO dao = DAO.getInstance();
        Cookie[] arr = request.getCookies();
        if (arr != null) {
            for (Cookie c : arr) {
                if (c.getName().equals("cartC")) {
                    try {
                        cart = dao.decode(c.getValue()); //mã hóa String thành List<Cart>
                    } catch (ClassNotFoundException ex) {
                        Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        }
        if (cart == null) {
            cart = new Cart(); //lỡ mã hóa xong thì curList bị null nên khởi tạo lại
        }

        Course course = dao.getCourseById(idS);
        if (cart.getCartList().containsKey(course)) {
            List<Course> listP = dao.getAllCourses();
            List<Category> listC = dao.getAllCategories();
            Course lastP = dao.getLastestCourse();
            request.setAttribute("listP", listP);
            request.setAttribute("listC", listC);
            request.setAttribute("lastP", lastP);
            request.setAttribute("tagCourseId", idS);
            request.setAttribute("mes", "Item Already in Cart");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else {
            cart.addCourseToCart(course, quantity);
            String txt = dao.encode(cart);
            Cookie cartC = new Cookie("cartC", txt); //tạo lại cartC
            cartC.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(cartC);

            Cookie sizeC = new Cookie("sizeC", String.valueOf(cart.getCartList().size()));
            sizeC.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(sizeC);

            response.sendRedirect("home");
        }
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
