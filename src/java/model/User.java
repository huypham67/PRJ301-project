/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author huypd
 */
public class User {
    private int id;
    private String userName;
    private String passWord;
    private int isAdmin;

    public User() {
    }

    public User(int id, String userName, String passWord, int isAdmin) {
        this.id = id;
        this.userName = userName;
        this.passWord = passWord;
        this.isAdmin = isAdmin;
    }
    
    

    public int getId() {
        return id;
    }

    
    
    public void setId(int id) {
        this.id = id;
    }

    

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public void setIsAdmin(int isAdmin) {
        this.isAdmin = isAdmin;
    }

    public int getIsAdmin() {
        return isAdmin;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", userName=" + userName + ", passWord=" + passWord + ", isAdmin=" + isAdmin + '}';
    }

    

    
    
}
