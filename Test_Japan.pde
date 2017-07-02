//Optical Character Recognition
//Stejara Dinulescu
//June 6-July 4, 2017

Table table;

int picNum = 71;
int size = 0;
int testNum = 2;

int largest = 0;

Input[] database = new Input[picNum];

Input input = new Input("Test_Be.png");

void characterMatch() {
  for (int i = 0; i < picNum; i++) { // for each of the images in the database
    if (input.vecNum == database[i].vecNum) {
      println("CHARACTER MATCH: " + database[i].name);
    } else if (input.vecNum == (database[i].vecNum + 50) || input.vecNum == (database[i].vecNum - 50)) {
      println("CLOSEST MATCH: " + database[i].name);
    } else {
      //println("NO PERFECT MATCH");
      matchSearch();
    }
  }
}

void matchSearch() {
  for (int i = 0; i < picNum; i++) { //caps the size to avoid nullpointer exception errors
    if (input.input.size() < database[i].input.size()) {
      size = input.input.size();
    } else {
      size = database[i].input.size();
    }

    for (int a = 0; a < size; a++) { //see how many of the vector points in the array match
      for (int b = 0; b < size; b++) {
        if (input.input.get(a).x == database[i].input.get(b).x && input.input.get(a).y == database[i].input.get(b).y) {
          database[i].vecMatch++;
        } else {
        }
      }
    }
  }
}

void setup() {
  size(500, 500); //size of the window
  background(255);
  table = loadTable("Name.csv", "header");
  //Input Image
  input.load();
  for (int a = 0; a < 50; a++) {
    for (int b = 0; b < 50; b++) {
      if (input.image.get(b, a) != color(255)) {
        input.searchImage(b, a);
      }
    }
  }

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
  }

  ////SEARCH ALGORITHM
  if (input.vecNum > 1500) {
    input.vecNum = input.vecNum/2;
    println("New VecNum: " + input.vecNum);
    characterMatch();
  } else if (input.vecNum < 50) {
    println("New VecNum: " + input.vecNum);
    input.vecNum = input.vecNum * 2;
    characterMatch();
  } else {
    characterMatch();
  }

  //Sort largest match values
  int[] matchLargest = new int[picNum];
  for (int i = 0; i < picNum; i++) {
    matchLargest[i] = database[i].vecMatch;
  }
  matchLargest = sort(matchLargest);
  matchLargest = reverse(matchLargest);
  largest = matchLargest[0];
  //println(matchLargest);

  for (int i = 0; i < picNum; i++) {
    if (database[i].vecMatch == largest) {
      println("Character Match Largest: " + database[i].name);
      println(table.findRow(database[i].name, "PicNum").getString("Name"));
    }
    if (database[i].vecMatch == matchLargest[1]) {
      println("Second Closest Match: " + database[i].name);
      println(table.findRow(database[i].name, "PicNum").getString("Name"));
    }
    if (database[i].vecMatch == matchLargest[2]) {
      println("Third Closest Match: " + database[i].name);
      println(table.findRow(database[i].name, "PicNum").getString("Name"));
    }
    if (database[i].vecMatch == matchLargest[3]) {
      println("Fourth Closest match: " + database[i].name);
      println(table.findRow(database[i].name, "PicNum").getString("Name"));
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
  }

  //for (int i = 0; i < picNum; i++) {
  //  if (database[i].vecMatch == largest) {
  //    for (int a = 0; a < database[i].input.size(); a++) {
  //      stroke(255, 0, 0);
  //      point(database[i].input.get(a).x * 10, database[i].input.get(a).y * 10);
  //    }
  //  }
  //}

  for (int i = 0; i < database[testNum].input.size() - 1; i++) {
    stroke(0, 255, 0);
    point(database[testNum].input.get(i).x * 10, database[testNum].input.get(i).y * 10);
  }
}