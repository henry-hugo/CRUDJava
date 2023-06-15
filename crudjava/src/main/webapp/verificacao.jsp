<%
	HttpSession logout = request.getSession();
	String username = (String) logout.getAttribute("username");
	if(username == null){
		response.reset();
		response.sendRedirect("/login.jsp");
	}
%>