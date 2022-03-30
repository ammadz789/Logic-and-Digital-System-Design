`timescale 1ns / 1ps


module CLA (input A0, input A1, input A2, input A3,
            input B0, input B1, input B2, input B3,
            input cin, output cout, 
            output sum0,output sum1, output sum2, output sum3 );
            
            wire p0,p1,p2,p3,g0,g1,g2,g3,c0,c1,c2,c3;
            
            assign p0= (A0^B0);
            assign p1= (A1^B1);
            assign p2= (A2^B2);
            assign p3= (A3^B3);
            
            assign g0= (A0&B0);
            assign g1= (A1&B1);
            assign g2= (A2&B2);
            assign g3= (A3&B3);
            
            assign c0= cin;
            assign c1= g0|(p0&c0);
            assign c2= g1|(p1&g0)|(p1&p0&c0);
            assign c3= g2|(p2&g1)|(p2&p1&g0)|(p2&p1&p0&c0);
            
            assign sum0= p0^c0;
            assign sum1= p1^c1;
            assign sum2= p2^c2;
            assign sum3= p3^c3;
            assign cout= g3|(p3&g2)|(p3&p2&g1)|(p3&p2&p1&g0)|(p3&p2&p1&p0&c0);
            
            
endmodule

/*
module andXor(input x,input y, output X, output Y);

    wire xorWire,andWire;
    assign xorWire = x^y;
    assign andWire = x&y;
    assign X = x;
    assign Y = y;

endmodule
*/

module CLAv2 (input A0, input A1, input A2, input A3,
            input B0, input B1, input B2, input B3,
            input cin, output cout, 
            output sum0,output sum1, output sum2, output sum3, output overflow );
            
            wire p0,p1,p2,p3,g0,g1,g2,g3,c0,c1,c2,c3;
            
            assign p0= (A0^B0);
            assign p1= (A1^B1);
            assign p2= (A2^B2);
            assign p3= (A3^B3);
            
            assign g0= (A0&B0);
            assign g1= (A1&B1);
            assign g2= (A2&B2);
            assign g3= (A3&B3);
            
            assign c0= cin;
            assign c1= g0|(p0&c0);
            assign c2= g1|(p1&g0)|(p1&p0&c0);
            assign c3= g2|(p2&g1)|(p2&p1&g0)|(p2&p1&p0&c0);
            
            assign sum0= p0^c0;
            assign sum1= p1^c1;
            assign sum2= p2^c2;
            assign sum3= p3^c3;
            assign cout= g3|(p3&g2)|(p3&p2&g1)|(p3&p2&p1&g0)|(p3&p2&p1&p0&c0);
            assign overflow = cout^c3;
            
            
endmodule



module Hybrid16bit(A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0,
              B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0,
              C15,C14,C13,C12,C11,C10,C9,C8,C7,C6,C5,C4,C3,C2,C1,C0,
              SUB, OVF);
              
              
              input A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0;
              input B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0;
              input SUB;
              output OVF;
              output C15,C14,C13,C12,C11,C10,C9,C8,C7,C6,C5,C4,C3,C2,C1,C0;
              
               /*
                 
               wire [15:0] Ain;
               assign Ain[0] = A0^B0;
               assign Ain[1] = A1^B1;
               assign Ain[2] = A2^B2;
               assign Ain[3] = A3^B3;
               assign Ain[4] = A4^B4;                          
               assign Ain[5] = A5^B5;
               assign Ain[6] = A6^B6;
               assign Ain[7] = A7^B7;                   
               assign Ain[8] = A8^B8;
               assign Ain[9] = A9^B9;
               assign Ain[10] = A10^B10;
               assign Ain[11] = A11^B11;
               assign Ain[12] = A12^B12;                          
               assign Ain[13] = A13^B13;
               assign Ain[14] = A14^B14;
               assign Ain[15] = A15^B15;
               
               
               
               wire [15:0] Bin;
               assign Bin[0] = A0&B0;
               assign Bin[1] = A1&B1;
               assign Bin[2] = A2&B2;
               assign Bin[3] = A3&B3;
               assign Bin[4] = A4&B4;                          
               assign Bin[5] = A5&B5;
               assign Bin[6] = A6&B6;
               assign Bin[7] = A7&B7;                                 
               assign Bin[8] = A8&B8;
               assign Bin[9] = A9&B9;
               assign Bin[10] = A10&B10;
               assign Bin[11] = A11&B11;
               assign Bin[12] = A12&B12;                          
               assign Bin[13] = A13&B13;
               assign Bin[14] = A14&B14;
               assign Bin[15] = A15&B15;
               */
               
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
                      
               wire [4:1] carry;               
               
               CLA Carry1(A0,A1,A2,A3,bin[0],bin[1],bin[2],bin[3],SUB,carry[1],C0,C1,C2,C3);
               CLA Carry2(A4,A5,A6,A7,bin[4],bin[5],bin[6],bin[7],carry[1],carry[2],C4,C5,C6,C7);
               CLA Carry3(A8,A9,A10,A11,bin[8],bin[9],bin[10],bin[11],carry[2],carry[3],C8,C9,C10,C11);
               CLAv2 Carry4(A12,A13,A14,A15,bin[12],bin[13],bin[14],bin[15],carry[3],carry[4],C12,C13,C14,C15,OVF);
               
               /*
                CLA Carry1(Ain[0],Ain[1],Ain[2],Ain[3],Bin[0],Bin[1],Bin[2],Bin[3],SUB,carry[1],C0,C1,C2,C3);
                CLA Carry2(Ain[4],Ain[5],Ain[6],Ain[7],Bin[4],Bin[5],Bin[6],Bin[7],carry[1],carry[2],C4,C5,C6,C7);
                CLA Carry3(Ain[8],Ain[9],Ain[10],Ain[11],Bin[8],Bin[9],Bin[10],Bin[11],carry[2],carry[3],C8,C9,C10,C11);
                CLA Carry4(Ain[12],Ain[13],Ain[14],Ain[15],Bin[12],Bin[13],Bin[14],Bin[15],carry[3],carry[4],C12,C13,C14,C15);
               */
               //assign OVF = carry[3]^carry[4];
                
              
endmodule














