package entities;

public class Sensor {
    private String fecha;
    private int id;
    private double temperatura;
    private double humedad;

    public Sensor() {
    }

    public Sensor(String fecha, int id, double temperatura, double humedad) {
        this.fecha = fecha;
        this.id = id;
        this.temperatura = temperatura;
        this.humedad = humedad;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getTemperatura() {
        return temperatura;
    }

    public void setTemperatura(double temperatura) {
        this.temperatura = temperatura;
    }

    public double getHumedad() {
        return humedad;
    }

    public void setHumedad(double humedad) {
        this.humedad = humedad;
    }
}
