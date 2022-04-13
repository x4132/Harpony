class Menu implements View{
    Button start = new Button(loadImage("ui/menu/start.png"), 0.537 * 0.45, 0.165 * 0.45, 0.5, 0.4, "start");
    Button tutorial = new Button(loadImage("ui/menu/tutorial.png"), 0.718 * 0.4, 0.180 * 0.4, 0.5, 0.6, "tutorial");
    Button options = new Button(loadImage("ui/menu/options.png"), 0.758 * 0.42, 0.192 * 0.42, 0.5, 0.8, "options");
    
    PImage backdrop = loadImage("ui/menu/bkg.png");
    PImage title = loadImage("ui/menu/name.png");
    
    void nextFrame() {
        imageMode(CORNER);
        image(backdrop, 0, 0, width, height);
        imageMode(CENTER);
        image(title, width / 2, height * 0.2, width * 0.797 * 0.65, width * 0.159 * 0.65);
        
        start.draw();
        tutorial.draw();
        options.draw();
    }
    
    void initialize(String s) {
        start.show();
        tutorial.show();
        options.show();
    }

    void destructor() {
        start.hide();
        tutorial.hide();
        options.hide();
    }
}

class Button implements EventListener {
    PImage image = null;
    float scaleW = 0, scaleH = 0;
    float posX = 0, posY = 0;
    String type;
    boolean shown = false;
    
    Button(PImage image, float scaleW, float scaleH, float posX, float posY, String type) {
        this.image = image;
        this.scaleW = scaleW;
        this.scaleH = scaleH;
        this.posX = posX;
        this.posY = posY;
        this.type = type;
    }

    void show() {
        clickEventManager.subscribe(this);
        shown = true;
    }

    void hide() {
        clickEventManager.unsubscribe(this);
        shown = false;
    }
     
    void draw() {
        imageMode(CENTER);
        if (mouseX < width * posX + ((width * scaleW) / 2) && mouseX > width * posX - ((width * scaleW) / 2)
            && mouseY < height * posY + ((width * scaleH) / 2) && mouseY > height * posY - ((width * scaleH) / 2)) {
            image(image, width * posX, height * posY, width * scaleW * 1.1, width * scaleH * 1.1);
        } else {
            image(image, width * posX, height * posY, width * scaleW, width * scaleH);
        }
    }
    
    void trigger() {
        if (mouseX < width * posX + ((width * scaleW) / 2) && mouseX > width * posX - ((width * scaleW) / 2)
            && mouseY < height * posY + ((width * scaleH) / 2) && mouseY > height * posY - ((width * scaleH) / 2)) {
            switch(type) {
                case "start":
                    viewManager.setView(Views.CUTSCENE, "begin");
                    break;
                case "tutorial":
                    viewManager.setView(Views.TUTORIAL);
                    break;
                case "options":
                    viewManager.setView(Views.OPTIONS);
                    break;
                case "menu":
                    viewManager.setView(Views.MENU);
                    break;
                case"generic":
                default:
                    break;
            }
        }
    }
}