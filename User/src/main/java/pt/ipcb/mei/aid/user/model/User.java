package pt.ipcb.mei.aid.user.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import jakarta.validation.constraints.PastOrPresent;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name="MEDITRACK_USER")
public class User extends Auditable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @Column(nullable = false, unique = true)
    private String userName;
    @Column(nullable = false)
    private String nome;
    @Column(nullable = true)
    private String email;
    @Column(nullable = true)
    private String telefone;
    @Column(nullable = true, unique = true)
    private String numUtente;
    @Past(message = "A data de nascimento deve estar no passado")
    private LocalDate dataNascto;
    @Column(nullable = true)
    private String codigoPostal;
    @Column(nullable = true)
    private String morada;
    @Column(nullable = true)
    private String cidade;
    @Column(nullable = true)
    private String pais;
    @Column(nullable = true, insertable = false, updatable = false)
    private String pin;
    @NotNull(message = "A data de aceitação dos termos é obrigatória")
    private LocalDateTime terms;

    @Column(nullable = true)
    private String genero;

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public User() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getNumUtente() {
        return numUtente;
    }

    public void setNumUtente(String numUtente) {
        this.numUtente = numUtente;
    }

    public String getCodigoPostal() {
        return codigoPostal;
    }

    public void setCodigoPostal(String codigoPostal) {
        this.codigoPostal = codigoPostal;
    }

    public String getMorada() {
        return morada;
    }

    public void setMorada(String morada) {
        this.morada = morada;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getPin() {
        return pin;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }

    public LocalDateTime getTerms() {
        return terms;
    }

    public void setTerms(LocalDateTime terms) {
        this.terms = terms;
    }

    public void setTerms(String terms) {
        this.terms = LocalDateTime.parse(terms, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public LocalDate getDataNascto() {
        return dataNascto;
    }

    public void setDataNascto(LocalDate dataNascto) {
        this.dataNascto = dataNascto;
    }
}
