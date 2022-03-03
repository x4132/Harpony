class ViewManager implements View {
    int curView;
    private View[] views = new View[4];

    void nextFrame() {
        if (views[curView] != null) {
            views[curView].nextFrame();
        }
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

    void initialize(String s) {
        views[0] = new Menu();

        this.setView(0);
    }
}

interface View {
    void nextFrame();
    void initialize(String s);
}