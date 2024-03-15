package controller;

import dao.DAO;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

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


@WebServlet("/PurchaseServlet")
public class PurchaseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy dữ liệu từ yêu cầu POST
        String postData = request.getParameter("data");
        HttpSession session = request.getSession();
        
        // Phân tích dữ liệu thành các cặp key-value
        String[] ids = postData.split(",");
        List<Course> coursesPurchase = new ArrayList<>();
        
        Cart cart = new Cart();
        DAO dao = DAO.getInstance();
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
        
        for (String id : ids) {
            Course course = dao.getCourseById(id);
            coursesPurchase.add(course);
            cart.removeCourseToCart(course);
        }  
        boolean success = false;
        
        
        
        if (success){
            session.setAttribute("selectedIds", null); 
            response.sendRedirect("orders.jsp");
        } else {
            request.setAttribute("mes", "Fail to Purchase!");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
        
        
        
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }
}
