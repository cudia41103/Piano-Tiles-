`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2023 08:43:21 PM
// Design Name: 
// Module Name: tiles
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//640 x 480 screen
//each tile 
module tiles( input logic vsync,
              input logic reset_ah,
              input logic [7:0] keycode,
              output logic [9:0] tilesize,
              output logic [9:0] TileY ,
              output logic [9:0] TileX 
    );
    // centered playing arrea
    parameter [9:0] Tile_Y_Max=479;
    parameter [9:0] tile_width = 90;
    parameter [9:0] offset = 140;
    parameter [9:0] TileStartX0 = 45+offset ;
    parameter [9:0] TileStartX1 = 45+tile_width+offset;
    parameter [9:0] TileStartX2 = 45+2*tile_width+offset;
    parameter [9:0] TileStartX3 = 45+3*tile_width+offset;
    parameter [9:0] TileYStep = 5;
    assign tilesize=45;
    logic [9:0] Tile_Y_Motion ;
    int random_num;
/*    always_comb
        begin
        if(random_num -1 < 0)
                begin
                random_num=1*//*$urandom%4*//*;//choose values 0-3
                end
        end*/
    always_ff @ (posedge vsync or posedge reset_ah)
        begin :Move_tile
            
            if(reset_ah)
                begin//initiaize values
                TileY <= 10'd0;
                TileX <= TileStartX0;
/*              TileX <= TileStartX1;
                TileX <= TileStartX2;
                TileX <= TileStartX3;*/
                Tile_Y_Motion <= 10'd1; 
                //random_num=0;         
                end
            else
                begin
                Tile_Y_Motion <= TileYStep + Tile_Y_Motion;  // Update tile position

                if(TileY >Tile_Y_Max)//if tile passes screen stop all tiles
                    Tile_Y_Motion <= 10'd0;
                
//                else if (TileY [1]+tilesize >Tile_Y_Max)//if tile passes screen stop all tiles
//                Tile_Y_Motion <= {10'd0,10'd0, 10'd0, 10'd0};
                
//                else if (TileY [2]+tilesize >Tile_Y_Max)//if tile passes screen stop all tiles
//                Tile_Y_Motion <= {10'd0,10'd0, 10'd0, 10'd0};
                
//                else if (TileY [3]+tilesize >Tile_Y_Max)//if tile passes screen stop all tiles
//                Tile_Y_Motion <= {10'd0,10'd0, 10'd0, 10'd0};
                else 
                Tile_Y_Motion <= Tile_Y_Motion;
                
                 
                 if(keycode == 8'h14)//if q (20)
                 begin
                    TileY[0] = 1'b0;
                 end   
                 if (keycode == 8'h1A)//if w (26) 
				 begin
                    TileY[1] = 1'b0;
                 end
                 if(keycode == 8'h08)//if e (8)
				 begin   
				    TileY[2] = 1'b0;
				 end
				 if(keycode == 8'h15)//if r (21)
				 begin
				    TileY[3] = 1'b0;
				 end
				 
			
		          
                end
        
            
        end 
    
endmodule
