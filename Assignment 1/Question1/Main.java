import java.util.*;
import java.lang.*;

class Main {
  public static int totalSocks; // Total number of socks

  public static void main(String[] args) throws Exception {
    Scanner scan = new Scanner(System.in);

    System.out.println("Please enter the number of Socks you want: ");
    totalSocks = scan.nextInt();
    System.out.println("Please enter the max number of Robots you want: ");
    int totalRobots = scan.nextInt();

    scan.close();

    Sock[] sockList = new Sock[totalSocks]; // Create array of the sockss

    // Assign random color out of 4 to every sock
    for (int i = 0; i < totalSocks; i++) {
      Random random = new Random();
      int col = random.nextInt(4) + 1;
      sockList[i] = new Sock(col, i);
      System.out.println("Colour of " + i + "th sock is " + col);
    }

    // Create array of the sockss
    Robot[] robots = new Robot[totalRobots];
    // Initialize the machine
    MatchingMachine m = new MatchingMachine().getInst();

    for (int i = 0; i < totalRobots; i++) {
      if (m.queue.size() < totalSocks) { // if all the socks are not still in the shelf
        // Initialie the robotic arms and start the threads
        robots[i] = new Robot(sockList, i);
        robots[i].start();
      }
    }
    // Start the machine thread
    m.start();
    System.out.println("Machine start main");
  }
}
