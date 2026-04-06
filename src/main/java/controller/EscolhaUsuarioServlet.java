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
        if (tipoUsuario == null || tipoUsuario.isEmpty()) {
            response.sendRedirect("index.jsp");
            return; 
        }

        if ("funcionariosecretaria".equalsIgnoreCase(tipoUsuario)) {
            request.getRequestDispatcher("funcionarioSecretaria").forward(request, response);
            return;
        } 
        
        else if ("aluno".equalsIgnoreCase(tipoUsuario)) {
            request.getRequestDispatcher("matricula").forward(request, response);
            return;
        } 
        
        else if ("professor".equalsIgnoreCase(tipoUsuario)) {
            request.getRequestDispatcher("professor.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("index.jsp");
    }

}
