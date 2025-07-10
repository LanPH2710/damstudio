<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Sửa địa chỉ giao hàng</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700;600;400&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editAddress.css?v=${System.currentTimeMillis()}" />
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="edit-address-wrapper">
            <form class="edit-address-form" action="editaddress" method="post" autocomplete="off">
                <div class="edit-address-title">
                    <i class="fa fa-pen-to-square"></i>
                    Sửa địa chỉ giao hàng
                </div>
                <input type="hidden" name="addressId" value="${address.addressId}" />

                <div class="form-group">
                    <label for="name"><i class="fa fa-user"></i> Họ và tên</label>
                    <input type="text" id="name" name="name" value="${address.name}" required>
                </div>
                <div class="form-group">
                    <label for="email"><i class="fa fa-envelope"></i> Email liên hệ</label>
                    <input type="email" id="email" name="email" value="${address.email}" required>
                </div>
                <div class="form-group">
                    <label for="phone"><i class="fa fa-phone"></i> Số điện thoại</label>
                    <input type="text" id="phone" name="phone" value="${address.phone}" required>
                </div>
                <div class="form-group">
                    <label><i class="fa fa-map-marker-alt"></i> Địa chỉ</label>
                    <div class="address-selects">
                        <select id="tinh" name="province" required>
                            <option value="">Chọn Tỉnh/Thành</option>
                        </select>
                        <select id="quan" name="district" required>
                            <option value="">Chọn Quận/Huyện</option>
                        </select>
                        <select id="phuong" name="ward" required>
                            <option value="">Chọn Phường/Xã</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="addressDetail"><i class="fa fa-location-dot"></i> Địa chỉ chi tiết (số nhà, tên đường...)</label>
                    <input type="text" id="addressDetail" name="addressDetail" value="${address.addressDetail}" required>
                </div>
                <div class="edit-address-btns">
                    <button type="submit" class="btn-save"><i class="fa fa-save"></i> Lưu thay đổi</button>
                    <a href="checkout?cartIds=${cartIds}" class="btn-cancel"><i class="fa fa-arrow-left"></i> Trở về</a>
                </div>
            </form>
        </div>

        <jsp:include page="footer.jsp"/>

        <!-- Nhúng jQuery và script lấy địa chỉ động -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(function () {
                // Load tỉnh/thành
                $.getJSON('https://esgoo.net/api-tinhthanh/1/0.htm', function (data_tinh) {
                    if (data_tinh.error == 0) {
                        $.each(data_tinh.data, function (_, val_tinh) {
                            $("#tinh").append('<option value="' + val_tinh.full_name + '" data-id="' + val_tinh.id + '">' + val_tinh.full_name + '</option>');
                        });
                        // Gán lại nếu có dữ liệu cũ
                        const province = "${address.province}";
                        if (province)
                            $("#tinh").val(province).trigger('change');
                    }
                });

                // Khi chọn tỉnh, load quận
                $("#tinh").on("change", function () {
                    var idtinh = $(this).find(':selected').data('id');
                    $("#quan").html('<option value="">Chọn Quận/Huyện</option>');
                    $("#phuong").html('<option value="">Chọn Phường/Xã</option>');
                    if (!idtinh)
                        return;
                    $.getJSON('https://esgoo.net/api-tinhthanh/2/' + idtinh + '.htm', function (data_quan) {
                        if (data_quan.error == 0) {
                            $.each(data_quan.data, function (_, val_quan) {
                                $("#quan").append('<option value="' + val_quan.full_name + '" data-id="' + val_quan.id + '">' + val_quan.full_name + '</option>');
                            });
                            // Gán lại nếu có dữ liệu cũ
                            const district = "${address.district}";
                            if (district)
                                $("#quan").val(district).trigger('change');
                        }
                    });
                });

                // Khi chọn quận, load phường
                $("#quan").on("change", function () {
                    var idquan = $(this).find(':selected').data('id');
                    $("#phuong").html('<option value="">Chọn Phường/Xã</option>');
                    if (!idquan)
                        return;
                    $.getJSON('https://esgoo.net/api-tinhthanh/3/' + idquan + '.htm', function (data_phuong) {
                        if (data_phuong.error == 0) {
                            $.each(data_phuong.data, function (_, val_phuong) {
                                $("#phuong").append('<option value="' + val_phuong.full_name + '" data-id="' + val_phuong.id + '">' + val_phuong.full_name + '</option>');
                            });
                            // Gán lại nếu có dữ liệu cũ
                            const ward = "${address.ward}";
                            if (ward)
                                $("#phuong").val(ward);
                        }
                    });
                });
            });
        </script>
    </body>
</html>
