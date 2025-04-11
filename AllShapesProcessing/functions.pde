import java.util.*;

class shapeParam {
  Float value;
  ArrayList<IntList> values;
  ArrayList<shapeParam> list =   new ArrayList<shapeParam>();
};




class ListList {
  ArrayList<ListList> list =   new ArrayList<ListList>();
  ArrayList<IntList> position = new  ArrayList<IntList>();
  float value;
};





float getSize(float orientation, boolean negativeRotation) {
  float cornerDistanceToEdge = 999999;
  float halfHeight = height/2.0;

  float ratioDiagonalRotation = 216.87;
  //  println("halfHeight:"+halfHeight);
  if (negativeRotation) {
    //positive - lower left corner  touching
    //   println("bottom");

    float shapeDiagonalRotation =  ratioDiagonalRotation - orientation;

    //println("shapeDiagonalRotation:"+shapeDiagonalRotation);
    if (shapeDiagonalRotation > ratioDiagonalRotation) {
      //touching top
      //  println("cos thing:"+(sin(radians(shapeDiagonalRotation))));
      cornerDistanceToEdge = (halfHeight/sin(radians(shapeDiagonalRotation)));
    } else {
      println("error top --> side");
    };
  } else {
    //positive - lower left corner  touching


    float shapeDiagonalRotation =  ratioDiagonalRotation + orientation;
    //rintln("shapeDiagonalRotation:"+shapeDiagonalRotation);
    if (shapeDiagonalRotation >= ratioDiagonalRotation) {
      //touching top
      //  println("cos thing:"+(sin(radians(shapeDiagonalRotation))));
      cornerDistanceToEdge = -(halfHeight/sin(radians(shapeDiagonalRotation)));
    } else {
      println("error bottomm --> side");
    }
  };
  if (cornerDistanceToEdge == 999999 ) {
    println("error cornerDistanceToEdge");
  } else {
  }
  // println("cornerDistancetoEdge"+cornerDistanceToEdge);
  float sizePercentage = (4) * ((cornerDistanceToEdge*2)/sqrt(sq(4)+sq(3)));
  //  println("sizePercentage" + sizePercentage);
  sizePercentage = sizePercentage/10.24;
  // println("sizePercentage" + sizePercentage);
  //return sizePercentage;




  if (negativeRotation) {

    sizePercentage = random( sizePercentage, -1);
  } else {

    sizePercentage = random(1, sizePercentage);
  };


  sizePercentage = roundToHalf(sizePercentage, negativeRotation);


  return sizePercentage;
};




float[] getProportionTopBottom(float areaSize, float rotation, boolean negativeRotation) {

  float fakeWidth;

  if (negativeRotation) {

    fakeWidth = height/tan(radians(-rotation));
  } else {

    fakeWidth = height/tan(radians(rotation));
  }

  //println(fakeWidth);


  float diagonal = sqrt(sq(height)+sq(fakeWidth));

  float newBoxHeightSquaredPart = 1-sqrt(1-4*(fakeWidth/height)*areaSize/sq(diagonal));
  float newBoxHeight = (diagonal*height/fakeWidth*newBoxHeightSquaredPart)/2;

  if (newBoxHeight < 5.0) {
    newBoxHeight = 5;
  }

  float newBoxWidth = areaSize/newBoxHeight;


  float[] returningValues = { newBoxHeight, newBoxWidth};

  return returningValues;
};


float[] getProportionSides(float areaSize, float rotation, boolean negativeRotation) {

  float fakeWidth;



  if (negativeRotation) {
    rotation = 45 + (45 - rotation);
    fakeWidth = width/tan(radians(-rotation));
  } else {
    rotation = 45 + (45 - rotation);
    fakeWidth = width/tan(radians(rotation));
  }



  float diagonal = sqrt(sq(width)+sq(fakeWidth));


  float newBoxHeightSquaredPart = 1-sqrt(1-4*(fakeWidth/width)*areaSize/sq(diagonal));
  float newBoxHeight = (diagonal*width/fakeWidth*newBoxHeightSquaredPart)/2;

  if (newBoxHeight < 5.0) {
    newBoxHeight = 5;
  }

  float newBoxWidth = areaSize/newBoxHeight;


  float[] returningValues = { newBoxHeight, newBoxWidth};
  return returningValues;
};



float[] getRandomAspectRatio(float startWidth, float maxWidth, float areaSize, boolean negativeRotation) {
  float newWidth;

  if (negativeRotation) {
    newWidth = random(-startWidth, maxWidth);
  } else {

    newWidth = random(startWidth, maxWidth);
  }




  float newHeight = areaSize/newWidth;
  float aspectRatio = newHeight/newWidth;



  float[] returningValues = {newWidth, newHeight, aspectRatio};

  return returningValues;
};



float roundToHalf(float value, boolean negativeRotation) {

  int decimalNums = abs(int((value % 1)*100));


  if (decimalNums >= 75) {
    if (negativeRotation) {
      value = int(value) - 1;
    } else {
      value = int(value) + 1;
    }
  } else if (decimalNums < 75 && decimalNums >= 25 ) {
    if (negativeRotation) {
      value = int(value) - 0.5;
    } else {
      value = int(value) + 0.5;
    }
  } else {
    value = int(value) ;
  }


  return value;
}



int findPlacementInList(ArrayList<shapeParam> list, float index) {
  int i;

  if (list.size() == 0) {
    return 0;
  } else if (list.size() == 1) {

    i = 0;


    shapeParam listInthelist = list.get(i);
    float presentValue = listInthelist.value;


    if (index > presentValue  ) {
      // println("here");
      return i+1;
    } else {
      return i;
    }
  } else if (list.size() == 2) {

    i = 0;

    shapeParam listInthelist = list.get(i);
    float presentValue = listInthelist.value;

    shapeParam followingListIntheList = list.get(i +1 );
    float nextValue = followingListIntheList.value;


    if (index > presentValue && index < nextValue ) {

      return i+1;
    } else if (index > presentValue && index > nextValue ) {
      return i+2;
    } else {
      return i;
    }
  } else {
    i = ((list.size()/2));


    while (true) {
      float nextValue = 0 ;
      float previousValue = 0;
      boolean isNextValue = list.size() - 1 > i;
      boolean isPreviousValue = i > 0;

      shapeParam listInthelist = list.get(i);
      float presentValue = listInthelist.value;

      println("present value:"+presentValue);

      if (isNextValue) {
        shapeParam followingListIntheList = list.get(i +1 );
        nextValue = followingListIntheList.value;
        println("next value:" +nextValue);
      } else {
        return i+1;
      }

      if (isPreviousValue) {
        shapeParam previousListIntheList = list.get(i -1 );
        previousValue = previousListIntheList.value;

        println("previous value:" +previousValue);
      } else {

        return 0;
      }

      if (index > presentValue) {
        if (isNextValue) {
          if (index < nextValue ) {
            return i+1;
          }
        }
        i = i + round(i/2.0);
        println("rounded"+i);
      } else if (index < presentValue) {
        if (isPreviousValue) {
          if (index > previousValue) {
            return i;
          }
        }
        i = floor(i/2.0);
      }
    }
  }
};



