class Forhindring {
  String[] linjeArray = loadStrings("bane.txt");
  Forhindring() {
  }

  void load() {

    //opretter arraylist for forhindringer
    ArrayList<Integer> kegleX = new ArrayList<Integer>();
    ArrayList<Integer> kegleY = new ArrayList<Integer>();
    ArrayList<Integer> buskX = new ArrayList<Integer>();
    ArrayList<Integer> buskY = new ArrayList<Integer>();
    ArrayList<Integer> boksX = new ArrayList<Integer>();
    ArrayList<Integer> boksY = new ArrayList<Integer>();
    ArrayList<Integer> parkX = new ArrayList<Integer>();
    ArrayList<Integer> parkY = new ArrayList<Integer>();


    //indsætter punkter fra txt fil til hver af forhindringerne
    for (int i = 0; i < linjeArray.length; i++) {
      for (int j = 0; j < linjeArray[i].length(); j ++) {
        if (linjeArray[i].charAt(j) == '1') {
          kegleX.add(j * 100);
          kegleY.add(i * 100);
        }
        if (linjeArray[i].charAt(j) == '2') {
          buskX.add(j * 100);
          buskY.add(i * 100);
        }
        if (linjeArray[i].charAt(j) == '3') {
          boksX.add(j * 100);
          boksY.add(i * 100);
        }
        if (linjeArray[i].charAt(j) == '4') {
          parkX.add(j * 100);
          parkY.add(i * 100);
        }
      }
    }

    //indsætter det i arraylist
    for (int i = 0; i <buskX.size(); i ++) {
      buskArray.add(new Busk(buskX.get(i), buskY.get(i)));
    }
    for (int i = 0; i < boksX.size(); i ++) {
      boksArray.add(new Boks(boksX.get(i)+30, boksY.get(i)+20));
    }
    for (int i = 0; i < kegleX.size(); i ++) {
      kegleArray.add(new Kegle(kegleX.get(i)+30, kegleY.get(i)+20));
    }
    for (int i = 0; i < parkX.size(); i ++) {
      parkArray.add(new Parkering(parkX.get(i)+30, parkY.get(i)+20));
    }
  }
}
