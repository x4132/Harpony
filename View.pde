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
        println("ViewManager > " + view.toString());
        this.getCurrent().destructor();
        curView = view;
        this.getCurrent().initialize(null);
    }
    void setView(Views view, String opt) {
        println("ViewManager > " + view.toString() + "/" + opt);
        this.getCurrent().destructor();
        curView = view;
        this.getCurrent().initialize(opt);
    }

    View getCurrent() {
        return map.get(curView);
    }

    void initialize(String s) {
        map.put(Views.MENU, new Menu());
        map.put(Views.CUTSCENE, new Cutscene());
        map.put(Views.OPTIONS, new Options());
        map.put(Views.GAME, new Game());
        map.put(Views.TUTORIAL, new Tutorial());

        this.curView = Views.MENU;
        this.getCurrent().initialize(null);
    }

    void destructor() {}
}

interface View {
    void nextFrame();
    void initialize(String s);
    void destructor();
}

enum Views {
    MENU,
    CUTSCENE,
    GAME,
    OPTIONS,
    TUTORIAL
}