<%@page import="com.shop.connection.DbCon"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("person", auth);
}
ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllProducts();
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>
<title>E-Commerce Cart</title>
<style>
.product-buttons {
	display: flex;
	flex-direction: column; /* Stack buttons vertically */
	margin-top: 10px; /* Adjust the spacing as needed */
}

.product-buttons a {
	margin-bottom: 5px; /* Add space below each button */
	padding: 5px 10px; /* Smaller padding for smaller buttons */
	font-size: 0.875rem; /* Smaller font size */
}

.product-buttons a:last-child {
	margin-bottom: 0; /* Remove the margin for the last button */
}

.product-card {
	background-color: black; /* Set card background color to black */
	color: white; /* Set text color to white */
}

.product-card .card-title, .product-card .price, .product-card .category
	{
	color: white; /* Ensure all text elements inside the card are white */
}

.product-buttons a:hover {
	transform: scale(1.05); /* Slightly enlarge the button on hover */
}

.btn-dark {
	background-color: #343a40; /* Dark background */
	border: none; /* Remove default border */
}

.btn-dark:hover {
	background-color: #23272b; /* Darker shade on hover */
}

.btn-primary {
	background-color: #007bff; /* Primary background color */
	border: none; /* Remove default border */
}

.btn-primary:hover {
	background-color: #0056b3; /* Darker shade on hover */
}

.img-container {
	position: relative;
	overflow: hidden;
}

.img-container img {
	transition: transform 0.5s ease; /* Smooth transition for scaling */
	width: 100%; /* Ensure the image fills the container */
	height: auto; /* Maintain aspect ratio */
}

.img-container:hover img {
	transform: scale(1.2);
	/* Adjust the scale factor for desired zoom level */
}
</style>


</head>
<body>
	<%@include file="/includes/navbar.jsp"%>
	<div class="container">
		<div class="card-header my-3">All Products</div>
		<div class="row">
			<%
			if (!products.isEmpty()) {
				for (Product p : products) {
			%>
			<div class="col-md-3 my-3">
				<div class="card w-100 product-card">
					<div class="img-container">
						<img class="card-img-top" src="product-image/<%=p.getImage()%>"
							alt="Card image cap">
					</div>
					<div class="card-body">
						<h5 class="card-title"><%=p.getName()%></h5>
						<h6 class="price">
							Price: $<%=p.getPrice()%></h6>
						<h6 class="category">
							Category:
							<%=p.getCategory()%></h6>
						<div class="product-buttons">
							<a class="btn btn-dark" href="add-to-cart?id=<%=p.getId()%>">Add
								to Cart</a> <a class="btn btn-primary"
								href="order-now?quantity=1&id=<%=p.getId()%>">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			} else {
			out.println("No products to show!");
			}
			%>
		</div>
	</div>
	<%@include file="/includes/footer.jsp"%>
</body>
</html>
