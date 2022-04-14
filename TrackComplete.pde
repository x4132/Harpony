class TrackComplete implements View {
    PImage backdrop = loadImage("ui/win/bkg.png");
    PImage title = loadImage("ui/win/title.png");

    Button cont;

    void initialize(String opt) {
        cont = new Button(loadImage("ui/win/cont.png"), 0.534 * 0.65, 0.126 * 0.65, 0.5, 0.8, opt);

        cont.show();
    }

    void destructor() {
        cont.hide();
    }

    void nextFrame() {
        imageMode(CORNER);
        image(backdrop, 0, 0, width, height);
        imageMode(CENTER);
        image(title, width / 2, height * 0.2, width * 1.105 * 0.65, width * 0.195 * 0.65);

        cont.draw();
    }
}