package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Aluno;
import model.Disciplina;
import model.Matricula;
import persistence.GenericDao;
import persistence.MatriculaDao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/matricula")
public class MatriculaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MatriculaServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("matricula.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String saida = "";
        String erro = "";
        List<Matricula> matriculas = new ArrayList<>();
        Matricula matricula = new Matricula();

        String comando = request.getParameter("botao");

        try {
            GenericDao gDao = new GenericDao();
            MatriculaDao mDao = new MatriculaDao(gDao);

            String ra = request.getParameter("aluno_ra");
            String codigoDiscipStr = request.getParameter("codigo_disciplina");

            Aluno aluno = new Aluno();
            aluno.setRa(ra);
            matricula.setAluno(aluno);

            if (comando.equalsIgnoreCase("Matricular")) {

                Disciplina d = new Disciplina();
                d.setCodigoDisciplina(Integer.parseInt(codigoDiscipStr));
                matricula.getDisciplinas().add(d); 

                saida = mDao.inserir(matricula);
            } 
            else if (comando.equalsIgnoreCase("Listar")) {
                matriculas = mDao.listar();
            }
            else if (comando.equalsIgnoreCase("Buscar")) {
                matricula.setIdMatricula(Integer.parseInt(request.getParameter("id_matricula")));
                matricula = mDao.buscar(matricula);
            }

        } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
            erro = e.getMessage();
            if (e instanceof NumberFormatException) {
                erro = "Por favor, preencha os campos numéricos corretamente.";
            }
        } finally {
            if (!"Buscar".equalsIgnoreCase(comando)) {
                matricula = null;
            }
            if (!"Listar".equalsIgnoreCase(comando)) {
                matriculas = null;
            }
        }

        request.setAttribute("saida", saida);
        request.setAttribute("erro", erro);
        request.setAttribute("matricula", matricula);
        request.setAttribute("matriculas", matriculas);
        request.getRequestDispatcher("matricula.jsp").forward(request, response);
    }
}