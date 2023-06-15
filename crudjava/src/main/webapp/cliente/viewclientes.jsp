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

<title>visualização de Clientes</title>
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
			<h1>Listagem de Clientes</h1>
		</div>
		<a class="btn float-end" href="./cadastrarCliente.jsp"><i class="bi bi-person-fill-add"></i>Cadastra novo Cliente</a>
		
		
		
		
		
		<%
		  String mensagemErro = (String) request.getAttribute("mensagemErro");
		  
		  if (mensagemErro != null) {
		    out.println("<div class='erro'>" + mensagemErro + "</div>");
		  }
		%>
	
		<%
		List<Cliente> list = ClienteDao.getAllClientes();
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
					sobrenome
				</th>
				<th>
					email
				</th>
				<th>
					telefone
				</th>
				<th>
					endereço
				</th>
				<th>
					cidade
				</th>
				<th>
					estado
				</th>
				<th>
					cep
				</th>
				<th>
					editar
				</th>
				<th>
					excluir
				</th>
			</tr>
			
			
			<c:forEach items="${list}" var="cliente">
				<tr>
					<td>
						${cliente.getId_cliente()}
					</td>
					<td>
						${cliente.getNome()}
					</td>
					<td>
						${cliente.getSobrenome()}
					</td>
					<td>
						${cliente.getEmail()}
					</td>
					<td>
						${cliente.getTelefone()}
					</td>
					<td>
						${cliente.getEndereco()}
					</td>
					<td>
						${cliente.getCidade()}
					</td>
					<td>
						${cliente.getEstado()}
					</td>
					<td>
						${cliente.getCep()}
					</td>
					<td>
						<a class="btn btn-primary" href="editform.jsp?id=${cliente.getId_cliente()}">Editar</a>
					</td>
					<td>
						<a class="btn btn-danger" href="deletecliente.jsp?id=${cliente.getId_cliente()}">Excluir</a>
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