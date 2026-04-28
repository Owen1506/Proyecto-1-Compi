package main;

import scanner.Lexer;
import parser.parser;
import java.io.*;

/**
 * Clase principal del compilador
 * Responsable de coordinar el análisis léxico y sintáctico
 */
public class Main {
    
    /**
     * Método principal
     * @param args argumentos de línea de comandos
     */
    public static void main(String[] args) {
        if (args.length < 1) {
            System.err.println("Uso: java main.Main <archivo_fuente>");
            System.exit(1);
        }
        
        String sourceFile = args[0];
        
        try {
            // Verificar que el archivo de entrada existe
            File inputFile = new File(sourceFile);
            if (!inputFile.exists()) {
                System.err.println("Error: No se puede encontrar el archivo: " + sourceFile);
                System.exit(1);
            }
            
            // Crear el lexer con el archivo de entrada
            FileReader fileReader = new FileReader(inputFile);
            Lexer lexer = new Lexer(fileReader);
            
            // Crear el parser
            parser parser = new parser(lexer);
            
            // Realizar el análisis sintáctico
            System.out.println("Iniciando análisis...");
            System.out.println("Archivo de entrada: " + sourceFile);
            
            try {
                // Parsear el archivo
                parser.parse();
                System.out.println("\n Análisis completado exitosamente");
                System.out.println(" El archivo respeta la gramática");
            } catch (Exception e) {
                System.err.println("\n Error durante el análisis: " + e.getMessage());
                System.exit(1);
            }
            
            fileReader.close();
            
        } catch (FileNotFoundException e) {
            System.err.println("Error: Archivo no encontrado: " + e.getMessage());
            System.exit(1);
        } catch (IOException e) {
            System.err.println("Error de E/S: " + e.getMessage());
            System.exit(1);
        }
    }
}