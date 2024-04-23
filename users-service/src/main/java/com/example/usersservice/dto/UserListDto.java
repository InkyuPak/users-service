package com.example.usersservice.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserListDto implements Serializable {

    private String userId;
    private String password;
    private String nickname;
    private String name;
    private String phoneNumber;
    private String email;
}