int findPlacementInMetaList(FloatList list, float index) {
  int i;

  if (list.size() == 0) {
    return 0;
  } else if (list.size() == 1) {

    i = 0;

    float presentValue = list.get(i);


    if (index > presentValue  ) {
      println("here");
      return i+1;
    } else {
      return i;
    }
  } else if (list.size() == 2) {

    i = 0;

    float presentValue = list.get(i);

    float nextValue = list.get(i+1);


    if (index > presentValue && index < nextValue ) {

      return i+1;
    } else if (index > presentValue && index > nextValue ) {
      return i+2;
    } else {
      return i;
    }
  } else {
    i = ((list.size()/2));


    while (true) {
      float nextValue = 0 ;
      float previousValue = 0;
      boolean isNextValue = list.size() - 1 > i;
      boolean isPreviousValue = i > 0;

      float presentValue = list.get(i);

      println("present value:"+presentValue);

      if (isNextValue) {
        nextValue = list.get(i+1);
        println("next value:" +nextValue);
      } else {
        return i+1;
      }

      if (isPreviousValue) {
        previousValue = list.get(i-1);

        println("previous value:" +previousValue);
      } else {

        return 0;
      }

      if (index > presentValue) {
        if (isNextValue) {
          if (index < nextValue ) {
            return i+1;
          }
        }
        i = i + round(i/2.0);
        println("rounded"+i);
      } else if (index < presentValue) {
        if (isPreviousValue) {
          if (index > previousValue) {
            return i;
          }
        }
        i = floor(i/2.0);
      }
    }
  }
};








float  getPoints(int Width, int Height) {

  Width = Width / 5;
  Height = Height / 5;

  int bigVal = max(Width, Height) ;
  int smallVal = min(Width, Height) ;

  //println(bigVal);

  if (smallVal == 1) {

    return 4;
  } else if (smallVal == 2) {

    return 2 + (bigVal*2);
  } else if (smallVal == 3) {
    if (bigVal > 3) {
      int addVal = 0;
      if (bigVal > 4) {
        int moduloVal = (bigVal-4)%3;



        switch(moduloVal) {
        case 0:
          addVal = 8;
          break;
        case 1:
          addVal = 4;
          break;
        case 2:
          addVal = 6;
          break;
        };
      };

      int amountOfRepetition = ((bigVal - 5)/3);



      return int(12 + ((amountOfRepetition)*8) + addVal);
    } else if (bigVal == 3) {

      return 8;
    }
  } else if (smallVal == 4) {


    if (bigVal > 4) {
      int addVal = 0;
      if (bigVal > 5) {
        int moduloVal = (bigVal)%4;



        switch(moduloVal) {
        case 0:
          addVal = 8;
          break;
        case 1:
          addVal = 12;
          break;
        case 2:
          addVal = 2;
          break;
        case 3:
          addVal = 4;
          break;
        };
      };

      int amountOfRepetition = ((bigVal - 6)/4);




      return int(20 + ((amountOfRepetition)*12) + addVal);
    } else if (bigVal == 4) {

      return 8;
    };
  } else if (smallVal == 5) {


    return 24 + ((bigVal - 5)*4);
  } else if (smallVal == 6) {



    if (bigVal > 7) {
      int addVal = 0;
      if (bigVal > 8) {
        int moduloVal = (bigVal)%6;



        switch(moduloVal) {
        case 0:
          addVal = 18;
          break;
        case 1:
          addVal = 22;
          break;
        case 2:
          addVal = 28;
          break;
        case 3:
          addVal = 4;
          break;
        case 4:
          addVal = 8;
          break;
        case 5:
          addVal = 12;
          break;
        };
      };

      int amountOfRepetition = ((bigVal - 9)/6);




      return int(42 + ((amountOfRepetition)*28) + addVal);
    } else if (bigVal == 6) {

      return 32;
    } else if (bigVal == 7) {

      return 34;
    };
  } else if (smallVal == 7) {

    int addVal = 0;
    if (bigVal > 7) {
      int moduloVal = (bigVal)%4;



      switch(moduloVal) {
      case 0:
        addVal = 6;
        break;
      case 1:
        addVal = 12;
        break;
      case 2:
        addVal = 16;
        break;
      case 3:
        addVal = 20;
        break;
      };
    };

    int amountOfRepetition = ((bigVal - 8)/4);




    return int(40 + ((amountOfRepetition)*20) + addVal);
  };

  return int(random(3, smallVal));
}


void printVals(ArrayList<shapeParam> list) {

  for (int i = 0; i < list.size(); i = i + 1) {


    shapeParam obj = list.get(i);



    print(obj.value+",");
  }
}


int getSmallestNumberFrom2DArray(int[][] arr) {


  int minvalue=arr[0][0];
  for (int i=0; i<arr.length; i++)
  {
    for (int j=0; j<arr[i].length; j++)
    {
      if (arr[i][j]<minvalue)
      {
        minvalue= arr[i][j];
      }
    }
  }
  //println("Min Value is: "+minvalue);
  return minvalue;
}


//  ArrayList<IntList> pickPointsFromMetaPositionList(int[][] arr, int numOfPoints, int shapeWidth, int shapeHeight){

// ListList ListList = new  ListList();

//        int smallestVal = getSmallestNumberFrom2DArray(arr);

//  //pick all the possible points to be evaluated, does not work when rotated
//    int countOfPoints  = 0;
////    while(countOfPoints < numOfPoints){


////    ListList listX = new ListList();

////    int StartHeight = int(height/2.0 - shapeHeight/2.0);
////    int EndHeight = int(height/2.0 + shapeHeight/2.0);



////       int StartWidth = int(width/2.0 - shapeWidth/2.0);
////    int EndWidth= int(width/2.0 + shapeWidth/2.0);




////    for(int i=StartHeight;i<EndHeight;i++)
////    {
////        for(int j=StartWidth;j<EndWidth;j++)
////        {

////            if(arr[i][j] == smallestVal)
////            {
////               IntList x = new IntList(i,j);
////               listX.position.add(x);
////               countOfPoints  = countOfPoints +1;
////            }

////        }
////    }
////ListList.list.add(listX);
////  smallestVal = smallestVal + 1;
////    }


//    //randomly pick points to be used, check to avoid 3 adjacent in any direction
//    ArrayList<IntList> OutputList = new ArrayList<IntList>();







