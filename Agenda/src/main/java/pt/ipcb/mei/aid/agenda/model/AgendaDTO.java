package pt.ipcb.mei.aid.agenda.model;

import java.time.LocalDateTime;

public class AgendaDTO {

    private Long id;
    private Long userId;
    private LocalDateTime inicio;
    private LocalDateTime fim;
    private String titulo;
    private String local;
    private boolean diaInteiro;
    private String recorrencia_rrle;
    private String notas;
    private LocalDateTime datahoraCriacao;
    private LocalDateTime datahoraAlteracao;

    public AgendaDTO() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public LocalDateTime getInicio() {
        return inicio;
    }

    public void setInicio(LocalDateTime inicio) {
        this.inicio = inicio;
    }

    public LocalDateTime getFim() {
        return fim;
    }

    public void setFim(LocalDateTime fim) {
        this.fim = fim;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getLocal() {
        return local;
    }

    public void setLocal(String local) {
        this.local = local;
    }

    public boolean isDiaInteiro() {
        return diaInteiro;
    }

    public void setDiaInteiro(boolean diaInteiro) {
        this.diaInteiro = diaInteiro;
    }

    public String getRecorrencia_rrle() {
        return recorrencia_rrle;
    }

    public void setRecorrencia_rrle(String recorrencia_rrle) {
        this.recorrencia_rrle = recorrencia_rrle;
    }

    public String getNotas() {
        return notas;
    }

    public void setNotas(String notas) {
        this.notas = notas;
    }

    public LocalDateTime getDatahoraCriacao() {
        return datahoraCriacao;
    }

    public void setDatahoraCriacao(LocalDateTime datahoraCriacao) {
        this.datahoraCriacao = datahoraCriacao;
    }

    public LocalDateTime getDatahoraAlteracao() {
        return datahoraAlteracao;
    }

    public void setDatahoraAlteracao(LocalDateTime datahoraAlteracao) {
        this.datahoraAlteracao = datahoraAlteracao;
    }
}
