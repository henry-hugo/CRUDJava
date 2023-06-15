<%@ page import="com.crudjava.dao.ChamadaDao, com.crudjava.bean.*, java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%
HttpSession logout = request.getSession();
Usuario username = (Usuario) request.getSession().getAttribute("usuario");;
if(username == null){
	response.sendRedirect("../login.jsp");
}else if(username.getNivel() == 0){
%>

<%
String dataHoraInicioStr = request.getParameter("dataHoraInicio");
String dataHoraFinalizacaoStr = request.getParameter("dataHoraFinalizacao");
dataHoraFinalizacaoStr = dataHoraFinalizacaoStr.replace(",", "");
String idClienteStr = request.getParameter("idCliente");
String idFuncionarioStr = request.getParameter("idFuncionario");
String resultado = request.getParameter("resultado");

// Converta a dataHoraInicio para o tipo Date
SimpleDateFormat formatoDataHora = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
Date dataHoraInicio = formatoDataHora.parse(dataHoraInicioStr);
Date dataHoraFinalizacao = formatoDataHora.parse(dataHoraFinalizacaoStr);

//Crie um objeto Chamada com os valores do formulário
Chamada chamada = new Chamada();
chamada.setData_hora_inicio(dataHoraInicio);
chamada.setData_hora_final(dataHoraFinalizacao);
chamada.setId_cliente(Integer.parseInt(idClienteStr));
chamada.setId_usuario(Integer.parseInt(idFuncionarioStr));
chamada.setResultado(resultado);

// Salve a chamada usando o ChamadaDao
int status = ChamadaDao.salvarChamada(chamada);

if (status > 0) {
    // A chamada foi salva com sucesso
    // Armazene uma mensagem de sucesso na sessão
    request.getSession().setAttribute("mensagem", "Chamada salva com sucesso.");
} else {
    // Ocorreu um erro ao salvar a chamada
    // Armazene uma mensagem de erro na sessão
    request.getSession().setAttribute("mensagem", "Erro ao salvar a chamada.");
}

// Redirecione de volta para a página inicial
response.sendRedirect("../index.jsp");
%>
<%}else{ %><jsp:include page="../index.jsp"></jsp:include>
<%} %>