//    /////// fill the list of list with list of points depending on number of uses inside of the lists are lists with coordinates
//    for(int i=0;i<numOfPoints;i++){


//        if(ListList.list.size() == 0){


//         countOfPoints = i;

//         while(countOfPoints < numOfPoints){


//                     println(countOfPoints);


//    ListList listX = new ListList();

//    int StartHeight = int(height/2.0 - shapeHeight/2.0);
//    int EndHeight = int(height/2.0 + shapeHeight/2.0);



//       int StartWidth = int(width/2.0 - shapeWidth/2.0);
//    int EndWidth= int(width/2.0 + shapeWidth/2.0);




//    for(int v=StartHeight;v<EndHeight;v++)
//    {
//        for(int j=StartWidth;j<EndWidth;j++)
//        {

//            if(arr[v][j] == smallestVal)
//            {
//               IntList x = new IntList(v,j);


//               listX.position.add(x);
//               countOfPoints  = countOfPoints +1;
//            }

//        }
//    }
//ListList.list.add(listX);
//  smallestVal = smallestVal + 1;
//    }

//       };


//      ListList x = ListList.list.get(0);

//    //int y =  round(random(x.position.size()-1));

//    int y =  0;



//     int p = (x.position.get(y).get(0) + x.position.get(y).get(1));



//     if(i == 0){


//      OutputList.add(x.position.get(y));

//          OutputList.get(i).append(p);

//     }else{


//     for(int h=0;h< OutputList.size();h++){



//     if(OutputList.get(h).get(2) >= p  ){


//      OutputList.add(h,x.position.get(y));
//        OutputList.get(h).append(p);
//        break;

//     }else if (OutputList.get(h).get(2) < p && h == OutputList.size()-1){



//       OutputList.add(h+1,x.position.get(y));
//        OutputList.get(h+1).append(p);
//        break;


//     }

//     }
//     }
//     //order distance and outputList

//    /////////////////////////////////////////////////////////////




//    x.position.remove(y);

//     if(x.position.size() == 0){

//     ListList.list.remove(0);
//     };

//    //int o = round(random(ListList.get()size()));
//    //OutputList.add(ListList.get(o));
//    //ListList.remove(o);

//   //////////////////////////////////////checking adjacency
//    // if(i != 0 && (i+1)%3 == 0 ){


//    //        println("test"+i);
//    //       println("test"+OutputList);


//    //     boolean sameAsFirst = false;
//    //     boolean sameAsLast = false;


//    //        if(OutputList.get(i-1).get(2) == ((OutputList.get(i-2).get(2)) + 1) || OutputList.get(i-1).get(2) == ((OutputList.get(i-2).get(2)) + 2)||  OutputList.get(i-1).get(2) == OutputList.get(i-2).get(2)){
//    //       sameAsLast = true;

//    //       };
//    //     if(sameAsLast) {


//    //     if(i > 2){

//    //       if(OutputList.get(i-2).get(2) == ((OutputList.get(i-3).get(2)) + 1) || OutputList.get(i-2).get(2) == ((OutputList.get(i-3).get(2))  + 2)||  OutputList.get(i-2).get(2) == OutputList.get(i-3).get(2)){



//    //             println(OutputList);
//    //         OutputList.remove(OutputList.size()-2);

//    //          i = i -1;

//    //          println(1);
//    //                      println(OutputList);



//    //       }}


//    //         if(OutputList.get(i-1).get(2) == OutputList.get(i).get(2) - 1 || OutputList.get(i-1).get(2) == OutputList.get(i).get(2)  - 2||  OutputList.get(i-1).get(2) == OutputList.get(i).get(2)){
//    //       sameAsFirst = true;




//    //       OutputList.remove(OutputList.size()-1);

//    //       i = i -1;

//    //                     println(2);
//    //                      println(OutputList);


//    //     };





//    //     }



//    //};
//    ///////////////////////////////////


//    println("iter")  ;
//            println(OutputList);





//    }





//    //sort points by distance from 0,0
// //ArrayList<IntList> OutputList2 = new  ArrayList<IntList>();


// //        OutputList2.add(0,OutputList.get(0));

// //       for(int i=1;i< OutputList.size();i++){

// //         int x = OutputList.get(i).get(0) + OutputList.get(i).get(1);

// //          for(int o=0;o< OutputList2.size();o++){



// //            int uff = OutputList2.get(o).get(0) +OutputList2.get(o).get(1);




// //            if(x < uff){

// //            OutputList2.add(o,OutputList.get(i));

// //            break;

// //            }else if( o == OutputList2.size()-1){
// //            OutputList2.add(OutputList2.size(),OutputList.get(i));

// //                 break;

// //            }


// //          }


// //       }
//   //println("Min Value is: "+minvalue);

//   //println(OutputList2);
//   return OutputList;
//  };


ListList FillTheLists(int numOfPoints, int countOfPoints, int[][] arr, ListList ListList, int shapeHeight, int shapeWidth, float orientation) {



  color red = color(255, 0, 0);
  PGraphics selectedArea = createGraphics(1024, 768);
  selectedArea.beginDraw();
  selectedArea.background(0);
  selectedArea.noStroke();
  selectedArea.fill(red);
  selectedArea.rectMode(CENTER);
  selectedArea.pushMatrix();
  selectedArea.translate(width/2.0, height/2.0);
  selectedArea.rotate(radians(orientation));
  selectedArea.rect(0, 0, shapeHeight, shapeWidth);
  selectedArea.popMatrix();
  selectedArea.endDraw();

  // image(selectedArea,0,0);



  int smallestVal = getSmallestNumberFrom2DArray(arr);

  for (int i=0; i<numOfPoints; i++) {


    if (ListList.list.size() == 0) {




      while (countOfPoints < numOfPoints) {





        ListList listX = new ListList();

        //int StartHeight = int(height/2.0 - shapeHeight/2.0);
        //int EndHeight = int(height/2.0 + shapeHeight/2.0);



        //   int StartWidth = int(width/2.0 - shapeWidth/2.0);
        //int EndWidth= int(width/2.0 + shapeWidth/2.0);



        for (int v=0; v<768; v++)
        {
          for (int j=0; j<1024; j++)
          {

            //println(v);
            // println(j);

            if (selectedArea.get(j, v) == red) {

              if (arr[v][j] == smallestVal)
              {
                IntList x = new IntList(j, v);



                listX.position.add(x);
                countOfPoints  = countOfPoints +1;
              }
            }
          }
        }

        ListList.list.add(listX);
        smallestVal = smallestVal + 1;
      }
    };
  };

  return ListList;
}
;


