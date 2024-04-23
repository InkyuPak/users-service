package com.example.usersservice.service;

import com.example.usersservice.dto.UserCreateDto;
import com.example.usersservice.dto.UserListDto;
import com.example.usersservice.dto.UserUpdateDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class UserServiceImpl implements UserService{
    @Override
    public UserCreateDto userCreate() {
        return null;
    }

    @Override
    public List<UserListDto> userListGet() {
        return null;
    }

    @Override
    public UserUpdateDto userUpdate() {
        return null;
    }
}
