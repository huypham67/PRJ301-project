/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Course;
import dao.DAO;
import jakarta.servlet.annotation.WebServlet;
import java.util.List;
import java.util.Random;
/**
 *
 * @author Administrator
 */
@WebServlet(name="AddProductServlet", urlPatterns={"/addProduct"})
public class AddProductServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddProductServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProductServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int duration_month = Integer.parseInt(request.getParameter("numberDu"));
        int cid = Integer.parseInt(request.getParameter("category"));
        String publicDate = request.getParameter("publicDate")+":00.000";
        String id = randomId(cid);
        try{
            DAO dao = DAO.getInstance();
            Course course = new Course(id, name, image, description, price, duration_month, cid, publicDate, 0);
            dao.addCourse(course);
        } catch(Exception e){
            System.out.println(e);
        }
        response.sendRedirect("manager");
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
    
    public String randomId(int cid) {
        Random random = new Random();       
        String id = "";
        switch(cid){
            case 1:{
                id += "WD";
                break;
            }
            case 2:{
                id += "DS";
                break;
            }
            case 3:{
                id += "MD";
                break;
            }
            case 4:{
                id += "ML";
                break;
            }
            case 5:{
                id += "GD";
                break;
            }            
        }
        for (int i = 0; i < 3; i++) {            
            id += random.nextInt(10);
        }
        while(!checkId(id)){
            randomId(cid);
        }
        return id;
    }
    
    public boolean checkId(String id){
        DAO dao = DAO.getInstance();
        List<Course> list = dao.getAllCourses();
        for(Course course : list){
            if(course.getId().equalsIgnoreCase(id)){
                return false;
            }
        }
        return true;
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
