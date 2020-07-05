package jms;

import com.google.gson.Gson;
import entities.Sensor;
import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.concurrent.TimeUnit;

public class Productor {
    public Productor() {
    }

    static Gson gson = new Gson();
    static Random random;
    static Format format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

    public static void enviarMensaje(String cola) throws JMSException {
        ActiveMQConnectionFactory factory = new ActiveMQConnectionFactory("failover:tcp://localhost:61616");

        Connection connection = factory.createConnection("admin", "admin");
        connection.start();

        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
        Queue queue = session.createQueue(cola);

        MessageProducer producer = session.createProducer(queue);

        while(true){
            try{
                TimeUnit.SECONDS.sleep(2);
                random = new Random();
                int id = random.nextInt(1 + 1)  + 1;
                String mensajeDispositivo = nuevaLectura(id);
                TextMessage message = session.createTextMessage(mensajeDispositivo);
                producer.send(message);
                System.out.println("[X] Enviado: '" + mensajeDispositivo + "'");
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }


    }

    public static String nuevaLectura(int idDispositivo) {
        String dateSrt = format.format(new Date());
        double tempreratura = random.nextInt(100-10) + 1;
        double humedad = random.nextInt(100-10) + 1;
        Sensor sensor = new Sensor(dateSrt, idDispositivo, tempreratura, humedad);
        return gson.toJson(sensor);
    }
}
