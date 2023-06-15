<%@ page import="com.crudjava.dao.UsuarioDao, com.crudjava.bean.*, java.util.*"%>
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

<title>visualização de Usuários</title>
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
					<a class="nav-link" href="../index.jsp">HOME</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" href="viewusuarios.jsp">USUARIO</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="../cliente/viewclientes.jsp">CLIENTES</a>
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
			<h1>Listagem de Usuário</h1>
		</div>
		<a class="btn float-end" href="cadastrarUsuario.jsp"><i class="bi bi-person-fill-add"></i>Cadastra novo Usuario</a>
		
		
		
		
		
		<%
		  String mensagemErro = (String) request.getAttribute("mensagemErro");
		  
		  if (mensagemErro != null) {
		    out.println("<div class='erro'>" + mensagemErro + "</div>");
		  }
		%>
	
		<%
		List<Usuario> list = UsuarioDao.getAllUsuarios();
		request.setAttribute("list", list);
		%>
		
		
		
		<section class="container">
		<table  class="table table-dark table-striped" >
			<tr>
				<th>
					id
				</th>
				<th>
					nome
				</th>
				<th>
					email
				</th>
				<th>
					senha
				</th>
				<th>
					nivel
				</th>
				<th>
					Editar
				</th>
				<th>
					Excluir
				</th>
			</tr>
			
			
			<c:forEach items="${list}" var="usuario">
				<tr>
					<td>
						${usuario.getId()}
					</td>
					<td>
						${usuario.getNome()}
					</td>
					<td>
						${usuario.getEmail()}
					</td>
					<td>
						${usuario.getSenha()}
					</td>
					<td>
						${usuario.getNivel()}
					</td>
					<td>
						<a class="btn btn-primary" href="editform.jsp?id=${usuario.getId()}">Editar</a>
					</td>
					<td>
						<a class="btn btn-danger" href="deleteusuario.jsp?id=${usuario.getId()}">Excluir</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		</section>
	</main>
</body>
</html>





<%}else{ %><jsp:include page="../index.jsp"></jsp:include>
<%} %>