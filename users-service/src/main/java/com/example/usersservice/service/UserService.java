package com.example.usersservice.service;

import com.example.usersservice.dto.UserCreateDto;
import com.example.usersservice.dto.UserListDto;
import com.example.usersservice.dto.UserUpdateDto;

import java.util.List;

public interface UserService {

    UserCreateDto userCreate();
    List<UserListDto> userListGet();
    UserUpdateDto userUpdate();
}
