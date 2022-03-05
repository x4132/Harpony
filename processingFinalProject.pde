import processing.javafx.*;
ViewManager viewManager = new ViewManager();
ClickEventManager clickEventManager = new ClickEventManager();

void setup() {
    // fullScreen();
    size(800, 600, FX2D);
    viewManager.initialize(null);
}

void draw() {
    background(255);
    viewManager.nextFrame();
}

void mousePressed() {
    clickEventManager.mouseDown();
}