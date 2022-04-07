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
        
        song = new SoundFile(parent, "audio/"+ osu.audioFile);

        song.play();
        startTime = millis();
    }
    
    void destructor() {
        
    }
    
    void nextFrame() {
        imageMode(CORNER);
        image(backdrop, 0, 0, width, height);
        image(track, width * 0.4, 0, width * 0.5, height);
        int lineWidth = (int) Math.round(width * 0.4 * (15d / 875d));
        int noteWidth = Math.round((width * 0.5 - lineWidth * 5) / 4);
        int linePos = (int) Math.round(height * (1472d / 1750d));
        int tick = millis() - startTime;
        t0.nextFrame(tick, 0, lineWidth, noteWidth, linePos);
        t1.nextFrame(tick, 1, lineWidth, noteWidth, linePos);
        t2.nextFrame(tick, 2, lineWidth, noteWidth, linePos);
        t3.nextFrame(tick, 3, lineWidth, noteWidth, linePos);
    }
    
    void trigger() {
        switch(keyCode) {
            case 68 : // D
                osu.cols.get(0).remove(0);
                break;
            case 70 : // F
                osu.cols.get(1).remove(0);
                break;
            case 74 : // J
                osu.cols.get(2).remove(0);
                break;
            case 75 : // K
                osu.cols.get(3).remove(0);
                break;
        }
    }
}

class Note {
    int time;
    int noteSpeed = 400; // % of the screen/s
    
    PImage note = loadImage("ui/game/note.png");
    
    Note(int time) {
        this.time = time;
    }
    
    void nextFrame(int tick, int xPos, int noteWidth, int linePos) {
        image(note, xPos + 5,(int) Math.floor((tick - time) * (noteSpeed / 1000d)) + linePos, noteWidth - 10, noteWidth * (63f / 192));
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
        int xPos = Math.round(noteWidth * col + lineWidth * (col + 1) + width * 0.4);
        
        for (Note n : notes) {
            n.nextFrame(tick, xPos, noteWidth, linePos);
        }
    }
}
