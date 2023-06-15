package com.crudjava.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.crudjava.bean.Cliente;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

public class ClienteDao {
	
	public static List<Cliente> getAllClientes() {
	    List<Cliente> list = new ArrayList<Cliente>();

	    try {
	        Connection con = (Connection) ConnectionDao.getConnection();
	        PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT * FROM cliente");
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	        	Cliente clientes = new Cliente();
	        	clientes.setId_cliente(rs.getInt("id_cliente"));
	        	clientes.setNome(rs.getString("nome"));
	        	clientes.setSobrenome(rs.getString("sobrenome"));
	        	clientes.setEmail(rs.getString("email"));
	        	clientes.setTelefone(rs.getString("telefone"));
	        	clientes.setEndereco(rs.getString("endereco"));
	        	clientes.setCidade(rs.getString("cidade"));
	        	clientes.setEstado(rs.getString("estado"));
	        	clientes.setCep(rs.getString("cep"));

	            list.add(clientes);
	        }
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    return list;
	}
	
	public static int salvarCliente(Cliente c) {
		String email = c.getEmail();
		try {
		    Connection con = (Connection) ConnectionDao.getConnection();
		    PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT COUNT(*) FROM cliente WHERE email = ?");
		    ps.setString(1, email);
		    ResultSet rs = ps.executeQuery();
		    rs.next();
		    int count = rs.getInt(1);
		    if(count > 0){
		        //email já existe
		        return -1;
		    }
		}catch (Exception e) {
		    System.out.println(e);
		    return -2;
		}
		int status = 0;
		try {
			Connection con = (Connection) ConnectionDao.getConnection();
			PreparedStatement ps = (PreparedStatement) con.prepareStatement("INSERT INTO cliente (nome, sobrenome, email, telefone, endereco, cidade, estado, cep )VALUES (?,?,?,?,?,?,?,?)");
			ps.setString(1,c.getNome());
			ps.setString(2,c.getSobrenome());
			ps.setString(3,c.getEmail());
			ps.setString(4,c.getTelefone());
			ps.setString(5,c.getEndereco());
			ps.setString(6,c.getCidade());
			ps.setString(7,c.getEstado());
			ps.setString(8,c.getCep());
			
			status =ps.executeUpdate();
		}catch (Exception e) {
			System.out.println(e);
		}
		return status;
		  
	}
	public static Cliente getRegistroById(int id) {
		Cliente cliente = null;
		
		try {
			Connection con = (Connection) ConnectionDao.getConnection();
			PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT * FROM cliente WHERE id_cliente=?");
		   ps.setInt(1, id);
		   ResultSet rs = ps.executeQuery();
		   
		   while (rs.next()) {
			   	cliente = new Cliente();
			   	cliente.setId_cliente(rs.getInt("id_cliente"));
			   	cliente.setNome(rs.getString("nome"));
			   	cliente.setSobrenome(rs.getString("sobrenome"));
			   	cliente.setEmail(rs.getString("email"));
			   	cliente.setTelefone(rs.getString("telefone"));
			   	cliente.setEndereco(rs.getString("endereco"));
			   	cliente.setCidade(rs.getString("cidade"));
			   	cliente.setEstado(rs.getString("estado"));
			   	cliente.setCep(rs.getString("cep"));
			   
		   }
			
		} catch (Exception e) {
			 System.out.println(e);
		}
		return cliente;
	}
	
	public static int updateCliente(Cliente c) {
		 System.out.println(c.getId_cliente());
		
		int status = 0;
		
		try {
		    Connection con = (Connection) ConnectionDao.getConnection();
		    PreparedStatement ps = (PreparedStatement) con.prepareStatement("UPDATE cliente SET nome=?, sobrenome=?, email=?, telefone=?, cep=?, endereco=?, cidade=?, estado=? WHERE id_cliente=?");
		    
		    ps.setString(1,c.getNome());
		    ps.setString(2,c.getSobrenome());
		    ps.setString(3,c.getEmail());
		    ps.setString(4,c.getTelefone());
		    ps.setString(5,c.getCep());
		    ps.setString(6,c.getEndereco());
		    ps.setString(7,c.getCidade());
		    ps.setString(8,c.getEstado());
		    ps.setInt(9,c.getId_cliente());
		    
		     status = ps.executeUpdate();
		    
		    if (status== 1) {
		        System.out.println("Cliente atualizado com sucesso!");
		    } else {
		        System.out.println("Nenhum cliente foi atualizado.");
		    }
		} catch (SQLException e) {
		    System.err.println("Erro ao atualizar cliente: " + e.getMessage());
		}

		return status;
	}
	public static int deletarCliente(Cliente c) {
		System.out.println(c.getId_cliente());
		int status = 0;
		try {
			Connection con = (Connection) ConnectionDao.getConnection();
			PreparedStatement ps = (PreparedStatement) con.prepareStatement("DELETE FROM cliente WHERE id_cliente=?");
			ps.setInt(1, c.getId_cliente());
			status =ps.executeUpdate();
		}catch (Exception e) {
			System.out.println(e);
		}
		return status;
		
	}

}
