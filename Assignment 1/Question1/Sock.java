import java.util.concurrent.locks.ReentrantLock;
import java.util.*;
import java.lang.*;
import java.io.*;

//Class for storing info about socks and the lock while accessed by Robot Threads
class Sock {
  Boolean collected; // If it has already been Collected
  int colour; // Colour of the sock
  int index; // Index in the sockArray

  ReentrantLock lock = new ReentrantLock();

  // Constructor
  Sock(int colour, int index) {
    this.colour = colour;
    collected = false;
    this.index = index;
  }

  Sock(Sock x) {
    colour = x.colour;
    collected = x.collected;
  }

  // Trying to acquire ReentrantLock
  public boolean acquireLock() {
    return lock.tryLock();
  }

  // Unlock
  public void unlock() {
    lock.unlock();
  }
}
