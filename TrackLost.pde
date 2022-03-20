class TrackLost extends View {
    Button restart = new Button (loadImage("ui/failRestart.png"), 1, 1, 0.4, "restart");
    Button quit = new Button (loadImage("ui/failQuit.png"), 1,1,0.5, "quit");
    
    PImage backdrop = loadImage("ui/failBkg.png");
    void nextFrame(){}
    void initialize(String s){}
    
}