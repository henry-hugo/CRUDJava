<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.crudjava.dao.UsuarioDao, com.crudjava.bean.*, java.util.*"%>
<%@ page import="com.crudjava.dao.ClienteDao, com.crudjava.bean.*, java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
HttpSession logout = request.getSession();
Usuario username = (Usuario) request.getSession().getAttribute("usuario");;
if(username == null){
	response.sendRedirect("../login.jsp");
}else if(username.getNivel() == 1){
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<title>Editar Cliente</title>
</head>
<body>
	<%
	// Obtém o objeto Usuario da sessão
	Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
	
	// Exibe as informações do usuário em HTML
	%>


	<%@page import="com.crudjava.bean.Cliente, com.crudjava.dao.ClienteDao" %>
	<%
		String id = request.getParameter("id");
		Cliente cliente = ClienteDao.getRegistroById(Integer.parseInt(id));
	%>
	
	<header class="container">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<ul  class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link" href="../index.jsp">HOME</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="../usuario/viewusuarios.jsp">USUARIO</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" href="viewclientes.jsp">CLIENTES</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="../relatorio/viewrelatorios.jsp">RELATORIOS</a>
				</li>
			</ul>
			<ul  class="navbar-nav mb-2 mb-lg-0">
				<li class="nav-item float-end">
					<p class="nav-link">Bem-vindo, <%= usuario.getNome() %>!</p>
				</li>
				<li class="nav-item float-end">
					<a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
				</li>
			</ul>

		</nav>
	</header>
	<main class="container">
		<div class="d-flex justify-content-center">
			<h1>Editar o Cliente</h1>
		</div>
	
		<form action="editcliente.jsp" method="post">
			<input type="hidden" name="id_cliente" value="<%=cliente.getId_cliente()%>"/>
			<label class="form-label">Nome</label>
			<input  class="form-control" type="text" name="nome" value="<%=cliente.getNome()%>">
			<br>
			<label class="form-label">Sobrenome</label>
			<input  class="form-control" type="text" name="sobrenome" value="<%=cliente.getSobrenome()%>">
			<br>
			<label>Email</label>
			<input  class="form-control" type="email" name="email" value="<%=cliente.getEmail()%>">
			<br>
			<label>Telefone</label>
			<input  class="form-control" type="text" name="telefone" value="<%=cliente.getTelefone()%>">
			<br>
			<label>CEP</label>
			<input  class="form-control" type="text" name="cep" value="<%=cliente.getCep()%>">
			<br>
			<label>Endereço</label>
			<input  class="form-control" type="text" name="endereco" value="<%=cliente.getEndereco()%>">
			<br>
			<label>Cidade</label>
			<input  class="form-control" type="text" name="cidade" value="<%=cliente.getCidade()%>">
			<br>
			<label>Estado</label>
			<input  class="form-control" type="text" name="estado" value="<%=cliente.getEstado()%>">
			<br>
			<input type="submit" value="Enviar">
		</form>
	</main>
</body>
</html>

<%}else{ %><jsp:include page="../index.jsp"></jsp:include>
<%} %>