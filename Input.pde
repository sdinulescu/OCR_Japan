class Input {
  String name;
  PImage image;
  int vecNum = 0;
  int vecMatch = 0;
  String vectorData = " ";
  ArrayList<PVector> input = new ArrayList<PVector>(); //creates an arrayList to store PVector data for each grid area
  
  Input(String name) {
    this.name = name;
  }
  
  void load() {
    image = loadImage(name);
    image.resize(50, 50); //size the image for standardization
    image.filter(THRESHOLD); //sets image to black and white, depending on whether it is above 0.5 threshold
    image.loadPixels(); //loads pixels to allow getting function
  }

  void searchImage(int x, int y) {
    if (x > 49 || x < 0 || y > 49 || y < 0) {
    } else {
      if (image.get(x, y) == image.get(x+1, y)) {
        input.add(new PVector(x, y));
        vecNum++;
        searchImage(x+1, y);
      }
    }
  }
}