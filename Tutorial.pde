class Tutorial implements View {
    Button back = new Button(loadImage("ui/opt/back.png"), 0.45 * 0.323, 0.45 * 0.114, 0.5, 0.7, "menu");
    PImage backdrop = loadImage("ui/menu/bkg.png");
    PImage normal = loadImage("ui/game/note.png");
    PImage hold = loadImage("ui/game/hold.png");
    
    void nextFrame() {
        imageMode(CORNER);
        image(backdrop,0,0,width,height);
        textSize(50);
        fill(#ea9f75);
        text("How to play: ", 60, 60);
        textSize(30);
        text("- Tap on beat when a normal note reaches the blue line", 60, 100);
        text("- Use either D, F, J, or K to hit the notes", 60, 130);
        text("- Hold notes require you to hold down the key and are different from the normal notes", 60, 160);
        text("- Hold them until it ends", 60, 190);
        image(normal, width / 4, height * 3 / 4);
        image(hold, width * 3 / 4, height * 3 / 4);
        back.draw();
    }
    
    void initialize(String s) {
        back.show();
    }
    void destructor() {
        back.hide();
    }
    
}