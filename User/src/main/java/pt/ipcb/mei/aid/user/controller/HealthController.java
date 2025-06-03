package pt.ipcb.mei.aid.user.controller;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;

@RestController
public class HealthController {

    @Value("${app.api-key}")
    private String secretKey;

    private static class Resposta {
        public String resposta;
        public String expiraEm;

        public Resposta(String resposta, String expiraEm) {
            this.resposta = resposta;
            this.expiraEm = expiraEm;
        }
    }

    @GetMapping("/ping")
    public ResponseEntity<?> getUser(
            Authentication authentication,
            @RequestHeader(value = "Authorization", required = false) String authHeader) {

        if (authentication == null || authHeader == null || !authHeader.startsWith("Bearer ")) {
            return ResponseEntity.ok("OK");
        }

        try {
            String token = authHeader.replace("Bearer ", "");
            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes(StandardCharsets.UTF_8)))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();

            Date exp = claims.getExpiration();
            String formattedDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(exp);

            return ResponseEntity.ok(new Resposta(authentication.getName(), formattedDate));

        } catch (Exception e) {
            return ResponseEntity.status(401).body("Token inválido ou expirado");
        }
    }
}
