class Options implements View {
    ButtonGroup bgroup = new ButtonGroup();
    Button back = new Button(loadImage("ui/opt/back.png"), 0.45 * 0.323, 0.45 * 0.114, 0.5, 0.7, "menu");
    
    PImage backdrop = loadImage("ui/opt/bkg.png");
    PImage title = loadImage("ui/opt/title.png");
    
    Options() {
        bgroup.add(loadImage("ui/opt/easy.png"), 0.45 * 0.315, 0.45 * 0.118, 0.2, 0.5, "difficulty_easy");
        bgroup.add(loadImage("ui/opt/hard.png"), 0.45 * 0.314, 0.45 * 0.108, 0.4, 0.5, "difficulty_hard");
        bgroup.add(loadImage("ui/opt/impossible.png"), 0.45 * 0.677, 0.45 * 0.123, 0.7, 0.5, "difficulty_impossible");
        bgroup.trigger("difficulty_easy", 0);
    }
    
    void nextFrame() {
        imageMode(CORNER);
        image(backdrop, 0, 0, width, height);
        imageMode(CENTER);
        image(title, width / 2, height * 0.2, width * 0.45 * 0.685, width * 0.45 * 0.160);
        
        bgroup.draw();

        back.draw();
    }
    
    void initialize(String s) {
        bgroup.initialize();
        back.show();
    }

    void destructor() {
        bgroup.destructor();
        back.hide();
    }
}

class ButtonGroup { // FOR ToggleableButton and ToggleableButton ONLY
    protected ArrayList<ToggleableButton> buttons = new ArrayList<ToggleableButton>();
    String toggleType = "difficulty_easy";
    int toggleKey = 0;
    
    void add(PImage image, float scaleW, float scaleH, float posX, float posY, String type) {
        buttons.add(new ToggleableButton(image, scaleW, scaleH, posX, posY, type, this, buttons.size()));
    }
    
    void draw() {
        for (ToggleableButton b : buttons) {
            b.draw();
        }
    }

    void trigger(String type, int key) {
        buttons.get(toggleKey).toggle(false);
        toggleType = type;
        toggleKey = key;
        buttons.get(key).toggle(true);
    }

    void initialize() {
        for (ToggleableButton b : buttons) {
            b.show();
        }
    }
    void destructor() {
        for (ToggleableButton b : buttons) {
            b.hide();
        }
    }
}

class ToggleableButton extends Button { // MUST USE IN A BUTTONGROUP (1 BUTTON GROUPS ARE ALSO A THING)
    boolean toggled = false;
    ButtonGroup parent;
    int key;
    
    ToggleableButton(PImage image, float scaleW, float scaleH, float posX, float posY, String type, ButtonGroup parent, int key) {
        super(image, scaleW, scaleH, posX, posY, type);
        this.parent = parent;
        this.key = key;
    }
    
    void draw() {
        imageMode(CENTER);
        if (toggled) {
            pushMatrix();
            translate(width * posX, height * posY);
            rotate(-PI / 12);
            image(image, 0, 0, width * scaleW * 1.1, width * scaleH * 1.1);
            popMatrix();
        } else {
            super.draw();
        }
    }

    void toggle(boolean t) {
        toggled = t;
    }
    
    void trigger() {
        if (mouseX < width * posX + ((width * scaleW) / 2) && mouseX > width * posX - ((width * scaleW) / 2)
            && mouseY < height * posY + ((width * scaleH) / 2) && mouseY > height * posY - ((width * scaleH) / 2)) {
            parent.trigger(type, key);
        }
    }
}