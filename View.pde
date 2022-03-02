class ViewManager {
    int curView;
    private View[] views = new View[4];

    void nextFrame() {
        views[curView].nextFrame();
    }

    void setView(int view) {
        curView = view;
    }
    void setView(int view, String opt) {
        curView = view;
        this.getCurrent().initialize(opt);
    }

    View getCurrent() {
        return views[curView];
    }
}

interface View {
    void nextFrame();
    void initialize(String s);
}