package com.example.usersservice.controller;

import com.example.usersservice.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequestMapping("/api/user")
public class UserController {
    private UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/join")
    public void join(){

    }

    @GetMapping("/list")
    public void list(){

    }

    @PostMapping("{id}")
    public void userUpdate(@PathVariable String id){

    }
}
