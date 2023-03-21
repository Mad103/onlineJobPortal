<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.List" %>
<%@ page import="com.dao.JobDAO" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.Jobs" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
<%@include file="all_component/all_css.jsp" %>
</head>
<body style="background-color: #f0f1f2">
	
	<c:if test="${empty userobj }">
	<c:redirect url="login.jsp" />
	</c:if>
	
	<%@include file="all_component/navbar.jsp" %>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h5 class="text-center text-primary mt-2">All Jobs</h5>
				
				<c:if test="${not empty succMsg}">
					<h4 class="text-center text-success">${succMsg }</h4>
					<c:remove var="succMsg" />
				</c:if>
				
				<div class="card">
					<div class="card-body">
						
						<form class="form-inline" action="more_view.jsp" methods="get">
							<div class="form-group col-md-5 mnt-1">
								<h5>Location</h5>
							</div>
							
							<div class="form-group col-md-4 mt-1">
								<h5>Category</h5>
							</div>
							
							<div class="form-group col-md-5">
								<select name="Loc" class="custom-select" id="inlineFormCustomSelectPref">
									<option selected value="Lo">Choose...</option>
										<option value="Odisha">Odisha</option>
										<option value="Jharkhand">Jharkhand</option>
										<option value="Gujurat">Gujurat</option>
										<option value="Bhubaneshwar">Bhubaneshwar</option>
										<option value="Delhi">Delhi</option>
										<option value="Banglore">Banglore</option>
										<option value="Chennai">Chennai</option>
										<option value="Hyderabad">Hyderabad</option>
								</select>
							</div>
							
							<div class="form-group col-md-5">
								<select name="cat" class="custom-select" id="inlineFormCustomSelectPref">
									<option selected value="ca">Choose...</option>
										<option value="IT">IT</option>
										<option value="Devloper">Developer</option>
										<option value="Banking">Banking</option>
										<option value="Engineer">Engineer</option>
										<option value="Teacher">Teacher</option>
								</select>
							</div>
							
							<button class="btn btn-success">Submit</button>
						</form>
					</div>
				</div>
				
				<% 
					JobDAO dao = new JobDAO(DBConnect.getConn());
					List<Jobs> list = dao.getAllJobsForUser();
					for(Jobs j : list){
					%>
					<div class="card mt-2">
						<div class="card-body">
							<div class="text-center text-primary">
								<i class="far fa-clipboard fa-2x"></i>
							</div>
							
							<h6><%=j.getTitle() %></h6>	
							
							<%
								if(j.getDescription().length() > 0 && j.getDescription().length() < 120){
								%>
								<p><%=j.getDescription() %></p>
								<%
								} else{
								%>
									<p><%=j.getDescription().substring(0,120) %>...
									</p>
								<%
								}
								%>
								
								
								<br>
								<div class="form-row">
									<div class="form-group col-md-3">
										<input type="text" class="form-control form-control-sm" value="Location: <%=j.getLocation()%>" readonly>
									</div>
									<div class="form-group col-md-3">
										<input type="text" class="form-control form-control-sm" value="Category: <%=j.getCategory()%>" readonly>
									</div>
								</div>
								<h6>Publish Date:
									<%=j.getPdate().toString() %>
								</h6>
								<div class="text-center">
									<a href="one_view.jsp?id=<%=j.getId() %>" class="btn btn-sm bg-success text-white">View More</a>
								</div>						
							</div>
					</div>
					<%
					}
				%>
			</div>
		</div>
	</div>
	

</body>
</html>