ArrayList<IntList> pickPointsFromMetaPositionList(int[][] arr, int numOfPoints, int shapeWidth, int shapeHeight, float orientation) {

  ListList ListList = new  ListList();





  //pick all the possible points to be evaluated, does not work when rotated



  //randomly pick points to be used, check to avoid 3 adjacent in any direction
  ArrayList<IntList> OutputList = new ArrayList<IntList>();






  //  if(ListList x.list.size() == 0){
  ///////// fill the list of list with list of points depending on number of uses inside of the lists are lists with coordinates

  //   };

  int[][] pointHelperGrid = new int[768][1024];


  // Two nested loops allow us to visit every spot in a 2D array.
  // For every column I, visit every row J.
  for (int i = 0; i < 768; i++) {
    for (int j = 0; j < 1024; j++) {
      pointHelperGrid[i][j] = 0;
    }
  };


  while (OutputList.size()<numOfPoints) {
    //get a first list of positions from the list of lists

    if (ListList.list.size() == 0) {
      ListList = FillTheLists(numOfPoints, OutputList.size(), arr, ListList, shapeWidth, shapeHeight, orientation);
    }





    ListList x = ListList.list.get(0);

    // println(x.position.size());


    for (int q=0; q<x.position.size(); q++) {


      //     println(OutputList);
      if (OutputList.size() == numOfPoints) {

        break;
      };




      //pick random number from the list of positions
      int y =  round(random(x.position.size()-1));
      //y = 0;
      IntList chosenPosition = x.position.get(y);



      //adds first value into the list
      if (q == 0) {


        pointHelperGrid[chosenPosition.get(1)][chosenPosition.get(0)] = 1;
        OutputList.add(chosenPosition);
      } else {


        //check horizontal adjacency
        int horizontalForward = 0;
        int horizontalForwardTwo = 0;
        int horizontalBackward = 0 ;
        int horizontalBackwardTwo = 0;


        //avoid error when coordinate at the end
        if (chosenPosition.get(0) < width) {

          horizontalForward = pointHelperGrid[chosenPosition.get(1)][chosenPosition.get(0)+1];
          if (chosenPosition.get(0) < width - 1) {
            horizontalForwardTwo = pointHelperGrid[chosenPosition.get(1)+2][chosenPosition.get(0)+2];
          }
        }

        //avoid error when coordinate at the start
        if (chosenPosition.get(0) > 0) {

          horizontalBackward = pointHelperGrid[chosenPosition.get(1)][chosenPosition.get(0)-1];
          if (chosenPosition.get(0) > 1) {
            horizontalBackwardTwo = pointHelperGrid[chosenPosition.get(1)][chosenPosition.get(0)-2];
          }
        }


        boolean horizontalForwardBool = false;
        boolean horizontalBackwardBool = false;


        if (horizontalForward == 1) {
          horizontalForwardBool = true;
        }

        if (horizontalBackward == 1) {
          horizontalBackwardBool = true;
        }

        if (horizontalForwardBool == true && horizontalBackwardBool == true) {

          println("error adjacent points backwards and forwards");
        } else if (horizontalForwardBool == true && horizontalForwardTwo == 1) {

          println("error two adjacent points forwards");
        } else if (horizontalBackwardBool == true && horizontalBackwardTwo == 1) {

          println("error two adjacent points backwards");
        } else {
          // check vertical adjacency when passed horizontal
          int VerticalDown = 0;
          int VerticalDownTwo = 0;
          int VerticalUp = 0 ;
          int VerticalUpTwo = 0;

          if (chosenPosition.get(1) < height) {

            VerticalDown = pointHelperGrid[chosenPosition.get(1)+1][chosenPosition.get(0)];
            if (chosenPosition.get(1) < height - 1) {
              VerticalDownTwo = pointHelperGrid[chosenPosition.get(1)+2][chosenPosition.get(0)];
            }
          }


          if (chosenPosition.get(1) > 0) {

            VerticalUp = pointHelperGrid[chosenPosition.get(1)-1][chosenPosition.get(0)];
            if (chosenPosition.get(1) > 1) {
              VerticalUpTwo = pointHelperGrid[chosenPosition.get(1)-2][chosenPosition.get(0)];
            }
          }




          boolean VerticalUpBool = false;
          boolean VerticalDownBool = false;


          if (VerticalUp == 1) {
            VerticalUpBool = true;
          }

          if (VerticalDown == 1) {
            VerticalDownBool = true;
          }

          if (VerticalUpBool == true && VerticalDownBool == true) {

            println("error two adjacent points above and below");
          } else if (VerticalUpBool == true && VerticalUpTwo == 1) {

            println("error two adjacent points above");
          } else if (VerticalDownBool == true && VerticalDownTwo == 1) {


            println("error two adjacent points below");
          } else {
            // check diagonal left is up  if passed

            int DiagonalDown = 0;
            int DiagonalDownTwo = 0;
            int DiagonalUp = 0 ;
            int DiagonalUpTwo = 0;


            if (chosenPosition.get(0) < width && chosenPosition.get(1) < height ) {

              DiagonalDown = pointHelperGrid[chosenPosition.get(1) + 1][chosenPosition.get(0)+1];
              if (chosenPosition.get(0) < width - 1 && chosenPosition.get(1) < height - 1 ) {
                DiagonalDownTwo = pointHelperGrid[chosenPosition.get(1)+2][chosenPosition.get(0)+2];
              }
            }

            if (chosenPosition.get(0) > 0  &&  chosenPosition.get(1) > 0 ) {

              DiagonalUp = pointHelperGrid[chosenPosition.get(1) - 1][chosenPosition.get(0) - 1];
              if (chosenPosition.get(0) > 1  &&  chosenPosition.get(1) > 1 ) {
                DiagonalUpTwo = pointHelperGrid[chosenPosition.get(1)-2][chosenPosition.get(0)-2];
              }
            }


            boolean DiagonalUpBool = false;
            boolean DiagonalDownBool = false;


            if (DiagonalUp == 1) {
              DiagonalUpBool = true;
            }

            if (DiagonalDown == 1) {
              DiagonalDownBool = true;
            }

            if (DiagonalUpBool == true && DiagonalDownBool == true) {

              println("error two adjacent points diagonally up/left and down/right");
            } else if (DiagonalUpBool == true && DiagonalUpTwo == 1) {

              println("error two adjacent points diagonally up/left");
            } else if (DiagonalDownBool == true && DiagonalDownTwo == 1) {

              println("error two adjacent points diagonally down/right");
            } else {

              // check diagonal right is up  if passed

              DiagonalDown = 0;
              DiagonalDownTwo = 0;
              DiagonalUp = 0 ;
              DiagonalUpTwo = 0;



              if (chosenPosition.get(0) > 0 && chosenPosition.get(1) < height ) {

                DiagonalDown = pointHelperGrid[chosenPosition.get(1) +1][chosenPosition.get(0)-1];
                if (chosenPosition.get(0) > 1 && chosenPosition.get(1) < height - 1) {
                  DiagonalDownTwo = pointHelperGrid[chosenPosition.get(1)+2][chosenPosition.get(0)-2];
                }
              }

              if (chosenPosition.get(0) < width && chosenPosition.get(1) > 0) {

                DiagonalUp = pointHelperGrid[chosenPosition.get(1) -1][chosenPosition.get(0) + 1];
                if (chosenPosition.get(0) < height - 1 && chosenPosition.get(1) > 1) {
                  DiagonalUpTwo = pointHelperGrid[chosenPosition.get(1)-2][chosenPosition.get(0)+2];
                }
              }

              DiagonalUpBool = false;
              DiagonalDownBool = false;


              if (DiagonalUpBool == true && DiagonalDownBool == true) {

                println("error two adjacent points diagonally up/right and down/left");
              } else if (DiagonalUpBool == true && DiagonalUpTwo == 1) {


                println("error two adjacent points diagonally up/right a");
              } else if (DiagonalDownBool == true && DiagonalDownTwo == 1) {


                println("error two adjacent points diagonally down/left");
              } else {
                // if passed all the checks add point


                pointHelperGrid[chosenPosition.get(1)][chosenPosition.get(0)] = 1;
                OutputList.add(chosenPosition);
              }
            }
          }
        }
      };

      x.position.remove(y);
    };


    // if list of positions is empty remove it
    if (x.position.size() == 0) {

      ListList.list.remove(0);
    };
  }




  return OutputList;
};



