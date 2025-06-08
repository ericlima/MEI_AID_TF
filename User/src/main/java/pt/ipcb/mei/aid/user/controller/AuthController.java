package pt.ipcb.mei.aid.user.controller;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pt.ipcb.mei.aid.user.service.UserService;

import java.util.Collections;
import java.util.Date;

@RestController
public class AuthController {
    public static class LoginRequest {
        private String username;
        private String password;

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }
    }

    @Value("${app.api-key}")
    private String SECRET_KEY;

    private UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @CrossOrigin(
            origins = "*",
            methods = { RequestMethod.POST, RequestMethod.OPTIONS },
            allowedHeaders = "*"
    )
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest login) {

        String userCode = userService.validateUser(login.getUsername(), login.getPassword());

        if (userCode == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Credenciais inválidas");
        }

        String token = Jwts.builder()
                .setSubject(login.getUsername())
                .claim("usr", userCode)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + 604_800_000))
                .signWith(Keys.hmacShaKeyFor(SECRET_KEY.getBytes()), SignatureAlgorithm.HS256)
                .compact();

        return ResponseEntity.ok(Collections.singletonMap("token", token));
    }

}
