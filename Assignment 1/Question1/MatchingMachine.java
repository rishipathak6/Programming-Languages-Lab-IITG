import java.util.*;
import java.lang.*;
import java.io.*;

// Matching machine class
class MatchingMachine extends Thread {
  // int[] colour;
  int colour1; // integers to store index of last odd sock that was of the same color
  int colour2;
  int colour3;
  int colour4;
  public static MatchingMachine mac;
  public static LinkedList<Sock> queue; // LinkedList of socks which are ready to be paired and pushed by robot threads
  public static int matchedSocks; // Number of matched socks

  // Constructor
  public MatchingMachine() {
    // colour[0] = -1;
    // colour[1] = -1;
    // colour[2] = -1;
    // colour[3] = -1;
    colour1 = -1; // All integers initialised to 0
    colour2 = -1;
    colour3 = -1;
    colour4 = -1;
    matchedSocks = 0;
    System.out.println("New machine made");
    queue = new LinkedList<>();
  }

  // Get one instace of the machine that does all the pairing work in the main
  public static MatchingMachine getInst() {
    if (mac == null) {
      mac = new MatchingMachine();
      matchedSocks = 0;
      return mac;
    } else
      return mac;
  }

  // Create array of the socks
  public void run() {
    System.out.println("Maching started");
    while (MatchingMachine.matchedSocks <= Main.totalSocks) { // Until all the socks have not matched then keep trying
      if (queue.size() != 0) { // Take a random sock in the machine's queue
        Random random = new Random();
        int ind = random.nextInt(queue.size());
        if (queue.get(ind).collected == true) {
          System.out.println("Sock already collected " + ind);
        } else if (queue.get(ind).collected == false) { // If it has not already been collected
          MatchingMachine.matchedSocks++;
          System.out.println("Trying to match sock " + ind);
          int clr = queue.get(ind).colour;
          switch (clr) {
            case 1:
              if (colour1 != -1) { // If there is already a sock collected before of the same color looking for
                                   // pair
                System.out.println("Matching socks found " + queue.get(colour1).index + " and " + queue.get(ind).index);
                // Then match these two socks
                colour1 = -1; // Reset the integer to -1 to show there is no odd sock
                queue.get(ind).collected = true;
              } else {
                colour1 = ind; // Else this sock is the odd sock of the colour
                queue.get(ind).collected = true;
              }
              break;
            case 2: // Similarly for other colours
              if (colour2 != -1) {
                System.out.println("Matching socks found " + queue.get(colour2).index + " and " + queue.get(ind).index);
                colour2 = -1;
                queue.get(ind).collected = true;
              } else {
                colour2 = ind;
                queue.get(ind).collected = true;
              }
              break;
            case 3:
              if (colour3 != -1) {
                System.out.println("Matching socks found " + queue.get(colour3).index + " and " + queue.get(ind).index);
                colour3 = -1;
                queue.get(ind).collected = true;
              } else {
                colour3 = ind;
                queue.get(ind).collected = true;
              }
              break;
            case 4:
              if (colour4 != -1) {
                System.out.println("Matching socks found " + queue.get(colour4).index + " and " + queue.get(ind).index);
                colour4 = -1;
                queue.get(ind).collected = true;
              } else {
                colour4 = ind;
                queue.get(ind).collected = true;
              }
              break;
            default:
              System.out.println("This case never comes");
          }
        }
        if (MatchingMachine.matchedSocks == Main.totalSocks) // if all socks have been matched break out of loop
          break;
      }
    }
  }

  public synchronized void Push(Sock sock) {
    // Add the sock to the shared heap in a synchronized way
    queue.add(sock);
  }
}
