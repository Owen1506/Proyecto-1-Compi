package scanner;

import parser.*;
import java_cup.runtime.Symbol;
import java.util.ArrayList;
import java.util.List;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.IOException;

%%

%class Lexer
%public
%unicode
%cup
%line
%column

%{

private static class TokenInfo {
    String token;
    String lexema;
    int linea;
    int columna;
    TokenInfo(String token, String lexema, int linea, int columna) {
        this.token = token;
        this.lexema = lexema;
        this.linea = linea;
        this.columna = columna;
    }
}
private List<TokenInfo> tokenLog = new ArrayList<>();
public List<TokenInfo> getTokenLog() {
    return tokenLog;
}
private void addToken(String token) {
    tokenLog.add(new TokenInfo(token, "-", yyline + 1, yycolumn));
}
private void addToken(String token, String lexema) {
    tokenLog.add(new TokenInfo(token, lexema, yyline + 1, yycolumn));
}

public void exportarTokens(String ruta) {
    try (PrintWriter writer = new PrintWriter(new FileWriter(ruta))) {
        writer.println("           LISTA DE TOKENS            ");
        writer.printf("%-12s %-15s %-8s %-8s%n",
                "TOKEN", "LEXEMA", "LINEA", "COL");
        for (TokenInfo t : tokenLog) {
            writer.printf("%-12s %-15s %-8d %-8d%n",
                    t.token,
                    t.lexema,
                    t.linea,
                    t.columna);
        }
        System.out.println("Tokens exportados correctamente a: " + ruta);
    } catch (IOException e) {
        System.err.println("Error al exportar tokens: " + e.getMessage());
    }
}

%}

/* =========================
   MACROS
   ========================= */
Digito = [0-9]
Letra = [a-zA-Z_]
Id = {Letra}({Letra}|{Digito})*

EnteroNoCero = [1-9]
IntN = 0|{EnteroNoCero}{Digito}*
FloatN = {IntN}"."{Digito}+
ExpN = {IntN}[eE]{EnteroNoCero}{Digito}*
FraccionarioN = {EnteroNoCero}{Digito}*"/"{EnteroNoCero}{Digito}*

StringLiteral = \"([^\"\\\r\n]|\\.)*\"
CharLiteral = \'([^\'\\\r\n]|\\.)\'

WhiteSpace = [ \t\f\r\n]+
LineComment = "¡¡"[^\r\n]*
BlockComment = "{-"([^\-]|-+[^}])*"-}"

%%

/* Manejo de BOM (Byte Order Mark) opcional al inicio */
\uFEFF               { /* ignorar BOM */ }

/* Palabras reservadas y tokens */
"int"       { addToken("INT"); return new Symbol(sym.INT, yyline+1, yycolumn, yytext()); }
"float"     { addToken("FLOAT"); return new Symbol(sym.FLOAT, yyline+1, yycolumn, yytext()); }
"char"      { addToken("CHAR"); return new Symbol(sym.CHAR, yyline+1, yycolumn, yytext()); }
"string"    { addToken("STRING"); return new Symbol(sym.STRING, yyline+1, yycolumn, yytext()); }
"bool"      { addToken("BOOL"); return new Symbol(sym.BOOL, yyline+1, yycolumn, yytext()); }
"boolean"   { addToken("BOOL"); return new Symbol(sym.BOOL, yyline+1, yycolumn, yytext()); }
"empty"     { addToken("EMPTY"); return new Symbol(sym.EMPTY, yyline+1, yycolumn, yytext()); }
"expint"    { addToken("EXPINT_KW"); return new Symbol(sym.EXPINT_KW, yyline+1, yycolumn, yytext()); }
"frac"      { addToken("FRAC_KW"); return new Symbol(sym.FRAC_KW, yyline+1, yycolumn, yytext()); }
"__main__"  { addToken("MAIN"); return new Symbol(sym.MAIN, yyline+1, yycolumn, yytext()); }

"if"        { addToken("IF"); return new Symbol(sym.IF, yyline+1, yycolumn, yytext()); }
"else"      { addToken("ELSE"); return new Symbol(sym.ELSE, yyline+1, yycolumn, yytext()); }
"break"     { addToken("BREAK"); return new Symbol(sym.BREAK, yyline+1, yycolumn, yytext()); }
"return"    { addToken("RETURN"); return new Symbol(sym.RETURN, yyline+1, yycolumn, yytext()); }
"case"      { addToken("CASE"); return new Symbol(sym.CASE, yyline+1, yycolumn, yytext()); }
"default"   { addToken("DEFAULT"); return new Symbol(sym.DEFAULT, yyline+1, yycolumn, yytext()); }
"switch"    { addToken("SWITCH"); return new Symbol(sym.SWITCH, yyline+1, yycolumn, yytext()); }
"while"     { addToken("WHILE"); return new Symbol(sym.WHILE, yyline+1, yycolumn, yytext()); }
"do"        { addToken("DO"); return new Symbol(sym.DO, yyline+1, yycolumn, yytext()); }

"cin"       { addToken("CIN"); return new Symbol(sym.CIN, yyline+1, yycolumn, yytext()); }
"cout"      { addToken("COUT"); return new Symbol(sym.COUT, yyline+1, yycolumn, yytext()); }

