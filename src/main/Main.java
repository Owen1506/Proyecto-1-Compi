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
                p.parse(); // SOLO UNA VEZ
                lexer.exportarTokens("tokens.txt");
                System.out.println("\n Análisis completado exitosamente");
                System.out.println(" El archivo respeta la gramática");
                
                System.out.println("\n=== TABLA DE SIMBOLOS ===");
                p.getTabla().imprimirHistorial();
                p.getTabla().exportarTXT("tabla_simbolos.txt");
                
            } catch (Exception e) {
                System.err.println("\n Error durante el análisis: " + e.getMessage());
                System.exit(1);
            }
            
            fileReader.close();
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            System.exit(1);
        }
    }
}