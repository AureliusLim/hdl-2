'timescale 1ns / 1ps
module halfadder();
    input x,y, ci;
    output s;

    xor(s, x, y, ci); // x xor y
    
endmodule

module fulladder();
    input x, y, ci;
    output s, co;
    wire w1, w2, w3;

    xor (w1, x, y) // x xor y
    xor (s, w1, ci); // x xor y xor ci

    and(w2,x, y); // xy
    and(w3, w1, ci); // (x xor y)ci
    or (co, w3, w2); // (x xor y)ci + xy

endmodule

module PG(P,G,X,Y);
    input X, Y;
    output P, G;

    xor G1(P, X, Y);
    and G2(G,X,Y);

endmodule

module cla(S4, S3, C5, C4, C3, X, Y, C0);
    input [7:0] X,Y;
    input C0;
    wire C1, C2;
    wire P0, P1, P2, P3, P4, G0, G1, G2, G3, G4;
    wire S0, S1, S2;
    
    output C3, C4, C5;
    output S4, S3; 

    PG T1(P0, G0, X[0], Y[0]);
    PG T2(P1, G1, X[1], Y[1]);
    PG T3(P2, G2, X[2], Y[2]);
    PG T4(P3, G3, X[3], Y[3]);
    PG T5(P4, G4, X[4], Y[4]);

    assign
         C1 = G0 | (P0 & C0),
         C2 = G1 | (P1 & (G0 | (P0 & C0))),
         C3 = G2 | (P2 & (G1 | (P1 & (G0 | (P0 & C0))))),
         C4 = G3 | (P3 & (G2 | (P2 & (G1 | (P1 & (G0 | (P0 & C0))))))),
         C5 = G4 | (P4 & (G3 | (P3 & (G2 | (P2 & (G1 | (P1 & (G0 | (P0 & C0)))))))));

    assign 
        S0 = P0 ^ C0,
        S1 = P1 ^ C1,
        S2 = P2 ^ C2,
        S3 = P3 ^ C3,
        S4 = P4 ^ C4;

endmodule

module circuit (S,C8,X,Y, C0);
    input [7:0] X,Y;
    input C0;
    wire C1, C2, C3, C4, C5, C6, C7;
    output [7:0] S;
    output C8;

    fulladder F1(S[0], C1, X[0], Y[0], C0);
    fulladder F2(S[1], C2, X[1], Y[1], C1);
    halfadder H3(S[2], X[2], Y[2], C2);

    cla F45(S[4], S[3], C5, C4, C3, X, Y, C0);

    fulladder F6(S[5], C6, X[5], Y[5], C5);
    fulladder F7(S[6], C7, X[6], Y[6], C6);
    fulladder F8(S[7], C8, X[7], Y[7], C7);

endmodule