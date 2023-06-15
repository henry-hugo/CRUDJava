<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.crudjava.dao.UsuarioDao, com.crudjava.bean.*, java.util.*"%>
<%@ page import="com.crudjava.dao.ClienteDao, com.crudjava.bean.*, java.util.*"%>
<%@ page import="com.crudjava.dao.ChamadaDao, com.crudjava.bean.*, java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>liga��o</title>
  <script>
    function finalizarChamada() {
      // Obt�m a data e hora atual
      var dataHoraAtual = new Date();
      
      // Converte a data e hora para o formato desejado (opcional)
      var dataHoraFormatada = dataHoraAtual.toLocaleString('pt-BR', {timeZone: 'UTC'});

      // Define o valor do campo hidden "dataHoraFinalizacao" no formul�rio
      document.getElementById("dataHoraFinalizacao").value = dataHoraFormatada;
      
      // Envia o formul�rio para o servidor
      document.getElementById("formChamada").submit();
    }
  </script>
</head>
<%
HttpSession logout = request.getSession();
Usuario username = (Usuario) request.getSession().getAttribute("usuario");;
if(username == null){
	response.sendRedirect("../login.jsp");
}else if(username.getNivel() == 0){
%>
<%
	// Obt�m o objeto Usuario da sess�o
	Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
	
	// Exibe as informa��es do usu�rio em HTML
	%>
	<%
		String idCliente = request.getParameter("id");
	  // Obt�m a data e hora atual
	  Date dataAtual = new Date();
	
	  // Formata a data e hora atual no formato desejado
	  SimpleDateFormat formatoDataHora = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	  String dataHoraFormatada = formatoDataHora.format(dataAtual);
	%>
<body>
	<section class="container">
  <h1>Chamada em andamento</h1>
  <form id="formChamada" action="finalizarChamada.jsp" method="post">
    <input type="hidden" value="<%= idCliente %>" name="idCliente">
    <input type="hidden" value="<%= usuario.getId() %>" name="idFuncionario">
    <input type="hidden" name="dataHoraInicio" value="<%= dataHoraFormatada %>">
    <input type="hidden" name="dataHoraFinalizacao" id="dataHoraFinalizacao" value="">
    <input type="hidden" name="dataHoraFinalizacaoStr" id="dataHoraFinalizacaoStr" value="">

    <select class="form-control" name="resultado">
      <option value="desligou">Desligou</option>
      <option value="atendeu">Atendeu</option>
    </select>
    <button type="button" class="btn btn-primary" onclick="finalizarChamada()">Finalizar chamada</button>
  </form>
</section>
	

</body>
</html>
<%}else{ %><jsp:include page="../index.jsp"></jsp:include>
<%} %>