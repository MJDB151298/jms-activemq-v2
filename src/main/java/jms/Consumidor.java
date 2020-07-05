package jms;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.w3c.dom.Text;

import javax.jms.*;

public class Consumidor {
    ActiveMQConnectionFactory factory;
    Connection connection;
    Session session;
    Topic topic;
    MessageConsumer consumer;
    String topicName;

    public Consumidor(String topicName){
        this.topicName = topicName;
    }

    public void conectar() throws JMSException {
        factory = new ActiveMQConnectionFactory("admin", "admin",
                "failover:tcp://localhost:61616");

        //Iniciando conexino
        connection = factory.createConnection();
        connection.start();
        session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        //Creando cola
        topic = session.createTopic(topicName);
        System.out.println("Esperando mensajes...");
        consumer = session.createConsumer(topic);
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
