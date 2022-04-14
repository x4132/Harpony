class TrackFail implements View {
    PImage backdrop = loadImage("ui/fail/bkg.png");
    PImage title = loadImage("ui/fail/title.png");
    Button restart;
    Button quit;

    void initialize(String opt) {
        quit = new Button(loadImage("ui/fail/quit.png"), 0.359 * 0.65, 0.145 * 0.65, 0.5, 0.8, "menu");

        if (opt.equals("next")) {
            restart = new Button(loadImage("ui/fail/restart.png"), 0.534 * 0.65, 0.126 * 0.65, 0.5, 0.5, "start");
        } else {
            restart = new Button(loadImage("ui/fail/restart.png"), 0.534 * 0.65, 0.126 * 0.65, 0.5, 0.5, "end");
        }
        

        quit.show();
        restart.show();
    }

    void destructor() {
        quit.hide();
        restart.hide();
    }

    void nextFrame() {
        imageMode(CORNER);
        image(backdrop, 0, 0, width, height);
        imageMode(CENTER);
        image(title, width / 2, height * 0.2, width * 1.167 * 0.65, width * 0.208 * 0.65);

        quit.draw();
        restart.draw();
    }
}