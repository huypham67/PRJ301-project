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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Course;
import model.Order;
import model.User;

@WebServlet(name="CheckOutServlet", urlPatterns={"/cart-check-out"})
public class CheckOutServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAO dao = DAO.getInstance();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("acc");
        if (user != null) {
            Cart cart = new Cart();
            Cookie[] arr = request.getCookies();
            if (arr != null) {
                for (Cookie c : arr) {
                    if (c.getName().equals("cartC")) {
                        try {
                            cart = dao.decode(c.getValue());
                        } catch (ClassNotFoundException ex) {
                            Logger.getLogger(CheckOutServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            }
            if (!cart.getCartList().isEmpty()) {
                for (Course c : cart.getCartList().keySet()) {
                    Order o = new Order(c, cart.getCartList().get(c));
                    dao.insertTransaction(o, user);
                }
                cart.getCartList().clear();
                Cookie cartC = new Cookie("cartC", dao.encode(cart));
                cartC.setMaxAge(0);
                response.addCookie(cartC);
                
                Cookie sizeC = new Cookie("sizeC", String.valueOf(cart.getCartList().size()));
                cartC.setMaxAge(60*60*24*7);
                response.addCookie(sizeC);
                
                response.sendRedirect("orders");
            } else {
                request.setAttribute("mes", "There is no items. We can't checkout for you.");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            }
        }
        else {
            response.sendRedirect("login.jsp");
        }
        
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
