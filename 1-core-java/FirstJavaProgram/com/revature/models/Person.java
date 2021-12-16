package com.revature.models;

import java.util.Objects;

//Remember that our custom class inherits from the java.lang.Object class
public class Person { //POJO = Plain Old Java Object

	//properties (states)
	
	//instance variables - properties specific to each Person object that's instantiated
	private String name; //PRIVATE keyword means it must be accessed through person object
	private int age;
	private double height, weight;
	
	
	//constructors
	public Person() {
		//this is a no-args constructor which allows me to create a person without passing in args
	}
	
	public Person(String name) {
		super(); //I'm calling the Object class (pr direct parent class)
		this.name = name; //this points to the specific object that I'm instantiating's NAME property
	}
	
	//A FULLY initialized person
	public Person(String name, int age, double height, double weight) {
		super();
		this.name = name;
		this.age = age;
		this.height = height;
		this.weight = weight;
	}
	
	//methods (behaviors)
	public void introduce() { //void is a non-access modifier - specifies the return type which is nothing - it just does something / perform an action
		System.out.println("Hello, my name is " + name); //by default, we know that name refers to the instance variable of this object that's calling it
	}
	

	//we must generate gettes and setters so that we can change the private
	//properties of the objects that are created from this class
	//
	//right click -> source -> generate getters & setters
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public double getHeight() {
		return height;
	}
	public void setHeight(double height) {
		this.height = height;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	
	//we can override a method that we inherit from the Object class
	@Override //overriding the toString() method from the Object class to properly reflect the specific instance variables of a Person object
	public String toString() {
		return "Person [name=" + name + ", age=" + age + ", height=" + height + ", weight=" + weight + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(age, height, name, weight);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Person other = (Person) obj;
		return age == other.age && Double.doubleToLongBits(height) == Double.doubleToLongBits(other.height)
				&& Objects.equals(name, other.name)
				&& Double.doubleToLongBits(weight) == Double.doubleToLongBits(other.weight);
	}
	
	
	
	

}