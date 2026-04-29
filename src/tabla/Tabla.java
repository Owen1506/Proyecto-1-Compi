package tabla;

import java.util.HashMap;
import java.util.Map;


public class Tabla {
    Map<String, Simbolo> simbolos;
    int idScope;

    public Tabla(int idScope) {
        this.idScope = idScope;
        this.simbolos = new HashMap<>();
    }

    public void insertar(Simbolo s) {
        simbolos.put(s.nombre, s);
    }

    public boolean existe(String nombre) {
        return simbolos.containsKey(nombre);
    }

    public Simbolo obtener(String nombre) {
        return simbolos.get(nombre);
    }

    public int getIdScope() {
        return idScope;
    }

    public void imprimir() {
        for (Simbolo s : simbolos.values()) {
            System.out.println(s);
        }
    }  
}
