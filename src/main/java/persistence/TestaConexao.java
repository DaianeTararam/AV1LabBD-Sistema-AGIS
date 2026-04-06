package persistence;

import java.sql.Connection;

public class TestaConexao {
    public static void main(String[] args) {
        try {
            GenericDao gDao = new GenericDao();
            Connection c = gDao.getConnection();
            if (c != null) {
                System.out.println("Conexão estabelecida com sucesso!");
                c.close();
            } else {
                System.out.println("Falha na conexão.");
            }
        } catch (Exception e) {
            System.out.println("Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

