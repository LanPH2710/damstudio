<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Edit Product</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editProduct.css?v=${System.currentTimeMillis()}" />
        <link rel="stylesheet" href="css/homePage.css">
        <link rel="shortcut icon" type="image/icon" href="image/logo/logoIMG.png"/>
    </head>

    <body class="container mt-5">
        <h2 class="mb-4">Edit Product</h2>

        <form action="editproduct" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productId" value="${product.productId}"/>

            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" name="name" value="${product.name}" class="form-control" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Price</label>
                <input type="number" name="price" value="${product.price}" class="form-control" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control" rows="3">${product.description}</textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">VAT (%)</label>
                <input type="number" name="VAT" value="${product.VAT}" class="form-control"/>
            </div>

            <div class="mb-3">
                <label class="form-label">Brand</label>
                <select name="brandId" class="form-select">
                    <c:forEach var="b" items="${brandList}">
                        <option value="${b.brandId}" ${b.brandId == product.brandId ? 'selected' : ''}>${b.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Style</label>
                <select name="styleId" class="form-select">
                    <c:forEach var="s" items="${styleList}">
                        <option value="${s.styleId}" ${s.styleId == product.styleId ? 'selected' : ''}>${s.styleName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Status</label>
                <select name="productStatus" class="form-select">
                    <option value="1" ${product.productStatus == 1 ? 'selected' : ''}>Active</option>
                    <option value="0" ${product.productStatus == 0 ? 'selected' : ''}>Inactive</option>
                </select>
            </div>

            <!-- Hiển thị ảnh hiện tại -->
            <div class="mb-3">
                <label class="form-label">Current Images</label>
                <div class="image-container">
                    <c:forEach var="img" items="${product.images}">
                        <img src="image/ao/${img.imageUrl}" alt="${product.name}" class="img-preview"/>
                    </c:forEach>
                </div>
            </div>

            <!-- Upload ảnh mới -->
            <div class="mb-3">
                <label class="form-label">Upload new image</label>
                <input type="file" name="newImage" accept="image/*" class="form-control" onchange="previewImage(event)">
                <div class="mt-2">
                    <img id="preview" class="img-preview" style="display:none;">
                </div>
            </div>

            <button type="submit" class="btn btn-primary">Save</button>
            <a href="managerproduct" class="btn btn-secondary">Cancel</a>
        </form>

        <script>
            function previewImage(event) {
                const preview = document.getElementById('preview');
                preview.src = URL.createObjectURL(event.target.files[0]);
                preview.style.display = 'block';
            }
        </script>
    </body>
</html>
