/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author huypd
 */
//<!--Date Name Category Quantity Price-->
public class Order{
    private Course course;
    private int quantity;

    public Order() {
    }

    public Order(Course course, int quantity) {
        this.course = course;
        this.quantity = quantity;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Order{" + "course=" + course + ", quantity=" + quantity + '}';
    }
    
}
