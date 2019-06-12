import java.sql.Connection;
import java.sql.DriverManager;

public class ConexaoJDBC {
	
	private static String driver = "org.postgresql.Driver";

	private static String usuarioBD = "xsjnboip"; // Alterar (User do Elephant)
	private static String senhaBD = "atDeRCqgAqy_C01s1qEnEZ8YkwUFA8cy"; // Alterar (Senha do Elephant)
	 
	public static Connection criarConexao() {
		final String urlConexao = "jdbc:postgresql://raja.db.elephantsql.com:5432/"  + usuarioBD;
	    Connection conexao = null;

		try {	 
		  	Class.forName(driver);
		  	conexao = DriverManager.getConnection(urlConexao, usuarioBD, senhaBD);
		  	
		  	conexao.setAutoCommit(false);
		 	 
		  	System.out.println("Conexao com o banco aberta com sucesso!!!");
		} catch (Exception e) {
		  	System.err.println(e.getClass().getName() + ": " + e.getMessage());
		  	System.exit(0);
		}
		return conexao;    
	 }

}
