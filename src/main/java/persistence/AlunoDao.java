package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.Aluno;
import model.Curso;
import model.Telefone;

public class AlunoDao implements ICrud<Aluno>{
	private GenericDao gDao;
	
	public AlunoDao(GenericDao gDao) {
		this.gDao = gDao;
	}
	
	@Override
	public Aluno buscar(Aluno aluno) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT a.ra, u.cpf, u.nome, u.nome_social, CONVERT(CHAR(10), u.data_nascimento, 103) as dataNasc, "
				   + "u.email_pessoal, u.email_corporativo, a.data_conclusao, CONVERT(CHAR(5), a.pontuacao_vestibular) AS pontuacao, "
				   + "c.codigo_curso, c.nome_curso, c.sigla_curso FROM "
				   + "aluno a "
				   + "INNER JOIN usuario u ON a.usuario_cpf = u.cpf "
				   + "INNER JOIN curso c ON a.curso_codigo = c.codigo_curso "
				   + "WHERE a.ra = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, aluno.getRa());
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			aluno.setRa(rs.getString("ra"));
			aluno.setCpf(rs.getString("cpf"));
			aluno.setNome(rs.getString("nome"));
			aluno.setNomeSocial(rs.getString("nome_social"));
			aluno.setDataNascimento(LocalDate.parse(rs.getString("data_nascimento")));
			aluno.setEmailPessoal(rs.getString("email_pessoal"));
			aluno.setEmailCorporativo(rs.getString("email_corporativo"));
			aluno.setDataConclusao(LocalDate.parse(rs.getString("data_conclusao")));

			aluno.setPontuacaoVestibular(rs.getBigDecimal("pontuacao_vestibular"));
			Curso curso = new Curso();
			curso.setCodigoCurso(rs.getInt("codigo_curso"));
			aluno.setCurso(curso);
		}
		return aluno;
	}

	@Override
	public List<Aluno> listar() throws SQLException, ClassNotFoundException {
		List<Aluno> alunos = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT a.ra, u.cpf, u.nome, u.nome_social, a.data_conclusao " +
                	 "FROM aluno a INNER JOIN usuario u " +
                	 "ON a.usuario_cpf = u.cpf";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Aluno aluno = new Aluno();
			aluno.setRa(rs.getString("ra"));
	        aluno.setCpf(rs.getString("cpf"));
	        aluno.setNome(rs.getString("nome"));
	        aluno.setNomeSocial(rs.getString("nome_social"));
	        aluno.setDataConclusao(LocalDate.parse(rs.getString("data_conclusao")));
	        alunos.add(aluno);
		}
		rs.close();
		ps.close();
		c.close();
		return alunos;
	}

	@Override
	public String inserir(Aluno aluno) throws SQLException, ClassNotFoundException {
		 Connection c = gDao.getConnection();
		 String sql = "{CALL sp_aluno(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
		 CallableStatement cs = c.prepareCall(sql);
		 cs.setString(1, "I");
		 cs.setString(2, aluno.getCpf());
		 cs.setString(3, aluno.getNome());
		 cs.setString(4, aluno.getNomeSocial());
		 cs.setString(5, aluno.getDataNascimento().toString());
		 cs.setString(6, aluno.getEmailPessoal());
		 cs.setString(7, aluno.getEmailCorporativo());
		 cs.setNull(8, Types.DATE);
		 cs.setBigDecimal(9, aluno.getPontuacaoVestibular());
		 cs.setInt(10, aluno.getCurso().getCodigoCurso());

		 Telefone tel = aluno.getTelefones().get(0);
		 cs.setInt(11, tel.getDdd());
		 cs.setInt(12, tel.getNumTelefone());
		 
		 for (int i = 1; i < aluno.getTelefones().size(); i++) {
			    Telefone telNovo = aluno.getTelefones().get(i);
			    inserirTelefone(c, telNovo, aluno.getCpf());
		 }
		 cs.registerOutParameter(13, Types.VARCHAR);
		 
		 cs.execute();
		 String saida = cs.getString(13);
		 
		 cs.close();
		 c.close();
		 return saida;
	}
	
	public void inserirTelefone(Connection c, Telefone tel, String cpf) throws SQLException, ClassNotFoundException {
	    String sql = "INSERT INTO telefone (ddd, num, usuario_cpf) VALUES (?, ?, ?)";
	    PreparedStatement ps = c.prepareStatement(sql);
	    ps.setInt(1, tel.getDdd());
	    ps.setInt(2, tel.getNumTelefone());
	    ps.setString(3, cpf); 
	    ps.executeUpdate();
	    ps.close();
	}


	@Override
	public String atualizar(Aluno aluno) throws SQLException, ClassNotFoundException {
		 Connection c = gDao.getConnection();
		 String sql = "{CALL sp_aluno(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
		 CallableStatement cs = c.prepareCall(sql);
		 cs.setString(1, "U");
		 cs.setString(2, aluno.getCpf());
		 cs.setString(3, aluno.getNome());
		 cs.setString(4, aluno.getNomeSocial());
		 cs.setString(5, aluno.getDataNascimento().toString());
		 cs.setString(6, aluno.getEmailPessoal());
		 cs.setString(7, aluno.getEmailCorporativo());
		 cs.setNull(8, Types.DATE);
		 cs.setBigDecimal(9, aluno.getPontuacaoVestibular());
		 cs.setInt(10, aluno.getCurso().getCodigoCurso());

		 Telefone tel = aluno.getTelefones().get(0);
		 cs.setInt(11, tel.getDdd());
		 cs.setInt(12, tel.getNumTelefone());

		 cs.registerOutParameter(13, Types.VARCHAR);
		 
		 cs.execute();
		 String saida = cs.getString(13);
		 
		 cs.close();
		 c.close();
		 return saida;
	}

	@Override
	public String deletar(Aluno aluno) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		 String sql = "{CALL sp_aluno(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
		 CallableStatement cs = c.prepareCall(sql);
		 cs.setString(1, "D");
		 cs.setString(2, aluno.getRa());
		 cs.setNull(3, Types.VARCHAR);
		 cs.setNull(4, Types.VARCHAR);
		 cs.setNull(5, Types.VARCHAR);
		 cs.setNull(6, Types.VARCHAR);
		 cs.setNull(7, Types.VARCHAR);
		 cs.setNull(8, Types.VARCHAR);
		 cs.setNull(9, Types.VARCHAR);
		 cs.setNull(10, Types.VARCHAR);
		 cs.setNull(11, Types.VARCHAR);
		 cs.setNull(12, Types.VARCHAR);
		 
		 cs.registerOutParameter(13, Types.VARCHAR);
		 
		 cs.execute();
		 String saida = cs.getString(13);
		 
		 cs.close();
		 c.close();
		 return saida;
	}

}
