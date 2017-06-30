int picNum = 71;
int vecNum = 0;
int vecMatch = 0;
int size = 0;

int largest = 0;

Input[] database = new Input[picNum];
String vectorData = " "; //used for concatination

Input input = new Input("Test_A.png");

void characterMatch() {
  for (int i = 0; i < picNum; i++) { // for each of the images in the database
    if (input.vecNum == database[i].vecNum) {
      println("CHARACTER MATCH: " + database[i].name);
    } else {
      //println("NO PERFECT MATCH");
      matchSearch();
    }
  }
}

void matchSearch() {
  for (int i = 0; i < picNum; i++) {
    if (input.input.size() < database[i].input.size()) {
      size = input.input.size();
    } else {
      size = database[i].input.size();
    }

    for (int a = 0; a < size; a++) {
      if (input.input.get(a).x == database[i].input.get(a).x && input.input.get(a).y == database[i].input.get(a).y) {
        database[i].vecMatch++;
      } else {
      }
    }
  }
  
  for (int i = 0; i < picNum; i++) {
    if (i+1 < 71) {
      if (database[i].vecMatch > database[i+1].vecMatch) {
        largest = database[i].vecMatch;
        database[i].largest = largest;
      }
    }
  }
}

void setup() {
  size(500, 500); //size of the window
  //Input Image
  input.load();
  for (int a = 0; a < 50; a++) {
    for (int b = 0; b < 50; b++) {
      if (input.image.get(b, a) != color(255)) {
        input.searchImage(b, a);
      }
    }
  }
  input.vectorData = input.input + " ";
  //println("Input: " + input.input);

  //Database
  for (int i = 0; i < picNum; i++) {
    database[i] = new Input(i + ".png"); //fill array with images
    database[i].load();
    for (int a = 0; a < 50; a++) {
      for (int b = 0; b < 50; b++) {
        if (database[i].image.get(b, a) != color(255)) {
          database[i].searchImage(b, a);
        }
      }
    }
    database[i].vectorData = database[i].input + " ";
  }

  ////SEARCH ALGORITHM
  if (input.vecNum > 1500) {
    input.vecNum = input.vecNum/2;
    //println("New VecNum: " + vecNum);
    characterMatch();
  } else {
    characterMatch();
  }
  println("Largest VecMatch: " + largest);
  for (int i = 0; i < picNum; i++) {
    if (database[i].largest == largest) {
      println("Character Match: " + database[i].name);
    }
  }
  println("DONE");
}

void draw() {
  //image(image, 0, 0, 500, 500); //draw the image
  for (int i = 0; i < input.input.size() - 1; i++) { //draw the vector
    stroke(0, 0, 255);
    strokeWeight(3);
    point(input.input.get(i).x * 10, input.input.get(i).y * 10);
    //strokeWeight(1);
    //line(input.get(i).x * 10, input.get(i).y * 10, input.get(i+1).x * 10, input.get(i+1).y * 10);
  }
  
  for (int i = 0; i < picNum; i++) {
    if (database[i].largest == largest) {
      for (int a = 0; a < database[i].input.size(); a++) {
        stroke(255, 0, 0);
        point(database[i].input.get(a).x * 10, database[i].input.get(a).y * 10);
      }
    }
  }
}