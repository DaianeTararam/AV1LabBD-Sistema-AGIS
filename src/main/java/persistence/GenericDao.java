package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GenericDao {
	private Connection conexao;
	
	public Connection getConnection() throws ClassNotFoundException, SQLException{
		String hostName = "localhost";
		String dbName = "db_agis";
		String user = "agis_user";
		String senha = "Agis@2026";
		
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		
		conexao = DriverManager.getConnection(String.format(
				"jdbc:jtds:sqlserver://%s:1433/%s;user=%s;password=%s;", 
				hostName,dbName, user, senha));
		return conexao;		
	}
}