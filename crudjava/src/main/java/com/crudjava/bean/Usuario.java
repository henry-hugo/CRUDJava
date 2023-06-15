package com.crudjava.bean;

public class Usuario {
	
	private int id;
	private String nome;
	private String senha;
	private String email;
	private int nivel;
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
	 if (nome != null && !nome.trim().isEmpty() && nome.length() <= 20) {
            this.nome = nome;
        } else {
            throw new IllegalArgumentException("Nome inválido");
        }
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
	  if (senha != null && !senha.trim().isEmpty() && senha.length() <= 10) {
          this.senha = senha;
      } else {
          throw new IllegalArgumentException("Senha inválida");
      }
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
	   if (email != null && !email.trim().isEmpty() && email.contains("@")) {
            this.email = email;
        } else {
            throw new IllegalArgumentException("Email inválido");
        }
	}
	public int getNivel() {
		return nivel;
	}
	public void setNivel(int nivel) {
		this.nivel = nivel;
	}
	

}
