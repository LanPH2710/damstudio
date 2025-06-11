<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Nhập OTP</title>
    <link rel="stylesheet" href="css/otp.css">
    <style>
        .otp-container {
            max-width: 500px;
            margin: 60px auto;
            padding: 40px;
            background-color: #fff9f9;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(183, 28, 28, 0.2);
            font-family: 'Segoe UI', sans-serif;
            text-align: center;
        }

        .otp-container h2 {
            color: #b71c1c;
            margin-bottom: 24px;
        }

        .form-control {
            width: 100%;
            padding: 12px 14px;
            border: 2px solid #f2c7c7;
            border-radius: 10px;
            font-size: 18px;
            margin-bottom: 20px;
        }

        .submit-btn {
            padding: 12px 26px;
            background-color: #b71c1c;
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #8b0000;
        }

        .message {
            color: green;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .error {
            color: red;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>

    <div class="otp-container">
        <h2>Xác Thực OTP</h2>

        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="error">${errorMessage}</div>
        </c:if>

        <form action="verifyotp" method="post">
            <input type="text" name="otp" class="form-control" placeholder="Nhập mã OTP đã nhận" required>
            <button type="submit" class="submit-btn">Xác nhận</button>
        </form>
    </div>

    <jsp:include page="footer.jsp"/>
</body>
</html>