"equal"       { addToken("EQUAL"); return new Symbol(sym.EQUAL, yyline+1, yycolumn, yytext()); }
"n_equal"     { addToken("N_EQUAL"); return new Symbol(sym.N_EQUAL, yyline+1, yycolumn, yytext()); }
"less_t"      { addToken("LESS_T"); return new Symbol(sym.LESS_T, yyline+1, yycolumn, yytext()); }
"less_te"     { addToken("LESS_TE"); return new Symbol(sym.LESS_TE, yyline+1, yycolumn, yytext()); }
"greather_t"  { addToken("GREATER_T"); return new Symbol(sym.GREATER_T, yyline+1, yycolumn, yytext()); }
"greather_te" { addToken("GREATER_TE"); return new Symbol(sym.GREATER_TE, yyline+1, yycolumn, yytext()); }

"True"  { addToken("TRUE"); return new Symbol(sym.TRUE, yyline+1, yycolumn, yytext()); }
"False" { addToken("FALSE"); return new Symbol(sym.FALSE, yyline+1, yycolumn, yytext()); }

"<|" { addToken("PAR_I"); return new Symbol(sym.PAR_I, yyline+1, yycolumn, yytext()); }
"|>" { addToken("PAR_D"); return new Symbol(sym.PAR_D, yyline+1, yycolumn, yytext()); }
"|:" { addToken("LLAVE_I"); return new Symbol(sym.LLAVE_I, yyline+1, yycolumn, yytext()); }
":|" { addToken("LLAVE_D"); return new Symbol(sym.LLAVE_D, yyline+1, yycolumn, yytext()); }

"<<" { addToken("ARR_I"); return new Symbol(sym.ARR_I, yyline+1, yycolumn, yytext()); }
">>" { addToken("ARR_D"); return new Symbol(sym.ARR_D, yyline+1, yycolumn, yytext()); }

"<-" { addToken("ASSIGN"); return new Symbol(sym.ASSIGN, yyline+1, yycolumn, yytext()); }
"~"  { addToken("SEP"); return new Symbol(sym.SEP, yyline+1, yycolumn, yytext()); }
"!"  { addToken("PYC"); return new Symbol(sym.PYC, yyline+1, yycolumn, yytext()); }
":"  { addToken("DOSPUNTOS"); return new Symbol(sym.DOSPUNTOS, yyline+1, yycolumn, yytext()); }
","  { addToken("COMMA"); return new Symbol(sym.COMMA, yyline+1, yycolumn, yytext()); }

"++" { addToken("INC"); return new Symbol(sym.INC, yyline+1, yycolumn, yytext()); }
"--" { addToken("DEC"); return new Symbol(sym.DEC, yyline+1, yycolumn, yytext()); }

"+"  { addToken("PLUS"); return new Symbol(sym.PLUS, yyline+1, yycolumn, yytext()); }
"-"  { addToken("MINUS"); return new Symbol(sym.MINUS, yyline+1, yycolumn, yytext()); }
"*"  { addToken("MULT"); return new Symbol(sym.MULT, yyline+1, yycolumn, yytext()); }
"/"  { addToken("DIV"); return new Symbol(sym.DIV, yyline+1, yycolumn, yytext()); }
"%"  { addToken("MOD"); return new Symbol(sym.MOD, yyline+1, yycolumn, yytext()); }
"^"  { addToken("POW"); return new Symbol(sym.POW, yyline+1, yycolumn, yytext()); }

"@"  { addToken("AND"); return new Symbol(sym.AND, yyline+1, yycolumn, yytext()); }
"#"  { addToken("OR"); return new Symbol(sym.OR, yyline+1, yycolumn, yytext()); }
"$"  { addToken("NOT"); return new Symbol(sym.NOT, yyline+1, yycolumn, yytext()); }

{FraccionarioN} { addToken("FRAC_LIT", yytext()); return new Symbol(sym.FRAC_LIT, yyline+1, yycolumn, yytext()); }
{ExpN}          { addToken("EXPINT_LIT", yytext()); return new Symbol(sym.EXPINT_LIT, yyline+1, yycolumn, yytext()); }
{FloatN}        { addToken("NUM", yytext()); return new Symbol(sym.NUM, yyline+1, yycolumn, yytext()); }
{IntN}          { addToken("NUM", yytext()); return new Symbol(sym.NUM, yyline+1, yycolumn, yytext()); }

{StringLiteral} { 
    String sinComillas = yytext().substring(1, yytext().length()-1);
    addToken("STRING_LIT", sinComillas);
    return new Symbol(sym.STRING_LIT, yyline+1, yycolumn, sinComillas);
}
{CharLiteral}   {
    String sinComillas = yytext().substring(1, yytext().length()-1);
    addToken("CHAR_LIT", sinComillas);
    return new Symbol(sym.CHAR_LIT, yyline+1, yycolumn, sinComillas);
}
{Id}            { addToken("ID", yytext()); return new Symbol(sym.ID, yyline+1, yycolumn, yytext()); }

{WhiteSpace}  { /* ignorar */ }
{LineComment}  { /* ignorar */ }
{BlockComment} { /* ignorar */ }


. {
    addToken("LEX_ERROR", yytext());
    System.err.println("ERROR LEXICO -> Línea " + (yyline+1) +
        ", Columna " + yycolumn +
        ", Caracter: '" + yytext() + "'");
    return new Symbol(sym.LEX_ERROR, yyline+1, yycolumn, yytext());
}

<<EOF>> { return new Symbol(sym.EOF); }