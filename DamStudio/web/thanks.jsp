<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/thanks.css?v=${System.currentTimeMillis()}" />
        <title>Dam Studio</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/home.css">        
        <link rel="stylesheet" href="css/nav.css">
        <script type="text/javascript" src="js/main.js"></script>
        <link rel="stylesheet" type="text/css" href="slick/slick.css" />
        <link rel="stylesheet" type="text/css" href="slick/slick-theme.css" />
        <script type="text/javascript" src="slick/slick.min.js"></script>      
        <style>
            .message {
                margin: 20px 0;
                font-size: 18px;
            }
            .link {
                color: red;
                text-decoration: none;
            }
            .button {
                background-color: #ea5455;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <c:if test="${vnp_TransactionStatus==null}">
            <div class="container" style="text-align: center;margin: 50px auto;width: 50%;border: 1px solid #f0f0f0;padding: 20px;border-radius: 10px;background-color: #fdfdfd;">
                <div class="header" style="background-color: #fca82d;padding: 10px;font-size: 24px;font-weight: bold;color: white;">ĐẶT HÀNG THÀNH CÔNG</div>
                <div class="message">
                    Chúc mừng bạn đã hoàn tất đơn hàng.<br>
                    Chúng tôi sẽ kiểm tra và liên hệ giao hàng đến bạn trong thời gian sớm nhất!<br>
                    Để xem lại đơn hàng, vui lòng <a href="myorder">nhấn vào đây</a>.
                </div>
                <a href="home" class="button">QUAY LẠI TRANG CHỦ</a>
            </div>        
        </c:if>
        <c:if test="${vnp_TransactionStatus!=null && vnp_TransactionStatus =='00'}">
            <c:if test="${addM==null}">
                <div class="container" style="text-align: center;margin: 0px auto;width: 50%;border: 1px solid #f0f0f0;padding: 20px;border-radius: 10px;background-color: #fdfdfd;">
                    <div class="header" style="background-color: #fca82d;padding: 10px;font-size: 24px;font-weight: bold;color: white;">ĐẶT HÀNG THÀNH CÔNG</div>
                    <div class="message" style="text-align: left">
                        Chúc mừng bạn đã hoàn tất đơn hàng.<br>
                        Chúng tôi sẽ kiểm tra và liên hệ giao hàng đến bạn trong thời gian sớm nhất!<br>
                        Để xem lại đơn hàng, vui lòng <a href="myorder">nhấn vào đây</a>.
                    </div><br><hr>
                </c:if>
                <c:if test="${addM!=null}">
                    <div class="container" style="text-align: center;margin: 0px auto;width: 50%;border: 1px solid #f0f0f0;padding: 20px;border-radius: 10px;background-color: #fdfdfd;">
                        <div class="header" style="background-color: #fca82d;padding: 10px;font-size: 24px;font-weight: bold;color: white;">NẠP TIỀN THÀNH CÔNG</div>
                        <div class="message" style="text-align: left">
                            Chúc mừng bạn đã nạp tiền vào tài khoản thành công.<br>
                            Chúc bạn có trải nghiệm tốt vớt Watch Shop!<br>
                        </div><br><hr>
                    </c:if>
                    <div class="header clearfix">
                        <h3 class="text-muted">KẾT QUẢ THANH TOÁN</h3>
                    </div>
                    <div class="table-responsive" style="text-align: left">
                        <div class="form-group">
                            <label >Mã giao dịch thanh toán:</label>
                            <label>${vnp_TxnRef}</label>
                        </div>    
                        <div class="form-group">
                            <label >Số tiền:</label>
                            <label><fmt:formatNumber value="${vnp_Amount}"/> vnđ</label>
                        </div>  
                        <div class="form-group">
                            <label >Mô tả giao dịch:</label>
                            <label>${vnp_OrderInfo}</label>
                        </div> 
                        <div class="form-group">
                            <label >Mã lỗi thanh toán:</label>
                            <label>${vnp_ResponseCode}</label>
                        </div> 
                        <div class="form-group">
                            <label >Mã giao dịch tại CTT VNPAY-QR:</label>
                            <label>${vnp_TransactionNo}</label>
                        </div> 
                        <div class="form-group">
                            <label >Mã ngân hàng thanh toán:</label>
                            <label>${vnp_BankCode}</label>
                        </div> 
                        <div class="form-group">
                            <label >Thời gian thanh toán:</label>
                            <label>${vnp_PayDate}</label>
                        </div> 
                        <div class="form-group">
                            <label >Tình trạng giao dịch:</label>
                            <label style="color: ${vnp_TransactionStatus.equals("00")?'springgreen':'red'} ">
                                ${vnp_TransactionStatus.equals("00")?'Hoàn Thành':'Chưa hoàn thành'}</label>
                        </div> 
                    </div> 
                    <a href="home" class="button">QUAY LẠI TRANG CHỦ</a>
                </div>  


            </c:if>
            <c:if test="${vnp_TransactionStatus!=null && vnp_TransactionStatus != '00'}">
                <c:if test="${addM==null}">
                    <div class="container" style="text-align: center;margin: 0px auto;width: 50%;border: 1px solid #f0f0f0;padding: 20px;border-radius: 10px;background-color: #fdfdfd;">
                        <div class="header" style="background-color: #fca82d;padding: 10px;font-size: 24px;font-weight: bold;color: white;">ĐẶT HÀNG THẤT BẠI</div>
                        <div class="message" style="color: red; margin-left: -20px;font-size: 19px;" >
                            Đơn hàng của bạn chưa được thanh toán thành công xin vui lòng hãy kiểm tra lại!.<br>
                        </div><br><hr>
                    </c:if>
                    <c:if test="${addM!=null}">
                        <div class="container" style="text-align: center;margin: 0px auto;width: 50%;border: 1px solid #f0f0f0;padding: 20px;border-radius: 10px;background-color: #fdfdfd;">
                            <div class="header" style="background-color: #fca82d;padding: 10px;font-size: 24px;font-weight: bold;color: white;">NẠP TIỀN THẤT BẠI</div>
                            <div class="message" style="color: red; margin-left: -20px;font-size: 19px;" >
                                Yêu cầu nạp tiền vào tài khoản của bạn không thành công!.<br>
                            </div><br><hr>
                        </c:if>

                        <div class="header clearfix">
                            <h3 class="text-muted">KẾT QUẢ THANH TOÁN</h3>
                        </div>
                        <div class="table-responsive" style="text-align: left">
                            <div class="form-group">
                                <label >Mã giao dịch thanh toán:</label>
                                <label>${vnp_TxnRef}</label>
                            </div>    
                            <div class="form-group">
                                <label >Số tiền:</label>
                                <label><fmt:formatNumber value="${vnp_Amount}"/> USD</label>
                            </div>  
                            <div class="form-group">
                                <label >Mô tả giao dịch:</label>
                                <label>${vnp_OrderInfo}</label>
                            </div> 
                            <div class="form-group">
                                <label >Mã lỗi thanh toán:</label>
                                <label>${vnp_ResponseCode}</label>
                            </div> 
                            <div class="form-group">
                                <label >Mã giao dịch tại CTT VNPAY-QR:</label>
                                <label>${vnp_TransactionNo}</label>
                            </div> 
                            <div class="form-group">
                                <label >Mã ngân hàng thanh toán:</label>
                                <label>${vnp_BankCode}</label>
                            </div> 
                            <div class="form-group">
                                <label >Thời gian thanh toán:</label>
                                <label>${vnp_PayDate}</label>
                            </div> 
                            <div class="form-group">
                                <label >Tình trạng giao dịch:</label>
                                <label style="color: ${vnp_TransactionStatus.equals("00")?'springgreen':'red'} ">
                                    ${vnp_TransactionStatus.equals("00")?'Hoàn Thành':'Chưa hoàn thành'}</label>
                            </div> 
                        </div>
                        <a href="home" class="button">QUAY LẠI TRANG CHỦ</a>
                    </div> 
                </c:if>
                <jsp:include page="footerDemo.jsp"></jsp:include>
                </body>
                </html>

