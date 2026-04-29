package main;

import scanner.Lexer;
import parser.parser;
import java.io.*;

public class Main {
    
    public static void main(String[] args) {
        if (args.length < 1) {
            System.err.println("Uso: java main.Main <archivo_fuente>");
            System.exit(1);
        }
        
        String sourceFile = args[0];
        
        try {
            File inputFile = new File(sourceFile);
            if (!inputFile.exists()) {
                System.err.println("Error: No se puede encontrar el archivo: " + sourceFile);
                System.exit(1);
            }
            
            FileReader fileReader = new FileReader(inputFile);
            Lexer lexer = new Lexer(fileReader);
            parser p = new parser(lexer); // SOLO UNO
            
            System.out.println("Iniciando análisis...");
            System.out.println("Archivo de entrada: " + sourceFile);
            
            try {
                try {
                    p.parse(); // SOLO UNA VEZ
                } catch (Exception e) {
                    System.err.println("\n Error durante el análisis: " + e.getMessage());
                }

                // Siempre exportar tokens y tablas aunque haya habido errores
                lexer.exportarTokens("tokens.txt");

                // Exportar errores sintácticos detectados por el parser
                try (java.io.PrintWriter se = new java.io.PrintWriter(new java.io.FileWriter("syntax_errors.txt"))) {
                    for (String sErr : parser.getSyntaxErrors()) {
                        se.println(sErr);
                    }
                } catch (Exception e) {
                    System.err.println("No se pudo exportar syntax_errors.txt: " + e.getMessage());
                }

                System.out.println("\n=== TABLA DE SIMBOLOS ===");
                p.getTabla().imprimirHistorial();
                p.getTabla().exportarTXT("tabla_simbolos.txt");

                // Exportar errores semánticos (redeclaraciones, etc.)
                p.getTabla().exportErrors("semantic_errors.txt");

            } finally {
                try { fileReader.close(); } catch (Exception ex) {}
            }
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            System.exit(1);
        }
    }
}