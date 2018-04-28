color getStarColor(String type)
{
  color col = (255);
   switch(type){
        case "M":
          col = #ffb46c;
          break;
        case "K":
          col = #ffd9b4;
          break;
        case "G":
          col = #ffece2;
          break;
        case "F":
          col = #f9f5ff;
          break;
        case "A":
          col = #d4dfff;
          break;
        case "B":
          col = #a1bfff;
          break;
        case "O":
          col = #91b4ff;
          break;
        case "D":
          col = #4882ff;
          break;
        case "L":
          col = #6e3d37;
          break;
      } 
    return col;
}

float getStarSize(String type)
{
  float size = starSize;
   switch(type){
        case "M":
          size *= 0.5;
          break;
        case "K":
          size *= 0.7;
          break;
        case "G":
          size *= 1;
          break;
        case "F":
          size *= 1.2;
          break;
        case "A":
          size *= 1.5;
          break;
        case "B":
          size *= 2;
          break;
        case "O":
          size *= 2.3;
          break;
        case "D":
          size *= 0.3;
          break;
        case "L":
          size *= 0.3;
          break;
      } 
    return size;
}

float getStarSizeList(String type)
{
  float size = 20;
   switch(type){
        case "M":
          size *= 0.8;
          break;
        case "K":
          size *= 0.9;
          break;
        case "G":
          size *= 1;
          break;
        case "F":
          size *= 1.1;
          break;
        case "A":
          size *= 1.2;
          break;
        case "B":
          size *= 1.3;
          break;
        case "O":
          size *= 1.4;
          break;
        case "D":
          size *= 0.5;
          break;
        case "L":
          size *= 0.5;
          break;
      } 
    return size;
}