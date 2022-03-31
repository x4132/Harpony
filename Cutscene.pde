class Cutscene implements View, EventListener {
    JSONObject data;
    double ticks = -1;
    int startFrameCount = -1;
    double charPerTick = -1;

    boolean animDone = false;
    
    PImage backdrop = loadImage("ui/cutscene/bkg.png");
    
    void initialize(String s) {
        String path = "";
        switch(s) {
            case "begin":
                path = "intro.json";
                break;
        }
        
        try{
            data = loadJSONObject("cutscenes/" + path);
        } catch(Exception e) {
            throw new RuntimeException(e);
        }
        
        clickEventManager.subscribe(this);

        this.startAnimation();
    }
    
    void destructor() {
        clickEventManager.unsubscribe(this);
    }
    
    void nextFrame() {
        imageMode(CORNER);
        image(backdrop, 0, 0, width, height);
        
        // frame compensator
        if (ticks >= 0 && startFrameCount >= 0 && charPerTick >= 0 && ticks < data.getInt("ticks")) {
            textSize(data.getInt("textSize"));
            fill(#ea9f75);
            textAlign(CENTER);
            text(data.getString("text").substring(0,(int) Math.round(ticks * charPerTick)), 10, 10, width - 20, height - 20);
            if (ticks < data.getInt("ticks")) {
                ticks += 60 / frameRate;
                if (ticks > data.getInt("ticks")) {
                    animDone = true;
                    ticks = data.getInt("ticks");
                }
            }
        } else {
            textAlign(CENTER);
            text(data.getString("text").substring(0,(int) Math.round(ticks * charPerTick)), 10, 10, width - 20, height - 20);
            push();
            fill(#ea9f75, Math.round(Math.sin(frameCount / 15f) * 127.5 + 127.5));
            text("> Click to Continue <", width * 0.5, height * 0.9);
            pop();
        }
    }
    
    void nextScene() {
        viewManager.setView(Views.valueOf(data.getJSONObject("endAction").getString("view")), data.getJSONObject("endAction").getString("opt"));
    }

    void trigger() {

    }
    
    void startAnimation() {
        ticks = 0;
        startFrameCount = frameCount;
        animDone = false;
        charPerTick = (float) data.getString("text").length() / data.getInt("ticks");
    }
}