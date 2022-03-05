interface EventListener {
    void trigger();
}

class ClickEventManager {
    ArrayList<EventListener> followers = new ArrayList<EventListener>();
    
    void subscribe(EventListener e) {
        followers.add(e);
    }
    
    void mouseDown() {
        for (EventListener e : followers) {
            e.trigger();
        }
    }
}