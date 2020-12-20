import java.util.*;
import java.lang.*;
import java.io.*;

class RollNoCompare implements Comparator<Student> { // Comparator for sorting student entries in ascending order of
                                                     // Student roll numbers
  @Override
  public int compare(Student s1, Student s2) {
    return s1.getRollNo() - s2.getRollNo();
  }
}

class NameCompare implements Comparator<Student> { // Comparator for sorting student entries in ascending order of
                                                   // Student names
  @Override
  public int compare(Student s1, Student s2) {
    return (s1.getName()).compareTo(s2.getName());
  }
}

class CreateNewfiles {// for creating files with sorted records according to name and roll no,
  public static void createFiles() throws IOException {
    // details are copied into new ArrayList
    ArrayList<Student> studArrayList = new ArrayList<>(Main.studArray);
    // Writing into File Sorted_Roll.txt
    FileWriter fileWriter1 = new FileWriter(".\\Sorted_Roll.txt");
    PrintWriter printWriter1 = new PrintWriter(fileWriter1);
    int listLength = studArrayList.size();
    Collections.sort(studArrayList, new RollNoCompare());// sorting the studArrayList based on RollNumbers
    for (int i = 0; i < listLength; i++) {
      // assumed Student details are stored as RollNumber,Name,MailID,Marks and
      // Teacher in order
      String buff = studArrayList.get(i).getRollNo() + "," + studArrayList.get(i).getName() + ","
          + studArrayList.get(i).getMailId() + "," + studArrayList.get(i).getMarks() + ","
          + studArrayList.get(i).getChecker();
      printWriter1.print(buff);
      if (i != listLength - 1)
        printWriter1.print("\n");
    }
    printWriter1.close();
    // Completed Writing into File Sorted_Roll.txt

    // Writing into File Sorted_Name.txt
    FileWriter fileWriter2 = new FileWriter(".\\Sorted_Name.txt");
    PrintWriter printWriter2 = new PrintWriter(fileWriter2);
    Collections.sort(studArrayList, new NameCompare());// sorting the studArrayList based on Names
    for (int i = 0; i < listLength; i++) {
      // assumed Student details are stored as RollNumber,Name,MailID,Marks and
      // Teacher in order
      String buff = studArrayList.get(i).getRollNo() + "," + studArrayList.get(i).getName() + ","
          + studArrayList.get(i).getMailId() + "," + studArrayList.get(i).getMarks() + ","
          + studArrayList.get(i).getChecker();
      printWriter2.print(buff);
      if (i != listLength - 1)// adding new line
        printWriter2.print("\n");
    }
    printWriter2.close();
    // Completed Writing into File Sorted_Name.txt
    System.out.println("Both the Files Sorted_Roll.txt and Sorted_Name.txt were created/modified");
  }
}

class UpdateOldFile// to update the Stud_Info file with final results everytime
{
  public static void updateFileStudInfo() throws IOException {
    ArrayList<Student> studArrayList = new ArrayList<>(Main.studArray);
    int listLength = Main.studArray.size();
    FileWriter filewriter = new FileWriter(".\\Stud_Info.txt");
    PrintWriter printwriter = new PrintWriter(filewriter);
    for (int i = 0; i < listLength; i++) {
      // assumed Student details are stored as RollNumber,Name,MailID,Marks and
      // Teacher in order
      String buff = studArrayList.get(i).getRollNo() + "," + studArrayList.get(i).getName() + ","
          + studArrayList.get(i).getMailId() + "," + studArrayList.get(i).getMarks() + ","
          + studArrayList.get(i).getChecker();
      printwriter.print(buff);
      if (i != listLength - 1)// adding new line
        printwriter.print("\n");
    }
    printwriter.close();
    System.out.println("Stud_Info.txt was updated with new marks of the students.You can check Stud_Info.txt file!!");
  }
}