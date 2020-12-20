package ques3p1;

import java.awt.Color;
import java.util.List;

import javax.swing.SwingWorker;
import javax.swing.JButton;

//This class is used to generate events to highlight different object on UI
public class Highlight extends SwingWorker<Integer, Integer> {
  // There are two type of buttons numbers and operators. Therefore we take input
  // the button array and its type
  private JButton[] btnArray;
  public Integer type;
  public Integer ind = 0;

  // This constructor sets the global variables
  public Highlight(JButton[] numBtnArray, Integer type) {
    this.btnArray = numBtnArray;
    this.type = type;
  }

  @Override
  // This thread increments the value of ind in the background, and then goes to
  // sleep for 0.75sec
  protected Integer doInBackground() throws Exception {
    while (true) {
      if (type == 0) // type 0 is for the number buttons and there are 10 numbers [0-9]
        ind = (ind + 1) % 10;
      else // type 1 is for the functions and there are 4 functions [+,-,*,/]
        ind = (ind + 1) % 4;
      publish(ind); // value is published for UI update from EHT
      Thread.sleep(750);
    }
  }

  // The process is run by the EHT when a value is published from doInBackground
  // it highlights the color of current object and changes back the color of
  // previous object
  @Override
  protected void process(final List<Integer> chunks) {
    for (Integer temp : chunks) {
      if (type == 0) {
        btnArray[temp].setForeground(new Color(255, 255, 255));
        btnArray[temp].setBackground(new Color(38, 74, 202));
        btnArray[temp > 0 ? (temp - 1) : 9].setForeground(new Color(0, 0, 0));
        btnArray[temp > 0 ? (temp - 1) : 9].setBackground(new Color(225, 225, 225));
      } else {
        btnArray[temp].setForeground(new Color(0, 0, 0));
        btnArray[temp].setBackground(new Color(238, 130, 238));
        btnArray[temp > 0 ? (temp - 1) : 3].setForeground(new Color(255, 255, 255));
        btnArray[temp > 0 ? (temp - 1) : 3].setBackground(new Color(128, 0, 128));
      }
    }
  }
}
