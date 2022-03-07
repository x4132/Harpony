class Cutscene implements View {
    JSONObject data;
    double ticks = -1;
    int startFrameCount = -1;
    int charPerTick = -1;
    
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
    
    void nextFrame() {
        // frame independent render
        if (ticks >= 0 && startFrameCount >= 0 && charPerTick >= 0) {
            text(data.getString("text").substring(0,(int) ticks * charPerTick), 0, 0);
            if (ticks <= data.getInt("ticks")) {
                println(ticks);
                ticks += 60 / frameRate;
            }
        }
    }
    
    void startAnimation() {
        ticks = 0;
        startFrameCount = frameCount;
        charPerTick = data.getString("text").length() / data.getInt("ticks");
    }
}