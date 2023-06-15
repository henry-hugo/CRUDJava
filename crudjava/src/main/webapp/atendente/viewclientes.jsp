<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.crudjava.dao.UsuarioDao, com.crudjava.bean.*, java.util.*"%>
<%@ page import="com.crudjava.dao.ClienteDao, com.crudjava.bean.*, java.util.*"%>
<%@ page import="com.crudjava.dao.ChamadaDao, com.crudjava.bean.*, java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<title>Ligações</title>
</head>
<%
HttpSession logout = request.getSession();
Usuario username = (Usuario) request.getSession().getAttribute("usuario");;
if(username == null){
	response.sendRedirect("../login.jsp");
}else if(username.getNivel() == 0){
%>
	<%
	// Obtém o objeto Usuario da sessão
	Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
	
	// Exibe as informações do usuário em HTML
	%>
<body>
	<header class="container">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<ul  class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link" href="index.jsp">HOME</a>
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
		<%
			List<Cliente> list = ChamadaDao.listarClientesSemChamada();
			request.setAttribute("list", list);
		%>
	<main>
		<section class="container">
		<%
			String mensagem = (String) request.getSession().getAttribute("mensagem");
			if (mensagem != null) {
			    out.println("<p>" + mensagem + "</p>");
			    // Remova a mensagem da sessão para que não seja exibida novamente após o refresh
			    request.getSession().removeAttribute("mensagem");
			}
		%>
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
					Ligar
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
						<a class="btn btn-primary" href="atendente/ligar.jsp?id=${cliente.getId_cliente()}">Ligar</a>
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