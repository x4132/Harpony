class Game implements View {
    JSONObject data;
    int startFrameCount = 0;

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
        image(track, width * 0.4, 0, width * 0.5, height);
        int lineWidth = (int) Math.round(width * 0.4 * 0.0165394402035623d);
        
    }
}

class Note {

}