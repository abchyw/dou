package com.dou.dou.controller;

import com.dou.dou.appService.model.Painting;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class PaintingController implements PaintingsApi {
    @Override
    public ResponseEntity<List<Painting>> paintingsGet() {
        return ResponseEntity.ok(
                List.of(new Painting()
                        .name("Sunflowers +1"))
        );
    }
}
