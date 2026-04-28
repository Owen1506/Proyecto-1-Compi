package main;
import parser.sym;
import scanner.Lexer;
import java.io.FileReader;
import java_cup.runtime.Symbol;

public class Main {
    public static void main(String[] args) throws Exception {

        Lexer lexer = new Lexer(new FileReader("src/tests/prueba.txt"));
        Symbol token;

        while (true) {
            token = lexer.next_token();

            if (token.sym == sym.EOF) {
                break;
            }

            System.out.println(
                "Token: " + token.sym +
                " | Valor: " + token.value +
                " | Línea: " + token.left +
                " | Columna: " + token.right
            );
        }
    }
}