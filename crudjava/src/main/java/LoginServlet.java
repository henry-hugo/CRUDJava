import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crudjava.bean.Usuario;
import com.crudjava.dao.UsuarioDao;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // Recupera os valores dos campos de entrada do formulário
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");
	    
	    // Verifica se as credenciais de login são válidas
	    Usuario usuario = UsuarioDao.verificarCredenciais(request, username, password);
	    if (usuario != null) {
	        HttpSession session = request.getSession();
	        session.setAttribute("usuario", usuario);
	        response.sendRedirect("index.jsp");
	    } else {
	        request.setAttribute("errorMessage", "Nome de usuário ou senha inválidos.");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
	        dispatcher.forward(request, response);
	    }
	}

}