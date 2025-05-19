package pt.ipcb.mei.aid.agenda.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import pt.ipcb.mei.aid.agenda.model.UserDTO;

@FeignClient(name = "user")
public interface UserProxy {

    @GetMapping("/api/{id}")
    UserDTO obterUser(@PathVariable String id);

}
