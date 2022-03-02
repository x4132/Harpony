import processing.javafx.*;

ViewManager viewManager = new ViewManager();

void setup() {
    // fullScreen();
    size(800, 600, FX2D);
}

void draw() {
    viewManager.nextFrame();
}