package com.dou.dou.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PaintingController implements PaintingsApi {
    @Override
    public ResponseEntity<String> paintingsGet() {
        return ResponseEntity.ok("hello paintings!");
    }
}
