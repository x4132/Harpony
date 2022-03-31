class Cutscene implements View {
    JSONObject data;
    double ticks = -1;
    int startFrameCount = -1;
    double charPerTick = -1;

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
        
        this.startAnimation();
    }

    void destructor() {
        
    }
    
    void nextFrame() {
        imageMode(CORNER);
        image(backdrop, 0, 0, width, height);

        // frame compensator
        if (ticks >= 0 && startFrameCount >= 0 && charPerTick >= 0) {
            textSize(data.getInt("textSize"));
            fill(#ea9f75);
            text(data.getString("text").substring(0,(int) (ticks * charPerTick)), 10, 10, width, height);
            if (ticks <= data.getInt("ticks")) {
                ticks += 60 / frameRate;
            } else {
                ticks = data.getInt("ticks");
            }
        }
    }
    
    void startAnimation() {
        ticks = 0;
        startFrameCount = frameCount;
        charPerTick = (float) data.getString("text").length() / data.getInt("ticks");
    }
}