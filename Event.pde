import java.util.HashSet;

interface EventListener {
    void trigger();
}

class ClickEventManager {
    HashSet<EventListener> subscribers = new HashSet<EventListener>();
    
    void subscribe(EventListener e) {
        subscribers.add(e);
    }
    
    void unsubscribe(EventListener e) {
        subscribers.remove(e);
    }
    
    void mouseDown() {
        HashSet<EventListener> tempSet = new HashSet<EventListener>(subscribers);
        println("ClickEventManager > Click event broadcast to " + tempSet.size() + " subscribers");
        for (EventListener e : tempSet) {
            e.trigger();
        }
    }
}

class KeyboardManager {
    HashSet<EventListener> subscribers = new HashSet<EventListener>();
    
    void subscribe(EventListener e) {
        subscribers.add(e);
    }
    
    void unsubscribe(EventListener e) {
        subscribers.remove(e);
    }
    
    void mouseDown() {
        HashSet<EventListener> tempSet = new HashSet<EventListener>(subscribers);
        println("KeyboardManager > Key event broadcast to " + tempSet.size() + " subscribers");
        for (EventListener e : tempSet) {
            e.trigger();
        }
    }
}