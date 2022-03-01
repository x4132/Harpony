Menu menu = new Menu();

public class View {
    protected int view = 0;
    View(int view) {
        this.view = view;
    }

    void render() {
        switch (view) {
            case 0:
                menu.render();
        }
    }
}