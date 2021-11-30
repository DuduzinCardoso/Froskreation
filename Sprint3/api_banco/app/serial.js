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
            let dadosGerados = sensors.lm35();
            let fk_aquario = (Math.random() * 3 + 1);
            console.log('Temperatura gerada: ', parseFloat(dadosGerados.toFixed(2)));
            this.dadosTemperatura.push(dadosGerados); 

            inserirBanco(dadosGerados,this.dadosTemperatura,fk_aquario);

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
                    console.log('Temperatura capturada: ', data);
                    this.dadosTemperatura.push(parseFloat(data));
                    
                    inserirBanco(data, this.dadosTemperatura);
                });
        }).catch(error => console.log(error));
    }
}

const serial = new ArduinoRead();
serial.SetConnection();


function inserirBanco(data,lista,fk_aquario){
    lista.push(parseFloat(data));


    let valor = lista[lista.length - 1];
    
    let sql = `INSERT INTO medida(temperatura,umidade,momento,fk_aquario) VALUES(${valor.toFixed(2)},null,now(),${fk_aquario})`;
    let valores = [valor];

    db.query(sql, [valores], function(err, result){
        if(err) throw err;
        console.log("Medidas inseridas: " + result.affectedRows)
    });
};