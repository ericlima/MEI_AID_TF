package pt.ipcb.mei.aid.apigateway.config;

import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;


@Component
public class LoggingGlobalFilter implements GlobalFilter {

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        System.out.println("[GATEWAY] Request: " + exchange.getRequest().getMethod() + " " + exchange.getRequest().getURI());
        return chain.filter(exchange).doOnSuccess(aVoid -> {
            System.out.println("[GATEWAY] Response: " + exchange.getResponse().getStatusCode());
        });
    }
}
