package pt.ipcb.mei.aid.user.model;

import jakarta.persistence.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public abstract class Auditable {

    @CreatedDate
    @Column(name = "datahora_criacao", nullable = false, updatable = false)
    private LocalDateTime datahoraCriacao;

    @LastModifiedDate
    @Column(name = "datahora_alteracao")
    private LocalDateTime datahoraAlteracao;

    public LocalDateTime getDatahoraCriacao() {
        return datahoraCriacao;
    }

    public LocalDateTime getDatahoraAlteracao() {
        return datahoraAlteracao;
    }
}
