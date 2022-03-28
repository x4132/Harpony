import processing.javafx.*;
ViewManager viewManager = new ViewManager();
ClickEventManager clickEventManager = new ClickEventManager();
PFont open_sans;

void setup() {
    // fullScreen();
    size(800, 600, FX2D);
    viewManager.initialize(null);
    open_sans = createFont("ui/Eina01-Regular.ttf", 32);
    textFont(open_sans, 32);
}

void draw() {
    background(255);
    viewManager.nextFrame();
}

void mousePressed() {
    clickEventManager.mouseDown();
}