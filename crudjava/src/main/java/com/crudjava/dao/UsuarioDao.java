package com.crudjava.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import com.crudjava.bean.Usuario;
import com.mysql.jdbc.PreparedStatement;

public class UsuarioDao {
	
	
	
	public static int deletarUsuario(Usuario u) {
		int status = 0;
		try {
			Connection con = ConnectionDao.getConnection();
			PreparedStatement ps = (PreparedStatement) con.prepareStatement("DELETE FROM usuario WHERE id=?");
			ps.setInt(1, u.getId());
			status =ps.executeUpdate();
		}catch (Exception e) {
			System.out.println(e);
		}
		return status;
		
	}
	
	public static int salvarUsuario(Usuario u) {
		String email = u.getEmail();
		try {
		    Connection con = ConnectionDao.getConnection();
		    PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT COUNT(*) FROM usuario WHERE email = ?");
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
			Connection con = ConnectionDao.getConnection();
			PreparedStatement ps = (PreparedStatement) con.prepareStatement("INSERT INTO usuario (nome, senha, email, nivel)VALUES (?,?,?,?)");
			ps.setString(1,u.getNome());
			ps.setString(2,u.getSenha());
			ps.setString(3,u.getEmail());
			ps.setInt(4,u.getNivel());
			
			status =ps.executeUpdate();
		}catch (Exception e) {
			System.out.println(e);
		}
		return status;
		  
	}
	
	public static Usuario getRegistroById(int id) {
		Usuario usuario = null;
		
		try {
			Connection con = ConnectionDao.getConnection();
			PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT * FROM usuario WHERE id=?");
		   ps.setInt(1, id);
		   ResultSet rs = ps.executeQuery();
		   
		   while (rs.next()) {
			   	usuario = new Usuario();
	            usuario.setId(rs.getInt("id"));
	            usuario.setNome(rs.getString("nome"));
	            usuario.setEmail(rs.getString("email"));
	            usuario.setSenha(rs.getString("senha"));
	            usuario.setNivel(rs.getInt("nivel"));
			   
		   }
			
		} catch (Exception e) {
			 System.out.println(e);
		}
		return usuario;
	}
	
	public static int updateUsuario(Usuario u ) {
		int status = 0;
		
		try {
			Connection con = ConnectionDao.getConnection();
			PreparedStatement ps = (PreparedStatement) con.prepareStatement("UPDATE usuario set"
														+ " nome=?, senha=?, email=?, nivel=? WHERE id=? ");
			ps.setString(1,u.getNome());
			ps.setString(2,u.getSenha());
			ps.setString(3,u.getEmail());
			ps.setInt(4,u.getNivel());
			ps.setInt(5,u.getId());
			
			status = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}
	
	public static List<Usuario> getAllUsuarios() {
	    List<Usuario> list = new ArrayList<Usuario>();

	    try {
	        Connection con = ConnectionDao.getConnection();
	        PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT * FROM usuario");
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            Usuario usuarios = new Usuario();
	            usuarios.setId(rs.getInt("id"));
	            usuarios.setNome(rs.getString("nome"));
	            usuarios.setEmail(rs.getString("email"));
	            usuarios.setSenha(rs.getString("senha"));
	            usuarios.setNivel(rs.getInt("nivel"));

	            list.add(usuarios);
	        }
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    return list;
	}

	public static Usuario verificarCredenciais(HttpServletRequest request, String username, String password) {
	    Usuario usuario = null;
	    try {
	        Connection con = ConnectionDao.getConnection();
	        PreparedStatement ps = (PreparedStatement) con.prepareStatement("SELECT * FROM usuario WHERE email=? AND senha=?");
	        ps.setString(1, username);
	        ps.setString(2, password);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            // Preenche o objeto Usuario com as informações do usuário
	            usuario = new Usuario();
	            usuario.setId(rs.getInt("id"));
	            usuario.setNome(rs.getString("nome"));
	            usuario.setEmail(rs.getString("email"));
	            usuario.setSenha(rs.getString("senha"));
	            usuario.setNivel(rs.getInt("nivel"));
	        }
	    } catch (Exception e) {
	        System.out.println(e);
	    } finally {
	        Object con = ConnectionDao.getConnection();
			Object ps = null;
			Object rs = null;
			closeConnection(con, ps, rs);
	    }
	    return usuario;
	}

	private static void closeConnection(Object con, Object ps, Object rs) {
		// TODO Auto-generated method stub
		
	}

}
