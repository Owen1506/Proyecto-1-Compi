package tabla;

import java.util.Map;
import java.util.HashMap;
import java.util.Stack;


class Simbolo{
    String nombre;
    String tipo;
    String categoria;
    int linea;
    int columna;
    int scope;

    Simbolo(String nombre, String tipo, String categoria, int linea, int columna, int scope){
        this.nombre = nombre;
        this.tipo = tipo;
        this.categoria = categoria;
        this.linea = linea;
        this.columna = columna;
        this.scope = scope;
    };

    String getNombre(){
        return this.nombre;
    };

    String getTipo(){
        return this.tipo;
    };
    
    String getCategoria(){
        return this.categoria;
    };

    int getLinea(){
        return this.linea;
    };

    int getColumna(){
        return this.columna;
    };
    
    int getScope(){
        return this.scope;
    };

    public String toString(){
        return 
        "Simbolo{" 
        + "nombre = " + getNombre() + ", " 
        + "tipo = " + getTipo() + ", " 
        + "categoria = " + getCategoria() + ", " 
        + "linea = " + getLinea() + ", " 
        + "columna = " + getColumna() + ", " 
        + "scope = " + getScope() + "}";
    };
    //public static void main(String[] args) {
    //    Simbolo s = new Simbolo("x", "int", "variable", 10, 5, 1);
    //    System.out.println(s);
    //}

};

class Tabla{
    Map<String, Simbolo> simbolos;
    int idScope;

    Tabla(int idScope){
        this.idScope = idScope;
        this.simbolos = new HashMap<>();
    };
    void insertar(Simbolo s){
        simbolos.put(s.getNombre(),s);
    }

};


class TablaManagement{
    Stack<Tabla> pilaScopes;
    int contadorScopes;


};

