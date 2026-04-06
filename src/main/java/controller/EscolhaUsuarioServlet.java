package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/EscolhaUsuario")
public class EscolhaUsuarioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EscolhaUsuarioServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipoUsuario = request.getParameter("tipoUsuario");
        
        if("funcionarioSecretaria".equalsIgnoreCase(tipoUsuario)) {
            response.sendRedirect("funcionariosecretaria.jsp");
        } else if("professor".equalsIgnoreCase(tipoUsuario)) {
            response.sendRedirect("professor.jsp");        
        } else if("Matricula".equalsIgnoreCase(tipoUsuario)) { // <--- Mudança aqui
            response.sendRedirect("matricula.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }
    }

}
