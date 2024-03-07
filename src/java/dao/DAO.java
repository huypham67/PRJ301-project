/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import model.Cart;
import model.Category;
import model.Course;
import model.Order;
import model.User;

/**
 *
 * @author huypd
 */
public class DAO extends DBContext implements Serializable{
    private static DAO instance;
    private DAO() {
    }
    public static DAO getInstance() {
        if (instance == null)
            instance = new DAO();
        return instance;
    }
    
    public List<Course> getAllCourses() {
        List<Course> list = new ArrayList<>();
        String sql = "select * from Courses";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course c = new Course(rs.getString(1), 
                        rs.getString(2), 
                        rs.getString(3), 
                        rs.getString(4), 
                        rs.getDouble(5), 
                        rs.getString(6), 
                        rs.getInt(7),
                        rs.getString(8));
                list.add(c);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
    public List<Course> getCoursesByCid(String cid) {
        List<Course> list = new ArrayList<>();
        String sql = "select * from Courses where cid = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, cid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course c = new Course(rs.getString(1), 
                        rs.getString(2), 
                        rs.getString(3), 
                        rs.getString(4), 
                        rs.getDouble(5), 
                        rs.getString(6), 
                        rs.getInt(7),
                        rs.getString(8));
                list.add(c);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
    public Course getLastestCourse() {
        String sql = "select * from Courses order by publicDate";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Course(rs.getString(1), 
                        rs.getString(2), 
                        rs.getString(3), 
                        rs.getString(4), 
                        rs.getDouble(5), 
                        rs.getString(6), 
                        rs.getInt(7),
                        rs.getString(8));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public Course getCourseById(String id) {
        String sql = "select * from Courses where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Course(rs.getString(1), 
                        rs.getString(2), 
                        rs.getString(3), 
                        rs.getString(4), 
                        rs.getDouble(5), 
                        rs.getString(6), 
                        rs.getInt(7),
                        rs.getString(8));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "select * from Categories";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(1), rs.getString(2));
                list.add(c);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
    public User login(String user, String pass) {
        String sql = "select * from Users where username = ? and [password] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public List<Course> searchByName(String key) {
        List<Course> list = new ArrayList<>();
        String sql = "select * from Courses where name LIKE ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + key + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course c = new Course(rs.getString(1), 
                        rs.getString(2), 
                        rs.getString(3), 
                        rs.getString(4), 
                        rs.getDouble(5), 
                        rs.getString(6), 
                        rs.getInt(7),
                        rs.getString(8));
                list.add(c);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
    public double getTotalCartPrice(Cart cart) {
        double s = 0;
        for (Course o : cart.getCartList().keySet()) {
            int quantity = cart.getCartList().get(o);
            try {
                String sql = "select price from Courses where id = ?";
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setString(1, o.getId());
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    s += rs.getDouble(1)*quantity;
                }
            } catch (Exception e) {
            }
        }
        return s;
    }
    public String getCategoryByCid(int cid) {
        String sql = "select name from Categories where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
 
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public void signUp(String user, String pass) {
        String sql = "INSERT INTO Users\n" 
                + "VALUES (?, ?, 0)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    //xử lý dữ liệu từ cookie
    public String encode(Cart cart) throws IOException {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ObjectOutputStream out = new ObjectOutputStream(bos);
        out.writeObject(cart);
        out.flush();
        return Base64.getEncoder().encodeToString(bos.toByteArray());
    }

    // Deserialize a string to Cart object
    public Cart decode(String cartString) throws IOException, ClassNotFoundException {
        byte[] data = Base64.getDecoder().decode(cartString);
        ObjectInputStream in = new ObjectInputStream(new ByteArrayInputStream(data));
        return (Cart) in.readObject();
    }
    public static void main(String[] args) {
        DAO dao = DAO.getInstance();
//        List<Course> list = dao.getAllCourses();
//        for (Course course : list) {
//            System.out.println(course);
//        }
        
        System.out.println(dao.login("huy", "123"));
    }

    public List<Order> getUserOrder(User user) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
