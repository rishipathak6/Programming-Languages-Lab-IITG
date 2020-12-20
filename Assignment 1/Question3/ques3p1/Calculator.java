package ques3p1;

import java.awt.Color;
import java.awt.Font;
import java.awt.EventQueue;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

import javax.swing.JFrame;
import javax.swing.JTextField;
import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.SwingConstants;
import javax.swing.border.LineBorder;

import java.math.BigDecimal;
import java.math.MathContext;

//main calculator class implements standard java keylistner interface
public class Calculator implements KeyListener {
  private JFrame frame; // main Calculator frame
  private Integer calcState = 0; // State of the calculator in FSM based on input
  private Integer selOpInd; // Variable to store the index of selected operation
  private Integer selNumInd; // Variable to store the index of digit pressed

  private JTextField textField; // textfield object
  public JButton[] numBtnArray = new JButton[10]; // Number Button stored in Array
  public JButton[] opBtnArray = new JButton[5]; // Operator and cleaar buttons stored in array

  private Highlight numHighlight = new Highlight(numBtnArray, 0); // highlighted number
  private Highlight opHighlight = new Highlight(opBtnArray, 1); // highlighted operator

  // instructions labels
  private JLabel label1;
  private JLabel label2;
  private JLabel label3;
  private JLabel label4;

