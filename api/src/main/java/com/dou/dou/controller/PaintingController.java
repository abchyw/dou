package com.dou.dou.controller;

import com.dou.dou.appService.model.Painting;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class PaintingController implements PaintingsApi {
    @Value("${dou.greeting-message}")
    private String greetingMessage;

    @Override
    public ResponseEntity<List<Painting>> paintingsGet() {
        return ResponseEntity.ok(
                List.of(new Painting()
                        .name("Sunflowers +1. " + greetingMessage))
        );
    }
}
