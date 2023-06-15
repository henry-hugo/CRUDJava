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
<%
int idCliente = Integer.parseInt(request.getParameter("id"));
Cliente cliente = new Cliente();
cliente.setId_cliente(idCliente);
ClienteDao.deletarCliente(cliente);

	response.sendRedirect("viewclientes.jsp");
%>
<%}else{ %><jsp:include page="../index.jsp"></jsp:include>
<%} %>