const sensors = require('./sensors')
const SerialPort = require("serialport");
const Readline = SerialPort.parsers.Readline;
const db = require('./connection');




class ArduinoRead {

    constructor() {
        this.dadosTemperatura = [];
    }

    get List() {
        return this.dadosTemperatura;
    }

    
    geradorDados() {
        setInterval(() => {
            let dadosGerados = sensors.dht11();

            console.log('Temperatura gerada: ' + dadosGerados);
            this.dadosTemperatura.push(dadosGerados); 
            let temp = dadosGerados[0];
            let umi = dadosGerados[1];

            inserirBanco(temp, umi);

        }, 2000);
    }

    SetConnection() {

        SerialPort.list().then(listSerialDevices => {

            let listArduinoSerial = listSerialDevices.filter(serialDevice => {
                return serialDevice.vendorId == 2341 && serialDevice.productId == 43;
            });

            if (listArduinoSerial.length != 1) {
                this.geradorDados();
                throw new Error("Arduino não encontrado - Gerando dados");
            } else {
                console.log("Arduino encontrado na porta COM %s", listArduinoSerial[0].comName);
                return listArduinoSerial[0].comName;
            }
        }).then(comName => {
                let arduino = new SerialPort(comName, { baudRate: 9600 });

                const parser = new Readline();
                arduino.pipe(parser);

                
                parser.on('data', (data) => {
                    let value = data.toString().split(';');
                    let temperature = parseFloat(value[1].replace('\r',''));
                    let humidity = parseFloat(value[0].replace('\r',''));
                    /*
                    this.listData.push(humidity);
                    this.__listDataTemp.push(temperature)
                    console.log("Temp: ",temperature," Umidade: ",humidity);
                    */
                    inserirBanco(temperature, humidity)
                });



        }).catch(error => console.log(error));
    }
}

const serial = new ArduinoRead();
serial.SetConnection();


function inserirBanco(temp,umi){

    let fk1 = 1;
    let fk2 = 2;

    let temp2 = temp * 0.6;
    
    console.log(fk1);
    let sql1 = "INSERT INTO medida(temperatura,umidade,fk_aquario,momento) VALUES( ? , now())";
    let valores1 = [temp,umi,fk1];
    console.log(fk2);
    let sql2 = "INSERT INTO medida(temperatura,umidade,fk_aquario,momento) VALUES( ? , now())";
    let valores2 = [temp2,umi,fk2];

    db.query(sql1, [valores1], function(err, result){
        if(err) throw err;
        console.log("Medidas inseridas tanque 1: " + result.affectedRows)
    });

    db.query(sql2, [valores2], function(err, result){
        if(err) throw err;
        console.log("Medidas inseridas tanque 2: " + result.affectedRows)
    });
};