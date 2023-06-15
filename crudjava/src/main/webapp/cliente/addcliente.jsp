<%@page import="com.crudjava.dao.UsuarioDao" %>
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
<jsp:useBean id="c" class="com.crudjava.bean.Cliente"></jsp:useBean>
<jsp:setProperty property="*" name="c"/>

<%
	int i = ClienteDao.salvarCliente(c);

	if(i > 0){
		String mensagemErro = "Cliente salvo com sucesso";
		 response.sendRedirect("viewclientes.jsp");
	}else{
		String mensagemErro = "Não foi possível salvar o cliente";
		response.sendRedirect("cadastrarCliente.jsp");
	}
%>

<%}else{ %><jsp:include page="../index.jsp"></jsp:include>
<%} %>%>