  public static void main(String[] args) { // main function that creates the calculator window
    EventQueue.invokeLater(new Runnable() {
      public void run() {
        try {
          // create a new object on start
          Calculator window = new Calculator(); // New calculator window created and made visible
          window.frame.setVisible(true);
          window.frame.setFocusable(true);
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
    });
  }

  public Calculator() { // Constructor
    initialize(); // Render the textfield, buttons and instructions in the frame
    frame.addKeyListener(this); // keylistner is added on the main frame
    numHighlight.execute(); // start the number highlight thread
  }

  private void initialize() { // render all the graphics at appropriate places and properties
    frame = new JFrame(); // Create new frame and set its size and position
    frame.setBounds(100, 100, 290, 520);
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.getContentPane().setLayout(null);

    textField = new JTextField(); // New textfield made
    textField.setHorizontalAlignment(SwingConstants.CENTER); // Text in textfield aligned centered
    textField.setFont(new Font("Tahoma", Font.BOLD, 18));
    textField.setBorder(new LineBorder(Color.BLACK, 1)); // Border color set to black
    textField.setEditable(false); // Made read-only
    textField.setBounds(20, 20, 235, 70); // Position the textfield
    frame.getContentPane().add(textField);
    textField.setColumns(10);

    // Creating, styling and adding number buttons to the frame

    for (int i = 0; i < 10; i++) {
      numBtnArray[i] = new JButton(String.valueOf(i));
      numBtnArray[i].setFont(new Font("Tahoma", Font.BOLD, 18));
      numBtnArray[i].setForeground(new Color(0, 0, 0));
      numBtnArray[i].setBackground(new Color(225, 225, 225));
      frame.getContentPane().add(numBtnArray[i]);
    }
    numBtnArray[7].setBounds(20, 110, 50, 50);
    numBtnArray[8].setBounds(80, 110, 50, 50);
    numBtnArray[9].setBounds(140, 110, 50, 50);
    numBtnArray[4].setBounds(20, 170, 50, 50);
    numBtnArray[5].setBounds(80, 170, 50, 50);
    numBtnArray[6].setBounds(140, 170, 50, 50);
    numBtnArray[1].setBounds(20, 230, 50, 50);
    numBtnArray[2].setBounds(80, 230, 50, 50);
    numBtnArray[3].setBounds(140, 230, 50, 50);
    numBtnArray[0].setBounds(20, 290, 110, 50);

    // Creating, styling and adding operations buttons to the frame

    for (int i = 0; i < 5; i++) {
      opBtnArray[i] = new JButton(getOperator(i));
      opBtnArray[i].setFont(new Font("Tahoma", Font.BOLD, 18));
      opBtnArray[i].setBackground(new Color(128, 0, 128));
      opBtnArray[i].setForeground(new Color(255, 255, 255));
      frame.getContentPane().add(opBtnArray[i]);
    }
    opBtnArray[0].setBounds(205, 110, 50, 50);
    opBtnArray[1].setBounds(205, 170, 50, 50);
    opBtnArray[2].setBounds(205, 230, 50, 50);
    opBtnArray[3].setBounds(205, 290, 50, 50);

    // Creating, styling and adding Clear button to the frame

    opBtnArray[4].setBackground(new Color(176, 48, 96));
    opBtnArray[4].setBounds(140, 290, 50, 50);

    // Adding instruction labels near bottom of the window
    JLabel labelHeading = new JLabel("Instructions:");
    labelHeading.setFont(new Font("Tahoma", Font.BOLD, 16));
    labelHeading.setBounds(20, 360, 150, 18);
    frame.getContentPane().add(labelHeading);

    textField.setFont(new Font("Tahoma", Font.PLAIN, 14));

    // 1st instruction
    label1 = new JLabel("1. Press Enter to select first number");
    label1.setBounds(20, 385, 250, 14);
    frame.getContentPane().add(label1);

    label2 = new JLabel("2. Press Enter to select operator");
    label2.setBounds(20, 405, 250, 14);
    frame.getContentPane().add(label2);

    label3 = new JLabel("3. Press Enter to select second number");
    label3.setBounds(20, 425, 250, 14);
    frame.getContentPane().add(label3);

    label4 = new JLabel("4. Press C to clear");
    label4.setBounds(20, 445, 250, 14);
    frame.getContentPane().add(label4);
  }

  // Function to get the operator binding corresponding to input number
  private String getOperator(Integer num) {
    if (num == 0) {
      return "+";
    } else if (num == 1) {
      return "-";
    } else if (num == 2) {
      return "*";
    } else if (num == 3) {
      return "/";
    } else if (num == 4) {
      return "C";
    } else
      return null;
  }

  // Keypress Events Actions are implemented in states of FSM of the Calculator
  // State 0 - no input State 1 - Number 1 selected State 2 - Operator selected
  // State 3 - Number 2 selected
  @Override
  public void keyPressed(KeyEvent e) {
    if (e.getKeyCode() == 10) { // 10 is code for enter key
      if (calcState == 0) {
        selNumInd = numHighlight.ind;
        numHighlight.cancel(true); // stop number highlight thread;
        textField.setText(textField.getText() + String.valueOf(selNumInd)); // update text field with number
        numBtnArray[selNumInd].setForeground(new Color(0, 0, 0)); // Reset the look of selected number button
        numBtnArray[selNumInd].setBackground(new Color(225, 225, 225));
        opHighlight.execute(); // Start the operation highlight thread
        calcState = 1;
      } else if (calcState == 1) {
        selOpInd = opHighlight.ind;
        textField.setText(textField.getText() + getOperator(selOpInd)); // update text field with number and operator
        opBtnArray[selOpInd].setForeground(new Color(255, 255, 255)); // Reset the look of selected operator button
        opBtnArray[selOpInd].setBackground(new Color(128, 0, 128));

        opHighlight.cancel(true); // stop operation highlight thread
        numHighlight = new Highlight(numBtnArray, 0); // one object can only be run once therefore new object needs to
        // be created
        numHighlight.execute(); // Start the number highlight thread again
        calcState = 2;
      } else if (calcState == 2) {
        selNumInd = numHighlight.ind;
        numHighlight.cancel(true); // stop both highlight thread
        opHighlight.cancel(true);
        textField.setText(textField.getText() + String.valueOf(selNumInd)); // add the second number to the textfield
        numBtnArray[selNumInd].setForeground(new Color(0, 0, 0)); // reset the look of the selected number
        numBtnArray[selNumInd].setBackground(new Color(225, 225, 225));
        textField.setText(textField.getText() + "=" + evaluateExpr(textField.getText())); // Calculate the the total
                                                                                          // expression and place in the
                                                                                          // textfield
        calcState = 3;
      }
    }
    // clear the user input(pressing the C key on keyboard)
    if (e.getKeyCode() == KeyEvent.VK_C) {
      if (calcState == 1) { // If C is pressed after 1 number has been selected and operations are
                            // highlighted
        selOpInd = opHighlight.ind;
        opHighlight.cancel(true); // Stop the operation highlight thread
        opBtnArray[selOpInd].setForeground(new Color(255, 255, 255)); // Reset the look of currently highlighted
                                                                      // operation
        opBtnArray[selOpInd].setBackground(new Color(128, 0, 128));
        numHighlight = new Highlight(numBtnArray, 0); // Create a new number highlight thread and start it
        numHighlight.execute();
        opHighlight = new Highlight(opBtnArray, 1); // Create a new operations highlight thread for later use
        textField.setText(""); // Reset the textfield
        calcState = 0; // Set FSM state to 0
      } else if (calcState == 2) { // If C key is pressed after selecting operator
        opBtnArray[selOpInd].setForeground(new Color(255, 255, 255));
        opBtnArray[selOpInd].setBackground(new Color(128, 0, 128));
        opHighlight = new Highlight(opBtnArray, 1);
        textField.setText("");
        calcState = 0;
      } else if (calcState == 3) { // If C key is pressed after complete procedure
        numHighlight = new Highlight(numBtnArray, 0);
        opHighlight = new Highlight(opBtnArray, 1);
        textField.setText("");
        numHighlight.execute();
        calcState = 0;
      }
    }
  }

  @Override
  public void keyReleased(KeyEvent arg0) {
    return;
  }

  @Override
  public void keyTyped(KeyEvent arg0) {
    return;
  }

  // Function to evaluate the input expression. Expression contains two numbers
  // and one operator
  private String evaluateExpr(String expr) {
    // BigDecimal used for long user inputs
    BigDecimal number1;
    BigDecimal number2;
    BigDecimal answer;
    BigDecimal zero = new BigDecimal("0");
    int opfind = 1;
    // find the position of operator
    while (Character.isDigit(expr.charAt(opfind)))
      opfind++;

    // Find the numbers from expression
    number1 = new BigDecimal(expr.substring(0, opfind));
    number2 = new BigDecimal(expr.substring(opfind + 1, expr.length()));
    // division by zero error
    if (number2.compareTo(zero) == 0 && expr.charAt(opfind) == '/')
      return "Invalid";

    // evaluate operations
    if (expr.charAt(opfind) == '*')
      answer = number1.multiply(number2);
    else if (expr.charAt(opfind) == '+')
      answer = number1.add(number2);
    else if (expr.charAt(opfind) == '/')
      answer = number1.divide(number2, MathContext.DECIMAL32);
    else
      answer = number1.subtract(number2);
    return answer.toString();
  }
}
