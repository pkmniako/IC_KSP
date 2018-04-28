JSONObject inputData;
ArrayList<galaxy> Galaxies = new ArrayList<galaxy>();
ArrayList<star> Stars = new ArrayList<star>();
ArrayList<star> StarsOnDemand = new ArrayList<star>();
ArrayList<float[]> grGal = new ArrayList<float[]>();

void loadData()
{
  text("Downloading JSON...",wid5,hei5);
  println("[JSON Manager] Downloading JSON from Github Repository https://raw.githubusercontent.com/pkmniako/IC_KSP/master/data.json...");
  inputData = loadJSONObject("https://raw.githubusercontent.com/pkmniako/IC_KSP/master/data.json");
  if(inputData == null){inputData = loadJSONObject("backup/data.json"); println("[JSON Manager] [WARNING] COULD NOT DOWNLOAD JSON FROM GITHUB REPOSITORY, USING BACKUP"); background(0); text("Loading Backup JSON...",wid5,hei5);}
  else{println("[JSON Manager] JSON Downloaded! Creating backup..."); saveJSONObject(inputData, "backup/data.json");}
  if(inputData == null){println("[JSON Manager] [WARNING] COULD NOT LOAD BACKUP DATA");}
  
  JSONArray galaxies = inputData.getJSONArray("galaxies");
  for(int i = 0; i < galaxies.size();i++)
  {
    JSONObject tempGal = galaxies.getJSONObject(i);
    galaxy dataGal = new galaxy();
    dataGal.name = tempGal.getString("name");
    dataGal.size = tempGal.getFloat("size");
    dataGal.type = tempGal.getString("type");
    dataGal.gX = tempGal.getFloat("graphX");
    dataGal.gY = tempGal.getFloat("graphY");
    dataGal.stars = tempGal.getFloat("stars");
    float pos[] = new float[3];
    pos[0] = i; pos[1] = dataGal.gX; pos[2] = dataGal.gY;
    grGal.add(pos);
    
    Galaxies.add(dataGal);
    println("[JSON Manager] Added Galaxy " + dataGal.name);
  }  
  
  JSONArray stars = inputData.getJSONArray("stars");
  for(int i = 0; i < stars.size();i++)
  {
    JSONObject tempStar = stars.getJSONObject(i);
    star dataStar = new star();
    dataStar.name = tempStar.getString("name");
    dataStar.type = tempStar.getString("type");
    dataStar.host = tempStar.getString("host");
    dataStar.posX = tempStar.getFloat("posX");
    dataStar.posY = tempStar.getFloat("posY");
    dataStar.posZ = tempStar.getFloat("posZ");
    Stars.add(dataStar);
    println("[JSON Manager] Added Star " + dataStar.name + " | Host (According to planet): " + dataStar.host);
  }  
}

class galaxy
{
  String name, type;
  float size, stars;
  
  float gX, gY;
}

class star
{
  String name, type, host;
  
  float posX, posY, posZ;
}