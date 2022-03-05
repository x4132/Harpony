import processing.javafx.*;
//import processing.sound.*;
//SoundFile file;
ViewManager viewManager = new ViewManager();
ClickEventManager clickEventManager = new ClickEventManager();

void setup() {
    // fullScreen();
    size(800, 600, FX2D);
    viewManager.initialize(null);
    // file = new SoundFile(this, "audio/HappyFakeShow.wav");
    // file.play();
    // file.loop();
}

void draw() {
    background(255);
    viewManager.nextFrame();
}

void mousePressed() {
    clickEventManager.mouseDown();
}