import processing.javafx.*;

ViewManager viewManager = new ViewManager();

void setup() {
    // fullScreen();
    size(800, 600, FX2D);
    viewManager.initialize(null);
}

void draw() {
    background(255);
    viewManager.nextFrame();
}