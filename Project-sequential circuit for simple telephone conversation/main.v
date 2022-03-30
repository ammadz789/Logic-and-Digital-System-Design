`timescale 1ns / 1ps


module tel(
    input clk,
    input rst,
    input startCall, answerCall,
    input endCall,
    input sendChar,
    input [7:0] charSent,
    output reg [63:0] statusMsg = "IDLE   ",
    output reg [63:0] sentMsg = {8{8'd32}} 
    );
    
    parameter [2:0] IDLE = 3'b000;
    parameter [2:0] BUSY = 3'b001;
    parameter [2:0] REJECTED = 3'b010;
    parameter [2:0] RINGING = 3'b011;
    parameter [2:0] CALL = 3'b100;
    parameter [2:0] COST = 3'b101;
    
    reg[2:0] curr_state, next_state;
    reg[3:0] counter = 0;
    reg[31:0] cost = 0;
    
    
    
    
      //state transitions
      always @ (posedge clk or posedge rst) begin
          if(rst) begin
              curr_state <= IDLE;
           end
           
           else begin
              curr_state <= next_state;
           end
      end
      
   
        
    
    //control registers
    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            counter <= 0;
            cost <= 0;
        end
        
        else begin
            case(curr_state)
            
                IDLE: begin
                    counter <= 0;
                    cost <= 0;                    
                end
                
                RINGING: begin
                    cost <= 0;
                    counter <= counter + 1;
                    if(next_state == REJECTED | next_state == BUSY | next_state == CALL) begin
                        counter <= 0;
                    end
                end
                
                CALL: begin
                    counter <= 0;
                    if(sendChar == 1) begin
                        if(charSent == 127) begin
                            cost <= cost + 2;
                        end
                        
                        else if(charSent < 8'd32 || charSent > 8'd127) begin
                            cost <= cost;
                        end
                        
                        else begin
                            if(charSent < 8'd48 || charSent > 8'd57 ) begin
                                cost <= cost + 2;
                            end
                            else begin
                                cost <= cost + 1;
                            end
                        end
                    end
                    else begin
                        cost <= cost;
                    end                    
                end
                
                REJECTED: begin
                    cost <= 0;
                    counter <= counter + 1;
                end
                
                COST: begin
                    cost <= cost;
                    counter <= counter + 1;
                end
                
                BUSY: begin
                    cost <= 0;
                    counter <= counter + 1;
                end
                
                default:
                begin
                    cost <= 0;
                    counter <= 0;
               end
           endcase       
           
           
            /*if(curr_state == RINGING | curr_state == REJECTED | curr_state == BUSY | curr_state == COST) begin
                if(counter == 10)
                    counter <= 0;
                else
                    counter <= counter + 1;
            end
            else
                counter <= counter;
          */
       end
    end
    
    
  
    //next state
    always @ (*) 
    begin
        case(curr_state)
        
            IDLE: begin
                if(startCall == 1) begin
                    next_state <= RINGING;
                end
                else begin
                    next_state <= IDLE;                    
                end
            end
            
            RINGING: begin
                if(endCall == 1) begin
                    next_state <= REJECTED;
                end
                else if(answerCall == 1) begin
                    next_state <= CALL;
                end
                else if(counter == 9) begin
                    next_state <= BUSY;
                end    
                else begin
                    next_state <= RINGING;   
                end                             
            end
            
            REJECTED: begin
                if(counter == 9) begin
                    next_state <= IDLE; 
                end
                else begin
                    next_state <= REJECTED;
                end
            end
            
            BUSY: begin
                if(counter == 9) begin
                    next_state <= IDLE; 
                end
                else begin
                    next_state <= BUSY;
                end
            end
            
            CALL: begin
                if(endCall == 1) begin
                    next_state <= COST; 
                end
                else if(charSent == 127) begin
                    next_state <= COST;
                end
                else begin
                    next_state <= CALL;
                end
            end
            
            COST: begin
                if(counter == 4) begin
                    next_state <= IDLE;
                end
                else begin
                    next_state <= COST;
                end
            end            
         endcase        
     end
     
     //outputs
     always @ (posedge clk or posedge rst) begin
        if(rst) begin
            statusMsg <= "IDLE    ";
            sentMsg <= {8{8'd32}};
        end
        else begin 
            case(curr_state)
            
                IDLE: begin
                    statusMsg <= "IDLE    ";
                    sentMsg <= {8{8'd32}};
                end
                RINGING: begin
                    statusMsg <= "RINGING ";
                 
                    sentMsg <= {8{8'd32}};
                end
                
                REJECTED: begin
                    statusMsg <= "REJECTED";
                    sentMsg <= {8{8'd32}};
                end
                BUSY: begin
                    statusMsg <= "BUSY    ";
                    sentMsg <= {8{8'd32}};
                end
                
                CALL: begin
                     statusMsg <= "CALLER  ";
                     
                     if(sendChar == 1) begin
                        if(charSent == 8'd127) begin
                            sentMsg <= {8{8'd32}};
                        end
                        else if (charSent < 8'd32 || charSent > 8'd127) begin
                            sentMsg <= sentMsg;
                        end
                        else begin
                            sentMsg[7:0] <= charSent;
                            sentMsg[15:8] <= sentMsg[7:0];
                            sentMsg[23:16] <= sentMsg[15:8];
                            sentMsg[31:24] <= sentMsg[23:16];
                            sentMsg[39:32] <= sentMsg[31:24];
                            sentMsg[47:40] <= sentMsg[39:32];
                            sentMsg[55:48] <= sentMsg[47:40];
                            sentMsg[63:56] <= sentMsg[55:48];
                        end
                     end
                     
                     else begin
                        sentMsg <= sentMsg;
                     end     
                end
                
                COST: begin
                    statusMsg <= "COST    ";
                    sentMsg <= {8{8'd48}};
                   
                    
                    if(cost[31:28] < 4'b1010) begin
                        sentMsg[63:56] <= 48 + cost[31:28];
                    end
                    else begin
                       sentMsg[63:56] <= 55 + cost[31:28];
                    end
                        
                    if(cost[27:24] < 4'b1010) begin
                        sentMsg[55:48] <= 48 + cost[27:24];
                    end
                    else begin
                        sentMsg[55:48] <= 55 + cost[27:24];
                    end
                    if(cost[23:20] < 4'b1010) begin
                         sentMsg[47:40] <= 48 + cost[23:20];
                    end
                    else begin
                         sentMsg[47:40] <= 55 + cost[23:20];
                    end
                        
                    if(cost[19:16] < 4'b1010) begin
                        sentMsg[39:32] <= 48 + cost[19:16];
                    end
                    else begin
                        sentMsg[39:32] <= 55 + cost[19:16];
                    end
                        
                    if(cost[15:12] < 4'b1010) begin
                        sentMsg[31:24] <= 48 + cost[15:12];
                    end
                    else begin
                        sentMsg[31:24] <= 55 + cost[15:12];
                    end
                        
                    if(cost[11:8] < 4'b1010) begin
                        sentMsg[23:16] <= 48 + cost[11:8];
                    end
                    else begin
                        sentMsg[23:16] <= 55 + cost[11:8];
                    end
                        
                    if(cost[7:4] < 4'b1010) begin
                        sentMsg[15:8] <= 48 + cost[7:4];
                    end
                    else begin
                        sentMsg[15:8] <= 55 + cost[7:4];
                    end
                        
                    if(cost[3:0] < 4'b1010) begin
                        sentMsg[7:0] <= 48 + cost[3:0];
                    end
                    else begin
                        sentMsg[7:0] <= 55 + cost[3:0];
                    end
                    
                end
                
                default
                begin
                             statusMsg <= "IDLE    ";
                             sentMsg <= {8{8'd32}};
                end
                
            endcase
                    
        end
     end    
    
endmodule
