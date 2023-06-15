<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	
	<title>Login</title>
</head>
<body class="container d-flex align-items-center justify-content-center" style="min-height: 60vh;">
	<div>
		 <form class="was-validated" method="POST" action="LoginServlet">
			<div class="modal-header">
            	<h1 class="modal-title text-center mx-auto">LOGIN</h1>
            </div>
            <div class="mb-3">
            	<label for="exampleFormControEMAIL" class="form-label"> Email</label>
                <input type="email" class="form-control" name="username" required placeholder="abc@gmail.com">
            </div>
            <div class="mb-3">
            	<label for="exampleFormControsenha" class="form-label"> Senha</label>
                <input type="password" class="form-control"  name="password" size=15 required placeholder="****">
            </div>
          	<div class="modal-footer">
            	<input type="submit" value="Login" class="btn btn-primary">
			</div>
		</form>
		
			<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
			<% if (errorMessage != null) { %>
			<div class="p-3 mb-2 bg-danger text-white">
				<p><%= errorMessage %></p>
			</div>	
			<% } %>
	</div>
</body>
</html>