void updateMetaPositionList(int[][] list, ArrayList<IntList> PositionsToBeUpdated) {

  for (int i=0; i<PositionsToBeUpdated.size(); i++) {
    int x = PositionsToBeUpdated.get(i).get(0);
    int y = PositionsToBeUpdated.get(i).get(1);

    list[y][x] =  list[y][x] + 1;
  };
};






ListList getperpedicularGroups(IntList startingPoint, IntList connectingPoint, ArrayList<IntList> points ) {


  //delete later
  for (int i=0; i<points.size(); i++) {



    rect(points.get(i).get(0), points.get(i).get(1), 5, 5);
  }



  color blue = color(0, 0, 255);
  color red = color(255, 0, 0);

  float deltaX =  connectingPoint.get(0) - startingPoint.get(0)  ;
  float deltaY =     connectingPoint.get(1) - startingPoint.get(1)  ;
  float distanceBetweenPoints = sqrt(sq(deltaX)+sq(deltaY));
  float perpAngleOfConnection = radians(degrees(atan2(deltaY, deltaX))+90);

  float firstCoordinateConnectingPointX = connectingPoint.get(0) + (1280  * cos(perpAngleOfConnection));
  float firstCoordinateConnectingPointY = connectingPoint.get(1) + (1280  * sin(perpAngleOfConnection));

  float secondCoordinateConnectingPointX = firstCoordinateConnectingPointX + (distanceBetweenPoints  * cos(perpAngleOfConnection+radians(90)));
  float secondCoordinateConnectingPointY = firstCoordinateConnectingPointY + (distanceBetweenPoints  * sin(perpAngleOfConnection+radians(90)));

  PGraphics selectedArea = createGraphics(1024, 768);
  selectedArea.beginDraw();
  selectedArea.background(0);

  rectMode(CORNER);

  selectedArea.fill(0, 0, 255);
  selectedArea.beginShape();
  selectedArea.vertex(startingPoint.get(0), startingPoint.get(1));
  selectedArea.vertex(connectingPoint.get(0), connectingPoint.get(1));
  selectedArea.vertex(firstCoordinateConnectingPointX, firstCoordinateConnectingPointY);
  selectedArea.vertex(secondCoordinateConnectingPointX, secondCoordinateConnectingPointY);
  selectedArea.vertex(startingPoint.get(0), startingPoint.get(1));
  selectedArea.endShape();


  //delete later
  noFill();
  stroke(255, 0, 0);
  beginShape();
  vertex(startingPoint.get(0), startingPoint.get(1));
  vertex(connectingPoint.get(0), connectingPoint.get(1));
  vertex(firstCoordinateConnectingPointX, firstCoordinateConnectingPointY);
  vertex(secondCoordinateConnectingPointX, secondCoordinateConnectingPointY);
  vertex(startingPoint.get(0), startingPoint.get(1));
  endShape();
  //

  //form the other side
  perpAngleOfConnection = perpAngleOfConnection-radians(180);
  float firstCoordinateConnectingPointXTwo = connectingPoint.get(0) + (1280  * cos(perpAngleOfConnection));
  float firstCoordinateConnectingPointYTwo = connectingPoint.get(1) + (1280  * sin(perpAngleOfConnection));

  float secondCoordinateConnectingPointXTwo = firstCoordinateConnectingPointXTwo + (-distanceBetweenPoints  * cos(perpAngleOfConnection+radians(90)));
  float secondCoordinateConnectingPointYTwo = firstCoordinateConnectingPointYTwo + (-distanceBetweenPoints  * sin(perpAngleOfConnection+radians(90)));

  selectedArea.fill(255, 0, 0);
  selectedArea.beginShape();
  selectedArea.vertex(startingPoint.get(0), startingPoint.get(1));
  selectedArea.vertex(connectingPoint.get(0), connectingPoint.get(1));
  selectedArea.vertex(firstCoordinateConnectingPointXTwo, firstCoordinateConnectingPointYTwo);
  selectedArea.vertex(secondCoordinateConnectingPointXTwo, secondCoordinateConnectingPointYTwo);
  selectedArea.vertex(startingPoint.get(0), startingPoint.get(1));
  selectedArea.endShape();


  selectedArea.endDraw();

  //delete later

  beginShape();
  stroke(0, 255, 0);
  vertex(startingPoint.get(0), startingPoint.get(1));
  vertex(connectingPoint.get(0), connectingPoint.get(1));
  vertex(firstCoordinateConnectingPointXTwo, firstCoordinateConnectingPointYTwo);
  vertex(secondCoordinateConnectingPointXTwo, secondCoordinateConnectingPointYTwo);
  vertex(startingPoint.get(0), startingPoint.get(1));
  endShape();

  //


  ListList groupA = new ListList();
  ListList groupB = new ListList();

  for (int i = 0; i < points.size(); i = i+1) {

    int x =points.get(i).get(0) ;
    int y = points.get(i).get(1);

    if (selectedArea.get(x, y) == color(0, 0, 0) ) {
    } else {
      if (selectedArea.get(x, y) == blue ) {



        groupA.position.add(points.get(i));
      } else if (selectedArea.get(x, y) == red ) {



        groupB.position.add(points.get(i));
      }
    }
  }


  //delete later
  noStroke();
  fill(255, 0, 255);
  for (int i=0; i< groupB.position.size(); i++) {



    rect( groupB.position.get(i).get(0), groupB.position.get(i).get(1), 5, 5);
  }


  fill(255, 255, 0);
  for (int i=0; i< groupA.position.size(); i++) {



    rect( groupA.position.get(i).get(0), groupA.position.get(i).get(1), 5, 5);
  }
  ///

  ListList groups = new ListList();

  groups.list.add(groupA);
  groups.list.add(groupB);
  groups.value = (perpAngleOfConnection);
  return  groups ;
}



