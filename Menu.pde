class Menu implements View, Event {
    Button start = new Button(loadImage("ui/menuStart.png"), 0.449 * 0.65, 0.127 * 0.65, 0.5);
    Button options = new Button(loadImage("ui/menuOptions.png"), 0.748 * 0.65, 0.166 * 0.65, 0.8);

    PImage backdrop = loadImage("ui/menuBg.png");
    PImage title = loadImage("ui/menuName.png");
    
    void nextFrame() {
        imageMode(CORNER);
        image(backdrop, 0, 0, width, height);
        imageMode(CENTER);
        image(title, width / 2, height * 0.2, width * 0.797 * 0.65, width * 0.159 * 0.65);
        
        start.draw();
        options.draw();
    }
    
    void initialize(String s) {}

}

class Button {
    PImage im = null;
    float scaleW = 0, scaleH = 0;
    float posY = 0;
    
    Button(PImage im, float scaleW, float scaleH, float posY) {
        this.im = im;
        this.scaleW = scaleW;
        this.scaleH = scaleH;
        this.posY = posY;
    }
    
    void draw() {
        imageMode(CENTER);
        if (mouseX < width / 2 + ((width * scaleW) / 2) && mouseX > width / 2 - ((width * scaleW) / 2)
            && mouseY < height * posY + ((width * scaleH) / 2) && mouseY > height * posY - ((width * scaleH) / 2)) {
            image(im, width / 2, height * posY, width * scaleW * 1.1, width * scaleH * 1.1);
        } else {
            image(im, width / 2, height * posY, width * scaleW, width * scaleH);
        }
    }
}
