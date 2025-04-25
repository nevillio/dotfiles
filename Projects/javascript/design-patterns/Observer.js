// NOTE: If there are many observers, try to run the methods in parallel. (Promise.all)
// NOTE: Not advisable when the observers relate to each other (result of one shouldn't affect another)
class Publisher {
  constructor() {
    this.observers = [];
    this.state = 0;
  }
  subscribe(observer) {
    const isExistent = this.observers.includes(observer);
    if (isExistent)
      return console.log("Publisher: Already subscribed to this observer");
    console.log("Publisher: Subscribed to a new observer");
    this.observers.push(observer);
  }
  unsubscribe(observer) {
    const observerIndex = this.observers.indexOf(observer);
    if (observerIndex === -1)
      return console.log("Publisher: Nonexistent observer");
    console.log("Removed an observer");
    this.observers = this.observers.filter((obs) => obs !== observer);
    // this.observers.splice(observerIndex,1);
  }
  notify() {
    console.log("Publisher: Notifying observers...");
    this.observers.forEach((obs) => obs.update(this));
  }
  someBusinessLogic(newState) {
    console.log("\nPublisher: I'm pretending to do something important.");
    this.state = newState;
    console.log(`Publisher: My state has just changed to: ${this.state}`);
    this.notify();
  }
}

class ObserverA {
  update(publisher) {
    if (publisher.state < 3) {
      console.log("ObserverA: Reacted to the event");
    }
  }
}

class ObserverB {
  update(publisher) {
    if (publisher.state === 0 || publisher.state >= 2)
      console.log("ObserverB: Reacted to the event");
  }
}

const publisher = new Publisher();

const observer1 = new ObserverA();
const observer2 = new ObserverB();

publisher.subscribe(observer1); //Publisher: Subscribed to a new observer

publisher.subscribe(observer2); //Publisher: Subscribed to a new observer

publisher.someBusinessLogic(0); //ObserverB: Reacted to the event

publisher.unsubscribe(observer2); //Removed an observer
publisher.someBusinessLogic(2); //ObserverA: Reacted to the event
