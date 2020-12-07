package com.sportcred.dto;

import java.util.List;

public class GetFollowerFollowedOutput {

    private List<Long> UserList;

    public List<Long> getUserList() {
        return UserList;
    }

    public void setUserList(List<Long> userList) {
        UserList = userList;
    }
}
