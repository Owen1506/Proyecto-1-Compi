package scanner;

import parser.*;
import java_cup.runtime.Symbol;

%%

%class Lexer
%public
%unicode
%cup
%line
%column

/* ===== MACROS ===== */
Digito = [0-9]
Letra = [a-zA-Z_]
Id = {Letra}({Letra}|{Digito})*

EnteroNoCero = [1-9]
IntN = 0|{EnteroNoCero}{Digito}*
FloatN = {IntN}"."{Digito}+
ExpN = {IntN}[e]{EnteroNoCero}{Digito}*
FraccionarioN = {EnteroNoCero}{Digito}*"/"{EnteroNoCero}{Digito}*

StringLiteral = \"([^\"\\\r\n]|\\.)*\"
CharLiteral = \'([^\'\\\r\n]|\\.)\'

WhiteSpace = [ \t\f\r\n]+
LineComment = "¡¡"[^\r\n]*
BlockComment = "{-"([^\-]|-+[^}])*"-}"

%%

/* ===== PALABRAS RESERVADAS ===== */
"int"         { return new Symbol(sym.INT, yyline, yycolumn); }
"float"       { return new Symbol(sym.FLOAT, yyline, yycolumn); }
"char"        { return new Symbol(sym.CHAR, yyline, yycolumn); }
"string"      { return new Symbol(sym.STRING, yyline, yycolumn); }
"bool"        { return new Symbol(sym.BOOL, yyline, yycolumn); }
"boolean"     { return new Symbol(sym.BOOL, yyline, yycolumn); }
"empty"       { return new Symbol(sym.EMPTY, yyline, yycolumn); }
"expint"      { return new Symbol(sym.EXPINT_KW, yyline, yycolumn); }
"frac"        { return new Symbol(sym.FRAC_KW, yyline, yycolumn); }
"__main__"    { return new Symbol(sym.MAIN, yyline, yycolumn); }

"if"          { return new Symbol(sym.IF, yyline, yycolumn); }
"else"        { return new Symbol(sym.ELSE, yyline, yycolumn); }
"break"       { return new Symbol(sym.BREAK, yyline, yycolumn); }
"return"      { return new Symbol(sym.RETURN, yyline, yycolumn); }
"case"        { return new Symbol(sym.CASE, yyline, yycolumn); }
"default"     { return new Symbol(sym.DEFAULT, yyline, yycolumn); }
"switch"      { return new Symbol(sym.SWITCH, yyline, yycolumn); }
"while"       { return new Symbol(sym.WHILE, yyline, yycolumn); }
"do"          { return new Symbol(sym.DO, yyline, yycolumn); }

"cin"         { return new Symbol(sym.CIN, yyline, yycolumn); }
"cout"        { return new Symbol(sym.COUT, yyline, yycolumn); }

/* relacionales */
"equal"        { return new Symbol(sym.EQUAL, yyline, yycolumn); }
"n_equal"      { return new Symbol(sym.N_EQUAL, yyline, yycolumn); }
"less_t"       { return new Symbol(sym.LESS_T, yyline, yycolumn); }
"less_te"      { return new Symbol(sym.LESS_TE, yyline, yycolumn); }
"greather_t"   { return new Symbol(sym.GREATER_T,yyline, yycolumn); }
"greather_te"  { return new Symbol(sym.GREATER_TE, yyline, yycolumn); }

"True"         { return new Symbol(sym.TRUE, yyline, yycolumn); }
"False"        { return new Symbol(sym.FALSE, yyline, yycolumn); }

/* ===== SIMBOLOS ===== */
"<|"  { return new Symbol(sym.PAR_I, yyline, yycolumn); }
"|>"  { return new Symbol(sym.PAR_D, yyline, yycolumn); }
"|:"  { return new Symbol(sym.LLAVE_I, yyline, yycolumn); }
":|"  { return new Symbol(sym.LLAVE_D, yyline, yycolumn); }
"<<"  { return new Symbol(sym.ARR_I, yyline, yycolumn); }
">>"  { return new Symbol(sym.ARR_D, yyline, yycolumn); }

"<-"  { return new Symbol(sym.ASSIGN, yyline, yycolumn); }
"~"   { return new Symbol(sym.SEP, yyline, yycolumn); }
"!"   { return new Symbol(sym.PYC,yyline, yycolumn); }
":"   { return new Symbol(sym.DOSPUNTOS, yyline, yycolumn); }
","   { return new Symbol(sym.COMMA, yyline, yycolumn); }

/* operadores */
"++"  { return new Symbol(sym.INC, yyline, yycolumn); }
"--"  { return new Symbol(sym.DEC, yyline, yycolumn); }
"+"   { return new Symbol(sym.PLUS, yyline, yycolumn); }
"-"   { return new Symbol(sym.MINUS, yyline, yycolumn); }
"*"   { return new Symbol(sym.MULT, yyline, yycolumn); }
"/"   { return new Symbol(sym.DIV, yyline, yycolumn); }
"%"   { return new Symbol(sym.MOD, yyline, yycolumn); }
"^"   { return new Symbol(sym.POW, yyline, yycolumn); }

"@"   { return new Symbol(sym.AND, yyline, yycolumn); }
"#"   { return new Symbol(sym.OR, yyline, yycolumn); }
"$"   { return new Symbol(sym.NOT, yyline, yycolumn); }


{FraccionarioN} { return new Symbol(sym.FRAC_LIT, yyline, yycolumn, yytext()); }
{ExpN}          { return new Symbol(sym.EXPINT_LIT,  yyline, yycolumn, yytext()); }
{FloatN}        { return new Symbol(sym.NUM,  yyline, yycolumn, yytext()); }
{IntN}          { return new Symbol(sym.NUM,  yyline, yycolumn, yytext()); }
{StringLiteral} { return new Symbol(sym.STRING_LIT,  yyline, yycolumn, yytext()); }
{CharLiteral}   { return new Symbol(sym.CHAR_LIT,  yyline, yycolumn, yytext()); }
{Id}            { return new Symbol(sym.ID,  yyline, yycolumn, yytext()); }


{WhiteSpace}  { }
{LineComment} { }
{BlockComment} { }

