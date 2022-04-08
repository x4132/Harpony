import processing.sound.*;

class Game implements View, EventListener {
    JSONObject data;
    int startTime = 0;
    int score = 0;
    int combo = 0;
    
    PImage backdrop = loadImage("ui/game/bkg.png");
    
    PImage track = loadImage("ui/game/track.png");
    
    PImage begin = loadImage("ui/game/begin.png");
    PImage middle = loadImage("ui/game/middle.png");
    PImage end = loadImage("ui/game/end.png");
    
    SoundFile song;
    
    OsuFile osu;
    
    Track t0, t1, t2, t3;
    
    void initialize(String s) {
        osu = new OsuFile("beatmaps/HappyFakeShow_" + curDiff + ".osu", sketchPath());
        
        t0 = new Track(osu.cols.get(0));
        t1 = new Track(osu.cols.get(1));
        t2 = new Track(osu.cols.get(2));
        t3 = new Track(osu.cols.get(3));
        
        keyboardManager.subscribe(this);
        
        song = new SoundFile(parent, "audio/" + osu.audioFile);
        
        song.play();
        startTime = millis();
    }
    
    void destructor() {
        
    }
    
    void nextFrame() {
        imageMode(CORNER);
        image(backdrop, 0, 0, width, height);
        image(track, width * 0.4, 0, width * 0.5, height);
        textAlign(LEFT);
        textFont(eina_MB, 40);
        fill(#77a6e0);
        text("Score: " + score, width * 0.05 + 3, height * 0.1 + 3);
        fill(#a5cdff);
        text("Score: " + score, width * 0.05, height * 0.1);
        textSize(30);
        fill(#77a6e0);
        text("Combo: " + combo, width * 0.05, height * 0.2);
        
        int lineWidth = (int) Math.floor(width * 0.4 * (15d / 875d));
        int noteWidth = (int) Math.ceil((width * 0.5 - lineWidth * 5) / 4);
        int linePos = (int) Math.floor(height * (1472d / 1750d));
        int tick = millis() - startTime;
        t0.nextFrame(tick, 0, lineWidth, noteWidth, linePos);
        t1.nextFrame(tick, 1, lineWidth, noteWidth, linePos);
        t2.nextFrame(tick, 2, lineWidth, noteWidth, linePos);
        t3.nextFrame(tick, 3, lineWidth, noteWidth, linePos);
        
        
        if (tick < 5000) {
            push();
            textAlign(CENTER);
            fill(#000000, 255 - (tick / 5000f) * 300);
            textSize(32);
            text("D", lineWidth * 1 + width * 0.4, linePos, noteWidth, 500);
            text("F", noteWidth * 1 + lineWidth * 2 + width * 0.4, linePos, noteWidth, 500);
            text("J", noteWidth * 2 + lineWidth * 3 + width * 0.4, linePos, noteWidth, 500);
            text("K", noteWidth * 3 + lineWidth * 4 + width * 0.4, linePos, noteWidth, 500);
            pop();
        }
    }
    
    void trigger() {
        switch(keyCode) {
            case 68 : // D
            if(!osu.cols.get(0).isEmpty()){
                osu.cols.get(0).remove(0);
                break;
            }
            case 70 : // F
            if(!osu.cols.get(0).isEmpty()){
                osu.cols.get(1).remove(0);
                break;
            }
            case 74 : // J
            if(!osu.cols.get(0).isEmpty()){
                osu.cols.get(2).remove(0);
                break;
            }
            case 75 : // K
            if(!osu.cols.get(0).isEmpty()){
                osu.cols.get(3).remove(0);
                break;
            }
        }
    }
}

class Note {
    int time;
    int noteSpeed = 100; // % of the screen/s
    
    PImage note = loadImage("ui/game/note.png");
    
    Note(int time) {
        this.time = time;
    }
    
    void nextFrame(int tick, int xPos, int noteWidth, int linePos) {
        image(note, xPos + 5,(int) Math.floor((tick - time) * (noteSpeed / 1000d)) + linePos, noteWidth - 10,(int) Math.floor(noteWidth * (63d / 192)));
    }
}

class Hold extends Note {
    int end;
    
    Hold(int time, int end) {
        super(time);
        this.end = end;
    }
}

class Track {
    ArrayList<Note> notes;
    
    Track(ArrayList<Note> notes) {
        this.notes = notes;
    }
    
    void nextFrame(int tick, int col, int lineWidth, int noteWidth, int linePos) {
        int xPos = (int) Math.floor(noteWidth * col + lineWidth * (col + 1) + width * 0.4);
        
        for (Note n : notes) {
            n.nextFrame(tick, xPos, noteWidth, linePos);
        }
    }
}
