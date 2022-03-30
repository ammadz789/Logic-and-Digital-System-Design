`timescale 1ns / 1ps


module FullAdder(output carry, output sum, input A, input B, input C

    );
    
    wire w1,w2,w3;
        
    assign w1 = (A & B);
    assign w2 = (A & C);
    assign w3 = (B & C);
    assign sum = (A^B^C);
    assign carry = (w1|w2|w3);
    
    
    
endmodule

module RA16bit(A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0,
              B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0,
              C15,C14,C13,C12,C11,C10,C9,C8,C7,C6,C5,C4,C3,C2,C1,C0,
              SUB, OVF);
    
    input A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0;
    input B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0;
    input SUB;
    output OVF;
    output C15,C14,C13,C12,C11,C10,C9,C8,C7,C6,C5,C4,C3,C2,C1,C0;
    
    wire w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w24;
    
    wire [15:0] bin;
        assign bin[0] = B0^SUB;
        assign bin[1] = B1^SUB;
        assign bin[2] = B2^SUB;
        assign bin[3] = B3^SUB;
        assign bin[4] = B4^SUB;                          
        assign bin[5] = B5^SUB;
        assign bin[6] = B6^SUB;
        assign bin[7] = B7^SUB;
        
        assign bin[8] = B8^SUB;
        assign bin[9] = B9^SUB;
        assign bin[10] = B10^SUB;
        assign bin[11] = B11^SUB;
        assign bin[12] = B12^SUB;                          
        assign bin[13] = B13^SUB;
        assign bin[14] = B14^SUB;
        assign bin[15] = B15^SUB;
    
   
     wire [16:1] carry;     
       
   //output carry = input carry of next 
    FullAdder FA0(carry[1], C0, A0, bin[0], SUB);
    FullAdder FA1(carry[2], C1, A1, bin[1], carry[1]);
    FullAdder FA2(carry[3], C2, A2, bin[2], carry[2]);
    FullAdder FA3(carry[4], C3, A3, bin[3], carry[3]);
    FullAdder FA4(carry[5], C4, A4, bin[4], carry[4]);
    FullAdder FA5(carry[6], C5, A5, bin[5], carry[5]);
    FullAdder FA6(carry[7], C6, A6, bin[6], carry[6]);
    FullAdder FA7(carry[8], C7, A7, bin[7], carry[7]);
    FullAdder FA8(carry[9], C8, A8, bin[8], carry[8]);
    FullAdder FA9(carry[10], C9, A9, bin[9], carry[9]);
    FullAdder FA10(carry[11], C10, A10, bin[10], carry[10]);
    FullAdder FA11(carry[12], C11, A11, bin[11], carry[11]);
    FullAdder FA12(carry[13], C12, A12, bin[12], carry[12]);
    FullAdder FA13(carry[14], C13, A13, bin[13], carry[13]);
    FullAdder FA14(carry[15], C14, A14, bin[14], carry[14]);
    FullAdder FA15(carry[16], C15, A15, bin[15], carry[15]);   
    
     
    
    //assign OVF = SUB^carry[16];
    assign OVF = carry[15]^carry[16];
endmodule

