package tabla;

public class Simbolo {
    String nombre;
    String tipo;
    String categoria;
    int linea;
    int columna;
    int scope;

    public Simbolo(String nombre, String tipo, String categoria, int linea, int columna, int scope) {
        this.nombre = nombre;
        this.tipo = tipo;
        this.categoria = categoria;
        this.linea = linea;
        this.columna = columna;
        this.scope = scope;
    }

    public int getScope() { return scope; }
    
    public String toString() {
        return String.format(
            "[Scope %d] Nombre: %s : Tipo: %s Categoria: %s  Linea:%d Columna:%d",
            scope,
            nombre,
            tipo,
            categoria,
            linea,
            columna
        );
    }
}
