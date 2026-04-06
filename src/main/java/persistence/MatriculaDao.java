package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Aluno;
import model.Curso;
import model.Matricula;

public class MatriculaDao implements ICrud<Matricula> {
	private GenericDao gDao;
	
	public MatriculaDao(GenericDao gDao) {
		this.gDao = gDao;
	}
	
	@Override
	public Matricula buscar(Matricula matricula) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT m.id_matricula, m.ano_ingresso, m.semestre, m.ano_limite_graduacao, m.turno, "
				   + "m.aluno_ra, m.codigo_curso FROM "
				   + "matricula m "
				   + "INNER JOIN aluno a ON a.ra = m.aluno_ra "
				   + "WHERE m.id_matricula= ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, matricula.getIdMatricula());
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			matricula.setAnoIngresso(rs.getInt("ano_ingresso"));
			matricula.setSemestre(rs.getInt("semestre"));
			matricula.setAnoLimiteGraduacao(rs.getInt("ano_limite_graduacao"));
			matricula.setTurno(rs.getString("turno"));
			
			Aluno aluno = new Aluno();
			aluno.setRa(rs.getString("aluno_ra"));
			matricula.setAluno(aluno);

			Curso curso = new Curso();
			curso.setCodigoCurso(rs.getInt("codigo_curso"));
			matricula.setCurso(curso);
		}
		rs.close();
		ps.close();
		c.close();
		return matricula;
	}

	@Override
	public List<Matricula> listar() throws SQLException, ClassNotFoundException {
		List<Matricula> matriculas = new ArrayList<>();
	    Connection c = gDao.getConnection();
	    String sql = "SELECT * FROM matricula";
	    PreparedStatement ps = c.prepareStatement(sql);
	    ResultSet rs = ps.executeQuery();

	    while (rs.next()) {
	        Matricula m = new Matricula();
	        m.setIdMatricula(rs.getInt("id_matricula"));
	        m.setAnoIngresso(rs.getInt("ano_ingresso"));
	        m.setSemestre(rs.getInt("semestre"));
	        m.setAnoLimiteGraduacao(rs.getInt("ano_limite_graduacao"));
	        m.setTurno(rs.getString("turno"));

	        Aluno a = new Aluno();
	        a.setRa(rs.getString("aluno_ra"));
	        m.setAluno(a);

	        Curso curso = new Curso();
	        curso.setCodigoCurso(rs.getInt("codigo_curso"));
	        m.setCurso(curso);

	        matriculas.add(m);
	    }

	    rs.close();
	    ps.close();
	    c.close();
	    return matriculas;
	}

	@Override
    public String inserir(Matricula matricula) throws SQLException, ClassNotFoundException {
        Connection c = gDao.getConnection();
        // Usando a procedure para validar as regras de negócio
        String sql = "{CALL sp_matricula(?, ?, ?)}";
        CallableStatement cs = c.prepareCall(sql);
        
        cs.setString(1, matricula.getAluno().getRa());
        // Pegando a disciplina da lista que você tem no Model
        cs.setInt(2, matricula.getDisciplinas().get(0).getCodigoDisciplina());
        cs.registerOutParameter(3, Types.VARCHAR);

        cs.execute();
        String saida = cs.getString(3);

        cs.close();
        c.close();
        return saida;
    }

	@Override
	public String atualizar(Matricula matricula) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
	    String sql = "UPDATE matricula SET turno = ?, semestre = ? WHERE id_matricula = ?";
	    PreparedStatement ps = c.prepareStatement(sql);
	    ps.setString(1, matricula.getTurno());
	    ps.setInt(2, matricula.getSemestre());
	    ps.setInt(3, matricula.getIdMatricula());

	    ps.executeUpdate();
	    ps.close();
	    c.close();
	    return "Matrícula atualizada com sucesso!";
	}

	@Override
	public String deletar(Matricula matricula) throws SQLException, ClassNotFoundException {
		return "Não é possível remover matrícula já realizada!";
	}
}