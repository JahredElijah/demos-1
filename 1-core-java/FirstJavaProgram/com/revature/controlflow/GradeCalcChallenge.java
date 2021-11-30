package com.revature.controlflow;

import java.util.Scanner;

public class GradeCalcChallenge {

	public static void main(String[] args) {
		
		double enteredMaxPoints, enteredScore, studentGrade;
		char studentLetterGrade;
		
		Scanner sc = new Scanner(System.in);
		
		System.out.print("Please enter the total amount of points available on the quiz: ");
		enteredMaxPoints = sc.nextDouble();
		
		System.out.print("Please enter the total amount the student scored on the quiz: ");
		enteredScore = sc.nextDouble();
		
		studentGrade = percentCalculation(enteredMaxPoints, enteredScore);
		
		
		if(studentGrade >= 90 && studentGrade <= 100) {
			studentLetterGrade = 'A';
		} else if(studentGrade >= 80 && studentGrade <= 89) {
			studentLetterGrade = 'B';
		} else if(studentGrade >= 70 && studentGrade <= 79) {
			studentLetterGrade = 'C';
		} else if(studentGrade >= 60 && studentGrade <= 69) {
			studentLetterGrade = 'D';
		} else {
			studentLetterGrade = 'F';
		}
		
		System.out.println("The Student's Lettter grade is " + studentLetterGrade + ". That's " + studentGrade + "% !");
		
	}
	
	
	public static double percentCalculation(double maxPoints, double score) {
		double studentGrade = (score / maxPoints) * 100;
		
		return (int) studentGrade;
	}

}
