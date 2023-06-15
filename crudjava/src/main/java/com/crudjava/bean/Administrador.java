package com.crudjava.bean;

public class Administrador {
    private Usuario usuarioLogado;

    public Administrador(Usuario usuarioLogado) {
        this.usuarioLogado = usuarioLogado;
    }

    public void setNomeUsuario(String nome) {
        verificarNivelAcesso();
        usuarioLogado.setNome(nome);
    }

    public void setSenhaUsuario(String senha) {
        verificarNivelAcesso();
        usuarioLogado.setSenha(senha);
    }

    public void setEmailUsuario(String email) {
        verificarNivelAcesso();
        usuarioLogado.setEmail(email);
    }

    public void setNomeCliente(Cliente cliente, String nome) {
        verificarNivelAcesso();
        cliente.setNome(nome);
    }

    public void setSobrenomeCliente(Cliente cliente, String sobrenome) {
        verificarNivelAcesso();
        cliente.setSobrenome(sobrenome);
    }

    public void setEmailCliente(Cliente cliente, String email) {
        verificarNivelAcesso();
        cliente.setEmail(email);
    }

    private void verificarNivelAcesso() {
        if (usuarioLogado == null || usuarioLogado.getNivel() != 1) {
            throw new IllegalStateException("Acesso negado. Nível de acesso insuficiente.");
        }
    }
}

