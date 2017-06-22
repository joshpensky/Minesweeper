public class MinesweeperView {
  private int headerSize;
  private int cellSize;
  private MinesweeperOperations model;
  private final PFont mono = loadFont("mono.vlw");
  private final color RED = color(#FF4360);
  private final color YELLOW = color(#FFF72B);
  private DrawUtils utils;
  private final PImage happy = loadImage("happy.png");
  private final PImage sad = loadImage("sad.png");
  private final PImage thinking = loadImage("thinking.png");
  private final PImage nervous = loadImage("nervous.png");
  
  public MinesweeperView(MinesweeperOperations model) {
    this.headerSize = height - width;
    this.model = model;
    this.utils = new DrawUtils();
  }
  
  public Posn getMousePosition(int mX, int mY) {
    return new Posn(mX / this.cellSize, (mY - this.headerSize) / this.cellSize);
  }
  
  public void display() {
    background(100);
    this.displayCells();
    this.displayHeader();
  }
  
  private void displayCells() {
    this.cellSize = width / model.getSize();
    List<Cell> cells = model.getCells();
    for (Cell c : cells) {
      c.display(headerSize, cellSize);
    }
  }
  
  private void displayHeader() {
    fill(240);
    rect(0, 0, width, this.headerSize);
    fill(30);
    rect(20, 20, 300, this.headerSize - 40);
    rect(width - 320, 20, 300, this.headerSize - 40);
    fill(RED);
    textAlign(CENTER, CENTER);
    textFont(mono, 150);
    text(utils.padNumber(this.model.getFlags(), 3), 170, (this.headerSize / 2));
    text(utils.padNumber(this.model.getTime(), 3), width - 170, (this.headerSize / 2));
    fill(YELLOW);
    PImage emoji;
    switch (this.model.getState()) {
      case WIN:
        emoji = happy;
        break;
      case LOSE:
        emoji = sad;
        break;
      case MOUSEPRESSED:
        emoji = nervous;
        break;
      default:
        emoji = thinking;
    }
    image(emoji, 330, ((this.headerSize - happy.height) / 2));
    //ellipse(400, this.headerSize / 2, 120, 120);
  }
}