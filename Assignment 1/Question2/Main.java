import java.util.*;
import java.lang.*;
import java.io.*;

public class Main {
  BufferedReader buffReader; // BufferReader to read the data from file
  static ArrayList<Student> studArray = new ArrayList<>(); // Array list to store the student records
  private int loadcheck = 0;// Variable to check whether data is properly loaded from the input file

  // Static variables to store input from user
  static String checker1;
  static String checker2;
  static String cont; // cont denotes whether user presses yes/no in the console for continuing
                      // editing
  static int rollno1;
  static int flag1; // increment/decrement the marks
  static int change1;// change in marks
  static int rollno2;
  static int flag2;
  static int change2;

  // sync denotes whether with synchronization or without(using lock)
  static int sync;

  public static void main(String[] args) {
    Main mainObj = new Main();
    mainObj.loadData();
    if (mainObj.loadcheck == 1)// if all the records have been loaded successfully
    {
      Scanner scan = new Scanner(System.in);
      while (true) {
        mainObj.takeEditDetails();// takes and stores the input from user
        System.out.print("Choose how to do changes: 1.Without Synchronization 2.With Synchronization(Enter 1/2):");
        sync = scan.nextInt();
        scan.nextLine();
        // now update/process the input
        if (rollno1 == rollno2)// record level modification
          mainObj.recordLevelModification();
        else// with synchronization
          mainObj.fileLevelModification();
        System.out.print("Do You Want to continue editing?(Enter yes/no):");
        cont = scan.nextLine();
        if (!(cont.equals("yes") || cont.equals("YES") || cont.equals("y")))
          break;
      }
    }
  }

  void recordLevelModification() {
    System.out.println("\n-Record Level Modification-");
    int listLength = studArray.size();
    int index = -1;
    for (int i = 0; i < listLength; i++) {
      if (studArray.get(i).getRollNo() == rollno1) {
        // Find the index of the student from Array list
        index = i;
        break;
      }
    }
    if (index != -1) {
      int recordOrFile = 1;
      // Create two threads by calling Updater constructor for updating the record
      Updater updater1 = new Updater(index, change1, flag1, checker1, sync, recordOrFile);// send first Student details
      Updater updater2 = new Updater(index, change2, flag2, checker2, sync, recordOrFile);// send second studnet details
      updater1.setName("First Thread");
      updater2.setName("Second Thread");
      updater1.start(); // Updater1 Started
      updater2.start(); // Updater2 Started

      try {
        updater1.join(); // First updater1 finish updating
        updater2.join(); // Then updater2 finish updating
        // finally files are created after both threads are completed
        // WAIT for threads to end
        CreateNewfiles.createFiles();
        UpdateOldFile.updateFileStudInfo();
        System.out.println(
            "\n" + "Current marks of " + rollno1 + " are changed to " + studArray.get(index).getMarks() + "\n");
      } catch (Exception e) {
        System.out.println("---Interrupted---");
      }

    } else {
      System.out.println("Roll Number " + rollno1 + " was not found in the file");
    }
  }

  void fileLevelModification() {
    System.out.println("-File Level Modification-");
    // firstly get the both students objects indices in ArrayList
    int index1 = -1;
    int index2 = -1;
    int listLength = studArray.size();
    for (int i = 0; i < listLength; i++) { // Get index of both the students
      if (studArray.get(i).getRollNo() == rollno1)
        index1 = i;
      else if (studArray.get(i).getRollNo() == rollno2)
        index2 = i;
    }
    if (index1 != -1 && index2 != -1) {
      // Create two threads by calling Updater constructor
      int recordOrFile = 2; // File level
      Updater updater1 = new Updater(index1, change1, flag1, checker1, sync, recordOrFile);// send first Student details
      Updater updater2 = new Updater(index2, change2, flag2, checker2, sync, recordOrFile);// send second studnet
                                                                                           // details
      updater1.setName("First Thread");
      updater2.setName("Second Thread");
      updater1.start();
      updater2.start();

      try {
        updater1.join();
        updater2.join();
        // finally files are created after both threads are completed
        // WAIT for threads to end
        CreateNewfiles.createFiles();
        UpdateOldFile.updateFileStudInfo();
        System.out.print("\n" + "Current marks of " + rollno1 + " are changed to " + studArray.get(index1).getMarks());
        System.out.print(
            "\n" + "Current marks of " + rollno2 + " are changed to " + studArray.get(index2).getMarks() + "\n\n");
      } catch (Exception e) {
        System.out.println("---Interrupted---");
      }
    } else {
      if (index1 == -1) {
        System.out.println("Roll Number " + rollno1 + " was not found in the file");
      } else if (index2 == -1) {
        System.out.println("Roll Number " + rollno2 + " was not found in the file");
      }
    }

  }

  void takeEditDetails() {
    System.out.print("Identify yourself(Enter CC/TA1/TA2):");
    Scanner scan = new Scanner(System.in);
    checker1 = scan.nextLine();
    System.out.print("Enter Roll Number of the first Student you want to edit:");
    rollno1 = scan.nextInt();
    System.out.print("Do you want to increase or decrease the marks?(Enter 1/2):");
    flag1 = scan.nextInt();
    if (flag1 == 1)
      System.out.print("Marks to increase:");
    else
      System.out.print("Marks to decrease:");
    change1 = scan.nextInt();
    scan.nextLine();
    System.out.print("Identify yourself(CC/TA1/TA2):");
    checker2 = scan.nextLine();
    System.out.print("Enter Roll Number of the second Student you want to edit:");
    rollno2 = scan.nextInt();
    System.out.print("Do you want to increase or decrease the marks?(Enter 1/2)");
    flag2 = scan.nextInt();
    if (flag2 == 1)
      System.out.print("Marks to increase:");
    else
      System.out.print("Marks to decrease:");
    change2 = scan.nextInt();
  }

  void loadData()// to load the data into the ArrayList from Stud_Info.txt
  {
    File file = new File(".\\Stud_Info.txt");
    try {
      buffReader = new BufferedReader(new FileReader(file)); // New BufferedReader
      String str;
      int i = 1;
      while ((str = buffReader.readLine()) != null) {
        String[] splited = str.split("\\s*,\\s*");// Reaading one line at a time and tokenising based on the assumption
                                                  // that the details in one student record are seperated by comma
        int rollno = Integer.parseInt(splited[0]);
        int marks = Integer.parseInt(splited[3]);
        // Assuming Student details are stored as RollNumber,Name,MailID,Marks and
        // checker in order
        studArray.add(new Student(rollno, splited[1], splited[2], marks, splited[4]));
        i++;
      }
      System.out.println("-All the Students details were loaded from Stud_Info.txt-");
      buffReader.close();
      loadcheck = 1;
    } catch (FileNotFoundException ex) { // if file is not found in the folder
      System.out.println("Student_Info.txt file was not found");// code to run when exception occurs
      System.out.println("Failed to load students details");
      System.out.println("Create the file and try again please!!");
    } catch (NullPointerException npe) { // Null pointer exception
      System.out.println(npe.getMessage() + " Some NullPointerException");
    } catch (IOException e) { // IO exception
      System.out.println(e.getMessage() + " Some IOException");
      // System.out.println(e.printStackTrace());
    }
  }
}