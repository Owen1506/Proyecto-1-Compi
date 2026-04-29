package tabla;

import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Stack;
import java.util.List;
import java.io.*;

class Simbolo {
    String nombre;
    String tipo;
    String categoria;
    int linea;
    int columna;
    int scope;

    Simbolo(String nombre, String tipo, String categoria, int linea, int columna, int scope) {
        this.nombre = nombre;
        this.tipo = tipo;
        this.categoria = categoria;
        this.linea = linea;
        this.columna = columna;
        this.scope = scope;
    }

    public String toString() {
        return "Simbolo{" +
                "nombre=" + nombre +
                ", tipo=" + tipo +
                ", categoria=" + categoria +
                ", linea=" + linea +
                ", columna=" + columna +
                ", scope=" + scope +
                "}";
    }
}

class Tabla {
    Map<String, Simbolo> simbolos;
    int idScope;

    Tabla(int idScope) {
        this.idScope = idScope;
        this.simbolos = new HashMap<>();
    }

    void insertar(Simbolo s) {
        simbolos.put(s.nombre, s);
    }

    boolean existe(String nombre) {
        return simbolos.containsKey(nombre);
    }

    Simbolo obtener(String nombre) {
        return simbolos.get(nombre);
    }

    int getIdScope() {
        return idScope;
    }

    void imprimir() {
        for (Simbolo s : simbolos.values()) {
            System.out.println(s);
        }
    }
}

class TablaManagement {

    Stack<Tabla> pilaScopes;
    List<Simbolo> historial;   
    int contadorScopes = 0;

    TablaManagement() {
        pilaScopes = new Stack<>();
        historial = new ArrayList<>();
        pilaScopes.push(new Tabla(contadorScopes++));
    }

    public void entrarScope() {
        pilaScopes.push(new Tabla(contadorScopes++));
    }

    public void salirScope() {
        if (!pilaScopes.isEmpty()) {
            pilaScopes.pop();
        }
    }

    public boolean insertar(Simbolo s) {
        Tabla actual = pilaScopes.peek();

        if (actual.existe(s.nombre)) {
            System.out.println("Error: variable " + s.nombre + " ya declarada en este scope");
            return false;
        }

        actual.insertar(s);
        historial.add(s); 

        return true;
    }

    public Simbolo buscarSimbolo(String nombre) {
        for (int i = pilaScopes.size() - 1; i >= 0; i--) {
            Tabla t = pilaScopes.get(i);
            if (t.existe(nombre)) {
                return t.obtener(nombre);
            }
        }
        return null;
    }

    public boolean existe(String nombre) {
        return buscarSimbolo(nombre) != null;
    }

    public int getScopeActual() {
        return pilaScopes.peek().getIdScope();
    }

    public void imprimirActual() {
        for (Tabla t : pilaScopes) {
            System.out.println("Scope: " + t.getIdScope());
            t.imprimir();
        }
    }

   
    public void imprimirHistorial() {
        System.out.println("\n=== HISTORIAL COMPLETO ===");
        for (Simbolo s : historial) {
            System.out.println(s);
        }
    }

    public void exportarTXT(String ruta) {
        try (PrintWriter writer = new PrintWriter(new FileWriter(ruta))) {
            for (Simbolo s : historial) {
                writer.println(s);
            }
            System.out.println("Tabla exportada correctamente a: " + ruta);
        } catch (IOException e) {
            System.out.println("Error al exportar: " + e.getMessage());
        }
    }
}
