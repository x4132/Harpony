import processing.sound.*;
import java.util.ArrayList;
import java.util.Iterator;

int missBound = 198;
int niceBound = 128;

class Game implements View, KeyboardEventListener {
    JSONObject data;
    int startTime = 0;
    int score = 0;
    int combo = 0;
    int total = 0;
    float PPN = 0;
    
    PImage backdrop = loadImage("ui/game/bkg.png");
    
    PImage track = loadImage("ui/game/track.png");
    
    SoundFile song;
    
    OsuFile osu;
    
    Track t0, t1, t2, t3;
    
    void initialize(String s) {
        osu = new OsuFile("beatmaps/HappyFakeShow_" + curDiff + ".osu", sketchPath());

        startTime = 0;
        score = 0;
        combo = 0;
        total = 0;
        PPN = 0;
        
        t0 = new Track(osu.cols.get(0), this);
        t1 = new Track(osu.cols.get(1), this);
        t2 = new Track(osu.cols.get(2), this);
        t3 = new Track(osu.cols.get(3), this);
        
        total = osu.total;
        PPN = 1000000f / total;
        
        keyboardManager.subscribe(this);
        
        println("audio/" + osu.audioFile);
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

        // push();
    }
    
    void keyDown() {
        ArrayList<Note> list = osu.cols.get(0);
        
        
        switch(keyCode) {
            case 68 : // D
                if (!osu.cols.get(0).isEmpty()) {
                    list = osu.cols.get(0);
                } else return;
                break;
            case 70 : // F
                if (!osu.cols.get(1).isEmpty()) {
                    list = osu.cols.get(1);
                } else return;
                break;
            case 74 : // J
                if (!osu.cols.get(2).isEmpty()) {
                    list = osu.cols.get(2);
                } else return;
                break;
            case 75 : // K
                if (!osu.cols.get(3).isEmpty()) {
                    list = osu.cols.get(3);
                } else return;
                break;
            default: return;
        }
        
        Note cur = list.get(0);
        int tick = millis() - startTime;
        int accuracy = Math.abs(cur.time - tick);
        if (accuracy > missBound + 200) {
            return;
        }
        if (accuracy > missBound) { // miss
            combo = 0;
            list.remove(0);
            return;
        }
        if (cur instanceof Hold) {
            combo++;
            score += PPN;
        } else {
            list.remove(0);
            combo++;
            if (accuracy > niceBound) { // nice hit
                score += PPN / 2;
            } else { // perfect hit
                score += PPN;
            }
        }
    }
    
    void keyUp() {
        ArrayList<Note> list = osu.cols.get(0);
        
        
        switch(keyCode) {
            case 68 : // D
                if (!osu.cols.get(0).isEmpty()) {
                    list = osu.cols.get(0);
                } else return;
                break;
            case 70 : // F
                if (!osu.cols.get(1).isEmpty()) {
                    list = osu.cols.get(1);
                } else return;
                break;
            case 74 : // J
                if (!osu.cols.get(2).isEmpty()) {
                    list = osu.cols.get(2);
                } else return;
                break;
            case 75 : // K
                if (!osu.cols.get(3).isEmpty()) {
                    list = osu.cols.get(3);
                } else return;
                break;
            default: return;
        }
        
        Note cur = list.get(0);
        if (cur instanceof Hold) {
            int tick = millis() - startTime;
            int accuracy = Math.abs(cur.endT - tick);
            list.remove(0);
            if (accuracy > missBound) { // miss
                combo = 0;
                return;
            } else {
                combo++;
                score += PPN;
            }
        }
    }
}

class Note {
    int time;
    int endT;
    int noteSpeed = 350; // % of the screen/s
    
    ArrayList<Note> list;
    
    PImage note = loadImage("ui/game/note.png");
    
    Note(int time) {
        this.time = time;
        this.endT = time;
        this.list = list;
    }
    
    void nextFrame(int tick, int xPos, int noteWidth, int linePos, Iterator<Note> it, Track track) {
        if (tick > time + missBound + 5) {
            track.g.combo = 0;
            it.remove();
            return;
        }
        
        image(note, xPos + 5,(int) Math.floor((tick - time) * (noteSpeed / 1000d)) + linePos, noteWidth - 10,(int) Math.floor((noteWidth - 10) * (63d / 192)));
    }
}

class Hold extends Note {
    boolean pressed;
    Track track;
    
    PImage begin = loadImage("ui/game/begin.png");
    PImage middle = loadImage("ui/game/middle.png");
    PImage end = loadImage("ui/game/end.png");
    
    Hold(int time, int end) {
        super(time);
        this.endT = end;
    }
    
    void nextFrame(int tick, int xPos, int noteWidth, int linePos, Iterator<Note> it, Track track) {
        if (tick > endT + missBound) {
            it.remove();
            track.g.combo = 0;
            return;
        }
        
        image(end, xPos + 5,(int) Math.floor((tick - time) * (noteSpeed / 1000d)) + linePos, noteWidth - 10,(int) Math.floor((noteWidth - 10) * (63d / 192)));
        image(middle, xPos + 5, (int) Math.floor((tick - endT) * (noteSpeed / 1000d)) + linePos, noteWidth - 10, (int) Math.floor((tick - time) * (noteSpeed / 1000d)) - (int) Math.floor((tick - endT) * (noteSpeed / 1000d)));
        image(begin, xPos + 5,(int) Math.floor((tick - endT) * (noteSpeed / 1000d)) + linePos, noteWidth - 10,(int) Math.floor((noteWidth - 10) * (63d / 192)));
    }
}

class Track {
    ArrayList<Note> notes;
    Game g;
    
    Track(ArrayList<Note> notes, Game g) {
        this.notes = notes;
        this.g = g;
    }
    
    void nextFrame(int tick, int col, int lineWidth, int noteWidth, int linePos) {
        int xPos = (int) Math.floor(noteWidth * col + lineWidth * (col + 1) + width * 0.4);
        
        Iterator<Note> it = notes.iterator();
        while(it.hasNext()) {
            it.next().nextFrame(tick, xPos, noteWidth, linePos, it, this);
        }
    }
}