IntList findPointClosestToEdge(ListList groupA, IntList startingPoint, IntList connectingPoint) {

  float deltaX;
  float deltaY;
  int indexConnectingPointEdge = 0;
  int indexStartingPointEdge = 0;
  float angleDistanceConnectingPoint = 0;
  float angleDistanceStartingPoint = 0;

  Collections.shuffle(groupA.position);


  for (int i = 0; i < groupA.position.size(); i = i+1) {

    deltaX =  connectingPoint.get(0) - startingPoint.get(0)  ;
    deltaY =     connectingPoint.get(1) - startingPoint.get(1)  ;

    float  distanceBetweenPoints =   sqrt(sq(deltaX)+sq(deltaY));

    float b = distanceBetweenPoints;

    deltaX =  connectingPoint.get(0) - groupA.position.get(i).get(0);
    deltaY =  connectingPoint.get(1) - groupA.position.get(i).get(1) ;

    float a =  sqrt(sq(deltaX)+sq(deltaY));



    deltaX =  startingPoint.get(0) - groupA.position.get(i).get(0) ;
    deltaY =  startingPoint.get(1) - groupA.position.get(i).get(1) ;

    float c =  sqrt(sq(deltaX)+sq(deltaY));

    float angle0 = (sq(a)+sq(c)-sq(b));
    float angle1 =  (2.0*(a*c));
    float angle3 = angle0/angle1;
    float angle4 = degrees(acos(angle3));



    float angle5 = (sq(b)+sq(c)-sq(a));
    float angle6 = 2.0*(b*c);
    float angleStartingPoint = degrees(acos(angle5/angle6));


    float angleConnectingPoint =  180 - angleStartingPoint - angle4;

    if (i == 0) {


      angleDistanceConnectingPoint = angleConnectingPoint;
      indexConnectingPointEdge = i;

      angleDistanceStartingPoint = angleStartingPoint;
      indexStartingPointEdge = i ;
    } else {




      if (angleConnectingPoint > angleDistanceConnectingPoint) {
        angleDistanceConnectingPoint = angleConnectingPoint;
        indexConnectingPointEdge = i;
      }


      if (angleStartingPoint > angleDistanceStartingPoint) {
        angleDistanceStartingPoint = angleStartingPoint;
        indexStartingPointEdge = i;
      }
    }

  }
  //delete later
  fill(0, 255, 255);
  rect(startingPoint.get(0), startingPoint.get(1), 5, 5);
  rect( groupA.position.get(indexStartingPointEdge).get(0), groupA.position.get(indexStartingPointEdge).get(1), 10, 10);




  fill(255, 0, 0);
  rect( groupA.position.get(indexConnectingPointEdge).get(0), groupA.position.get(indexConnectingPointEdge).get(1), 10, 10);
  rect(connectingPoint.get(0), connectingPoint.get(1), 5, 5);


  ///
  IntList x = new IntList();
  x.append(indexStartingPointEdge);
  x.append(indexConnectingPointEdge);
  return x;
};


