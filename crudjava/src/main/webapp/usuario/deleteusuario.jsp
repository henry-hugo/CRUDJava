<%@ page import="com.crudjava.dao.UsuarioDao, com.crudjava.bean.*, java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
HttpSession logout = request.getSession();
Usuario username = (Usuario) request.getSession().getAttribute("usuario");;
if(username == null){
	response.sendRedirect("../login.jsp");
}else if(username.getNivel() == 1){
%>
<%@page import="com.crudjava.dao.UsuarioDao" %>
<jsp:useBean id="u" class="com.crudjava.bean.Usuario"></jsp:useBean>
<jsp:setProperty property="*" name="u"/>

<%
	UsuarioDao.deletarUsuario(u);
	response.sendRedirect("viewusuarios.jsp");
%>
<%}else{ %><jsp:include page="../index.jsp"></jsp:include>
<%} %>