<%@ page import="com.crudjava.dao.UsuarioDao, com.crudjava.bean.*, java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
HttpSession logout = request.getSession();
Usuario username = (Usuario) request.getSession().getAttribute("usuario");
if (username == null) {
    response.sendRedirect("../login.jsp");
} else if (username.getNivel() == 1) {
    %>
    <%@ page import="java.net.URLEncoder" %>
    <%@ page import="java.nio.charset.StandardCharsets" %>
    <%
    // Obtenha os parâmetros do formulário
    String nome = request.getParameter("nome");
    String senha = request.getParameter("senha");
    String email = request.getParameter("email");

    // Verifique se os campos estão preenchidos corretamente
    String regexEspacoEmBranco = "\\s";
    java.util.regex.Pattern patternEspacoEmBranco = java.util.regex.Pattern.compile(regexEspacoEmBranco);
    java.util.regex.Matcher matcherNome = patternEspacoEmBranco.matcher(nome);
    java.util.regex.Matcher matcherSenha = patternEspacoEmBranco.matcher(senha);
    java.util.regex.Matcher matcherEmail = patternEspacoEmBranco.matcher(email);

    if (nome.isEmpty() || senha.isEmpty() || email.isEmpty() || matcherNome.find() || matcherSenha.find() || matcherEmail.find()) {
        String mensagemErro = "Os campos devem ser preenchidos corretamente.";
        response.sendRedirect("cadastrarUsuario.jsp?mensagemErro=" + URLEncoder.encode(mensagemErro, StandardCharsets.UTF_8.toString()));
    } else if (senha.length() > 10) {
        String mensagemErro = "A senha deve ter no máximo 10 caracteres.";
        response.sendRedirect("cadastrarUsuario.jsp?mensagemErro=" + URLEncoder.encode(mensagemErro, StandardCharsets.UTF_8.toString()));
    } else {
        // Crie o objeto Usuario
        Usuario u = new Usuario();
        u.setNome(nome);
        u.setSenha(senha);
        u.setEmail(email);

        try {
            int i = UsuarioDao.salvarUsuario(u);

            if (i > 0) {
                String mensagemErro = "Usuário salvo com sucesso";
                response.sendRedirect("viewusuarios.jsp");
            } else {
                String mensagemErro = "Não foi possível salvar o usuário";
                response.sendRedirect("cadastrarUsuario.jsp?mensagemErro=" + URLEncoder.encode(mensagemErro, StandardCharsets.UTF_8.toString()));
            }
        } catch (Exception e) {
            String mensagemErro = "Ocorreu um erro ao salvar o usuário.";
            response.sendRedirect("cadastrarUsuario.jsp?mensagemErro=" + URLEncoder.encode(mensagemErro, StandardCharsets.UTF_8.toString()));
        }
    }
%>

<% } else { %>
    <jsp:include page="../index.jsp"></jsp:include>
<% } %>
