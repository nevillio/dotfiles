public class Main {
  public static class Array {
    private int size = 0;
    private int[] elements;

    public Array(int capacity) { this.elements = new int[capacity]; }

    public void print() {
      if (this.size == 0) {
        System.out.println("Empty array");
        return;
      }
      for (int i = 0; i < this.size; i++) {
        System.out.println(this.elements[i]);
      }
    }

    public void insert(int element) {
      if (this.size == this.elements.length) {
        int[] newArray = new int[this.size * 2];
        System.arraycopy(this.elements, 0, newArray, 0, this.size);
        this.elements = newArray;
      }
      this.elements[this.size++] = element;
    }

    public void removeAt(int index) {
      if (index < 0 || index >= size) {
        System.out.println("index out of bounds");
        return;
      }
      System.arraycopy(this.elements, index + 1, this.elements, index,
                       (this.size) - index - 1);
      this.size--;
    }

    public int indexOf(int element) {
      int index = -1;
      for (int i = 0; i < this.size; i++) {
        if (this.elements[i] == element) {
          index = i;
          break;
        }
      }
      return index;
    }
  }

  public static void main(String[] args) {
    Array numbers = new Array(3);
    numbers.insert(10);
    numbers.insert(20);
    numbers.insert(30);
    numbers.insert(40);
    numbers.removeAt(2);
    System.out.println(numbers.indexOf(10));
    numbers.print();
  }
}
