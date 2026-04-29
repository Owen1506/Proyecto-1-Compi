package tabla;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Stack;
import java.util.List;
import java.util.Map;
import java.io.*;

public class TablaManagement {

    Stack<Tabla> pilaScopes;
    List<Simbolo> historial;   
    List<String> semanticErrors;
    int contadorScopes = 0;

    public TablaManagement() {
        pilaScopes = new Stack<>();
        historial = new ArrayList<>();
        semanticErrors = new ArrayList<>();
        pilaScopes.push(new Tabla(contadorScopes++));
    }

    public void entrarScope() {
        System.out.println("Entrando en scope");
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
            String msg = "Error semántico: variable " + s.nombre + " ya declarada en este scope";
            semanticErrors.add(msg);
            System.err.println(msg);
            return false;
        }

        actual.insertar(s);
        historial.add(s); 

        return true;
    }

    public List<String> getSemanticErrors() {
        return new ArrayList<>(semanticErrors);
    }

    public void exportErrors(String ruta) {
        try (PrintWriter writer = new PrintWriter(new FileWriter(ruta))) {
            for (String e : semanticErrors) {
                writer.println(e);
            }
            System.out.println("Errores semánticos exportados correctamente a: " + ruta);
        } catch (IOException e) {
            System.err.println("Error al exportar errores semánticos: " + e.getMessage());
        }
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
        Map<Integer, List<Simbolo>> porScope = new HashMap<>();

        for (Simbolo s : historial) {
            porScope
                .computeIfAbsent(s.scope, k -> new ArrayList<>())
                .add(s);
        }

        for (Integer scope : porScope.keySet()) {
            System.out.println("\n--- SCOPE " + scope + " ---");
            for (Simbolo s : porScope.get(scope)) {
                System.out.println(s);
            }
        }
    }

    public void exportarTXT(String ruta) {
        try (PrintWriter writer = new PrintWriter(new FileWriter(ruta))) {

            Map<Integer, List<Simbolo>> porScope = new HashMap<>();

            // agrupar por scope
            for (Simbolo s : historial) {
                porScope
                    .computeIfAbsent(s.scope, k -> new ArrayList<>())
                    .add(s);
            }

            for (Integer scope : porScope.keySet()) {

                writer.println("\nSCOPE: " + scope);
                writer.println("------------------------------------------------------");
                writer.printf("%-10s %-10s %-12s %-6s %-6s%n",
                        "NOMBRE", "TIPO", "CATEGORIA", "LIN", "COL");
                writer.println("------------------------------------------------------");

                for (Simbolo s : porScope.get(scope)) {
                    writer.printf("%-10s %-10s %-12s %-6d %-6d%n",
                            s.nombre,
                            s.tipo,
                            s.categoria,
                            s.linea,
                            s.columna);
                }
            }
            
            System.out.println("Tabla exportada correctamente a: " + ruta);

        } catch (IOException e) {
            System.out.println("Error al exportar: " + e.getMessage());
        }
    }
}
