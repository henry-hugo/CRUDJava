package com.crudjava.bean;

import java.util.Date;

public class Chamada {
	
	private int id_chamada;
	private int id_cliente;
	private int id_usuario;
	private Date data_hora_inicio;
	private Date data_hora_final;
	private String resultado;
	private String nome_usuario;
	private String nome_cliente;
	
	
	public int getId_chamada() {
		return id_chamada;
	}
	public void setId_chamada(int id_chamada) {
		this.id_chamada = id_chamada;
	}
	public int getId_cliente() {
		return id_cliente;
	}
	public void setId_cliente(int id_cliente) {
		this.id_cliente = id_cliente;
	}
	public int getId_usuario() {
		return id_usuario;
	}
	public void setId_usuario(int id_usuario) {
		this.id_usuario = id_usuario;
	}
	public Date getData_hora_inicio() {
		return data_hora_inicio;
	}
	public void setData_hora_inicio(Date data_hora_inicio) {
		this.data_hora_inicio = data_hora_inicio;
	}
	
	public Date getData_hora_final() {
		return data_hora_final;
	}
	public void setData_hora_final(Date data_hora_final) {
		this.data_hora_final = data_hora_final;
	}
	public String getResultado() {
		return resultado;
	}
	public void setResultado(String resultado) {
		this.resultado = resultado;
	}
	 public String getNome_usuario() {
        return nome_usuario;
    }

    public void setNome_usuario(String nome_usuario) {
        this.nome_usuario = nome_usuario;
    }

    public String getNome_cliente() {
        return nome_cliente;
    }

    public void setNome_cliente(String nome_cliente) {
        this.nome_cliente = nome_cliente;
    }
	
	

}
