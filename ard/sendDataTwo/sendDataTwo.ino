
#include <DHT.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h> 
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"



DHT dht_sensor(18, DHT22);
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

bool signupOK = false;
 
void setup() {
  pinMode(2, OUTPUT);
  pinMode(26, OUTPUT);
  pinMode(35, INPUT);
  
  dht_sensor.begin();
  Serial.begin(9600);
  WiFi.begin("Nikitah", "nikita1234");
  Serial.println("connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) { 
    Serial.println("."); delay(2000);
  }
  Serial.println();
  Serial.println("connected to WiFi");
  Serial.println(WiFi.localIP());
  Serial.println();

  config.api_key = "AIzaSyAcQF3h777HBg9rjmL19IM7o-MDNhYQ4cQ";
  config.database_url = "https://esp32sample-6eb0b-default-rtdb.firebaseio.com/";

  if (Firebase.signUp(&config, &auth, "", "")) {
    Serial.println("auth successful");
    digitalWrite(2, HIGH);
    signupOK= true;
  } else { 
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }
  config.token_status_callback = tokenStatusCallback;

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

int summa = 0;

void loop() {
  if (Firebase.ready() && signupOK) { 
    
    int humi  = dht_sensor.readHumidity();
    int tempC = dht_sensor.readTemperature();
    int soil = 4095 - analogRead(35);
    int preparedGhumi = map(soil, 0, 4095, 0, 100);
    useFB(humi, "Sensor2/humi");
    useFB(tempC, "Sensor2/temp");
    useFB(preparedGhumi, "Sensor2/ghumi");

  if (isnan(humi) || isnan(tempC) || humi == 2147483647 || tempC == 2147483647) {
      toggleError("hdt11 error", "Errors/dht11");
    }
    if (isnan(soil) || soil == 2147483647) {
      toggleError("ghumi error", "Errors/ghumi2");
    }

    uvl();
    
    delay(2000);
    
  }
}


void useFB(int dataToSave, const char* path) { 
  if (Firebase.RTDB.setInt(&fbdo, path, dataToSave)) { 
//      Serial.println(); Serial.println("data send" + fbdo.dataPath() + dataToSave);
    } else { 
//      Serial.println("data send error" + fbdo.errorReason());
    }
    
}



void uvl() {
  Firebase.RTDB.getInt(&fbdo, "/Sensor1/humi");
    Serial.println(fbdo.intData());
    summa += fbdo.intData();
    Firebase.RTDB.getInt(&fbdo, "/Sensor2/humi");
    Serial.println(fbdo.intData());
    summa += fbdo.intData();

    Serial.println("summa:  " + String(summa));

    Firebase.RTDB.getInt(&fbdo, "/Values/humi");
    
    if (int(summa / 2.0) > int(fbdo.intData())) {
      digitalWrite(26, LOW);
      Serial.println("low");
    } else {
     digitalWrite(26, HIGH);
     Serial.println("high");
    }

    summa = 0;
}



void toggleError(const char* dataToSave, const char* path) { 
  if (Firebase.RTDB.set(&fbdo, path, dataToSave)) { 
      Serial.println(); Serial.println("data send" + fbdo.dataPath() + dataToSave);
    } else { 
      Serial.println("data send error" + fbdo.errorReason());
    }
}