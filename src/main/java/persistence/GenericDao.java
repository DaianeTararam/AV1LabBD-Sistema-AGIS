package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GenericDao {
	private Connection conexao;
	
	public Connection getConnection() throws ClassNotFoundException, SQLException{
		String hostName = "localhost";
		String dbName = "java_web_procedures";
		String user = "daiane";
		String senha = "123456";
		
		Class.forName("net.source.jtds.jdbc.Driver");
		
		conexao = DriverManager.getConnection(String.format(
				"jdbc:jtds:sqlserver://%s:1433;"
				+ "databaseName=%s;user=%s;password=%s;", 
				hostName, dbName, user, senha));
		return conexao;		
	}
}