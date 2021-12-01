#include "DHT.h"
#define dht_type DHT11 
int dht_pin = A0;
DHT dht_1 = DHT (dht_pin, dht_type);

void setup()
{
    Serial.begin(9600);
    dht_1.begin();
}

void loop()
{
    float umidade = dht_1.readHumidity();  
    float temperatura = dht_1.readTemperature();
    if (isnan(temperatura) or isnan(umidade))
    {
        Serial.printIn("Erro ao ler DHT");
    }
    else
    {
        Serial.print(umidade);
        Serial.print(";");
        Serial.print(tempertura);
    }
    delay(2000);
}

// Gerenciar bibliotecas ---> Sketch
// Bibliotecas para baixar:
//
// >> DHT Sensor Library
// >> Adafruit Unified Sensor 
// >> Adafruity Circuit Playground
//
// Após instalar bibliotecas, salvar na pasta da IDE do Arduino.