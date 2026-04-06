package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Disciplina;

public class DisciplinaDao implements ICrud<Disciplina> {
	private GenericDao gDao;
	
	public DisciplinaDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Disciplina buscar(Disciplina disciplina) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
        String sql = "SELECT codigoDisciplina, nomeDisciplina, qtdeHorasSemanais FROM disciplina WHERE codigoDisciplina = ?";
        PreparedStatement ps = c.prepareStatement(sql);
        ps.setInt(1, disciplina.getCodigoDisciplina());
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            disciplina.setNomeDisciplina(rs.getString("nomeDisciplina"));
            disciplina.setQtdeHorasSemanais(rs.getInt("qtdeHorasSemanais"));
        }
        rs.close();
        ps.close();
        c.close();
        return disciplina;
	}

	@Override
	public List<Disciplina> listar() throws SQLException, ClassNotFoundException {
		List<Disciplina> disciplinas = new ArrayList<>();
	    Connection c = gDao.getConnection();
	    String sql = "SELECT codigo_disciplina, nome_disciplina, qtde_horas_semanais FROM disciplina";
	    PreparedStatement ps = c.prepareStatement(sql);
	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
	        Disciplina d = new Disciplina();
	        d.setCodigoDisciplina(rs.getInt("codigo_disciplina"));
	        d.setNomeDisciplina(rs.getString("nome_disciplina"));
	        d.setQtdeHorasSemanais(rs.getInt("qtde_horas_semanais"));
	        disciplinas.add(d);
	    }
	    rs.close();
	    ps.close();
	    c.close();
	    return disciplinas;
	}

	@Override
	public String inserir(Disciplina t) throws SQLException, ClassNotFoundException {
		return null;
	}

	@Override
	public String atualizar(Disciplina t) throws SQLException, ClassNotFoundException {
		return null;
	}

	@Override
	public String deletar(Disciplina t) throws SQLException, ClassNotFoundException {
		return null;
	}

}
