package pt.ipcb.mei.aid.medicamento;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class MedicamentoApplication {

    public static void main(String[] args) {
        SpringApplication.run(MedicamentoApplication.class, args);
    }

}
