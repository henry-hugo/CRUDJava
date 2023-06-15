<%@ page import="com.crudjava.dao.UsuarioDao, com.crudjava.bean.*, java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
HttpSession logout = request.getSession();
Usuario username = (Usuario) request.getSession().getAttribute("usuario");;
if(username == null){
	response.sendRedirect("../login.jsp");
}else if(username.getNivel() == 1){
%>
<%@page import="com.crudjava.dao.ClienteDao" %>
<jsp:useBean id="c" class="com.crudjava.bean.Cliente"></jsp:useBean>
<jsp:setProperty property="*" name="c"/>
<%
	int i = ClienteDao.updateCliente(c);
	response.sendRedirect("viewclientes.jsp");
%>

<%}else{ %><jsp:include page="../index.jsp"></jsp:include>
<%} %>