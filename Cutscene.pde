class Cutscene implements View {
    JSONObject data;
    double ticks = -1;
    int startFrameCount = -1;
    double charPerTick = -1;
    
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
        // frame compensator
        if (ticks >= 0 && startFrameCount >= 0 && charPerTick >= 0) {
            textSize(128);
            fill(0);
            text(data.getString("text").substring(0,(int) (ticks * charPerTick)), 40, 120);
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