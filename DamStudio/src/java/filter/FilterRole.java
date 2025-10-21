package filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

public class FilterRole implements Filter {

    private FilterConfig filterConfig = null;

    // Chỉ admin mới được phép vào các URL này
    private List<String> adminOnlyUrls = Arrays.asList(
            "/editproduct",
            "/managerproduct",
            "/manageruser",
            "/changeorder"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String requestURI = req.getRequestURI();
        String errorPage = req.getContextPath() + "/error.jsp";

        // Kiểm tra xem URL hiện tại có nằm trong danh sách admin-only không
        boolean requiresAdmin = adminOnlyUrls.stream().anyMatch(requestURI::contains);

        // Nếu URL không cần quyền admin → cho qua luôn
        if (!requiresAdmin) {
            chain.doFilter(request, response);
            return;
        }

        // Nếu URL yêu cầu quyền admin → kiểm tra đăng nhập và role
        if (session != null && session.getAttribute("account") != null) {
            Account account = (Account) session.getAttribute("account");
            int roleId = account.getRoleId();

            if (roleId == 1) {
                chain.doFilter(request, response); // Admin → cho phép
            } else {
                res.sendRedirect(errorPage); // Không phải admin → chặn
            }
        } else {
            res.sendRedirect(errorPage); // Chưa đăng nhập → chặn
        }
    }

    @Override
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    @Override
    public void destroy() {
    }
}
