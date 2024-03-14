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
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Random;
import model.Cart;
import model.Category;
import model.Course;
import model.Order;
import model.Transaction;
import model.User;

/**
 *
 * @author huypd
 */
public class DAO extends DBContext implements Serializable {

    private static DAO instance;

    private DAO() {
    }

    public static DAO getInstance() {
        if (instance == null) {
            instance = new DAO();
        }
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
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getDouble(9));
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
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getDouble(9));
                list.add(c);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public Course getLastestCourse() {
        String sql = "select * from Courses order by publicDate desc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Course(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDouble(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getDouble(9));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public Course getMostOrderCourse() {
        String sql = "SELECT * \n"
                + "FROM Courses\n"
                + "WHERE id = (\n"
                + "		SELECT TOP 1\n"
                + "			CourseId\n"
                + "		FROM Orders\n"
                + "		GROUP BY CourseId\n"
                + "		ORDER BY COUNT(CourseId) DESC\n"
                + "	)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Course(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDouble(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getDouble(9));
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
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getDouble(9));
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
        String sql = "select * from Users where email = ? and [password] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt(1), rs.getString(5), rs.getString(6), rs.getInt(7));
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
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getDouble(9));
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
                String sql = "select price, discount from Courses where id = ?";
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setString(1, o.getId());
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    s += rs.getDouble(1) * quantity * (1 - rs.getDouble(2));
                }
            } catch (SQLException e) {
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

    public void signUp(String fullName, String address, String phoneNumber, String email, String pass) {
        String sql = "INSERT INTO Users\n"
                + "VALUES (?, ?, ?, ?, ?, 0)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, address);
            ps.setString(3, phoneNumber);
            ps.setString(4, email);
            ps.setString(5, pass);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void addCourse(Course course) {
        String sql = "INSERT INTO [dbo].[Courses]\n"
                + "           ([id]\n"
                + "           ,[name]\n"
                + "           ,[image]\n"
                + "           ,[description]\n"
                + "           ,[price]\n"
                + "           ,[duration_month]\n"
                + "           ,[cid]\n"
                + "           ,[publicDate]\n"
                + "           ,[discount])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, course.getId());
            ps.setString(2, course.getName());
            ps.setString(3, course.getImage());
            ps.setString(4, course.getDescription());
            ps.setDouble(5, course.getPrice());
            ps.setInt(6, course.getDuration_month());
            ps.setInt(7, course.getCid());
            ps.setString(8, course.getPublicDate());
            ps.setDouble(9, course.getDiscount());
            ResultSet rs = ps.executeQuery();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void deleteCourseById(String id) {
        String sql = "DELETE Courses where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void updateCourse(Course course) {
        String sql = "UPDATE [dbo].[Courses]\n"
                + "   SET [name] = ?\n"
                + "      ,[image] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[duration_month] = ?\n"
                + "      ,[cid] = ?\n"
                + "      ,[publicDate] = ?\n"
                + "      ,[discount] = ?\n"
                + " WHERE [id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, course.getName());
            ps.setString(2, course.getImage());
            ps.setString(3, course.getDescription());
            ps.setDouble(4, course.getPrice());
            ps.setInt(5, course.getDuration_month());
            ps.setInt(6, course.getCid());
            ps.setString(7, course.getPublicDate());
            ps.setDouble(8, course.getDiscount());
            ps.setString(9, course.getId());
            ResultSet rs = ps.executeQuery();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public String encode(Cart cart) throws IOException {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ObjectOutputStream out = new ObjectOutputStream(bos);
        out.writeObject(cart);
        out.flush();
        return Base64.getEncoder().encodeToString(bos.toByteArray());
    }

    public Cart decode(String cartString) throws IOException, ClassNotFoundException {
        byte[] data = Base64.getDecoder().decode(cartString);
        ObjectInputStream in = new ObjectInputStream(new ByteArrayInputStream(data));
        return (Cart) in.readObject();
    }

    public List<Transaction> getUserOrder(User user) {
        DAO dao = DAO.getInstance();
        List<Transaction> list = new ArrayList<>();
        String sql = "select * from Transactions"
                + " where userId = ? order by [date] desc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, user.getId());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Transaction t = new Transaction();
                t.setTransactionId(rs.getString(1));
                t.setUid(rs.getInt(2));
                t.setDate(rs.getString(3));
                t.setTotalPrice(rs.getDouble(4));
                List<Order> orders = new ArrayList<>();
                String sql1 = "select courseId, activationCode, endDate, quantity from Orders where transactionId = ?";
                PreparedStatement ps1 = connection.prepareStatement(sql1);
                ps1.setString(1, rs.getString(1));
                ResultSet rs1 = ps1.executeQuery();
                while (rs1.next()) {
                    Course c = dao.getCourseById(rs1.getString(1));
                    String activationCode = rs1.getString(2);
                    String endDate = rs1.getString(3);
                    int quantity = rs1.getInt(4);
                    orders.add(new Order(c, quantity, activationCode, endDate));
                }
                t.setListOrders(orders);
                list.add(t);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    //mới update
    public void insertTransaction(List<Order> listO, User user) {
        double total = 0;
        for (Order o : listO) {
            total += o.getCourse().getPrice() * o.getQuantity()*(1 - o.getCourse().getDiscount());
        }
        String transactionId = DAO.generateRandomCode("transaction");
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        String sql1 = "INSERT INTO [dbo].[Transactions]\n"
                + "           ([id]\n"
                + "           ,[userId]\n"
                + "           ,[date]\n"
                + "           ,[totalPrice])\n"
                + "     VALUES\n"
                + "           (?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql1);
            ps.setString(1, transactionId);
            ps.setInt(2, user.getId());
            ps.setString(3, dateFormat.format(new Date()));
            ps.setDouble(4, total);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        for (Order o : listO) {
            String activationCode = DAO.generateRandomCode("activation");
            String sql2 = "INSERT INTO [dbo].[Orders]\n"
                    + "           ([courseId]\n"
                    + "           ,[transactionId]\n"
                    + "           ,[activationCode]\n"
                    + "           ,[endDate]\n"
                    + "           ,[quantity]\n"
                    + "           ,[price])\n"
                    + "     VALUES\n"
                    + "           (?,?,?,?,?,?)";
            try {
                PreparedStatement ps = connection.prepareStatement(sql2);
                ps.setString(1, o.getCourse().getId());
                ps.setString(2, transactionId);
                ps.setString(3, sql2);
                ps.setString(4, o.getEndDate());
                ps.setInt(5, o.getQuantity());
                ps.setDouble(6, o.getCourse().getPrice() * o.getQuantity() * (1 - o.getCourse().getDiscount()));
                ps.executeUpdate();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
    }

    public static String generateRandomCode(String key) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        int length = 0;
        if (key.equals("transaction")) {
            length = 10;
        }
        if (key.equals("activation")) {
            length = 8;
        }
        StringBuilder sb = new StringBuilder(length);
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(characters.length());
            sb.append(characters.charAt(index));
        }
        return sb.toString();
    }

    public static void main(String[] args) {
        DAO dao = DAO.getInstance();
        System.out.println(dao.login("huy@gmail.com", "123"));
    }

}
