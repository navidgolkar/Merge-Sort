float[] set;
String text;
float offset = 0;
int wid = 1, i1 = 0;
boolean run = true;
int time = 0;
void setup() {
  size(800, 600);
  frameRate(60);
  set = new float[int(0.99*width)];
  offset = 0.01*width/2;
  for (int i = 0; i < set.length; i++) set[i] = map(i, 0, set.length - 1, height/50, 9*height/10);
  disorder(set);
}

void draw() {
  background(0);
  textSize(20);
  if (run) {
    if (wid < set.length) {
      if (i1 < set.length) {
        joinmerge(set, i1, min(i1+wid, set.length - 1), min(i1+2*wid - 1, set.length-1));
        i1 += 2*wid;
      }
      else {
        i1 = 0;
        wid = 2*wid;
      }
      text = "Time: " + (millis() - time) + " ms";
      text(text, 20, 20);
    }
    else {
      run = false;
      time = millis() - time;
    }
    //for (int i = 0; i < set.length; i++) joinmerge(set, i, min(i+wid, set.length - 1), min(i+2*wid - 1, set.length-1));;
  } else {
    fill(255);
      text = "Time: " + time + " ms";
      text("finished!\n" + text, 20, 20);
  }

  stroke(255);
  for (int i = 0; i < set.length; i++) line(i + offset, height, i + offset, height-set[i]);
}

//void joinmerge(float[] arr, int start1, int start2, int end) {
//  int s1 = start1, s2 = start2;
//  float[] ans = new float[end - start1 + 1];
//  for (int i = 0; i < ans.length; i++) {
//    if (s1 < start2 && (s2 > end || arr[s1] < arr[s2])) {
//      ans[i] = arr[s1];
//      s1++;
//    } else {
//      ans[i] = arr[s2];
//      s2++;
//    }
//  }
//  for (int i = 0; i < ans.length; i++) arr[start1+i] = ans[i];
//}

void joinmerge(float[] arr, int start1, int start2, int end) {
  int mid = start2 - 1;
  if (arr[mid] <= arr[start2]) return;
  while (start1 <= mid && start2 <= end) {
    if (arr[start1] <= arr[start2]) start1++;
    else {
      int index = start2 - 1;
      while (index != start1) {
        swap(arr, index, index - 1);
        index--;
      }
      swap(arr, start1, start2);
      start1++;
      mid++;
      start2++;
    }
  }
}

void swap(float[] arr, int a, int b) {
  if (a != b) {
    arr[a] += arr[b];
    arr[b] = arr[a] - arr[b];
    arr[a] = arr[a] - arr[b];
  }
}

void disorder(float[] arr) {
  for (int i = 0; i < set.length; i++) {
    int x = round(random(set.length - 1));
    if (i != x) swap(arr, i, x);
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    disorder(set);
    i1 = 0;
    wid = 1;
    time = millis();
    run = true;
  }
}
