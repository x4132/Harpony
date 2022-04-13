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

interface KeyboardEventListener {
    void keyDown();
    void keyUp();
}

class KeyboardManager {
    HashSet<KeyboardEventListener> subscribers = new HashSet<KeyboardEventListener>();
    
    void subscribe(KeyboardEventListener e) {
        subscribers.add(e);
    }
    
    void unsubscribe(KeyboardEventListener e) {
        subscribers.remove(e);
    }
    
    void keyDown() {
        HashSet<KeyboardEventListener> tempSet = new HashSet<KeyboardEventListener>(subscribers);
        for (KeyboardEventListener e : tempSet) {
            e.keyDown();
        }
    }

    void keyUp() {
        HashSet<KeyboardEventListener> tempSet = new HashSet<KeyboardEventListener>(subscribers);
        for (KeyboardEventListener e : tempSet) {
            e.keyUp();
        }
    }
}