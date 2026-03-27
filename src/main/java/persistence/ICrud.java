package persistence;

import java.sql.SQLException;
import java.util.List;

public interface ICrud<T> {
	public T buscar(T t) throws SQLException, ClassNotFoundException;
	public List<T> listar() throws SQLException, ClassNotFoundException;
	public String inserir(T t) throws SQLException, ClassNotFoundException;
	public String atualizar(T t) throws SQLException, ClassNotFoundException;
	public String deletar(T t) throws SQLException, ClassNotFoundException;
}
