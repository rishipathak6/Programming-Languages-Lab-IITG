import java.util.*;
import java.lang.*;
import java.io.*;

// This is the Updater class which is used to update the data in the Stud_info in synchronized or asynchronized
class Updater extends Thread {
  int index;
  int rollno;
  int marks;
  int flag;
  int sync;
  String checker;
  Student stud;// current Student object
  int recordOrFile;// assume 1 for record level and 2 for file level

  public Updater(int index, int marks, int flag, String checker, int sync, int recordOrFile)// record level modification
  {
    this.index = index;
    stud = Main.studArray.get(index);
    this.rollno = stud.getRollNo();
    this.marks = marks;
    this.checker = checker;
    this.flag = flag;
    this.sync = sync;
    this.recordOrFile = recordOrFile;
  }

  @Override
  public void run() {
    if (sync == 2)// with synchronization
    {
      if (recordOrFile == 1)// record level i.e. update in the same student record
      {
        // synchronized block on current Student object is used here
        synchronized (stud) {
          System.out.println(Thread.currentThread().getName()
              + " acquired the lock on Student record object with RollNumber " + rollno + " and running ");
          stud.marksUpdate(checker, flag, marks, sync);
        }
      } else// file level i.e. update in different student records
      {
        // synchronized block on entire file is used here
        synchronized (Student.class) {
          System.out.println(
              Thread.currentThread().getName() + " acquired the lock on entire file records " + " and running ");
          stud.marksUpdate(checker, flag, marks, sync);
        }
      }
    } else// without synchronization as sync value is 1
    {
      // Calling the method without acquiring any lock
      stud.marksUpdate(checker, flag, marks, sync);
    }
  }
}