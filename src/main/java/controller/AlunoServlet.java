package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Aluno;
import model.Curso;
import model.Telefone;
import persistence.AlunoDao;
import persistence.CursoDao;
import persistence.GenericDao;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/funcionarioSecretaria")
public class AlunoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AlunoServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String saida = "";
        String erro = "";
        List<Aluno> alunos = new ArrayList<>();
        Aluno aluno = new Aluno();
        String comando = request.getParameter("botao");

        try {
            String ra = request.getParameter("ra");
            if (ra != null && !ra.isEmpty() && !comando.equalsIgnoreCase("Listar")) {
                aluno.setRa(ra);
            }

            if (comando.equalsIgnoreCase("Cadastrar") || comando.equalsIgnoreCase("Atualizar")) {
                aluno.setCpf(request.getParameter("cpf"));
                aluno.setNome(request.getParameter("nome"));
                aluno.setNomeSocial(request.getParameter("nome_social"));

                String dataNasc = request.getParameter("data_nascimento");
                if (dataNasc != null && !dataNasc.isEmpty()) {
                    aluno.setDataNascimento(LocalDate.parse(dataNasc));
                }

                aluno.setEmailPessoal(request.getParameter("email_pessoal"));
                aluno.setEmailCorporativo(request.getParameter("email_corporativo"));

                String pontuacaoStr = request.getParameter("pontuacao_vestibular");
                if (pontuacaoStr != null && !pontuacaoStr.isEmpty()) {
                    aluno.setPontuacaoVestibular(new BigDecimal(pontuacaoStr.replace(",", ".")));
                }

                String ddd = request.getParameter("ddd");
                String num = request.getParameter("num");
                if (ddd != null && !ddd.isEmpty() && num != null && !num.isEmpty()) {
                    Telefone tel = new Telefone(Integer.parseInt(ddd), Integer.parseInt(num));
                    aluno.getTelefones().add(tel);
                }

                String cursoCod = request.getParameter("curso");
                if (cursoCod != null && !cursoCod.isEmpty()) {
                    Curso c = new Curso();
                    c.setCodigoCurso(Integer.parseInt(cursoCod));
                    aluno.setCurso(c);
                }
            }

            GenericDao gDao = new GenericDao();
            AlunoDao aDao = new AlunoDao(gDao);

            if (comando.equalsIgnoreCase("Cadastrar")) {
                saida = aDao.inserir(aluno);
            }
            if (comando.equalsIgnoreCase("Atualizar")) {
                saida = aDao.atualizar(aluno);
            }
            if (comando.equalsIgnoreCase("Excluir")) {
                saida = aDao.deletar(aluno);
            }
            if (comando.equalsIgnoreCase("Buscar")) {
                aluno = aDao.buscar(aluno);
            }
            if (comando.equalsIgnoreCase("Listar")) {
                alunos = aDao.listar();
            }

        } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
            saida = "";
            erro = e.getMessage();
            if (erro.contains("input string")) {
                erro = "Preencha os campos corretamente";
            }
        } finally {
            if (!comando.equalsIgnoreCase("Buscar")) {
                aluno = null;
            }
            if (!comando.equalsIgnoreCase("Listar")) {
                alunos = null;
            }

            request.setAttribute("saida", saida);
            request.setAttribute("erro", erro);
            request.setAttribute("aluno", aluno);
            request.setAttribute("alunos", alunos);

            try {
                CursoDao cDao = new CursoDao(new GenericDao());
                request.setAttribute("cursos", cDao.listar());
            } catch (Exception e) {
                System.err.println("Erro ao carregar cursos: " + e.getMessage());
            }

            request.getRequestDispatcher("funcionariosecretaria.jsp").forward(request, response);
        }
    }
}
