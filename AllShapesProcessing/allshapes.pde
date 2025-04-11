FloatList metaRotationList = new FloatList();
; //358 vals
FloatList metaSizeList = new FloatList();
; // 198 vals
FloatList metaProportionList = new FloatList();
; //39 204 vals
FloatList metaPointList = new FloatList();
;






ArrayList metaConnectionList = new ArrayList();
;

ArrayList<shapeParam> ListOfLists = new ArrayList<shapeParam>();
shapeParam rotationList ;
shapeParam sizeList ;
shapeParam proportionList  ;
shapeParam pointList  ;



shapeParam pointList2  ;
shapeParam  positionList ;
FloatList ConnectionList ;







void setup() {
  
    int cols = height;
int rows = width;
int[][] positionMetaList = new int[cols][rows];
  
 rotationList = new shapeParam();
sizeList = new shapeParam();
proportionList = new shapeParam();
 pointList = new shapeParam();
 
pointList2 = new shapeParam();
positionList = new shapeParam();
ConnectionList = new FloatList();


  


// Two nested loops allow us to visit every spot in a 2D array.
// For every column I, visit every row J.
for (int i = 0; i < cols; i++) {
  for (int j = 0; j < rows; j++) {
    positionMetaList[i][j] = 0;
  }
};

 

  size(1024, 768);
  background(0);
  stroke(25, 10, 255);

  pushMatrix();
  float z = sqrt(sq(1024) + sq(768))/2.0;
  float x = z*cos(radians(216.87));
  float y =  z*sin(radians(216.87));
  translate(width/2.0, height/2.0);
  //line(0,0,-width/2 + 20,-height/2.0 + 20);
  //line(0, 0, x, y);
  
  Boolean negativeRotation = false;
  float orientation = (random(-89.5, 90));
  
 //orientation = 0;


  if (orientation < 0) {

    negativeRotation = true;
  };

  orientation = roundToHalf(orientation, negativeRotation);

float index = round(map(orientation, -89.5, 90, 0, 358));

  float size = getSize(orientation, negativeRotation);
  float[] size2 = {size*10.24, size*7.68};
  float areaSize = size2[0]*size2[1];
   float[] size3 = new float[2];

  if (orientation == 0) {

    if (areaSize/width < 5) {

      size3[1] = areaSize/5.0;
      size3[0] = 5;
    } else {
      size3[0] = areaSize/width;
      size3[1] = width;
    }
  } else if (orientation == 90 ) {


    if (areaSize/width < 5) {

      size3[1] = areaSize/5.0;
      size3[0] = 5;
    } else {
      size3[0] = areaSize/height;
      size3[1] = height ;
    }
  } else {

    size3 = getProportionTopBottom(areaSize, orientation, negativeRotation);

    z = sqrt(sq(size3[1]) + sq(size3[0]));
    float alpha = asin(size3[0]/(z));
    z = z/2.0;
    x = z*cos(alpha+radians(orientation));
    y =  z*sin(alpha+radians(orientation));

    if (x  > 512.5 || y < -511.5) {

      size3 = getProportionSides(areaSize, orientation, negativeRotation);
      z = sqrt(sq(size3[1]) + sq(size3[0]));
      alpha = asin(size3[0]/(z));
      z = z/2.0;
      x = z*cos(radians(orientation)-alpha);
      y =  z*sin(radians(orientation)-alpha);
    }
  }

  float[] size4 = getRandomAspectRatio(size2[0], size3[1], areaSize, negativeRotation);

  //line(0, 0, x, y);

  noFill();
  rectMode(CENTER);
  rotate(radians(orientation));

  //rect(0, 0, size2[0], size2[1]);
  // rect(0,0,size3[1],size3[0]);
  rect(0, 0, size4[0], size4[1]);
   popMatrix();
  //   println(size2[0], size2[1]);
  //println(size3[0], size3[1]);
  //  println(size4[0], size4[1]);


  rotationList.value = orientation;


  sizeList.value = abs(size);


  proportionList.value = size4[2];


  pointList.value = float(round(random(3,getPoints(int(size4[0]), int(size4[1])))));




  //add to relation lists
  ListOfLists.add(findPlacementInList(ListOfLists, index), rotationList);
  rotationList.list.add(findPlacementInList(rotationList.list, sizeList.value), sizeList);
  sizeList.list.add(findPlacementInList(sizeList.list, proportionList.value), proportionList);
  proportionList.list.add(findPlacementInList(proportionList.list, pointList.value), pointList);
  
  

  

  //add to metalists
  metaRotationList.insert(findPlacementInMetaList(metaRotationList, index), rotationList.value);
  metaSizeList.insert(findPlacementInMetaList(metaSizeList, abs(size)), abs(size));
  metaProportionList.insert(findPlacementInMetaList(metaProportionList,proportionList.value), proportionList.value);
  metaPointList.insert(findPlacementInMetaList(metaPointList, pointList.value), pointList.value);

 
   //positionList.value = ;

  
  //add to the pointList
  pointList2.value =  pointList.value;

  // positionList.list.add(findPlacementInList(rotationList.list, sizeList.value), sizeList);
  
 //pickPointsFromMetaPositionList(positionMetaList, int(pointList.value),int(size4[0]),int(size4[1])) ;

//randomly picks available points in the selected area
positionList.values =  pickPointsFromMetaPositionList(positionMetaList, int(pointList.value) ,int(size4[0]),int(size4[1]),orientation) ;


updateMetaPositionList(positionMetaList, positionList.values);


   pointList2.list.add( positionList);

 


 connectingPointsReturnConnections(positionList.values);
 
 stroke(0,255,0);
 // for(int i=0;i<positionList.values.size();i++){
   
 //  IntList o = positionList.values.get(i);
 
 //    rect(o.get(0), o.get(1), 5, 5);
 
 //}
 
 //connectingPoints(positionList.values);


  // ListOfLists.append(list);
}

void draw() {
}
