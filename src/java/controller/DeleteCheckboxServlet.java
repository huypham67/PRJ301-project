package controller;

import dao.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deleteSelected")
public class DeleteCheckboxServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Nhận danh sách id được chọn từ request
        String[] selectedIds = request.getParameterValues("selectedIds");
        
        // Gọi hàm xóa các mục dựa trên id
        DAO dao = DAO.getInstance();
        dao.removeItems(selectedIds);
        
        // Redirect hoặc gửi phản hồi tùy thuộc vào nhu cầu của ứng dụng
    }
}
