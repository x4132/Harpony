class Game implements View {
    JSONObject data;
    int startFrameCount = 0;
    int score = 0;
    int combo = 0;

    PImage backdrop = loadImage("ui/game/bkg.png");

    PImage track = loadImage("ui/game/track.png");

    PImage note = loadImage("ui/game/note.png");
    PImage begin = loadImage("ui/game/begin.png");
    PImage middle = loadImage("ui/game/middle.png");
    PImage end = loadImage("ui/game/end.png");

    void initialize(String s) {
        data = loadJSONObject("beatmaps/" + s + "_" + curDiff + ".json");
    }

    void destructor() {

    }

    void nextFrame() {
        imageMode(CORNER);
        image(backdrop, 0, 0, width, height);
        image(track, width * 0.4, 0, height/1.7, height);
        textFont(eina_MB, 40/* 40 = 800/20)*/);
        textAlign(CORNER);
        fill(#77a6e0);
        text("Score: " + score, width*0.05+3, height *0.1+3);
        fill(#a5cdff);
        text("Score: " + score, width*0.05, height *0.1);
        textSize(30);
        fill(#77a6e0);
        text("Combo: " + combo, width*0.05, height *0.2);
        // fill(#a5cdff);
        // text("Combo: " + combo, width*0.05, height *0.2);
    }
}

class Note {

}