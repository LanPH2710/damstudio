<%-- 
    Document   : policy
    Created on : Oct 21, 2025, 7:17:13 PM
    Author     : ADMIN
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <link rel="shortcut icon" type="image/icon" href="image/logo/logoIMG.png"/>
        <title>Điều Khoản & Chính Sách</title>
        <link rel="stylesheet" href="css/homePage.css">
        <style>
            .mainbody {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                padding: 20px;
                max-width: 800px;
                margin: auto;
                background-color:#FFFBF5;
                color: #4D403D;
            }
            h1 {
                color: #9A3F3F; 
                text-align: center;
                margin-bottom: 30px;
            }
            h2 {
                color: #9A3F3F;
                border-bottom: 2px solid #9A3F3F;
                padding-bottom: 5px;
                margin-top: 25px;
            }
            ul {
                list-style-type: disc;
                margin-left: 20px;
            }
            p.contact {
                margin-top: 30px;
                text-align: center;
                font-style: italic;
                color: #9A3F3F;
            }
            
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="mainbody">
            <h1>ĐIỀU KHOẢN & CHÍNH SÁCH CHUNG</h1>

            <h2>1. ĐIỀU KHOẢN DỊCH VỤ (TOS)</h2>
            <ul>
                <li>**Chấp nhận:** Việc sử dụng dịch vụ của chúng tôi đồng nghĩa với việc bạn đồng ý với các điều khoản này.</li>
                <li>**Quyền từ chối:** Chúng tôi có quyền từ chối, hủy đơn hàng hoặc chấm dứt dịch vụ đối với bất kỳ ai vi phạm Điều khoản mà không cần báo trước.</li>
                <li>**Thông tin:** Bạn cam kết cung cấp thông tin chính xác khi đặt hàng hoặc đăng ký.</li>
                <li>**Miễn trách:** Chúng tôi không chịu trách nhiệm về thiệt hại gián tiếp phát sinh từ việc sử dụng dịch vụ hoặc sản phẩm của chúng tôi.</li>
            </ul>

            <h2>2. CHÍNH SÁCH BẢO MẬT (PRIVACY)</h2>
            <ul>
                <li>**Thu thập:** Chúng tôi thu thập thông tin cá nhân (Tên, SĐT, Địa chỉ, Email) chỉ nhằm mục đích xử lý đơn hàng, giao hàng và hỗ trợ khách hàng.</li>
                <li>**Bảo mật:** Thông tin cá nhân của bạn được bảo mật tuyệt đối và KHÔNG được chia sẻ với bất kỳ bên thứ ba nào trừ khi có yêu cầu từ cơ quan pháp luật hoặc để hoàn thành việc giao hàng (cho đơn vị vận chuyển).</li>
                <li>**Cookie:** Chúng tôi có thể sử dụng cookie để cải thiện trải nghiệm duyệt web của bạn.</li>
            </ul>

            <h2>3. CHÍNH SÁCH GIAO HÀNG (DELIVERY)</h2>
            <ul>
                <li>**Phạm vi:** Giao hàng trên toàn quốc (Việt Nam).</li>
                <li>**Thời gian:**
                    <ul>
                        <li>Nội thành: 1-3 ngày làm việc.</li>
                        <li>Ngoại thành/Tỉnh: 3-7 ngày làm việc.</li>
                    </ul>
                    *Thời gian có thể thay đổi do yếu tố khách quan (thời tiết, lễ tết...).
                </li>
                <li>**Phí giao hàng:** Được tính dựa trên địa chỉ nhận hàng và trọng lượng đơn hàng, sẽ được thông báo cụ thể khi xác nhận đơn.</li>
                <li>**Kiểm tra:** Khách hàng có trách nhiệm kiểm tra sản phẩm trước khi thanh toán và nhận hàng. Mọi khiếu nại về ngoại hình sản phẩm sau khi đã ký nhận sẽ không được giải quyết.</li>
            </ul>

            <p class="contact">
                **Lưu ý:** Vui lòng liên hệ với chúng tôi nếu có bất kỳ thắc mắc nào về các điều khoản và chính sách trên.
            </p>

        </div>
        <jsp:include page="footer.jsp"/>

    </body>
</html>