`timescale 1ns / 1ps


module RA16bitsim(

    );    
    
    // Inputs
       reg A0;
       reg A1;
       reg A2;
       reg A3;
       reg A4;
       reg A5;
       reg A6;
       reg A7;
       reg A8;
       reg A9;
       reg A10;
       reg A11;
       reg A12;
       reg A13;
       reg A14;
       reg A15;      
       reg B0;
       reg B1;
       reg B2;
       reg B3;
       reg B4;
       reg B5;
       reg B6;
       reg B7;
       reg B8;
       reg B9;
       reg B10;
       reg B11;
       reg B12;
       reg B13;
       reg B14;
       reg B15;       
       reg SUB;
           
    
    // Output
       wire C0;
       wire C1;
       wire C2;
       wire C3;
       wire C4;
       wire C5;
       wire C6;
       wire C7;
       wire C8;
       wire C9;
       wire C10;
       wire C11;
       wire C12;
       wire C13;
       wire C14;
       wire C15;
       wire OVF;
    
    // Bidirs
    
    // Instantiate the UUT
       RA16bit UUT (
       .A0(A0), 
       .B0(B0), 
       .A1(A1), 
       .B1(B1), 
       .A2(A2), 
       .B2(B2), 
       .SUB(SUB), 
       .A3(A3), 
       .B3(B3), 
       .A4(A4), 
       .B4(B4), 
       .A5(A5), 
       .B5(B5), 
       .B8(B8), 
       .A8(A8), 
       .B7(B7), 
       .A7(A7), 
       .A6(A6), 
       .B6(B6), 
       .A9(A9), 
       .B9(B9), 
       .A10(A10), 
       .B10(B10), 
       .A11(A11), 
       .B11(B11), 
       .B14(B14), 
       .A14(A14), 
       .B13(B13), 
       .A13(A13), 
       .B12(B12), 
       .A12(A12),
       .A15(A15),
       .B15(B15), 
       .C0(C0), 
       .C1(C1), 
       .C2(C2), 
       .C3(C3), 
       .C4(C4), 
       .C5(C5), 
       .C6(C6), 
       .C7(C7), 
       .C8(C8), 
       .C9(C9), 
       .C10(C10), 
       .C11(C11), 
       .C12(C12), 
       .C13(C13), 
       .C14(C14),
       .C15(C15), 
       .OVF(OVF)
       );
    // Initialize Inputs
       
       initial begin
       SUB = 0;

      {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = -18966;

      {B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0} = 9483;
        
        #100;
      SUB = 0;

      {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = 153;

      {B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0} = -247;
        
        #100;
      SUB = 1;

      {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = -18966;

      {B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0} = -6;
        
        #100;
      SUB = 1;

      {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = 256;

      {B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0} = 350;
      
              #100;
     SUB = 0;

      {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = 32767;

      {B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0} = 32767;
 
       end
    endmodule

