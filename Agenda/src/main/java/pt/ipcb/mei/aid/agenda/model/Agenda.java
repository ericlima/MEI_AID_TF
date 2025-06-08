package pt.ipcb.mei.aid.agenda.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name="AGENDA")
public class Agenda extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private Long userId;
    @Column(nullable = false)
    private LocalDateTime inicio;
    @Column(nullable = true)
    private LocalDateTime fim;
    @Column(nullable = false)
    private String titulo;
    @Column(nullable = true)
    private String local;
    @Column(nullable = true)
    private boolean diaInteiro;
    @Column(nullable = true)
    private String recorrencia_rrle;
    @Column(nullable = true)
    private String notas;

    public Agenda() {
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
}
