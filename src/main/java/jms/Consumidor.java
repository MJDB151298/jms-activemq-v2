package jms;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.w3c.dom.Text;

import javax.jms.*;

public class Consumidor {
    ActiveMQConnectionFactory factory;
    Connection connection;
    Session session;
    Queue queue;
    MessageConsumer consumer;
    String cola;

    public Consumidor(String cola){
        this.cola = cola;
    }

    public void conectar() throws JMSException {
        factory = new ActiveMQConnectionFactory("admin", "admin",
                "failover:tcp://localhost:61616");

        //Iniciando conexino
        connection = factory.createConnection();
        connection.start();
        session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        //Creando cola
        queue = session.createQueue(cola);
        System.out.println("Esperando mensajes...");
        consumer = session.createConsumer(queue);
        consumer.setMessageListener(message -> {
            TextMessage textMessage = (TextMessage) message;
            try {
                System.out.println(textMessage.getText());
            } catch (JMSException e) {
                e.printStackTrace();
            }
        });
    }
}
