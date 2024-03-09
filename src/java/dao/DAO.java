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
                        rs.getString(6),
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
                        rs.getString(6),
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
                        rs.getString(6),
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
                        rs.getString(6),
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
                        rs.getString(6),
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
                        rs.getString(6),
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
                String sql1 = "select courseId, quantity from Orders where transactionId = ?";
                PreparedStatement ps1 = connection.prepareStatement(sql1);
                ps1.setString(1, rs.getString(1));
                ResultSet rs1 = ps1.executeQuery();
                while (rs1.next()) {
                    Course c = dao.getCourseById(rs1.getString(1));
                    int quantity = rs1.getInt(2);
                    orders.add(new Order(c, quantity));
                }
                t.setListOrders(orders);
                list.add(t);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public void insertTransaction(Order o, User user) {
        String transactionId = generateRandomCode();
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
            ps.setDouble(4, o.getCourse().getPrice() * o.getQuantity());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        String sql2 = "INSERT INTO [dbo].[Orders]\n"
                + "           ([courseId]\n"
                + "           ,[transactionId]\n"
                + "           ,[quantity]\n"
                + "           ,[price])\n"
                + "     VALUES\n" 
                + "           (?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql2);
            ps.setString(1, o.getCourse().getId());
            ps.setString(2, transactionId);
            ps.setInt(3, o.getQuantity());
            ps.setDouble(4, o.getCourse().getPrice() * o.getQuantity() * (1 - o.getCourse().getDiscount()));
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public String generateRandomCode() {
        // Tạo một đối tượng Random
        Random random = new Random();
        // Tạo mã TRAN + 5 ký tự số ngẫu nhiên
        StringBuilder codeBuilder = new StringBuilder("TRAN");
        for (int i = 0; i < 9; i++) {
            int randomNumber = random.nextInt(10); // Số ngẫu nhiên từ 0 đến 9
            codeBuilder.append(randomNumber);
        }

        return codeBuilder.toString();
    }

    public static void main(String[] args) {
        DAO dao = DAO.getInstance();
        System.out.println(dao.login("huy@gmail.com", "123"));
    }

}
