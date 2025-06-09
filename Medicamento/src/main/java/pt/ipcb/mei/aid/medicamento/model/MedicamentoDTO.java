package pt.ipcb.mei.aid.medicamento.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class MedicamentoDTO {

    private long id;
    private long userId;
    private String descricao;
    private String posologia;
    private String preditor;
    private String local;
    private LocalDate inicio;
    private LocalDate fim;
    private String pinacesso;
    private String pinopcao;
    private Integer quantEmb;
    private Integer quantDia;
    private Integer quantPrescrita;
    private Integer quantDispensada;
    private LocalDateTime datahoraCriacao;
    private LocalDateTime datahoraAlteracao;


    public MedicamentoDTO() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getPosologia() {
        return posologia;
    }

    public void setPosologia(String posologia) {
        this.posologia = posologia;
    }

    public String getPreditor() {
        return preditor;
    }

    public void setPreditor(String preditor) {
        this.preditor = preditor;
    }

    public String getLocal() {
        return local;
    }

    public void setLocal(String local) {
        this.local = local;
    }

    public LocalDate getInicio() {
        return inicio;
    }

    public void setInicio(LocalDate inicio) {
        this.inicio = inicio;
    }

    public LocalDate getFim() {
        return fim;
    }

    public void setFim(LocalDate fim) {
        this.fim = fim;
    }

    public String getPinacesso() {
        return pinacesso;
    }

    public void setPinacesso(String pinacesso) {
        this.pinacesso = pinacesso;
    }

    public String getPinopcao() {
        return pinopcao;
    }

    public void setPinopcao(String pinopcao) {
        this.pinopcao = pinopcao;
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

    public Integer getQuantEmb() {
        return quantEmb;
    }

    public void setQuantEmb(Integer quantEmb) {
        this.quantEmb = quantEmb;
    }

    public Integer getQuantDia() {
        return quantDia;
    }

    public void setQuantDia(Integer quantDia) {
        this.quantDia = quantDia;
    }

    public Integer getQuantPrescrita() {
        return quantPrescrita;
    }

    public void setQuantPrescrita(Integer quantPrescrita) {
        this.quantPrescrita = quantPrescrita;
    }

    public Integer getQuantDispensada() {
        return quantDispensada;
    }

    public void setQuantDispensada(Integer quantDispensada) {
        this.quantDispensada = quantDispensada;
    }
}
