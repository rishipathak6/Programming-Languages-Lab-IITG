import java.util.Random;

// Class for robot thread
class Robot extends Thread {
  Sock sock; // Sock that robot picks up and send to managing machine
  int sockIndex;
  Sock[] sockList;
  int robotIndex;

  @Override
  public void run() {
    try {
      pickSock(); // When Robot is started, it trys to pick a sock
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  Robot(Sock sockList[], int index) { // initialise the Robot thread
    this.sockList = sockList;
    sock = null;
    sockIndex = -1;
    robotIndex = index;
  }

  public void pickSock() throws Exception {
    while (MatchingMachine.queue.size() < Main.totalSocks) {
      Random random = new Random();
      int ind = random.nextInt(Main.totalSocks);
      // Select a sock if it is not accessed already and there is no lock on the sock
      // object
      if (sockList[ind].acquireLock()) { // Try to acquire lock on the sock.
        try {
          if (sockList[ind].collected == false) { // if it is not collected already
            sock = new Sock(sockList[ind]);
            sockIndex = ind;
            sockList[ind].collected = true; // Mark it Collected in original sock array
            sock.collected = false; // Create a copy of the sock and mark it as uncollected for the Matching maching
                                    // linked list
            sock.index = ind;
            System.out.println(this.robotIndex + " Thread selected sock " + ind);
            MatchingMachine.getInst().Push(sock);// Add the sock in to the machine
          } else {
            System.out.println(this.robotIndex + " Thread tried to access sock " + ind + " but access was denied");
          }
        } catch (Exception e) {
          e.printStackTrace();
        } finally {
          // After accessing the sock and adding the sock, release the lock
          System.out.println("Sock " + ind + " unlocked");
          sockList[ind].unlock();
        }
      }
    }
  }
}
