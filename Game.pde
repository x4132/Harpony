class Game implements View {
    JSONObject data;
    int startFrameCount = 0;

    void initialize(String s) {
        data = loadJSONObject("cutscene/" + s);
    }

    void destructor() {

    }

    void nextFrame() {

    }
}

class Note {

}