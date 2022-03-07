import java.util.EnumMap;

class ViewManager implements View {
    Views curView;
    private EnumMap<Views, View> map = new EnumMap<Views, View>(Views.class);

    void nextFrame() {
        if (map.get(curView) != null) {
            map.get(curView).nextFrame();
        }
    }

    void setView(Views view) {
        curView = view;
    }
    void setView(Views view, String opt) {
        curView = view;
        this.getCurrent().initialize(opt);
    }

    View getCurrent() {
        return map.get(curView);
    }

    void initialize(String s) {
        map.put(Views.MENU, new Menu());
        map.put(Views.CUTSCENE, new Cutscene());

        this.setView(Views.MENU);
    }
}

interface View {
    void nextFrame();
    void initialize(String s);
}

enum Views {
    MENU,
    CUTSCENE,
    GAME,
    OPTIONS
}