IntList getLineCoordinates(IntList chosenEdgePoint, IntList boundaryPoint){
  
      float deltaX = boundaryPoint.get(0)-chosenEdgePoint.get(0);
   float  deltaY = boundaryPoint.get(1)-chosenEdgePoint.get(1);
      float angleBetweenPoints = degrees(atan2(deltaY, deltaX)) ;
      
      if(angleBetweenPoints < 0){
      
        angleBetweenPoints = angleBetweenPoints + 360;
      
      };

    IntList pointCoordinate = new IntList(0,0);
    //if edge point is on the right relative to the connection Point == direction left
    if(boundaryPoint.get(0)<chosenEdgePoint.get(0)){
      
          //if angle between points is more than zero ==  edge point is above/ direction down
          if(angleBetweenPoints < 180){
                
                   //side of the connecting points
                 //  println("line direction is left and down");
                          float a = height - boundaryPoint.get(1);
                          float angleAlpha = abs(angleBetweenPoints-180);
                          float angleBeta = 90-angleAlpha;
                          
                  
                          
                         
                          
                          float b =  abs(a * tan(radians(angleBeta)));
                          
                         //  stroke(0,255,0);
                         // strokeWeight(3);
                         //line(connectingPoint.get(0),connectingPoint.get(1),connectingPoint.get(0) -((a-10)*cos(radians(-90))),connectingPoint.get(1) -((a-10)*sin(radians(-90)))); 
                         //float coordinateX = connectingPoint.get(0) -((a-10)*cos(radians(-90)));
                         //float coordinateY = connectingPoint.get(1) -((a-10)*sin(radians(-90)));
                         //line(coordinateX,coordinateY,coordinateX -b,coordinateY);
                         // strokeWeight(1);
                          
                          
                          //check if end of triangle outside of frame
                          if(boundaryPoint.get(0) - b < 0){
                                    //  println("left side");
                                      // find y of the coordinate by calculating smaller triangle
                                      b =  abs(boundaryPoint.get(0) - b);
                                      a = b * tan(radians(angleAlpha));
                                      
                                      int x = 0;
                                      int y = round(height -  a);
                                      int direction = 1;
                                      pointCoordinate = new IntList(x,y,direction);  
                          
                          
                          }else{
                               //  println("bottom");
                          
                          
                          
                                     int x = round(boundaryPoint.get(0) - b);
                                    int y = height;
                                     int direction = 1;
                                     pointCoordinate = new IntList(x,y,direction);  
              
                          
                          
                          };
                          
                    
                           //undo later
             //       stroke(0,255,0);
             //             strokeWeight(3);
             //     line(groupA.position.get(indexConnectingPointEdge).get(0),groupA.position.get(indexConnectingPointEdge).get(1),pointCoordinate.get(0) -(10*cos(radians(angleBetweenPoints))) ,pointCoordinate.get(1)-((10)*sin(radians(angleBetweenPoints))));
             ////if angle between points is more than zero ==  edge point is below/direction is up 
          }else if(angleBetweenPoints > 180){
                      
                   //    println("line direction is left and up");
                        float a =  boundaryPoint.get(1);
                          float angleAlpha = abs(angleBetweenPoints-180);
                          float angleBeta = 90-angleAlpha;
                          
                          float b =  a * tan(radians(angleBeta));
                   
                       
                       
                       
                         //check if end of triangle outside of frame
                          if(boundaryPoint.get(0) - b < 0){
                                    //  println("left side");
                                      // find y of the coordinate by calculating smaller triangle
                                      b =  abs(boundaryPoint.get(0) - b);
                                      a = b * tan(radians(angleAlpha));
                                      
                                      int x = 0;
                                      int y = round(a);
                                           int direction = 0;
                                     pointCoordinate = new IntList(x,y,direction);  
                          
                          
                          }else{
                             //    println("up");
                                 
                                     int x = round(boundaryPoint.get(0) - b);
                                    int y = 0;
                                     int direction = 0;
                                     pointCoordinate = new IntList(x,y,direction);  

                          };
          
            
                             //undo later
                  //  stroke(0,255,0);
                  //        strokeWeight(3);
                  //line(groupA.position.get(indexConnectingPointEdge).get(0),groupA.position.get(indexConnectingPointEdge).get(1),pointCoordinate.get(0) -(10*cos(radians(angleBetweenPoints))) ,pointCoordinate.get(1)-((10)*sin(radians(angleBetweenPoints))));
             
            
          //angle is the same 
          }else if(abs(angleBetweenPoints) == 180 ){
            
              //       println("direction left");
            
            int x = 0;
            int y = boundaryPoint.get(1);
                    int direction = 0;
             pointCoordinate = new IntList(x,y,direction);    
          
          
          }else{
          
          println("error connecting point2");
          }
      
      
    
      
    //if edge point is on the left  relative to the connection Point == direction right
    }else if(boundaryPoint.get(0)>chosenEdgePoint.get(0)){
          
              //if angle between points is more than zero ==  edge point is above//direction is down
              if(angleBetweenPoints < 90){
                
                     //side of the connecting points
                      // println("line direction is right and down");
                          float a = height - boundaryPoint.get(1);
                          float angleAlpha = abs(angleBetweenPoints-180);
                          float angleBeta = 90-angleAlpha;
                          
                          float b =  abs(a * tan(radians(angleBeta)));
                          
               
                          
                          //check if end of triangle outside of frame
                          if(boundaryPoint.get(0) + b > width){
                                    //  println("right side");
                                      // find y of the coordinate by calculating smaller triangle
                                      b =  width-(boundaryPoint.get(0) + b);
                                      a = b * tan(radians(angleAlpha));
                                      
                                      int x = width;
                                      int y = round(height -  a);
                                              int direction = 1;
                                           pointCoordinate = new IntList(x,y,direction);  
                          
                          
                          }else{
                         //       println("bottom");
                          
                          
                          
                                     int x = round(boundaryPoint.get(0) + b);
                                    int y = height;
                                     int direction = 1;
                                         pointCoordinate = new IntList(x,y,direction);  
              
                          
                          
                          };       
                
            
              
                 //if angle between points is more than zero ==  edge point is below//direction is up
              }else if(angleBetweenPoints > 270 ){
                      
                    //   println("line direction is right  and up");
                  
                              float a =  boundaryPoint.get(1);
                                float angleAlpha = abs(angleBetweenPoints-180);
                                float angleBeta = 90-angleAlpha;
                            
                                float b =  abs(a * tan(radians(angleBeta)));
                             
                             
                             
                               //check if end of triangle outside of frame
                                if(boundaryPoint.get(0) + b > width){
                                           // println("right side");
                                            // find y of the coordinate by calculating smaller triangle
                                            b =  width-(boundaryPoint.get(0) + b);
                                            a = b * tan(radians(angleAlpha));
                                            
                                            int x = width;
                                            int y = round(a);
                                                 int direction = 0;
                                                 pointCoordinate = new IntList(x,y,direction);  
                                
                                
                                }else{
                                    //   println("up");
                                       
                                           int x = round(boundaryPoint.get(0) + b);
                                          int y = 0;
                                               int direction = 0;
                                               pointCoordinate = new IntList(x,y,direction);  
      
                                };
                
                      
                      
                
              
              //angle is the same 
              }else if(angleBetweenPoints == 0 || angleBetweenPoints == 360 ){
                
                 //   println("direction right");
                         int x = width;
                        int y = boundaryPoint.get(1);
                           int direction = 1;
                             pointCoordinate = new IntList(x,y,direction);   
              
              
              }else{
              
              println("error connecting point2");
              }
      
      
      
      
      
    
    //if edge point X is equal to  connectingPointX
    }else if(boundaryPoint.get(0)==chosenEdgePoint.get(0)){
    
                       // check if  the edge point is above or below the connecting point
                       //direction down
                      if(boundaryPoint.get(1) > chosenEdgePoint.get(1)){
                        
                        
                         int x = boundaryPoint.get(0);
                         int y = height;
                              int direction = 1;
                               pointCoordinate = new IntList(x,y,direction);  
                      
                      
                      //direction up
                      }else if(boundaryPoint.get(1) < chosenEdgePoint.get(1)){
                             int x = boundaryPoint.get(0);
                             int y = 0;
                                  int direction = 0;
                                   pointCoordinate = new IntList(x,y,direction);   
                      
                      
                      
                      }else{
                      print("error connecting point1");
                      
                      };
                      
             
      
      
    }else{
    
    print("error connecting point");
    }



return pointCoordinate;

};

