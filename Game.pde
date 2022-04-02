class Game implements View {
    JSONObject data;
    int startFrameCount = 0;

    PImage backdrop = loadImage("ui/game/bkg.png");

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
        push();
        stroke(#B3DBFF);
        int lineSize = Math.round(5 + width * 0.003628140704f);
        strokeWeight(lineSize);
        line(width * 0.8, 0, width * 0.8, height);
        line(width * 0.7, 0, width * 0.7, height);
        line(width * 0.6, 0, width * 0.6, height);
        line(width * 0.5, 0, width * 0.5, height);
        line(width * 0.4, 0, width * 0.4, height);
        pop();
        push();
        stroke(#4ABAFF);
        strokeWeight(lineSize * 2);
        line(width * 0.4, height * 0.85, width * 0.8, height * 0.85);
        pop();
        push();
        int noteWidth = width / 10 - lineSize;
        image(note, width * 0.4 + lineSize / 2, 250, noteWidth, noteWidth * 0.351758794f);
        pop();
    }
}

class Note {

}