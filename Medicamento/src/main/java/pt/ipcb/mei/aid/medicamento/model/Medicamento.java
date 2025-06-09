package pt.ipcb.mei.aid.medicamento.model;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(
        name = "MEDICAMENTO",
        indexes = {
                @Index(name = "idx_medicamento_user_id", columnList = "userId")
        }
)

public class Medicamento extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @Column(nullable = false)
    private long userId;
    @Column(nullable = false)
    private String descricao;
    @Column(nullable = false)
    private String posologia;
    @Column(nullable = false)
    private String preditor;
    @Column(nullable = true)
    private String local;
    @Column(nullable = true)
    private LocalDate inicio;
    @Column(nullable = true)
    private LocalDate fim;
    @Column(nullable = true)
    private String pinacesso;
    @Column(nullable = true)
    private String pinopcao;
    @Column(nullable = true)
    private Integer quantEmb;
    @Column(nullable = true)
    private Integer quantDia;
    @Column(nullable = true)
    private Integer quantPrescrita;
    @Column(nullable = true)
    private Integer quantDispensada;


    public Medicamento() {
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
