package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Curso;

public class CursoDao implements ICrud<Curso> {
    private GenericDao gDao;

    public CursoDao(GenericDao gDao) {
        this.gDao = gDao;
    }

    @Override
    public List<Curso> listar() throws SQLException, ClassNotFoundException {
        List<Curso> cursos = new ArrayList<>();
        Connection c = gDao.getConnection();

        String sql = "SELECT codigo_curso, nome_curso, sigla_curso FROM curso";
        
        PreparedStatement ps = c.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            Curso curso = new Curso();
            curso.setCodigoCurso(rs.getInt("codigo_curso"));
            curso.setNomeCurso(rs.getString("nome_curso"));
            curso.setSiglaCurso(rs.getString("sigla_curso"));
            cursos.add(curso);
        }
        
        rs.close();
        ps.close();
        c.close();
        return cursos;
    }

    @Override public Curso buscar(Curso c) throws SQLException, ClassNotFoundException { 
    	return null; 
    }
    
    @Override public String inserir(Curso c) throws SQLException, ClassNotFoundException { 
    	return null; 
    }
    @Override public String atualizar(Curso c) throws SQLException, ClassNotFoundException { 
    	return null; 
    }
    @Override public String deletar(Curso c) throws SQLException, ClassNotFoundException { 
    	return null; 
    }
}