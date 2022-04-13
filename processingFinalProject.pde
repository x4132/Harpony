import processing.javafx.*;
ViewManager viewManager = new ViewManager();
ClickEventManager clickEventManager = new ClickEventManager();
KeyboardManager keyboardManager = new KeyboardManager();
PFont open_sans;
PFont eina_MB;
String curDiff = "difficulty_easy";

PApplet parent;

void setup() {
    // fullScreen();
    parent = this;
    size(800, 600, FX2D);
    open_sans = createFont("ui/Eina01-Regular.ttf", 32);
    eina_MB = createFont("ui/Eina01-SemiBold.ttf", 32);
    textFont(open_sans, 32);
    viewManager.initialize(null);
}

void draw() {
    background(255);
    viewManager.nextFrame();
}

void mousePressed() {
    clickEventManager.mouseDown();
}

void keyPressed() {
    keyboardManager.keyDown();
}
