package com.crudjava.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import com.crudjava.bean.Chamada;
import com.crudjava.bean.Cliente;
import com.mysql.jdbc.PreparedStatement;

public class ChamadaDao {
	public static List<Chamada> getAllChamada() {
	    List<Chamada> list = new ArrayList<Chamada>();

	    try {
	        Connection con = ConnectionDao.getConnection();
	        PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT c.id_chamada, c.id_cliente, c.id_usuario, c.data_hora_inicio, c.data_hora_final, c.resultado, u.nome AS nome_usuario, GROUP_CONCAT(cl.nome SEPARATOR ', ') AS nome_cliente FROM chamada c INNER JOIN usuario u ON c.id_usuario = u.id INNER JOIN cliente cl ON c.id_cliente = cl.id_cliente GROUP BY c.id_usuario");
	        ResultSet rs = ps.executeQuery();

	        Map<String, Chamada> chamadasPorUsuario = new HashMap<String, Chamada>();

	        while (rs.next()) {
	            String nomeUsuario = rs.getString("nome_usuario");
	            Chamada chamada = chamadasPorUsuario.get(nomeUsuario);

	            if (chamada == null) {
	                chamada = new Chamada();
	                chamada.setId_usuario(rs.getInt("id_usuario"));
	                chamada.setNome_usuario(nomeUsuario);
	                chamada.setNome_cliente(rs.getString("nome_cliente"));
	                chamadasPorUsuario.put(nomeUsuario, chamada);
	            } else {
	                chamada.setNome_cliente(chamada.getNome_cliente() + ", " + rs.getString("nome_cliente"));
	            }

	            chamada.setId_chamada(rs.getInt("id_chamada"));
	            chamada.setId_cliente(rs.getInt("id_cliente"));
	            chamada.setData_hora_inicio(rs.getDate("data_hora_inicio"));
	            chamada.setData_hora_final(rs.getDate("data_hora_final"));
	            chamada.setResultado(rs.getString("resultado"));
	        }

	        list.addAll(chamadasPorUsuario.values());
	    } catch (Exception e) {
	        System.out.println(e);
	    }

	    return list;
	}
	public static List<Chamada> historico(int idUsuario) {
	    List<Chamada> list = new ArrayList<Chamada>();
	    try {
	        Connection con = ConnectionDao.getConnection();
	        PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT c.*, u.nome AS nome_usuario, cl.nome AS nome_cliente FROM chamada c INNER JOIN usuario u ON c.id_usuario = u.id INNER JOIN cliente cl ON c.id_cliente = cl.id_cliente WHERE c.id_usuario = ?");
	        ps.setInt(1, idUsuario);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            Chamada chamada = new Chamada();
	            chamada.setId_chamada(rs.getInt("id_chamada"));
	            chamada.setId_cliente(rs.getInt("id_cliente"));
	            chamada.setId_usuario(rs.getInt("id_usuario"));
	            chamada.setData_hora_inicio(rs.getTimestamp("data_hora_inicio"));
	            chamada.setData_hora_final(rs.getTimestamp("data_hora_final"));
	            chamada.setResultado(rs.getString("resultado"));
	            chamada.setNome_usuario(rs.getString("nome_usuario"));
	            chamada.setNome_cliente(rs.getString("nome_cliente"));

	            list.add(chamada);
	        }
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    return list;
	}
	public static List<Cliente> listarClientesSemChamada() {
	    List<Cliente> list = new ArrayList<Cliente>();
	    
	    try {
	        Connection con = ConnectionDao.getConnection();
	        PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT * FROM cliente WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente FROM chamada)");
	        ResultSet rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            Cliente cliente = new Cliente();
	            cliente.setId_cliente(rs.getInt("id_cliente"));
	            cliente.setNome(rs.getString("nome"));
	            cliente.setSobrenome(rs.getString("sobrenome"));
	        	cliente.setEmail(rs.getString("email"));
	        	cliente.setTelefone(rs.getString("telefone"));
	        	cliente.setEndereco(rs.getString("endereco"));
	        	cliente.setCidade(rs.getString("cidade"));
	        	cliente.setEstado(rs.getString("estado"));
	        	cliente.setCep(rs.getString("cep"));
	                
	            list.add(cliente);
	        }
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    
	    return list;
	}
	
	public static int salvarChamada(Chamada chamada) {
	    int status = 0;
	    
	    try {
	        Connection con = ConnectionDao.getConnection();
	        
	        PreparedStatement ps = (PreparedStatement) con.prepareStatement("INSERT INTO chamada (id_cliente, id_usuario, data_hora_inicio, data_hora_final, resultado) VALUES (?, ?, ?, ?, ?)");
	 
	        ps.setInt(1, chamada.getId_cliente());
	        ps.setInt(2, chamada.getId_usuario());
	        ps.setTimestamp(3, new Timestamp(chamada.getData_hora_inicio().getTime()));
	        ps.setTimestamp(4, new Timestamp(chamada.getData_hora_final().getTime()));
	        ps.setString(5, chamada.getResultado());
	        
	        // Execute a instrução SQL
	        status = ps.executeUpdate();
	        
	        // Feche a PreparedStatement e a conexão com o banco
	        ps.close();
	        con.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return status;
	}
	
	
	public static int getQuantidadeChamadasPorData(java.sql.Date data) {
	    int quantidade = 0;
	    ResultSet resultSet = null;

	    try {
	        Connection con = ConnectionDao.getConnection();
	        PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT COUNT(*) FROM chamada WHERE DATE_FORMAT(data_hora_inicio, '%Y-%m-%d') LIKE ?");
	        ps.setDate(1, data);
	        resultSet = ps.executeQuery();

	        if (resultSet.next()) {
	            quantidade = resultSet.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return quantidade;
	}


}
