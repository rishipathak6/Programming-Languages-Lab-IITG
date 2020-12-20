import java.util.*;
import java.lang.*;
import java.io.*;

// This is the student class which is used to store and manipulate the data in the Stud_info
class Student {
  private int rollno; // Various attributes of student given in the table
  private String name;
  private String mailId;
  private int marks;
  private String checker;

  // Constructor to make a new student
  public Student(int rollno, String name, String mailId, int marks, String checker) {
    this.rollno = rollno;
    this.name = name;
    this.mailId = mailId;
    this.marks = marks;
    this.checker = checker;
  }

  public void marksUpdate(String checker, int flag, int marks, int sync) {
    if (this.checker.equals("CC"))// if the Student was previously checked by CC
    {
      if (checker.equals("TA1") || checker.equals("TA2"))// and the current checker is TA1/TA2
      {
        // with (or) without synchronization
        // marks will not be changed by TA1/TA2 because marks were previously updated by
        // CC
        System.out
            .println("Marks of " + rollno + " were not changed because of lesser priority of current executing thread");
      } else// or if the current checker is again CC
      {
        if (flag == 1) { // CC wants to increase student's marks
          int temp = this.marks;
          this.marks += marks;
          if (sync == 2)// with synchronization
            System.out.println("Marks of " + rollno + " were incremented from " + temp + " to " + this.marks + " by "
                + this.checker + "\n");
          else// without synchronization
            System.out.println("Marks of " + rollno + " were incremented");
        } else { // CC wants to decrease student's marks
          int temp = this.marks;
          this.marks -= marks;
          if (sync == 2)
            System.out.println("Marks of " + rollno + " were decremented from " + temp + " to " + this.marks + " by "
                + this.checker + "\n");
          else
            System.out.println("Marks of " + rollno + " were decremented\n");
        }
      }
    } else// if the Student was previously checked by TA1/TA2
    {
      if (checker.equals("CC"))// current checker is CC therefore change the checker to CC
      {
        this.checker = "CC";
      } else if (!this.checker.equals(checker))// If current checker is not CC, and this time another TA is checking the
                                               // student, then update checker to current TA
      {
        this.checker = checker;// need to update checker
      } else if (this.checker.equals(checker)) // If current checker is not CC, and this time same TA is checking the
                                               // student, then no need to update the checker
      {

      }
      if (flag == 1)// TA wants to increase student's marks
      {
        int temp = this.marks;
        this.marks += marks;
        if (sync == 2) // With synchronization
          System.out.println("Marks of " + rollno + " were incremented from " + temp + " to " + this.marks + " by "
              + this.checker + "\n");
        else
          System.out.println("Marks of " + rollno + " were incremented");
      } else {// CC wants to decrease student's marks
        int temp = this.marks;
        this.marks -= marks;
        if (sync == 2) // With synchronization
          System.out.println("Marks of " + rollno + " were decremented from " + temp + " to " + this.marks + " by "
              + this.checker + "\n");
        else
          System.out.println("Marks of " + rollno + " were decremented");

      }
    }
  }

  // Public functions to get private attributes of the class

  public int getRollNo() {
    return rollno;
  }

  public String getName() {
    return name;
  }

  public String getMailId() {
    return mailId;
  }

  public int getMarks() {
    return marks;
  }

  public String getChecker() {
    return checker;
  }
}
