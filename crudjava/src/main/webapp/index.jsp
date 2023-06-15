<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.crudjava.dao.UsuarioDao, com.crudjava.bean.*, java.util.*, java.sql.*"%>
<%@ page import="com.crudjava.dao.ChamadaDao, com.crudjava.bean.*, java.util.*, java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	HttpSession logout = request.getSession();
	Usuario username = (Usuario) request.getSession().getAttribute("usuario");
	if(username == null){
		response.reset();
		response.sendRedirect("./login.jsp");
	}else if(username.getNivel() == 1){
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>Dashboard</title>
</head>
<body>
	<%
	// Obtém o objeto Usuario da sessão
	Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
	
	// Exibe as informações do usuário em HTML
	%>
	
	<header class="container">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<ul  class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link active" href="#">HOME</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="usuario/viewusuarios.jsp">USUARIO</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="cliente/viewclientes.jsp">CLIENTES</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="relatorio/viewrelatorios.jsp">RELATORIOS</a>
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
	<section class="container">
	<h1 class="d-flex justify-content-center">RESUMO DO DIA</h1>
	<div>
		<h2>Chamadas feitas no dia</h2>
		<%
		    // Obtenha a data atual
		    java.util.Date dataAtual = new java.util.Date();
		
		    // Crie um objeto java.sql.Date com a data atual
		    java.sql.Date dataSql = new java.sql.Date(dataAtual.getTime());
		
		    // Consulte o banco de dados para obter a quantidade de chamadas feitas no dia
		    int quantidadeChamadas = ChamadaDao.getQuantidadeChamadasPorData(dataSql);
		
		    // Exiba a quantidade de chamadas feitas no dia
		    out.println("Quantidade de chamadas feitas no dia: " + quantidadeChamadas);
		%>

	</div>
	</section>
</body>
</html>

<%}else{ %>
	<jsp:include page="atendente/viewclientes.jsp"></jsp:include>
<%} %>
