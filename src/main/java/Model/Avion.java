package Model;

public class Avion {
    private int id;
    private String reference;
    private int nombre_place_business_class;
    private int nombre_place_economique_class;

    public int getId() {
        return id;
    }

    public int getNombre_place_business_class() {
        return nombre_place_business_class;
    }

    public int getNombre_place_economique_class() {
        return nombre_place_economique_class;
    }

    public String getReference() {
        return reference;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNombre_place_business_class(int nombre_place_business_class) {
        this.nombre_place_business_class = nombre_place_business_class;
    }

    public void setNombre_place_economique_class(int nombre_place_economique_class) {
        this.nombre_place_economique_class = nombre_place_economique_class;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }
}