void connectingPointsReturnConnections(ArrayList<IntList> points) {
  
  PGraphics AreaOfSightGraphic  = createGraphics(1024, 768);
  

  float  deltaX;
  float  deltaY ;

  ArrayList connectionList = new ArrayList();

  




  //get first random point
  color blue = color(0, 0, 255);
  color red = color(255, 0, 0);
  int randomNumber = round(random(0, points.size()-1));
  IntList firstPoint = points.get(randomNumber);
  //points.remove(randomNumber);

  IntList startingPoint = firstPoint;

  //get possible connection point
  randomNumber = round(random(1, points.size()));
  IntList connectingPoint = points.get(randomNumber);
  
  //create a line
  AreaOfSightGraphic.beginDraw();
  AreaOfSightGraphic.background(0);
  AreaOfSightGraphic.stroke(255,0,0);
  AreaOfSightGraphic.strokeWeight(1);
  AreaOfSightGraphic.line(firstPoint.get(0),firstPoint.get(1),connectingPoint.get(0),connectingPoint.get(1));
   AreaOfSightGraphic.endDraw();
   
   //add the connecting point to the list
   ArrayList<IntList> fieldOfViewPoints = new ArrayList<IntList>();
   fieldOfViewPoints.add(connectingPoint);


  ///
  ListList groups =  getperpedicularGroups(startingPoint, connectingPoint, points);
  ListList groupA = groups.list.get(0);
  ListList groupB = groups.list.get(1);
  float perpAngleOfConnection = groups.value;
  //index of points closest to the edge


  if (groupA.position.size() == 0 || groupB.position.size() == 0) {
  } else {

    //get points that are closest to the edge line





    perpAngleOfConnection = degrees(perpAngleOfConnection)-90;


    IntList pointsClosestToTheEdgeIndexGroup = findPointClosestToEdge(groupA, startingPoint, connectingPoint);
    int indexStartingPointEdge = pointsClosestToTheEdgeIndexGroup.get(0);
    int indexConnectingPointEdge = pointsClosestToTheEdgeIndexGroup.get(1);




    //start with connecting point outlier point and see if it can be connected to any of the points in groupB

    //create area of sight for the connecting point outlier point
    //connecting point line
   IntList straightLineToTheEdgeCoordinates =  getLineCoordinates(groupA.position.get(indexConnectingPointEdge),connectingPoint);
   
   
   //// helper   
          deltaX = connectingPoint.get(0)-groupA.position.get(indexConnectingPointEdge).get(0);
     deltaY = connectingPoint.get(1)-groupA.position.get(indexConnectingPointEdge).get(1);
      float angleBetweenPoints = degrees(atan2(deltaY, deltaX)) ;
      
      if(angleBetweenPoints < 0){
      
        angleBetweenPoints = angleBetweenPoints + 360;
      
      };
//helper


//create a line and check according to the direction if there are any obstructions on the way

//draw the line
 PGraphics lineGraphic = createGraphics(1024, 768);
 lineGraphic.beginDraw();
 lineGraphic.background(0);
 lineGraphic.stroke(255,255,255);
  lineGraphic.strokeWeight(0.1);
  lineGraphic.line(groupA.position.get(indexConnectingPointEdge).get(0),groupA.position.get(indexConnectingPointEdge).get(1),straightLineToTheEdgeCoordinates.get(0)  ,straightLineToTheEdgeCoordinates.get(1));
   lineGraphic.endDraw();
 
 
 println(straightLineToTheEdgeCoordinates.get(0) );
  println(straightLineToTheEdgeCoordinates.get(1) );
//check direction
// image(lineGraphic, 0,0); 

int smallerCoordinateX;
int biggerCoordinateX;
int smallerCoordinateY;
int biggerCoordinateY;


//check which coordinate is more to the left
if( groupA.position.get(indexConnectingPointEdge).get(1) >  straightLineToTheEdgeCoordinates.get(1)){
smallerCoordinateY = straightLineToTheEdgeCoordinates.get(1);
biggerCoordinateY = groupA.position.get(indexConnectingPointEdge).get(1);

}else{


smallerCoordinateY = groupA.position.get(indexConnectingPointEdge).get(1);
biggerCoordinateY = straightLineToTheEdgeCoordinates.get(1);

};


if( groupA.position.get(indexConnectingPointEdge).get(0) >  straightLineToTheEdgeCoordinates.get(0)){
smallerCoordinateX = straightLineToTheEdgeCoordinates.get(0);
biggerCoordinateX = groupA.position.get(indexConnectingPointEdge).get(0);

}else{

smallerCoordinateX = groupA.position.get(indexConnectingPointEdge).get(0);
biggerCoordinateX = straightLineToTheEdgeCoordinates.get(0);

};




boolean pointFound = false;

//if direction up/ from bottom right up 
if(straightLineToTheEdgeCoordinates.get(2) == 0){
  println("here1");
  





  for (int i = biggerCoordinateY; i >  smallerCoordinateY; i = i-1) {
  for (int j =biggerCoordinateX; j > smallerCoordinateX; j = j-1) {
    //if this is the stroke check obstructions

   
    if(lineGraphic.get(j,i) != color(0)){
                  if(j == 0 || j == width || i == 0 || i == height){
                             AreaOfSightGraphic.beginDraw();
                        AreaOfSightGraphic.set(j,i,color(0,255,0));
                              AreaOfSightGraphic.endDraw();
                              if( pointFound == false){
                   fieldOfViewPoints.add(new IntList(j,i));
                      println("here");
                              pointFound = true;
                              }
            }
            else if(AreaOfSightGraphic.get(j,i) == color(0)){
                        AreaOfSightGraphic.beginDraw();
                        AreaOfSightGraphic.set(j,i,color(255));
                              AreaOfSightGraphic.endDraw();
                
            }else if(AreaOfSightGraphic.get(j,i) == color(0,0,255)){
                       AreaOfSightGraphic.beginDraw();
                        AreaOfSightGraphic.set(j,i,color(0,255,0));
                              AreaOfSightGraphic.endDraw();
                   if( pointFound == false){
                           fieldOfViewPoints.add(new IntList(j,i));
                                      pointFound = true;
                              }
            }
    };
  };
}

//if direction down/ from left up down
}else if(straightLineToTheEdgeCoordinates.get(2) == 1){
  
  println("here2");
    

  
    for (int i = smallerCoordinateY; i < biggerCoordinateY; i = i+1) {
  for (int j = smallerCoordinateX; j < biggerCoordinateX; j = j+1) {
 


    
        if(lineGraphic.get(j,i) != color(0)){
          
                      if(j == 0 || j == width || i == 0 || i == height){
                             AreaOfSightGraphic.beginDraw();
                        AreaOfSightGraphic.set(j,i,color(0,255,0));
                              AreaOfSightGraphic.endDraw();
                      if( pointFound == false){
                   fieldOfViewPoints.add(new IntList(j,i));
                      println("here");
                              pointFound = true;
                              }
  
            }    else if(AreaOfSightGraphic.get(j,i) == color(0)){
                  
                     AreaOfSightGraphic.beginDraw();
                  AreaOfSightGraphic.set(j,i,color(255));
                        AreaOfSightGraphic.endDraw();
            }else if(AreaOfSightGraphic.get(j,i) == color(0,0,255)){
              AreaOfSightGraphic.beginDraw();
                  AreaOfSightGraphic.set(j,i,color(0,255,0));
                        AreaOfSightGraphic.endDraw();
                            if( pointFound == false){
                             fieldOfViewPoints.add(new IntList(j,i));
                                        pointFound = true;
                              }
            }
    };
    
  };
};


}else{println("errorDirection");}


 for (int i = 0; i < 1024; i = i+1) {
 
 if(AreaOfSightGraphic.get(i,768) != color(0)){
 println("hello");
 
 }
 }

image(AreaOfSightGraphic,0,0);
//                     stroke(0,255,0);
//strokeWeight(3);
//line(groupA.position.get(indexConnectingPointEdge).get(0),groupA.position.get(indexConnectingPointEdge).get(1),straightLineToTheEdgeCoordinates.get(0) -(10*cos(radians(angleBetweenPoints))) ,straightLineToTheEdgeCoordinates.get(1)-((10)*sin(radians(angleBetweenPoints))));
             
             
             
            
              

  

    IntList finalPoint = null;
    
  
  };
}
