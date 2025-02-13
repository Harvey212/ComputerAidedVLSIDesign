
module core (                       //Don't modify interface
	input         i_clk,
	input         i_rst_n,
	input         i_op_valid,
	input  [ 3:0] i_op_mode,
    output        o_op_ready,
	input         i_in_valid,
	input  [ 7:0] i_in_data,
	output        o_in_ready,
	output        o_out_valid,
	output [13:0] o_out_data
);

// ---------------------------------------------------------------------------
// Wires and Registers
// ---------------------------------------------------------------------------
// ---- Add your own wires and registers here if needed ---- //


reg [11:0] imgcount;


///////////////////////////////////////////////////////////////
//input
//reg t_i_op_valid;
reg [3:0] t_i_op_mode;
////////
//reg t_i_in_valid;
//reg [7:0] t_i_in_data;
///////////////////////////

//output
reg t_o_op_ready;
reg t_o_in_ready;
reg t_o_out_valid;
reg [13:0] t_o_out_data;
/////////////////////////////////////////////////////////////////




/////////////////////////////////////////////////////////////////
//for chip
reg enable1;
reg writable1;
reg [8:0] sramaddr1;
reg [7:0] sramin1;
reg [7:0] sramout1;

reg enable2;
reg writable2;
reg [8:0] sramaddr2;
reg [7:0] sramin2;
reg [7:0] sramout2;

reg enable3;
reg writable3;
reg [8:0] sramaddr3;
reg [7:0] sramin3;
reg [7:0] sramout3;

reg enable4;
reg writable4;
reg [8:0] sramaddr4;
reg [7:0] sramin4;
reg [7:0] sramout4;
/////////////////////////////////////
reg [8:0] t_sramaddr1;
reg [8:0] t_sramaddr2;
reg [8:0] t_sramaddr3;
reg [8:0] t_sramaddr4;
///////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////
//for load
///////////
//131313
//242424
//131313
//242424
//////////
reg [2:0] rowc;
reg [2:0] colc;
reg [4:0] depc;

reg [2:0] t_rowc;
reg [2:0] t_colc;
reg [4:0] t_depc;

reg [1:0] loadwho;

reg [8:0] Lsramaddr1;
reg [8:0] Lsramaddr2;
reg [8:0] Lsramaddr3;
reg [8:0] Lsramaddr4;


reg loaddone1;
reg loaddone2;
////////////////////////////////////////////////////////////////////





///////////////////////////////////////////////////
//FSM

reg [5:0] state;
reg [5:0] next_state;

//39 state
localparam ReadyState   = 6'b000000;
localparam BufferState  = 6'b000001;
localparam GetInstState = 6'b000010;
localparam LoadState    = 6'b000011;
localparam Disp0State   = 6'b000100;
localparam Buffer2State = 6'b000101;
localparam Disp1State   = 6'b000110;
localparam Disp2State   = 6'b000111;
localparam Disp3State   = 6'b001000;
localparam Disp4State   = 6'b001001;
localparam PreState     = 6'b001010;
localparam Buffer3State = 6'b001011;
localparam ReaState     = 6'b001100;
localparam OKState      = 6'b001101;
localparam Conv0State   = 6'b001110;
localparam Conv1State   = 6'b001111;
localparam Conv2State   = 6'b010000;
localparam Conv3State   = 6'b010001;
localparam Buffer4State = 6'b010010;
localparam Conv4State   = 6'b010011;
localparam Conv5State   = 6'b010100;
localparam Conv6State   = 6'b010101;
localparam Conv7State   = 6'b010110;
localparam Conv8State   = 6'b010111;
localparam Med0State    = 6'b011000;
localparam Med1State    = 6'b011001;
localparam Med2State    = 6'b011010;
localparam Med3State    = 6'b011011;
localparam Med4State    = 6'b011100;
localparam Med5State    = 6'b011101;
localparam Med6State    = 6'b011110;
localparam Sobel0State  = 6'b011111;
localparam Sobel1State  = 6'b100000;
localparam Sobel2State  = 6'b100001;
localparam Sobel3State  = 6'b100010;
localparam Sobel4State  = 6'b100011;
localparam Sobel5State  = 6'b100100;
localparam Sobel6State  = 6'b100101;
localparam Sobel7State  = 6'b100110;
localparam Sobel8State  = 6'b100111;


///////////////////////////////////////////////////////





//////////////////////////////////////////////////
//for shifting and increase and decrease of channel
//for display region
reg [2:0] Orow;
reg [2:0] Ocol;

reg [4:0] maxdep;
/////////////////////////////////////////////////




//////////////////////////////////////////////////////
//for display
reg disposdone;
//
reg [8:0] pos1;
reg [8:0] pos2;
reg [8:0] pos3;
reg [8:0] pos4;

reg [4:0] mydep;

reg [1:0] discon;
////////////////////////////////////////////////////////





/////////////////////////////////////////////////////////
//for reading
reg readdone;
///////////////
reg [1:0] block;
reg [4:0] cdep;

reg [8:0] cpos1;
reg [8:0] cpos2;
reg [8:0] cpos3;
reg [8:0] cpos4;

reg cpos1valid;
reg cpos2valid;
reg cpos3valid;
reg cpos4valid;

reg [2:0] tOrow;
reg [2:0] tOcol;
reg [1:0] tdiscon;
//////////////////////////////////////////////////////////////







///////////////////////////////////////////////////////////
//for convolution
///////////////////////////////
reg [17:0] Conv1 [0:8];
reg [17:0] Conv2 [0:8];
reg [17:0] Conv3 [0:8];
reg [17:0] Conv4 [0:8];

////////////////////////////////////////////
//reg [20:0] dataLU;
//reg [20:0] dataRU;
//reg [20:0] dataLD;
//reg [20:0] dataRD;

reg convdone1;
reg convdone2;
reg convdone3;
reg convdone4;

reg adjdone;
//////////////////////////////////////////
reg [17:0] myacc [0:3];
reg [17:0] t0;
reg [17:0] t1;
reg [17:0] t2;
reg [17:0] t3;

reg [17:0] g0;
reg [17:0] g1;
reg [17:0] g2;
reg [17:0] g3;

reg [13:0] cANS1;
reg [13:0] cANS2;
reg [13:0] cANS3;
reg [13:0] cANS4;
////////////////////////////////
reg [17:0] ctemp1;
reg [17:0] ctemp2;
reg [17:0] ctemp3;
reg [17:0] ctemp4;

//reg [20:0] tlu;
//reg [20:0] tru;
//reg [20:0] tld;
//reg [20:0] trd;

///////////////////////////////












/////////////////////////////////////////////////////////////////////////
//median filter
reg [7:0] m0;
reg [7:0] m1;
reg [7:0] m2;
reg [7:0] m3;

reg [7:0] m4;
reg [7:0] m5;
reg [7:0] m6;
reg [7:0] m7;

reg [7:0] m8;
reg [7:0] m9;
reg [7:0] m10;
reg [7:0] m11;

reg [7:0] m12;
reg [7:0] m13;
reg [7:0] m14;
reg [7:0] m15;

/////////////////////////////////////
reg [7:0] sorted1 [0:8];
reg [7:0] sorted2 [0:8];
reg [7:0] sorted3 [0:8];
reg [7:0] sorted4 [0:8];

reg [7:0] mt1;
reg [7:0] mt2;
reg [7:0] mt3;
reg [7:0] mt4;
/////////////////////////////////////
integer i1,i2,i3,i4;
integer j1,j2,j3,j4;

reg [13:0] median1;
reg [13:0] median2;
reg [13:0] median3;
reg [13:0] median4;

reg [7:0] tsort1 [0:8];
reg [7:0] tsort2 [0:8];
reg [7:0] tsort3 [0:8];
reg [7:0] tsort4 [0:8];

reg mdone1;
reg mdone2;
reg mdone3;
reg mdone4;
////////////////////////////////////////////////////////////////////////////













////////////////////////////////////////////////////////////////////////////////////////////
//Sobel Gradient

reg sdone1;
reg sdone2;
reg sdone3;
reg sdone4;

reg tGdone;
///////////////////////////////////////
reg signed [13:0] NMS1 [0:8];
reg signed [13:0] NMS2 [0:8];
reg signed [13:0] NMS3 [0:8];
reg signed [13:0] NMS4 [0:8];

reg signed [20:0] GX1;
reg signed [20:0] GY1;
reg signed [20:0] AGX1;
reg signed [20:0] AGY1;
reg signed [20:0] GG1;

reg signed [20:0] GX2;
reg signed [20:0] GY2;
reg signed [20:0] AGX2;
reg signed [20:0] AGY2;
reg signed [20:0] GG2;

reg signed [20:0] GX3;
reg signed [20:0] GY3;
reg signed [20:0] AGX3;
reg signed [20:0] AGY3;
reg signed [20:0] GG3;

reg signed [20:0] GX4;
reg signed [20:0] GY4;
reg signed [20:0] AGX4;
reg signed [20:0] AGY4;
reg signed [20:0] GG4;

//////////////////////////////

reg signed [20:0] Q11;
reg signed [20:0] Q12;
reg signed [20:0] T11;
reg signed [20:0] T12;

reg [1:0] DK1;
reg negx1;
reg negy1;
//////////////////////////////

reg signed [20:0] Q21;
reg signed [20:0] Q22;
reg signed [20:0] T21;
reg signed [20:0] T22;

reg [1:0] DK2;
reg negx2;
reg negy2;

///////////////////////////////

reg signed [20:0] Q31;
reg signed [20:0] Q32;
reg signed [20:0] T31;
reg signed [20:0] T32;

reg [1:0] DK3;
reg negx3;
reg negy3;

///////////////////////////////////

reg signed [20:0] Q41;
reg signed [20:0] Q42;
reg signed [20:0] T41;
reg signed [20:0] T42;

reg [1:0] DK4;
reg negx4;
reg negy4;

///////////////////////////////////////


reg [13:0] nans1;
reg [13:0] nans2;
reg [13:0] nans3;
reg [13:0] nans4;

reg signed [20:0] tGG1;
reg signed [20:0] tGG2;
reg signed [20:0] tGG3;
reg signed [20:0] tGG4;

reg [1:0] tdk1;
reg [1:0] tdk2;
reg [1:0] tdk3;
reg [1:0] tdk4;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////








/////////////////////////////////////////////////////////////////////////////////////////////
sram_512x8 sram1(.Q(sramout1),.CLK(i_clk),.CEN(enable1),.WEN(writable1),.A(sramaddr1),.D(sramin1));
sram_512x8 sram2(.Q(sramout2),.CLK(i_clk),.CEN(enable2),.WEN(writable2),.A(sramaddr2),.D(sramin2));
sram_512x8 sram3(.Q(sramout3),.CLK(i_clk),.CEN(enable3),.WEN(writable3),.A(sramaddr3),.D(sramin3));
sram_512x8 sram4(.Q(sramout4),.CLK(i_clk),.CEN(enable4),.WEN(writable4),.A(sramaddr4),.D(sramin4));
////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ---------------------------------------------------------------------------
// Continuous Assignment
// ---------------------------------------------------------------------------
// ---- Add your own wire data assignments here if needed ---- //

assign o_op_ready = t_o_op_ready;
assign o_in_ready = t_o_in_ready;
assign o_out_valid = t_o_out_valid;
assign o_out_data = t_o_out_data;
////////////////////////////////////////////////////////////////////////////////////





// ---------------------------------------------------------------------------
// Combinational Blocks
// ---------------------------------------------------------------------------
// ---- Write your conbinational block design here ---- //

///////////////////////////////////////////////////////////////
//                         For FSM
////////////////////////////////////////////////////////////////
always@(next_state)
begin
    state = next_state;
end
////////////////////////////////////////////////////////////////







//////////////////////////////////////////////////////////////////////////////////
//                         For Loading
//////////////////////////////////////////////////////////////////////////////////
always@(*)
begin
	loaddone1 =0;
	/////////////////////////////
	t_sramaddr1=0;
	t_sramaddr2=0;
	t_sramaddr3=0;
	t_sramaddr4=0;

	if( (rowc[0] ==0) && (colc[0]==0) )
		begin
			
			loadwho = 2'b00;

			if((rowc==0) && (colc==0) && (depc == 0))
				begin
					t_sramaddr1=0;
				end
			else
				begin
					t_sramaddr1 = Lsramaddr1 +1;
				end
		end
	else if((rowc[0] ==0) && (colc[0]==1))
		begin
			loadwho = 2'b10;

			if((rowc==0) && (colc==1) && (depc == 0) )
				begin
					t_sramaddr3=0;
				end
			else
				begin
					t_sramaddr3 = Lsramaddr3 +1;
				end
		end
	else if( (rowc[0] ==1) && (colc[0]==0) )
		begin
			loadwho = 2'b01;

			if((rowc==1) && (colc==0) && (depc == 0))
				begin
					t_sramaddr2=0;
				end
			else
				begin
					t_sramaddr2 = Lsramaddr2 +1;
				end
		end

	else 
		begin
			loadwho = 2'b11;

			if((rowc==1) && (colc==1)  && (depc == 0))
				begin
					t_sramaddr4=0;
				end
			else
				begin
					t_sramaddr4 = Lsramaddr4 +1;
				end
		end

	///////////////////////////////////////////
	loaddone1 =1;
end

///////////////////////////////////////////////////////////////////////////
always@(*)
begin
	loaddone2 =0;

	//////////////////////////////////
	if(colc == 3'b111)
		begin
			
			///////////////////////////////
			if(rowc == 3'b111)
				begin
					/////////////////////////
					if(depc == 5'b11111)
						begin
							//loaddone = 1;
							/////////////////////
							t_colc = colc;
							t_rowc = rowc;
							t_depc = depc;
							//////////////////////
						end
					else
						begin
							t_depc = depc +1;
							t_rowc =0;
							t_colc =0;		
						end
					/////////////////////////////
				end
			else
				begin
					///////////////////////////
					t_rowc = rowc +1;
					t_colc =0;
					/////////////////////////
					t_depc = depc;
				end
		end
	else
		begin
			/////////////////////
			t_colc = colc + 1;
			//////////////////////
			t_rowc = rowc;
			t_depc = depc;
			//////////////////////
		end
	////////////////////////////////////////////////////////

	loaddone2 =1;
end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////








///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             for display
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//131313
//242424
//131313
//242424
//131313
//242424
always@(*)
begin
	

	disposdone =0;

	if( (Orow[0]==0) && (Ocol[0]==0) )
		begin
			//13
			//24
			//
			//
			//////////////////
			pos1 = 16*mydep + 2* Orow + (Ocol >>1);	//pos1 = 16*mydep + 4* (Orow/2) + (Ocol/2);
			pos3 = 16*mydep + 2* Orow + (Ocol >>1); //pos3 = 16*mydep + 4* (Orow/2) + (Ocol/2);

			pos2 = 16*mydep + 2* Orow + (Ocol >>1);	//pos2 = 16*mydep + 4* (Orow/2) + (Ocol/2);			
			pos4 = 16*mydep + 2* Orow + (Ocol >>1);	//pos4 = 16*mydep + 4* (Orow/2) + (Ocol/2);	
			/////////////////////////////////
			//discon = 2'b00;


		end
	else if( (Orow[0]==0) && (Ocol[0]==1) )
	
		begin
			//row 4 col 3
			//31
			//42
			//
			pos1 = 16*mydep + 2* Orow + ((Ocol +1) >>1); //	 16*mydep + 4* Orow/2 + (Ocol +1)/2
			pos3 = 16*mydep + 2* Orow + ((Ocol -1) >>1); // 16*mydep + 4* Orow/2 + (Ocol -1)/2

			pos2 = 16*mydep + 2* Orow + ((Ocol +1) >>1); // 16*mydep + 4* Orow/2 + (Ocol +1)/2 
			pos4 = 16*mydep + 2* Orow + ((Ocol -1) >>1); //	 16*mydep + 4* Orow/2 + (Ocol -1)/2
			//////////////////////////////////////
			//discon = 2'b01;

		end
	else if((Orow[0]==1) && (Ocol[0]==0))
	
		begin
			//row =3, col =4
			//24
			//13
			//
			pos1 = 16*mydep + 2* (Orow+1) + (Ocol >>1);  //16*mydep + 4* (Orow +1)/2 + Ocol/2
			pos3 = 16*mydep + 2* (Orow+1) + (Ocol >>1);  //16*mydep + 4* (Orow +1)/2 + Ocol/2

			pos2 = 16*mydep + 2* (Orow -1) + (Ocol >>1); //16*mydep + 4 * (Orow-1)/2 + Ocol/2
			pos4 = 16*mydep + 2* (Orow -1) + (Ocol >>1); //16*mydep + 4 * (Orow-1)/2 + Ocol/2
			////////////////////////////////////
			//discon = 2'b10;
		end
	else
	
		begin
			//row =3 col =3
			//42
			//31
			//
			pos1 = 16*mydep + 2* (Orow +1) + ((Ocol +1) >> 1);//16*mydep +  4* (Orow +1)/2 + (Ocol +1)/2
			pos3 = 16*mydep + 2* (Orow +1) + ((Ocol -1) >> 1);//16*mydep +  4* (Orow +1)/2 + (Ocol -1)/2

			pos2 = 16*mydep + 2* (Orow -1) + ((Ocol +1) >> 1); //16*mydep + 4*(Orow -1)/2 + (Ocol +1)/2
			pos4 = 16*mydep + 2* (Orow -1) + ((Ocol -1) >> 1);  //16*mydep + 4*(Orow -1)/2 + (Ocol -1)/2
			//////////////////////////////////////
			//discon = 2'b11;
		end
	

	disposdone =1;
end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always@(*)
begin
	if((Orow[0]==0) && (Ocol[0]==0))
		begin
			discon = 2'b00;
		end
	else if( (Orow[0]==0) && (Ocol[0]==1) )
		begin
			discon = 2'b01;
		end
	else if((Orow[0]==1) && (Ocol[0]==0))
		begin
			discon = 2'b10;
		end
	else
		begin
			discon = 2'b11;
		end
end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               for reading input in 4 x 4
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////
//0	//131 31313
//1	//242 42424
//2	//131 31313
//3	//242 42424

//4	//131 31313
//5	//242 42424
//6 //131 31313
//7 //242 42424
////////////////////////////////////

always@(*)
begin
	readdone =0;




	///////////////////////////

	cpos1valid =1;
	cpos2valid =1;
	cpos3valid =1;
	cpos4valid =1;

	cpos1 = 0;
	cpos2 = 0;
	cpos3 = 0;
	cpos4 = 0;


	///////////////
	case(tdiscon)
		//13
		//24
		//row even , col even
		2'b00:
			begin
				case(block)
					2'b00:
						begin
							//
							//42
							//31
							////////////////////////////////////////////////////
							if( (tOcol == 3'b000)  && (tOrow == 3'b000) )
								begin
									//cpos1
									//cpos1valid
									cpos1valid =1;
									cpos2valid =0;
									cpos3valid =0;
									cpos4valid =0;

									cpos1 = 16*cdep + 2*tOrow + (tOcol >> 1);
									cpos2 =0;
									cpos3 =0;
									cpos4 =0;
									

								end
							else if ( (tOrow == 3'b000) )
								begin
									cpos1valid =1;
									cpos2valid =0;
									cpos3valid =1;
									cpos4valid =0;

									cpos1 = 16*cdep + 2*tOrow + (tOcol >> 1); 
									cpos2 =0;
									cpos3 = 16*cdep + 2*tOrow + (tOcol >>1) -1;
									cpos4 =0;

								end
							else if( (tOcol == 3'b000) )
								begin
									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =0;
									cpos4valid =0;

									cpos1 = 16*cdep + 2*tOrow + (tOcol >> 1); 
									cpos2 = 16*cdep + 2*(tOrow-2) + (tOcol >> 1);

									cpos3 =0;
									cpos4 =0;



								end
							else
								begin
									cpos1 = 16*cdep + 2*tOrow + (tOcol >> 1); //pos1 = 16*cdep + 4* (Orow/2) + Ocol/2
									cpos2 = 16*cdep + 2*(tOrow-2) + (tOcol >> 1); //pos2 = 16*cdep + 4* (Orow -2)/2  + (Ocol )/2
									cpos3 = 16*cdep + 2*tOrow + (tOcol >>1) -1;//pos3 = 16*cdep + 4* (Orow/2) + (Ocol-2)/2 
									cpos4 = 16*cdep + 2*(tOrow -2) + (tOcol >>1) -1;//pos4 = 16*cdep + 4* (Orow -2)/2  + (Ocol -2)/2

									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =1;
									cpos4valid =1;
								end
							


						end
					2'b01:
						begin
							//
							//
							//42
							//31

							//4242
							//3131

							//4242
							//3131

							if( (tOcol == 3'b110) && (tOrow == 3'b000))
								begin


									cpos1 =0;
									cpos2 =0;
									cpos3 = 16*cdep + 2*tOrow + (tOcol >>1);
									cpos4 =0;

									cpos1valid =0;
									cpos2valid =0;
									cpos3valid =1;
									cpos4valid =0;
								end
							else if((tOrow == 3'b000))
								begin


									cpos1 = 16*cdep + 2* tOrow + (tOcol >>1) +1;
									cpos2 = 0;
									cpos3 = 16*cdep + 2*tOrow + (tOcol >>1);
									cpos4 = 0;

									cpos1valid =1;
									cpos2valid =0;
									cpos3valid =1;
									cpos4valid =0;

								end
							else if((tOcol == 3'b110))
								begin


									
									cpos1 =0;
									cpos2 =0;

									cpos3 = 16*cdep + 2*tOrow + (tOcol >>1);
									cpos4 = 16*cdep + 2*(tOrow -2) + (tOcol >>1);


									cpos1valid =0;
									cpos2valid =0;
									cpos3valid =1;
									cpos4valid =1;

								end
							else
								begin
									cpos1 = 16*cdep + 2* tOrow + (tOcol >>1) +1;//pos1 = 16*cdep + 4* (Orow/2) + Ocol/2 + 1
									cpos2 = 16*cdep + 2*(tOrow -2) + (tOcol >>1) +1;//pos2 = 16*cdep + 4* (Orow -2)/2  + (Ocol )/2 +1
									cpos3 = 16*cdep + 2*tOrow + (tOcol >>1);//pos3 = 16*cdep + 4* (Orow/2) + (Ocol-2)/2  +1
									cpos4 = 16*cdep + 2*(tOrow -2) + (tOcol >>1);//pos4 = 16*cdep + 4* (Orow -2)/2  + (Ocol -2)/2 +1
									
									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =1;
									cpos4valid =1;
								end

						end
					2'b10:
						begin
							
							
							
							if( (tOcol == 3'b000)  && (tOrow == 3'b110) )
								begin


									cpos1 = 0;
									cpos2 = 16*cdep + 2*tOrow + (tOcol >> 1);
									cpos3 = 0;
									cpos4 = 0;

									cpos1valid =0;
									cpos2valid =1;
									cpos3valid =0;
									cpos4valid =0;


								end
							else if((tOrow == 3'b110))
								begin

									cpos1 =0;
									cpos2 = 16*cdep + 2*tOrow + (tOcol >> 1);
									cpos3 =0; 
									cpos4 = 16*cdep + 2*tOrow + (tOcol >> 1) -1;

									cpos1valid =0;
									cpos2valid =1;
									cpos3valid =0;
									cpos4valid =1;

								end
							
							else if ( (tOcol == 3'b000) )
								begin

									cpos1 = 16*cdep + 2*tOrow + 4 + (tOcol >> 1);
									cpos2 = 16*cdep + 2*tOrow + (tOcol >> 1);
									cpos3 =0;
									cpos4 =0;


									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =0;
									cpos4valid =0;

								end
							else
								begin

									cpos1 = 16*cdep + 2*tOrow + 4 + (tOcol >> 1); //pos1 = 16*cdep + 4* ((Orow/2 ) +1) + Ocol/2
									cpos2 = 16*cdep + 2*tOrow + (tOcol >> 1);    //pos2 = 16*cdep + 4* ((Orow -2 )/2 +1)  + (Ocol )/2
									cpos3 = 16*cdep + 2*tOrow + 3 + (tOcol >> 1);  //pos3 = 16*cdep + 4* ((Orow/2 )  +1) + (Ocol-2)/2 
									cpos4 = 16*cdep + 2*tOrow + (tOcol >> 1) -1;    //pos4 = 16*cdep + 4* ((Orow -2 )/2 +1)  + (Ocol -2)/2

									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =1;
									cpos4valid =1;

								end


						end
					default:
						begin

							if(  (tOrow == 3'b110) && (tOcol == 3'b110) )
								begin

									cpos1valid =0;
									cpos2valid =0;
									cpos3valid =0;
									cpos4valid =1;

									cpos1 =0;	
									cpos2 =0;
									cpos3 =0;
									cpos4 = 16*cdep + 2* tOrow + (tOcol >> 1);

								end
							else if( (tOrow == 3'b110) )
								begin
									cpos1valid =0;
									cpos2valid =1;
									cpos3valid =0;
									cpos4valid =1;

									cpos1 = 0;
									cpos2 = 16*cdep + 2* tOrow + (tOcol >> 1) +1;
									cpos3 = 0;
									cpos4 = 16*cdep + 2* tOrow + (tOcol >> 1);


								end
							else if ( (tOcol == 3'b110) )
								begin
									cpos1valid =0;
									cpos2valid =0;
									cpos3valid =1;
									cpos4valid =1;

									cpos1 = 0;
									cpos2 = 0;
									cpos3 = 16*cdep + 2* tOrow + (tOcol >> 1) +4;
									cpos4 = 16*cdep + 2* tOrow + (tOcol >> 1); 

								end
							else
								begin


									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =1;
									cpos4valid =1;


									cpos1 = 16*cdep + 2* tOrow + (tOcol >> 1) +5;//pos1 = 16*cdep + 4* ((Orow/2) +1) + Ocol/2 + 1
									cpos2 = 16*cdep + 2* tOrow + (tOcol >> 1) +1;//pos2 = 16*cdep + 4* ((Orow -2)/2  +1)  + (Ocol )/2 +1

									cpos3 = 16*cdep + 2* tOrow + (tOcol >> 1) +4;//pos3 = 16*cdep + 4* ((Orow/2) +1) + (Ocol-2)/2  +1
									cpos4 = 16*cdep + 2* tOrow + (tOcol >> 1);   //pos4 = 16*cdep + 4* ((Orow -2)/2 +1)  + (Ocol -2)/2 +1

								end


							
							
							
							


						end
				endcase
			end
		
		//0	//131 31313
		//1	//242 42424

		//2	//131 31313
		//3	//242 42424

		//4	//131 31313
		//5	//242 42424
		//6 //131 31313
		//7 //242 42424
		//////////////////////////////


		//31
		//42
		//row even , col odd
		2'b01:
			//
			//24
			//13
			//
			begin
				case(block)
					2'b00:
						begin

							if(tOrow == 3'b000)
								begin
									cpos1valid =1;
									cpos2valid =0;
									cpos3valid =1;
									cpos4valid =0;

									cpos1 = 16*cdep + 2* tOrow + ((tOcol -1) >>1);
									cpos2 = 0;
									cpos3 = 16*cdep + 2* tOrow + ((tOcol -1) >>1);
									cpos4 = 0;
								end
							else
								begin
									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =1;
									cpos4valid =1;

									cpos1 = 16*cdep + 2* tOrow + ((tOcol -1) >>1); //pos1 = 16*cdep + 4 * (Orow/2) + (Ocol -1)/2
									cpos2 = 16*cdep + 2* tOrow + ((tOcol -1) >>1) -4;   //pos2 = 16*cdep + 4* (Orow/2 -1) + (Ocol -1)/2
									cpos3 = 16*cdep + 2* tOrow + ((tOcol -1) >>1);   //pos3 = 16*cdep + 4 * (Orow/2) + (Ocol -1)/2
									cpos4 = 16*cdep + 2* tOrow + ((tOcol -1) >>1) -4;//pos4 = 16*cdep + 4* (Orow/2 -1) + (Ocol -1)/2
								end


						end
					2'b01:
						begin

							if(tOrow == 3'b000)
								begin
									cpos1valid =1;
									cpos2valid =0;
									cpos3valid =1;
									cpos4valid =0;

									cpos1 = 16*cdep + 2 * tOrow + ((tOcol -1) >>1) +1;
									cpos2 = 0;
									cpos3 = 16*cdep + 2 * tOrow + ((tOcol -1) >>1) +1;
									cpos4 = 0;

								end
							else
								begin

									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =1;
									cpos4valid =1;


									cpos1 = 16*cdep + 2 * tOrow + ((tOcol -1) >>1) +1; //pos1 = 16*cdep + 4 * (Orow/2) + (Ocol -1)/2 +1
									cpos2 = 16*cdep + 2 * tOrow + ((tOcol -1) >>1) -3;//pos2 = 16*cdep + 4* (Orow/2 -1) + (Ocol -1)/2 +1
									cpos3 = 16*cdep + 2 * tOrow + ((tOcol -1) >>1) +1;//pos3 = 16*cdep + 4 * (Orow/2) + (Ocol -1)/2 +1
									cpos4 = 16*cdep + 2 * tOrow + ((tOcol -1) >>1) -3;//pos4 = 16*cdep + 4* (Orow/2 -1) + (Ocol -1)/2 +1
								end
							
						end
					2'b10:
						begin

							if(tOrow == 3'b110)
								begin
									cpos1valid =0;
									cpos2valid =1;
									cpos3valid =0;
									cpos4valid =1;

									cpos1 = 0;
									cpos2 = 16*cdep + 2* tOrow + ((tOcol -1) >>1);
									cpos3 = 0;
									cpos4 = 16*cdep + 2* tOrow + ((tOcol -1) >>1);

								end
							else
								begin
									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =1;
									cpos4valid =1;

									cpos1 = 16*cdep + 2* tOrow + ((tOcol -1) >>1) +4;//pos1 = 16*cdep + 4 * ((Orow/2) +1) + (Ocol -1)/2
									cpos2 = 16*cdep + 2* tOrow + ((tOcol -1) >>1);//pos2 = 16*cdep + 4* ((Orow/2 -1) +1) + (Ocol -1)/2
									cpos3 = 16*cdep + 2* tOrow + ((tOcol -1) >>1) +4;//pos3 = 16*cdep + 4 * ((Orow/2) +1) + (Ocol -1)/2
									cpos4 = 16*cdep + 2* tOrow + ((tOcol -1) >>1);//pos4 = 16*cdep + 4* ((Orow/2 -1) +1) + (Ocol -1)/2
								end		
						end
					default:
						begin


							if(tOrow == 3'b110)
								begin
									cpos1valid =0;
									cpos2valid =1;
									cpos3valid =0;
									cpos4valid =1;

									cpos1 = 0;
									cpos2 = 16*cdep + 2 * tOrow + ((tOcol -1) >>1) +1;
									cpos3 = 0;
									cpos4 = 16*cdep + 2 * tOrow + ((tOcol -1) >>1) +1;

								end
							else
								begin

									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =1;
									cpos4valid =1;

									cpos1 = 16*cdep + 2 * tOrow + ((tOcol -1) >>1) +5;//pos1 = 16*cdep + 4 * ((Orow/2) +1) + (Ocol -1)/2 +1
									cpos2 = 16*cdep + 2 * tOrow + ((tOcol -1) >>1) +1;//pos2 = 16*cdep + 4* ((Orow/2 -1) +1) + (Ocol -1)/2 +1
									cpos3 = 16*cdep + 2 * tOrow + ((tOcol -1) >>1) +5;//pos3 = 16*cdep + 4 * ((Orow/2) +1) + (Ocol -1)/2 +1
									cpos4 = 16*cdep + 2 * tOrow + ((tOcol -1) >>1) +1;//pos4 = 16*cdep + 4* ((Orow/2 -1) +1) + (Ocol -1)/2 +1

								end
							
						end
				endcase
			end
		//0	//131 31313
		//1	//242 42424

		//2	//131 31313
		//3	//242 42424

		//4	//131 31313
		//5	//242 42424
		//6 //131 31313
		//7 //242 42424
		//////////////////////////////
		//row odd, col even	

		//24
		//13
		2'b10:
			//31
			//42
			begin
				case(block)
					2'b00:
						begin

							if(tOcol == 3'b000)
								begin
									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =0;
									cpos4valid =0;

									cpos1 = 16*cdep + 2 * (tOrow -1) + (tOcol >>1);
									cpos2 = 16*cdep + 2 * (tOrow -1) + (tOcol >>1);
									cpos3 = 0;
									cpos4 = 0;

								end
							else
								begin
									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =1;
									cpos4valid =1;

									cpos1 = 16*cdep + 2 * (tOrow -1) + (tOcol >>1);//pos1 = 16*cdep + 4*( (Orow -1)/2   ) + (Ocol)/2
									cpos2 = 16*cdep + 2 * (tOrow -1) + (tOcol >>1);//pos2 = 16*cdep + 4*( (Orow -1)/2    ) +(Ocol)/2
									cpos3 = 16*cdep + 2 * (tOrow -1) + (tOcol >>1) -1;//pos3 = 16*cdep + 4*( (Orow -1)/2  ) + (Ocol -2)/2
									cpos4 = 16*cdep + 2 * (tOrow -1) + (tOcol >>1) -1;//pos4 = 16*cdep + 4*(  (Orow -1)/2   ) +(Ocol -2)/2

								end
							//
						end
					2'b01:
						begin

							if( (tOcol == 3'b110))
								begin
									cpos1valid =0;
									cpos2valid =0;
									cpos3valid =1;
									cpos4valid =1;

									cpos1 = 0;
									cpos2 = 0;
									cpos3 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1);
									cpos4 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1);

								end
							else
								begin
									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =1;
									cpos4valid =1;

									cpos1 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +1;//pos1 = 16*cdep + 4*( (Orow -1)/2   ) + (Ocol)/2 +1
									cpos2 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +1;//pos2 = 16*cdep + 4*( (Orow -1)/2    ) +(Ocol)/2 +1
									cpos3 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1);//pos3 = 16*cdep + 4*( (Orow -1)/2  ) + (Ocol -2)/2 +1
									cpos4 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1);//pos4 = 16*cdep + 4*(  (Orow -1)/2   ) +(Ocol -2)/2 +1

								end
							

						end
					2'b10:
						begin

							if((tOcol == 3'b000))
								begin
									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =0;
									cpos4valid =0;

									cpos1 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +4;
									cpos2 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +4;

									cpos3 =0;
									cpos4 =0;
								end
							else
								begin

									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =1;
									cpos4valid =1;

									cpos1 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +4;//pos1 = 16*cdep + 4*( (Orow -1)/2  +1 ) + (Ocol)/2
									cpos2 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +4;//pos2 = 16*cdep + 4*( (Orow -1)/2  +1  ) +(Ocol)/2
									cpos3 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +3;//pos3 = 16*cdep + 4*( (Orow -1)/2  +1) + (Ocol -2)/2
									cpos4 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +3;//pos4 = 16*cdep + 4*(  (Orow -1)/2  +1 ) +(Ocol -2)/2
								end

						end
					default:
						begin

							if( (tOcol == 3'b110) )
								begin

									cpos1valid =0;
									cpos2valid =0;
									cpos3valid =1;
									cpos4valid =1;

									cpos1 = 0;
									cpos2 = 0;
									cpos3 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +4;
									cpos4 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +4;


								end
							else
								begin

									cpos1valid =1;
									cpos2valid =1;
									cpos3valid =1;
									cpos4valid =1;

									cpos1 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +5;//pos1 = 16*cdep + 4*( (Orow -1)/2  +1 ) + (Ocol)/2 +1
									cpos2 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +5;//pos2 = 16*cdep + 4*( (Orow -1)/2  +1  ) +(Ocol)/2 +1
									cpos3 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +4;//pos3 = 16*cdep + 4*( (Orow -1)/2  +1) + (Ocol -2)/2 +1
									cpos4 = 16*cdep + 2 *(tOrow -1) + (tOcol >>1) +4;//pos4 = 16*cdep + 4*(  (Orow -1)/2  +1 ) +(Ocol -2)/2 +1

								end

							
						end
				endcase
			end
		

		//0	//131 31313
		//1	//242 42424

		//2	//131 31313
		//3	//242 42424

		//4	//131 31313
		//5	//242 42424
		//6 //131 31313
		//7 //242 42424
		////////////////////
		//42
		//31

		//row odd, col odd
		default://2'b11
			begin
				//13
				//24
				case(block)
					2'b00:
						begin

							cpos1valid =1;
							cpos2valid =1;
							cpos3valid =1;
							cpos4valid =1;


							cpos1 = 16*cdep + 2* (tOrow -1) + ((tOcol -1) >>1);//pos1 = 16*cdep + 4* ( (Orow-1)/2 ) + (Ocol -1)/2
							cpos2 = 16*cdep + 2* (tOrow -1) + ((tOcol -1) >>1);//pos2 = 16*cdep + 4* ( (Orow-1)/2 ) + (Ocol -1)/2
							cpos3 = 16*cdep + 2* (tOrow -1) + ((tOcol -1) >>1);//pos3 = 16*cdep + 4* ( (Orow-1)/2 ) + (Ocol -1)/2
							cpos4 = 16*cdep + 2* (tOrow -1) + ((tOcol -1) >>1);//pos4 = 16*cdep + 4* ( (Orow-1)/2 ) + (Ocol -1)/2

						end
					2'b01:
						begin

							cpos1valid =1;
							cpos2valid =1;
							cpos3valid =1;
							cpos4valid =1;

							cpos1 = 16*cdep + 2 *(tOrow -1) + ((tOcol -1) >>1) +1;//pos1 = 16*cdep + 4* ( (Orow-1)/2 ) + (Ocol -1)/2 +1
							cpos2 = 16*cdep + 2 *(tOrow -1) + ((tOcol -1) >>1) +1;//pos2 = 16*cdep + 4* ( (Orow-1)/2 ) + (Ocol -1)/2 +1
							cpos3 = 16*cdep + 2 *(tOrow -1) + ((tOcol -1) >>1) +1;//pos3 = 16*cdep + 4* ( (Orow-1)/2 ) + (Ocol -1)/2 +1
							cpos4 = 16*cdep + 2 *(tOrow -1) + ((tOcol -1) >>1) +1;//pos4 = 16*cdep + 4* ( (Orow-1)/2 ) + (Ocol -1)/2 +1
							

						end
					2'b10:
						begin

							cpos1valid =1;
							cpos2valid =1;
							cpos3valid =1;
							cpos4valid =1;

							cpos1 = 16*cdep + 2 *(tOrow -1) + ((tOcol -1) >>1) +4;//pos1 = 16*cdep + 4* ( (Orow-1)/2 +1) + (Ocol -1)/2
							cpos2 = 16*cdep + 2 *(tOrow -1) + ((tOcol -1) >>1) +4;//pos2 = 16*cdep + 4* ( (Orow-1)/2 +1) + (Ocol -1)/2
							cpos3 = 16*cdep + 2 *(tOrow -1) + ((tOcol -1) >>1) +4;//pos3 = 16*cdep + 4* ( (Orow-1)/2 +1) + (Ocol -1)/2
							cpos4 = 16*cdep + 2 *(tOrow -1) + ((tOcol -1) >>1) +4;//pos4 = 16*cdep + 4* ( (Orow-1)/2 +1) + (Ocol -1)/2

						end
					default:
						begin
							cpos1valid =1;
							cpos2valid =1;
							cpos3valid =1;
							cpos4valid =1;

							cpos1 = 16*cdep + 2*(tOrow -1) + ((tOcol -1) >>1) +5;//pos1 = 16*cdep + 4* ( (Orow-1)/2 +1) + (Ocol -1)/2 +1
							cpos2 = 16*cdep + 2*(tOrow -1) + ((tOcol -1) >>1) +5;//pos2 = 16*cdep + 4* ( (Orow-1)/2 +1) + (Ocol -1)/2 +1
							cpos3 = 16*cdep + 2*(tOrow -1) + ((tOcol -1) >>1) +5;//pos3 = 16*cdep + 4* ( (Orow-1)/2 +1) + (Ocol -1)/2 +1
							cpos4 = 16*cdep + 2*(tOrow -1) + ((tOcol -1) >>1) +5;//pos4 = 16*cdep + 4* ( (Orow-1)/2 +1) + (Ocol -1)/2 +1

						end
				endcase

			end
	endcase

	/////////////////////////
	readdone =1;

end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                           Convolution
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
//0	//131 31313
//1	//242 42424
//2	//131 31313
//3	//242 42424

//4	//131 31313
//5	//242 42424
//6 //131 31313
//7 //242 42424
/////////////////////////////

//kernel
//1/16  1/8  1/16  
//1/8   1/4  1/8
//1/16  1/8  1/16
//

/*
//version 1
always@(*)
begin
	convdone =0;

	tlu = dataLU << 4;
	tru = dataRU << 4;
	tld = dataLD << 4;
	trd = dataRD << 4;

	case(block)
		2'b00:
			begin
				ctemp1 = (tlu >> 4) + (tru >> 3) + (tld >>3) + (trd >> 2);
				ctemp2 = (tru >> 4) + (trd >> 3);
				ctemp3 = (tld >> 4) + (trd >> 3);
				ctemp4 = (trd >> 4);
			end
		2'b01:
			begin
				ctemp1 = (tlu >> 4) + (tld >> 3);
				ctemp2 = (tlu >> 3) + (tru >> 4) + (tld >> 2) + (trd >> 3);
				ctemp3 = (tld >> 4);
				ctemp4 = (tld >> 3) + (trd >> 4);

			end
		2'b10:
			begin
				ctemp1 = (tlu >> 4) + (tru >> 3);
				ctemp2 = (tru >> 4);
				ctemp3 = (tlu >> 3) + (tru >> 2) + (tld >> 4) + (trd >> 3);
				ctemp4 = (tru >> 3) + (trd >> 4);
			end
		2'b11:
			begin
				ctemp1 = (tlu >> 4);
				ctemp2 = (tlu >> 3) + (tru >> 4);
				ctemp3 = (tlu >> 3) + (tld >> 4);
				ctemp4 = (tlu >> 2) + (tru >> 3) + (tld >> 3) + (trd >> 4);
			end
	endcase
	convdone =1;
end
/////////////////////////////////////////////////////////////////////////////////
*/



always@(*)
begin
//rightmost is 1/16	
convdone1 =0;
ctemp1 = (Conv1[0]) + (Conv1[1] << 1) + (Conv1[2]) + (Conv1[3] << 1) + (Conv1[4] << 2) + (Conv1[5] << 1) + (Conv1[6]) + (Conv1[7] << 1) + (Conv1[8]);

//$display("conv0: %b", Conv1[0]); 
//$display("conv1: %b", Conv1[1]); 
//$display("conv2: %b", Conv1[2]); 
//$display("conv3: %b", Conv1[3]); 
//$display("conv4: %b", Conv1[4]); 
//$display("conv5: %b", Conv1[5]); 
//$display("conv6: %b", Conv1[6]); 
//$display("conv7: %b", Conv1[7]); 
//$display("conv8: %b", Conv1[8]); 

//$display("ctemp1: %b", ctemp1); 

convdone1 =1;
end

always@(*)
begin
//rightmost is 1/16	
convdone2 =0;
ctemp2 = (Conv2[0]) + (Conv2[1] << 1) + (Conv2[2]) + (Conv2[3] << 1) + (Conv2[4] << 2) + (Conv2[5] << 1) + (Conv2[6]) + (Conv2[7] << 1) + (Conv2[8]);

convdone2 =1;
end

always@(*)
begin
//rightmost is 1/16	

convdone3 =0;
ctemp3 = (Conv3[0]) + (Conv3[1] << 1) + (Conv3[2]) + (Conv3[3] << 1) + (Conv3[4] << 2) + (Conv3[5] << 1) + (Conv3[6]) + (Conv3[7] << 1) + (Conv3[8]);

convdone3 =1;
end

always@(*)
begin
//rightmost is 1/16	
convdone4 =0;
ctemp4 = (Conv4[0]) + (Conv4[1] << 1) + (Conv4[2]) + (Conv4[3] << 1) + (Conv4[4] << 2) + (Conv4[5] << 1) + (Conv4[6]) + (Conv4[7] << 1) + (Conv4[8]);
convdone4 =1;
end


/////////////////////////////////////////////////////////////////////////////////
//for rounding
always@(*)
begin

	adjdone =0;
	/////////////////////////
	if(t0[3] ==1)
		begin
			g0 = t0 + 18'b000000000000001000;
		end
	else
		begin
			g0 = t0;
		end
	cANS1 = g0[17:4];

	///////////////////////////////////////
	if(t1[3] ==1)
		begin
			g1 = t1 + 18'b000000000000001000;
		end
	else
		begin
			g1 = t1;
		end
	cANS2 = g1[17:4];
	//////////////////////////////////////////
	if(t2[3] ==1)
		begin
			g2 = t2 + 18'b000000000000001000;
		end
	else
		begin
			g2 = t2;
		end
	cANS3 = g2[17:4];
	////////////////////////////////////////
	if(t3[3] ==1)
		begin
			g3 = t3 + 18'b000000000000001000;
		end
	else
		begin
			g3 = t3;
		end
	cANS4 = g3[17:4];
	///////////////////////////////////////////
	adjdone =1;
end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////







//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                   Medain Filter
//////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
always@(*)
begin

	mdone1 =0;

	tsort1[0] = sorted1[0];
	tsort1[1] = sorted1[1];
	tsort1[2] = sorted1[2];
	tsort1[3] = sorted1[3];
	tsort1[4] = sorted1[4];
	tsort1[5] = sorted1[5];
	tsort1[6] = sorted1[6];
	tsort1[7] = sorted1[7];
	tsort1[8] = sorted1[8];

	mt1 =0;

	for (i1 = 0; i1 < 9; i1 = i1 + 1) 
		begin
            for (j1 = 0; j1 < 8 - i1; j1 = j1 + 1)
				begin
                	if (tsort1[j1] > tsort1[j1 + 1]) 
						begin
                    		mt1 = tsort1[j1];
                    		tsort1[j1] = tsort1[j1 + 1];
                    		tsort1[j1 + 1] = mt1;
                		end

            	end
    	end

    median1 = {6'b000000 ,tsort1[4]};

	mdone1 =1;
end
/////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////
always@(*)
begin

	mdone2 =0;

	tsort2[0] = sorted2[0];
	tsort2[1] = sorted2[1];
	tsort2[2] = sorted2[2];
	tsort2[3] = sorted2[3];
	tsort2[4] = sorted2[4];
	tsort2[5] = sorted2[5];
	tsort2[6] = sorted2[6];
	tsort2[7] = sorted2[7];
	tsort2[8] = sorted2[8];

	mt2 =0;

	for (i2 = 0; i2 < 9; i2 = i2 + 1) 
		begin
            for (j2 = 0; j2 < 8 - i2; j2 = j2 + 1)
				begin
                	if (tsort2[j2] > tsort2[j2 + 1]) 
						begin
                    		mt2 = tsort2[j2];
                    		tsort2[j2] = tsort2[j2 + 1];
                    		tsort2[j2 + 1] = mt2;
                		end

            	end
    	end

    median2 = {6'b000000 ,tsort2[4]};

	mdone2 =1;
end
/////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
always@(*)
begin

	mdone3 =0;

	tsort3[0] = sorted3[0];
	tsort3[1] = sorted3[1];
	tsort3[2] = sorted3[2];
	tsort3[3] = sorted3[3];
	tsort3[4] = sorted3[4];
	tsort3[5] = sorted3[5];
	tsort3[6] = sorted3[6];
	tsort3[7] = sorted3[7];
	tsort3[8] = sorted3[8];

	mt3 =0;

	for (i3 = 0; i3 < 9; i3 = i3 + 1) 
		begin
            for (j3 = 0; j3 < 8 - i3; j3 = j3 + 1)
				begin
                	if (tsort3[j3] > tsort3[j3 + 1]) 
						begin
                    		mt3 = tsort3[j3];
                    		tsort3[j3] = tsort3[j3 + 1];
                    		tsort3[j3 + 1] = mt3;
                		end

            	end
    	end

    median3 = {6'b000000 ,tsort3[4]};

	mdone3 =1;
end
/////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////
always@(*)
begin

	mdone4 =0;

	tsort4[0] = sorted4[0];
	tsort4[1] = sorted4[1];
	tsort4[2] = sorted4[2];
	tsort4[3] = sorted4[3];
	tsort4[4] = sorted4[4];
	tsort4[5] = sorted4[5];
	tsort4[6] = sorted4[6];
	tsort4[7] = sorted4[7];
	tsort4[8] = sorted4[8];

	mt4 =0;

	for (i4 = 0; i4 < 9; i4 = i4 + 1) 
		begin
            for (j4 = 0; j4 < 8 - i4; j4 = j4 + 1)
				begin
                	if (tsort4[j4] > tsort4[j4 + 1]) 
						begin
                    		mt4 = tsort4[j4];
                    		tsort4[j4] = tsort4[j4 + 1];
                    		tsort4[j4 + 1] = mt4;
                		end

            	end
    	end

    median4 = {6'b000000 ,tsort4[4]};

	mdone4 =1;
end
/////////////////////////////////////////////////////////////////////











////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                       Sobel NMS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always@(*)
begin

	sdone1 =0;
	/////////////////////////////////

	GX1 = -(NMS1[0]) + (NMS1[2]) - 2*(NMS1[3])+ 2* (NMS1[5]) - (NMS1[6])  + (NMS1[8]);//+ (NMS1[1])+ (NMS1[4])+ (NMS1[7])
	GY1 = - (NMS1[0]) -2 * (NMS1[1]) - (NMS1[2])  + (NMS1[6]) + 2* (NMS1[7]) + (NMS1[8]);//+ (NMS1[3]) + (NMS1[4]) + (NMS1[5])

	if(GX1 <0)
		begin
			AGX1 = -GX1;//~GX1 + 1'b1;
			negx1 = 1;
		end
	else
		begin
			AGX1 = GX1;
			negx1 = 0;
		end

	if(GY1 <0)
		begin
			AGY1 = -GY1;
			negy1 = 1;
		end
	else
		begin
			AGY1 = GY1;
			negy1 = 0;
		end

	GG1 = AGX1 + AGY1;
	/////////////////////////////////////////////////////
	
	T11 = (AGX1 << 7);
	T12 = (AGY1 << 7);
	Q11 = (T11 >> 2) + (T11 >> 3) + (T11 >>5) + (T11 >> 7);
	Q12 = Q11 + (T11 << 1);
	//////////////////////////////////////

	if((T12 <= Q12) && (T12 >= Q11))
		begin
			if( (negx1 ^ negy1) ==1)
				begin
					DK1 =2'b11;
				end
			else
				begin
					DK1 = 2'b01;
				end
		end
	else if(T12 < Q11)
		begin
			DK1 = 2'b00;
		end
	else
		begin
			DK1 = 2'b10;
		end

	////////////////////////////////////
	sdone1 =1;
end
///////////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always@(*)
begin
	sdone2 =0;
	//////////////////////////////
	GX2 = -(NMS2[0]) + (NMS2[2]) - 2*(NMS2[3])+ 2* (NMS2[5]) - (NMS2[6])  + (NMS2[8]);//+ (NMS1[1])+ (NMS1[4])+ (NMS1[7])
	GY2 = - (NMS2[0]) -2 * (NMS2[1]) - (NMS2[2])  + (NMS2[6]) + 2* (NMS2[7]) + (NMS2[8]);//+ (NMS1[3]) + (NMS1[4]) + (NMS1[5])

	if(GX2 <0)
		begin
			AGX2 = -GX2;//~GX1 + 1'b1;
			negx2 = 1;
		end
	else
		begin
			AGX2 = GX2;
			negx2 = 0;
		end

	if(GY2 <0)
		begin
			AGY2 = -GY2;
			negy2 = 1;
		end
	else
		begin
			AGY2 = GY2;
			negy2 = 0;
		end

	GG2 = AGX2 + AGY2;
	/////////////////////////////////////////////////////
	
	T21 = (AGX2 << 7);
	T22 = (AGY2 << 7);
	Q21 = (T21 >> 2) + (T21 >> 3) + (T21 >>5) + (T21 >> 7);
	Q22 = Q21 + (T21 << 1);
	//////////////////////////////////////

	if((T22 <= Q22) && (T22 >= Q21))
		begin
			if( (negx2 ^ negy2) ==1)
				begin
					DK2 =2'b11;
				end
			else
				begin
					DK2 = 2'b01;
				end
		end
	else if(T22 < Q21)
		begin
			DK2 = 2'b00;
		end
	else
		begin
			DK2 = 2'b10;
		end
	///////////////////////////
	sdone2 =1;
end
///////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always@(*)
begin
	sdone3 =0;
	/////////////////////////
	GX3 = -(NMS3[0]) + (NMS3[2]) - 2*(NMS3[3])+ 2* (NMS3[5]) - (NMS3[6])  + (NMS3[8]);//+ (NMS1[1])+ (NMS1[4])+ (NMS1[7])
	GY3 = - (NMS3[0]) -2 * (NMS3[1]) - (NMS3[2])  + (NMS3[6]) + 2* (NMS3[7]) + (NMS3[8]);//+ (NMS1[3]) + (NMS1[4]) + (NMS1[5])

	if(GX3 <0)
		begin
			AGX3 = -GX3;//~GX1 + 1'b1;
			negx3 = 1;
		end
	else
		begin
			AGX3 = GX3;
			negx3 = 0;
		end

	if(GY3 <0)
		begin
			AGY3 = -GY3;
			negy3 = 1;
		end
	else
		begin
			AGY3 = GY3;
			negy3 = 0;
		end

	GG3 = AGX3 + AGY3;
	/////////////////////////////////////////////////////
	
	T31 = (AGX3 << 7);
	T32 = (AGY3 << 7);
	Q31 = (T31 >> 2) + (T31 >> 3) + (T31 >>5) + (T31 >> 7);
	Q32 = Q31 + (T31 << 1);
	//////////////////////////////////////

	if((T32 <= Q32) && (T32 >= Q31))
		begin
			if( (negx3 ^ negy3) ==1)
				begin
					DK3 =2'b11;
				end
			else
				begin
					DK3 = 2'b01;
				end
		end
	else if(T32 < Q31)
		begin
			DK3 = 2'b00;
		end
	else
		begin
			DK3 = 2'b10;
		end
	///////////////////////////
	sdone3 =1;
end
///////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always@(*)
begin
	sdone4 =0;
	///////////////////////////////
	GX4 = -(NMS4[0]) + (NMS4[2]) - 2*(NMS4[3])+ 2* (NMS4[5]) - (NMS4[6])  + (NMS4[8]);//+ (NMS1[1])+ (NMS1[4])+ (NMS1[7])
	GY4 = - (NMS4[0]) -2 * (NMS4[1]) - (NMS4[2])  + (NMS4[6]) + 2* (NMS4[7]) + (NMS4[8]);//+ (NMS1[3]) + (NMS1[4]) + (NMS1[5])

	if(GX4 <0)
		begin
			AGX4 = -GX4;//~GX1 + 1'b1;
			negx4 = 1;
		end
	else
		begin
			AGX4 = GX4;
			negx4 = 0;
		end

	if(GY4 <0)
		begin
			AGY4 = -GY4;
			negy4 = 1;
		end
	else
		begin
			AGY4 = GY4;
			negy4 = 0;
		end

	GG4 = AGX4 + AGY4;
	/////////////////////////////////////////////////////
	
	T41 = (AGX4 << 7);
	T42 = (AGY4 << 7);
	Q41 = (T41 >> 2) + (T41 >> 3) + (T41 >>5) + (T41 >> 7);
	Q42 = Q41 + (T41 << 1);
	//////////////////////////////////////

	if((T42 <= Q42) && (T42 >= Q41))
		begin
			if( (negx4 ^ negy4) ==1)
				begin
					DK4 =2'b11;
				end
			else
				begin
					DK4 = 2'b01;
				end
		end
	else if(T42 < Q41)
		begin
			DK4 = 2'b00;
		end
	else
		begin
			DK4 = 2'b10;
		end

	////////////////////////////////
	sdone4 =1;
end
///////////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////
always@(*)
begin

	tGdone =0;
	//////////////////////////////

	nans1 =0;
	nans2 =0;
	nans3 =0;
	nans4 =0;

	case(tdk1)
		2'b00://0
			begin
				if( (tGG1 >= tGG2))
					begin
						nans1 = tGG1[13:0] ;
					end
				else
					begin
						nans1 =0;
					end
			end
		2'b01://45
			begin
				if( (tGG1 >= tGG4 ))
					begin
						nans1 = tGG1[13:0];
					end
				else
					begin
						nans1 = 0;
					end
			end
		2'b10://90
			begin
				if( (tGG1 >= tGG3))
					begin
						nans1 = tGG1[13:0];
					end
				else
					begin
						nans1 =0;
					end
			end
		default://135
			begin
				nans1 = tGG1[13:0];
			end
	endcase

	////////////////////////////////////////////////////
	case(tdk2)
		2'b00://0
			begin
				if(tGG2 >= tGG1)
					begin
						nans2 = tGG2[13:0];
					end
				else
					begin
						nans2 =0;
					end
			end
		2'b01://45
			begin
				nans2 = tGG2[13:0];
			end
		2'b10://90
			begin
				if((tGG2 >= tGG4))
					begin
						nans2 = tGG2[13:0];
					end
				else
					begin
						nans2 =0;
					end
			end
		default://135
			begin
				if((tGG2 >= tGG3))
					begin
						nans2 = tGG2[13:0];
					end
				else
					begin
						nans2 =0;
					end

			end
	endcase
	////////////////////////////////////////////////////////////////////////

	case(tdk3)
		2'b00://0
			begin
				if(tGG3 >= tGG4)
					begin
						nans3 = tGG3[13:0];
					end
				else
					begin
						nans3 = 0;
					end
			end
		2'b01://45
			begin
				nans3 = tGG3[13:0];
			end
		2'b10://90
			begin
				if(tGG3 >=tGG1)
					begin
						nans3 = tGG3[13:0];
					end
				else
					begin
						nans3 =0;
					end
			end
		default://135
			begin
				if(tGG3 >=tGG2)
					begin
						nans3 = tGG3[13:0];
					end
				else
					begin
						nans3 =0;
					end
			end
	endcase

	//////////////////////////////////////////////////////////////

	case(tdk4)
		2'b00:
			begin//0
				if(tGG4 >= tGG3)
					begin
						nans4 = tGG4[13:0];
					end
				else
					begin
						nans4 =0;
					end
			end
		2'b01:
			begin//45
				if(tGG4 >= tGG1)
					begin
						nans4 = tGG4[13:0];
					end
				else
					begin
						nans4 =0;
					end
			end
		2'b10:
			begin//90
				if(tGG4 >= tGG2)
					begin
						nans4 = tGG4[13:0];
					end
				else
					begin
						nans4 =0;
					end
			end
		default:
			begin//135
				nans4 = tGG4[13:0];
			end
	endcase

	////////////////////////////
	tGdone =1;

end	
//////////////////////////////////////////////////////////////////////////////
////










//sram_512x8 sram1(.Q(sramout1),.CLK(i_clk),.CEN(enable1),.WEN(writable1),.A(sramaddr1),.D(sramin1));
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ---------------------------------------------------------------------------
// Sequential Block
// ---------------------------------------------------------------------------
// ---- Write your sequential block design here ---- //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always@(negedge i_rst_n or posedge i_clk)
begin
	if(!i_rst_n)
		begin
			

			imgcount <=0;
			
			/////////////////////////////////////////
			next_state <= ReadyState;
			//////////////////////////////////////////
			//For chip loading
			enable1 <=0;
			writable1 <=1;
			sramaddr1 <=0;
			sramin1 <=0;
			//sramout1 <=0;

			enable2 <=0;
			writable2 <=1;
			sramaddr2 <=0;
			sramin2 <=0;
			//sramout2 <=0;

			enable3 <=0;
			writable3 <=1;
			sramaddr3 <=0;
			sramin3 <=0;
			//sramout3 <=0;

			enable4 <=0;
			writable4 <=1;
			sramaddr4 <=0;
			sramin4 <=0;
			//sramout4 <=0;
			/////////////////
			/////////////////
			
			/////////////////////////////////////////////


			////////////////////////////////////////////
			//for loading
			Lsramaddr1 <=0;
			Lsramaddr2 <=0;
			Lsramaddr3 <=0;
			Lsramaddr4 <=0;

			depc <= 0;
			rowc <= 0;
			colc <= 0;
			//////////////////////////////////////////////



			///////////////////////////////////////////////
			//for display region
			maxdep <= 5'b11111;
			Ocol <=0;
			Orow <=0;
			mydep <=0;
			////////////////////////////////////////////////


			/////////////////////////////////////////////////
			//for output input
			t_o_op_ready <= 0;
			t_i_op_mode <=0;

			t_o_in_ready<=0;

			t_o_out_valid <=0;
			t_o_out_data<=0;
			////////////////////////////////////////////////


			/////////////////////////////////////////////////
			//for read data
			cdep <= 0;
			block <=0;

			m0 <=0;
			m1 <=0;
			m2 <=0;
			m3 <=0;
			m4 <=0;
			m5 <=0;
			m6 <=0;
			m7 <=0;
			m8 <=0;
			m9 <=0;
			m10 <=0;
			m11 <=0;
			m12 <=0;
			m13 <=0;
			m14 <=0;
			m15 <=0;

			tOrow <=0;
			tOcol <=0;
			tdiscon <=0;
			///////////////////////////////////////////////////


			/////////////////////////////////////////////////
			//convolution
			myacc[0] <=0;
			myacc[1] <=0;
			myacc[2] <=0;
			myacc[3] <=0;
			
			//dataLU <=0;
			//dataRU <=0;
			//dataLD <=0;
			//dataRD <=0;

			t0 <=0;
			t1 <=0;
			t2 <=0;
			t3 <=0;

			Conv1[0] <= 0;
        	Conv1[1] <= 0;
        	Conv1[2] <= 0;
        	Conv1[3] <= 0;
        	Conv1[4] <= 0;
        	Conv1[5] <= 0;
        	Conv1[6] <= 0;
        	Conv1[7] <= 0;
        	Conv1[8] <= 0;
			/////////////////////////////////////////////////////////

			Conv2[0] <= 0;
        	Conv2[1] <= 0;
        	Conv2[2] <= 0;
        	Conv2[3] <= 0;
        	Conv2[4] <= 0;
        	Conv2[5] <= 0;
        	Conv2[6] <= 0;
        	Conv2[7] <= 0;
        	Conv2[8] <= 0;
			////////////////////////////////////////////////////////////

			Conv3[0] <= 0;
        	Conv3[1] <= 0;
        	Conv3[2] <= 0;
        	Conv3[3] <= 0;
        	Conv3[4] <= 0;
        	Conv3[5] <= 0;
        	Conv3[6] <= 0;
        	Conv3[7] <= 0;
        	Conv3[8] <= 0;

			/////////////////////////////////////////////////////////////////

			Conv4[0] <= 0;
        	Conv4[1] <= 0;
        	Conv4[2] <= 0;
        	Conv4[3] <= 0;
        	Conv4[4] <= 0;
        	Conv4[5] <= 0;
        	Conv4[6] <= 0;
        	Conv4[7] <= 0;
        	Conv4[8] <= 0;
			///////////////////////////////////////////////////////////////////////


			///////////////////////////////////////////////




			////////////////////////////////////////////////////
			//median filter
			sorted1[0] <= 0;
        	sorted1[1] <= 0;
        	sorted1[2] <= 0;
        	sorted1[3] <= 0;
        	sorted1[4] <= 0;
        	sorted1[5] <= 0;
        	sorted1[6] <= 0;
        	sorted1[7] <= 0;
        	sorted1[8] <= 0;
			//

			sorted2[0] <= 0;
        	sorted2[1] <= 0;
        	sorted2[2] <= 0;
        	sorted2[3] <= 0;
        	sorted2[4] <= 0;
        	sorted2[5] <= 0;
        	sorted2[6] <= 0;
        	sorted2[7] <= 0;
        	sorted2[8] <= 0;
			//
			sorted3[0] <= 0;
        	sorted3[1] <= 0;
        	sorted3[2] <= 0;
        	sorted3[3] <= 0;
        	sorted3[4] <= 0;
        	sorted3[5] <= 0;
        	sorted3[6] <= 0;
        	sorted3[7] <= 0;
        	sorted3[8] <= 0;

			//
			sorted4[0] <= 0;
        	sorted4[1] <= 0;
        	sorted4[2] <= 0;
        	sorted4[3] <= 0;
        	sorted4[4] <= 0;
        	sorted4[5] <= 0;
        	sorted4[6] <= 0;
        	sorted4[7] <= 0;
        	sorted4[8] <= 0;
			/////////////////////////////////////////////////////




			/////////////////////////////////////////////////////
			//sobel filter
			NMS1[0] <= 0;
        	NMS1[1] <= 0;
        	NMS1[2] <= 0;
        	NMS1[3] <= 0;
        	NMS1[4] <= 0;
        	NMS1[5] <= 0;
        	NMS1[6] <= 0;
        	NMS1[7] <= 0;
        	NMS1[8] <= 0;
			//

			NMS2[0] <= 0;
        	NMS2[1] <= 0;
        	NMS2[2] <= 0;
        	NMS2[3] <= 0;
        	NMS2[4] <= 0;
        	NMS2[5] <= 0;
        	NMS2[6] <= 0;
        	NMS2[7] <= 0;
        	NMS2[8] <= 0;
			//

			NMS3[0] <= 0;
        	NMS3[1] <= 0;
        	NMS3[2] <= 0;
        	NMS3[3] <= 0;
        	NMS3[4] <= 0;
        	NMS3[5] <= 0;
        	NMS3[6] <= 0;
        	NMS3[7] <= 0;
        	NMS3[8] <= 0;

			//

			NMS4[0] <= 0;
        	NMS4[1] <= 0;
        	NMS4[2] <= 0;
        	NMS4[3] <= 0;
        	NMS4[4] <= 0;
        	NMS4[5] <= 0;
        	NMS4[6] <= 0;
        	NMS4[7] <= 0;
        	NMS4[8] <= 0;
			//

			tGG1 <= 0;
			tGG2 <= 0;
			tGG3 <= 0;
			tGG4 <= 0;

			tdk1 <= 0;
			tdk2 <= 0;
			tdk3 <= 0;
			tdk4 <= 0;
			////////////////////////////////////////////////////


		end
	else
		begin
			case(state)





			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//                                          Get Instruction
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


				ReadyState://to set opready=1
					begin
						t_o_op_ready <=1;
						t_o_out_valid <=0;

						next_state <= BufferState;
					end
				BufferState://to set opready=0
					begin
						t_o_op_ready <=0;
						next_state <= GetInstState;
					end

			
				GetInstState://get opmode
					begin
						if(i_op_valid ==1)
							begin
								t_i_op_mode <= i_op_mode;

								case(i_op_mode)
									4'b0000:
										begin
											t_o_in_ready <=1;
											next_state <= LoadState;
											////////////////////////////
										end


									4'b0001:
										begin
											//if(Ocol == 3'b110)
											//	begin
											//		Ocol <= Ocol;
											//	end
											//else
											//	begin
											//		Ocol <= Ocol +1;
											//	end

											if(Ocol != 3'b110)
												begin
													Ocol <= Ocol +1;
												end


											next_state <= ReadyState;
										end
									4'b0010:
										begin
											//if(Ocol == 3'b000)
											//	begin
											//		Ocol <= Ocol;
											//	end
											//else
											//	begin
											//		Ocol <= Ocol -1;
											//	end

											if(Ocol != 3'b000)
												begin
													Ocol <= Ocol -1;
												end
											

											next_state <= ReadyState;
										end
									4'b0011:
										begin
											if(Orow != 3'b000)
												begin
													Orow <= Orow -1;
												end
											
											next_state <= ReadyState;
										end
									4'b0100:
										begin
											if(Orow != 3'b110)
												begin
													Orow <= Orow +1;
												end
											
											next_state <= ReadyState;
										end
									4'b0101:
										begin
											
											case(maxdep)
												5'b11111:
													begin
														maxdep <= 5'b01111;
													end
												//5'b01111:
												//	begin
												//		maxdep <= 5'b00111;
												//	end
												default:
													begin
														maxdep <= 5'b00111;
													end
											endcase


											next_state <= ReadyState;
										end
									4'b0110:
										begin

											case(maxdep)
												5'b00111:
													begin
														maxdep <=5'b01111;
													end
												//5'b01111:
												//	begin
												//		maxdep <=5'b11111;
												//	end
												default:
													begin
														maxdep <=5'b11111;
													end
											endcase

											next_state <= ReadyState;
										end
									////////////////////////////////////////////////////////
									4'b0111:
										begin
											//display
											mydep <= 0;
											next_state <= Disp0State;
										end
									4'b1000:
									 	begin
											//convolution
											cdep <= 0;
											block <=0;

											tOrow <= Orow; 
											tOcol <= Ocol;
											tdiscon <= discon;

											myacc[0] <= 0;
											myacc[1] <= 0;
											myacc[2] <= 0;
											myacc[3] <= 0;

											//next_state <= Conv0State;
											next_state <= PreState;
										end
									4'b1001:
										begin
											//median filter
											cdep <= 0;
											block <=0;

											tOrow <= Orow; 
											tOcol <= Ocol;
											tdiscon <= discon;

											next_state <= PreState;
										end
									4'b1010:
										begin
											//sobel gradient
											cdep <= 0;
											block <=0;

											tOrow <= Orow; 
											tOcol <= Ocol;
											tdiscon <= discon;

											next_state <= PreState;
										end									

								endcase

							end
						else
							begin//no more opmode
								
								next_state <= ReadyState;
							end
					end









			/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//                                       Loading
			/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				LoadState:
					begin

						if( (i_in_valid ==1) && (loaddone1 ==1) && (loaddone2==1) && (imgcount !=12'b100000000000))// //!loaddone
							begin
								case(loadwho)
									2'b00:
										begin
											writable2 <= 1'b1;
											writable3 <= 1'b1;
											writable4 <= 1'b1;

											////////////////////////////////
											//sram1
											sramaddr1 <= t_sramaddr1;
											Lsramaddr1 <= t_sramaddr1;
											enable1<= 1'b0;
											sramin1 <= i_in_data;
											writable1 <= 1'b0;
											///////////////////////////////
											//$display("Value1: %b", t_sramaddr1); 
											//$display("data1: %b", i_in_data);
										end
									2'b01:
										begin
											writable1 <= 1'b1;
											writable3 <= 1'b1;
											writable4 <= 1'b1;

											//////////////////////////////////
											//sram2
											sramaddr2 <= t_sramaddr2;
											Lsramaddr2 <= t_sramaddr2;
											enable2<= 1'b0;
											sramin2 <= i_in_data;
											writable2 <= 1'b0;
											//////////////////////////////////
											//$display("Value2: %b", t_sramaddr2); 
											//$display("data2: %b", i_in_data);
										end
									2'b10:
										begin
											writable1 <= 1'b1;
											writable2 <= 1'b1;
											writable4 <= 1'b1;

											/////////////////////////////////
											//sram3
											sramaddr3 <= t_sramaddr3;
											Lsramaddr3 <= t_sramaddr3;
											enable3<= 1'b0;
											sramin3 <= i_in_data;
											writable3 <= 1'b0;
											//////////////////////////////////
											//$display("Value3: %b", t_sramaddr3); 
											//$display("data3: %b", i_in_data);
										end
									2'b11:
										begin
											writable1 <= 1'b1;
											writable2 <= 1'b1;
											writable3 <= 1'b1;
											/////////////////////////////////////
											//sram4
											sramaddr4 <= t_sramaddr4;
											Lsramaddr4 <= t_sramaddr4;
											enable4<= 1'b0;
											sramin4 <= i_in_data; 
											writable4 <= 1'b0;
											///////////////////////////////////////
											//$display("Value4: %b", t_sramaddr4); 
											//$display("data4: %b", i_in_data); 
										end
								endcase

								///////////////////////////////////////
								//////////////////////////////////////
								depc <= t_depc;
								rowc <= t_rowc;
								colc <= t_colc;
								///////////////////////////////////////
								t_o_in_ready <= 1;
								next_state <= LoadState;


								imgcount <= imgcount+1;


							end
						else if(imgcount ==12'b100000000000)
							begin
								//////////////////////////////////
								writable1 <= 1'b1;
								writable2 <= 1'b1;
								writable3 <= 1'b1;
								writable4 <= 1'b1;
								/////////////////////////////////
								t_o_in_ready <= 0;
								next_state <= ReadyState;
							end
						else
							begin
								t_o_in_ready <= 0;
								next_state <= LoadState;
							end
					end







			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//                                             Display
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				Disp0State:
					begin
						//sram1(.Q(sramout1),.CLK(i_clk),.CEN(enable1),.WEN(writable1),.A(sramaddr1),.D(sramin1));
						////////////////////////////////////////////////////////////
						
						
						if(disposdone)
							begin
								sramaddr1 <= pos1;
								sramaddr2 <= pos2;
								sramaddr3 <= pos3;
								sramaddr4 <= pos4;

								writable1 <= 1'b1;
								writable2 <= 1'b1;
								writable3 <= 1'b1;
								writable4 <= 1'b1;

								t_o_out_valid <=0;

								next_state <= Buffer2State;//Disp1State;

							end
						else
							begin
								next_state <= Disp0State;
							end
						
					end

				Buffer2State:
					begin
						next_state <= Disp1State;
					end

				Disp1State:
					begin
						//$display("disconn: %b", discon);
						case(discon)
							2'b00:
								//13
								//24
								begin
									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout1};
									//sramaddr1 <= pos1;
								end
							2'b01:
								//31
								//42
								begin
									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout3};
									//sramaddr3 <= pos3;
								end
							2'b10:
								//24
								//13
								begin
									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout2};
									//sramaddr2 <= pos2;
								end
							2'b11:
								//42
								//31
								begin
									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout4};
									//sramaddr4 <= pos4;
								end
						endcase
						///////////////////////////////////////////////////////////
						
						next_state <= Disp2State;
					end
				Disp2State:
					begin
						case(discon)
							2'b00:
								begin
									//sramaddr3 <= pos3;
									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout3};
								end
							2'b01:
								begin
									//sramaddr1 <= pos1;

									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout1};
								end
							2'b10:
								begin
									//sramaddr4 <= pos4;

									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout4};
								end
							2'b11:
								begin
									//sramaddr2 <= pos2;

									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout2};
								end
						endcase

						next_state <= Disp3State;
					end
				Disp3State:
					begin

						case(discon)
							2'b00:
								begin
									//sramaddr2 <= pos2;

									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout2};
								end
							2'b01:
								begin
									//sramaddr4 <= pos4;

									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout4};
								end
							2'b10:
								begin
									//sramaddr1 <= pos1;

									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout1};
								end
							2'b11:
								begin
									//sramaddr3 <= pos3;

									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout3};
								end
						endcase
						

						next_state <= Disp4State;
					end
				Disp4State:
					begin


						case(discon)
							2'b00:
								begin
									//sramaddr4 <= pos4;

									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout4};
								end
							2'b01:
								begin
									//sramaddr2 <= pos2;

									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout2};
								end
							2'b10:
								begin
									//sramaddr3 <= pos3;

									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout3};
								end
							2'b11:
								begin
									//sramaddr1 <= pos1;

									t_o_out_valid <=1;
									t_o_out_data <= {6'b000000,sramout1};
								end
						endcase



						if(mydep == maxdep)
							begin
								next_state <= ReadyState;
							end
						else
							begin
								mydep <= mydep +1;
								next_state <= Disp0State;
							end
					end

			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				



				
				
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//                                                  Reading	
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				PreState:
					begin

						if((readdone ==1))
							begin
								sramaddr1 <= cpos1;
								sramaddr2 <= cpos2;
								sramaddr3 <= cpos3;
								sramaddr4 <= cpos4;

								writable1 <= 1'b1;
								writable2 <= 1'b1;
								writable3 <= 1'b1;
								writable4 <= 1'b1;



								//////////////////////////////////////////////
								//$display("discon: %b", discon);
								//$display("block: %b", block);
								//$display("cdep: %b", cdep);
								//$display("discon: %b", discon);

								//$display("cpos1: %b", cpos1); 
								//$display("cpos2: %b", cpos2); 
								//$display("cpos3: %b", cpos3); 
								//$display("cpos4: %b", cpos4);


								//next_state <= ReaState;
								next_state <= Buffer3State;
							end
						else
							begin
								next_state <= PreState;
							end

					end


				Buffer3State:
					begin
						//$display("sramout2: %b", sramout2);
						next_state <= ReaState;
					end

				ReaState:	
					begin
						
						//$display("sramout1: %b", sramout1);
						//$display("sramout2: %b", sramout2);
						//$display("sramout3: %b", sramout3);
						//$display("sramout4: %b", sramout4);




						case(discon)
						/////////////////////////////////////////////////////////////////////////////////////////
							2'b00:
								//center
								//13
								//24
								begin
									//block
									//42
									//31

									//4242
									//3131
									//4242
									//3131

									///////////////////////////////////////////////////////
									if(cpos4valid)
										begin
											case(block)
												2'b00:
													begin
														m0 <= sramout4;
													end
												2'b01:
													begin
														m2 <= sramout4;
													end
												2'b10:
													begin
														m8 <= sramout4;
													end
												default:
													begin
														m10 <= sramout4;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m0 <= 0;
													end
												2'b01:
													begin
														m2 <= 0;
													end
												2'b10:
													begin
														m8 <= 0;
													end
												default:
													begin
														m10 <= 0;
													end
											endcase
										end
									/////////////////////////////////////////////////////////
									if(cpos2valid)
										begin
											case(block)
												2'b00:
													begin
														m1 <= sramout2;
													end
												2'b01:
													begin
														m3 <= sramout2;
													end
												2'b10:
													begin
														m9 <= sramout2;
													end
												default:
													begin
														m11 <= sramout2;
													end
											endcase

											
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m1 <= 0;
													end
												2'b01:
													begin
														m3 <= 0;
													end
												2'b10:
													begin
														m9 <= 0;
													end
												default:
													begin
														m11 <= 0;
													end
											endcase
										end


									///////////////////////////////////////////////////////////////////////////////////////////
									if(cpos3valid)
										begin
											case(block)
												2'b00:
													begin
														m4 <= sramout3;
													end
												2'b01:
													begin
														m6 <= sramout3;
													end
												2'b10:
													begin
														m12 <= sramout3;
													end
												default:
													begin
														m14 <= sramout3;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m4 <= 0;
													end
												2'b01:
													begin
														m6 <= 0;
													end
												2'b10:
													begin
														m12 <= 0;
													end
												default:
													begin
														m14 <= 0;
													end
											endcase
										end									
									
									//////////////////////////////////////////////////////////////////////////////////
									if(cpos1valid)
										begin
											case(block)
												2'b00:
													begin
														m5 <= sramout1;
													end
												2'b01:
													begin
														m7 <= sramout1;
													end
												2'b10:
													begin
														m13 <= sramout1;
													end
												default:
													begin
														m15 <= sramout1;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m5 <= 0;
													end
												2'b01:
													begin
														m7 <= 0;
													end
												2'b10:
													begin
														m13 <= 0;
													end
												default:
													begin
														m15 <= 0;
													end
											endcase
										end
								end
						//////////////////////////////////////////////////////////////////////////////////////////////////////////
							2'b01:
								//center
								//31
								//42
								begin
									//block
									//24
									//13

									//2424
									//1313
									//2424
									//1313
									////////////////////////////////////////////////////////////////
									if(cpos2valid)
										begin
											case(block)
												2'b00:
													begin
														m0 <= sramout2;
													end
												2'b01:
													begin
														m2 <= sramout2;
													end
												2'b10:
													begin
														m8 <= sramout2;
													end
												default:
													begin
														m10 <= sramout2;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m0 <= 0;
													end
												2'b01:
													begin
														m2 <= 0;
													end
												2'b10:
													begin
														m8 <= 0;
													end
												default:
													begin
														m10 <= 0;
													end
											endcase
										end
									////////////////////////////////////////////////////////////////////////

									if(cpos4valid)
										begin

											case(block)
												2'b00:
													begin
														m1 <= sramout4;
													end
												2'b01:
													begin
														m3 <= sramout4;
													end
												2'b10:
													begin
														m9 <= sramout4;
													end
												default:
													begin
														m11 <= sramout4;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m1 <= 0;
													end
												2'b01:
													begin
														m3 <= 0;
													end
												2'b10:
													begin
														m9 <= 0;
													end
												default:
													begin
														m11 <= 0;
													end
											endcase
										end
									//////////////////////////////////////////////////////////////////////
									if(cpos1valid)
										begin
											case(block)
												2'b00:
													begin
														m4 <= sramout1;
													end
												2'b01:
													begin
														m6 <= sramout1;
													end
												2'b10:
													begin
														m12 <= sramout1;
													end
												default:
													begin
														m14 <= sramout1;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m4 <= 0;
													end
												2'b01:
													begin
														m6 <= 0;
													end
												2'b10:
													begin
														m12 <= 0;
													end
												default:
													begin
														m14 <= 0;
													end
											endcase
										end
									//////////////////////////////////////////////////////////////////////////
									if(cpos3valid)
										begin
											case(block)
												2'b00:
													begin
														m5 <= sramout3;
													end
												2'b01:
													begin
														m7 <= sramout3;
													end
												2'b10:
													begin
														m13 <= sramout3;
													end
												default:
													begin
														m15 <= sramout3;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m5 <= 0;
													end
												2'b01:
													begin
														m7 <= 0;
													end
												2'b10:
													begin
														m13 <= 0;
													end
												default:
													begin
														m15 <= 0;
													end
											endcase
										end
								end
							///////////////////////////////////////////////////////////////////////////////////////////////////////
							2'b10:
								//center
								//24
								//13
								begin
									//block
									//31
									//42

									//3131
									//4242
									//3131
									//4242
									////////////////////////////////////////////////////////////////////////////////////////////
									if(cpos3valid)
										begin

											case(block)
												2'b00:
													begin
														m0 <= sramout3;
													end
												2'b01:
													begin
														m2 <= sramout3;
													end
												2'b10:
													begin
														m8 <= sramout3;
													end
												default:
													begin
														m10 <= sramout3;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m0 <= 0;
													end
												2'b01:
													begin
														m2 <= 0;
													end
												2'b10:
													begin
														m8 <= 0;
													end
												default:
													begin
														m10 <= 0;
													end
											endcase
										end
									///////////////////////////////////////////////////////////////////////////////////

									if(cpos1valid)
										begin

											case(block)
												2'b00:
													begin
														m1 <= sramout1;
													end
												2'b01:
													begin
														m3 <= sramout1;
													end
												2'b10:
													begin
														m9 <= sramout1;
													end
												default:
													begin
														m11 <= sramout1;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m1 <= 0;
													end
												2'b01:
													begin
														m3 <= 0;
													end
												2'b10:
													begin
														m9 <= 0;
													end
												default:
													begin
														m11 <= 0;
													end
											endcase
										end
									///////////////////////////////////////////////////////////////////////////////
									if(cpos4valid)
										begin

											case(block)
												2'b00:
													begin
														m4 <= sramout4;
													end
												2'b01:
													begin
														m6 <= sramout4;
													end
												2'b10:
													begin
														m12 <= sramout4;
													end
												default:
													begin
														m14 <= sramout4;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m4 <= 0;
													end
												2'b01:
													begin
														m6 <= 0;
													end
												2'b10:
													begin
														m12 <= 0;
													end
												default:
													begin
														m14 <= 0;
													end
											endcase
										end
									///////////////////////////////////////////////////////////////////////////////////

									if(cpos2valid)
										begin

											case(block)
												2'b00:
													begin
														m5 <= sramout2;
													end
												2'b01:
													begin
														m7 <= sramout2;
													end
												2'b10:
													begin
														m13 <= sramout2;
													end
												default:
													begin
														m15 <= sramout2;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m5 <= 0;
													end
												2'b01:
													begin
														m7 <= 0;
													end
												2'b10:
													begin
														m13 <= 0;
													end
												default:
													begin
														m15 <= 0;
													end
											endcase
										end
									
								end
							/////////////////////////////////////////////////////////////////////////////////////////////////////////////
							//2'b11:
							default:
								//center
								//42
								//31
								begin
									//block
									//13
									//24

									//1313
									//2424
									//1313
									//2424

									//////////////////////////////////////////////////////////////
									if(cpos1valid)
										begin

											case(block)
												2'b00:
													begin
														m0 <= sramout1;
													end
												2'b01:
													begin
														m2 <= sramout1;
													end
												2'b10:
													begin
														m8 <= sramout1;
													end
												default:
													begin
														m10 <= sramout1;
													end
											endcase
											
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m0 <= 0;
													end
												2'b01:
													begin
														m2 <= 0;
													end
												2'b10:
													begin
														m8 <= 0;
													end
												default:
													begin
														m10 <= 0;
													end
											endcase
										end
									////////////////////////////////////////////////////////////////////////////

									if(cpos3valid)
										begin
											case(block)
												2'b00:
													begin
														m1 <= sramout3;
													end
												2'b01:
													begin
														m3 <= sramout3;
													end
												2'b10:
													begin
														m9 <= sramout3;
													end
												default:
													begin
														m11 <= sramout3;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m1 <= 0;
													end
												2'b01:
													begin
														m3 <= 0;
													end
												2'b10:
													begin
														m9 <= 0;
													end
												default:
													begin
														m11 <= 0;
													end
											endcase
										end
									////////////////////////////////////////////////////////////////

									if(cpos2valid)
										begin
											case(block)
												2'b00:
													begin
														m4 <= sramout2;
													end
												2'b01:
													begin
														m6 <= sramout2;
													end
												2'b10:
													begin
														m12 <= sramout2;
													end
												default:
													begin
														m14 <= sramout2;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m4 <= 0;
													end
												2'b01:
													begin
														m6 <= 0;
													end
												2'b10:
													begin
														m12 <= 0;
													end
												default:
													begin
														m14 <= 0;
													end
											endcase
										end
									////////////////////////////////////////////////////////////////
									
									if(cpos4valid)
										begin
											case(block)
												2'b00:
													begin
														m5 <= sramout4;
													end
												2'b01:
													begin
														m7 <= sramout4;
													end
												2'b10:
													begin
														m13 <= sramout4;
													end
												default:
													begin
														m15 <= sramout4;
													end
											endcase
										end
									else
										begin
											case(block)
												2'b00:
													begin
														m5 <= 0;
													end
												2'b01:
													begin
														m7 <= 0;
													end
												2'b10:
													begin
														m13 <= 0;
													end
												default:
													begin
														m15 <= 0;
													end
											endcase
										end
								end
						endcase
						///////////////////////////////////////////////////////////////////////////////////////////////////////////////



						if(block == 2'b11)
							begin
								next_state <= OKState;
							end
						else
							begin
								block <= block +1;
								next_state <= PreState;
							end
					end

				OKState:
					begin
						case(t_i_op_mode)
							4'b1000:
								begin
									next_state <= Conv0State;
								end
							4'b1001:
								begin
									next_state <= Med0State;
								end
							default:
								begin
									next_state <= Sobel0State;
								end
						endcase

					end
				/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				//                                                 Convolution
				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				Conv0State:
					begin
						/////////////////////////////////////////////////////////////
						//$display("m0: %b", m0); 
						//$display("m1: %b", m1); 
						//$display("m2: %b", m2); 
						//$display("m3: %b", m3); 
						//$display("m4: %b", m4); 
						//$display("m5: %b", m5); 
						//$display("m6: %b", m6); 
						//$display("m7: %b", m7); 
						//$display("m8: %b", m8); 
						//$display("m9: %b", m9); 
						//$display("m10: %b", m10); 
						//$display("m11: %b", m11); 
						//$display("m12: %b", m12); 
						//$display("m13: %b", m13); 
						//$display("m14: %b", m14);
						//$display("m15: %b", m15);

						////////////////////////////////////////////////////////////////
						
						Conv1[0] <= m0;
        				Conv1[1] <= m1;
        				Conv1[2] <= m2;
        				Conv1[3] <= m4;
        				Conv1[4] <= m5;
        				Conv1[5] <= m6;
        				Conv1[6] <= m8;
        				Conv1[7] <= m9;
        				Conv1[8] <= m10;
						/////////////////////////////////////////////////////////

						Conv2[0] <= m1;
        				Conv2[1] <= m2;
        				Conv2[2] <= m3;
        				Conv2[3] <= m5;
        				Conv2[4] <= m6;
        				Conv2[5] <= m7;
        				Conv2[6] <= m9;
        				Conv2[7] <= m10;
        				Conv2[8] <= m11;
						////////////////////////////////////////////////////////////

						Conv3[0] <= m4;
        				Conv3[1] <= m5;
        				Conv3[2] <= m6;
        				Conv3[3] <= m8;
        				Conv3[4] <= m9;
        				Conv3[5] <= m10;
        				Conv3[6] <= m12;
        				Conv3[7] <= m13;
        				Conv3[8] <= m14;

						/////////////////////////////////////////////////////////////////

						Conv4[0] <= m5;
        				Conv4[1] <= m6;
        				Conv4[2] <= m7;
        				Conv4[3] <= m9;
        				Conv4[4] <= m10;
        				Conv4[5] <= m11;
        				Conv4[6] <= m13;
        				Conv4[7] <= m14;
        				Conv4[8] <= m15;
						///////////////////////////////////////////////////////////////////////
						next_state <= Conv1State;
					end

				Conv1State:
					begin
						if((convdone1 ==1) && (convdone2 ==1) && (convdone3 ==1) && (convdone4 ==1))
							begin
								next_state <= Conv2State;
							end
						else
							begin
								next_state <= Conv1State;
							end
					end
				Conv2State:
					begin
						

						/////////////////////////////////////////////////////////
						//$display("ctemp1: %b", ctemp1); 
						//$display("ctemp2: %b", ctemp2); 
						//$display("ctemp3: %b", ctemp3); 
						//$display("ctemp4: %b", ctemp4); 
						/////////////////////////////////////////////////////////
						myacc[0] <= myacc[0] + ctemp1;
						myacc[1] <= myacc[1] + ctemp2;
						myacc[2] <= myacc[2] + ctemp3;
						myacc[3] <= myacc[3] + ctemp4;

						if(cdep == maxdep)
							begin
								next_state <= Conv3State;
							end
						else
							begin
								block <=0;
								cdep <= cdep +1;
								next_state <= PreState;
							end
					end
				Conv3State:
					begin
						t0 <= myacc[0];
						t1 <= myacc[1];
						t2 <= myacc[2];
						t3 <= myacc[3];

						next_state <= Buffer4State;

					end
				Buffer4State:
					begin
						if(adjdone)
							begin
								next_state <= Conv4State;
							end
						else
							begin
								next_state <= Buffer4State;
							end
					end
				Conv4State:
					begin
						t_o_out_data <= cANS1;
						t_o_out_valid <=1;
						next_state <= Conv5State;
					end
				Conv5State:
					begin
						t_o_out_data <= cANS2;
						t_o_out_valid <=1;
						next_state <= Conv6State;
					end
				Conv6State:
					begin
						t_o_out_data <= cANS3;
						t_o_out_valid <=1;
						next_state <= Conv7State;
					end
				Conv7State:
					begin
						t_o_out_data <= cANS4;
						t_o_out_valid <=1;
						next_state <= Conv8State;
					end
				Conv8State:
					begin
						t_o_out_valid <=0;
						next_state <= ReadyState;
					end	



				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				//                                            Median filter
				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				Med0State:
					begin
						sorted1[0] <= m0;
        				sorted1[1] <= m1;
        				sorted1[2] <= m2;
        				sorted1[3] <= m4;
        				sorted1[4] <= m5;
        				sorted1[5] <= m6;
        				sorted1[6] <= m8;
        				sorted1[7] <= m9;
        				sorted1[8] <= m10;
						/////////////////////////////////////////////////////////

						sorted2[0] <= m1;
        				sorted2[1] <= m2;
        				sorted2[2] <= m3;
        				sorted2[3] <= m5;
        				sorted2[4] <= m6;
        				sorted2[5] <= m7;
        				sorted2[6] <= m9;
        				sorted2[7] <= m10;
        				sorted2[8] <= m11;
						////////////////////////////////////////////////////////////

						sorted3[0] <= m4;
        				sorted3[1] <= m5;
        				sorted3[2] <= m6;
        				sorted3[3] <= m8;
        				sorted3[4] <= m9;
        				sorted3[5] <= m10;
        				sorted3[6] <= m12;
        				sorted3[7] <= m13;
        				sorted3[8] <= m14;

						/////////////////////////////////////////////////////////////////

						sorted4[0] <= m5;
        				sorted4[1] <= m6;
        				sorted4[2] <= m7;
        				sorted4[3] <= m9;
        				sorted4[4] <= m10;
        				sorted4[5] <= m11;
        				sorted4[6] <= m13;
        				sorted4[7] <= m14;
        				sorted4[8] <= m15;
						///////////////////////////////////////////////////////////////////////
						next_state <= Med1State;
					end
				Med1State:
					begin
						if((mdone1 ==1) && (mdone2 ==1) && (mdone3 ==1) && (mdone4 ==1))
							begin
								next_state <= Med2State;
							end
						else
							begin
								next_state <= Med1State;
							end
					end
				Med2State:
					begin
						t_o_out_data <= median1;
						t_o_out_valid <= 1;
						next_state <= Med3State;
					end
				Med3State:
					begin
						t_o_out_data <= median2;
						t_o_out_valid <= 1;
						next_state <= Med4State;
					end
				Med4State:
					begin
						t_o_out_data <= median3;
						t_o_out_valid <= 1;
						next_state <= Med5State;
					end
				Med5State:
					begin
						t_o_out_data <= median4;
						t_o_out_valid <= 1;
						next_state <= Med6State;
					end
				Med6State:
					begin
						t_o_out_valid <= 0;

						if(cdep == 5'b00011)
							begin
								next_state <= ReadyState;
							end
						else
							begin
								cdep <= cdep +1;
								block <=0;
								next_state <= PreState;
							end
					end
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				//                                               Sobel filter
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				Sobel0State:
					begin
						NMS1[0] <= m0;
        				NMS1[1] <= m1;
        				NMS1[2] <= m2;
        				NMS1[3] <= m4;
        				NMS1[4] <= m5;
        				NMS1[5] <= m6;
        				NMS1[6] <= m8;
        				NMS1[7] <= m9;
        				NMS1[8] <= m10;
						/////////////////////////////////////////////////////////

						NMS2[0] <= m1;
        				NMS2[1] <= m2;
        				NMS2[2] <= m3;
        				NMS2[3] <= m5;
        				NMS2[4] <= m6;
        				NMS2[5] <= m7;
        				NMS2[6] <= m9;
        				NMS2[7] <= m10;
        				NMS2[8] <= m11;
						////////////////////////////////////////////////////////////

						NMS3[0] <= m4;
        				NMS3[1] <= m5;
        				NMS3[2] <= m6;
        				NMS3[3] <= m8;
        				NMS3[4] <= m9;
        				NMS3[5] <= m10;
        				NMS3[6] <= m12;
        				NMS3[7] <= m13;
        				NMS3[8] <= m14;

						/////////////////////////////////////////////////////////////////

						NMS4[0] <= m5;
        				NMS4[1] <= m6;
        				NMS4[2] <= m7;
        				NMS4[3] <= m9;
        				NMS4[4] <= m10;
        				NMS4[5] <= m11;
        				NMS4[6] <= m13;
        				NMS4[7] <= m14;
        				NMS4[8] <= m15;
						////////////////////////////////////////////////////////////////////

						next_state <= Sobel1State;
					end

				Sobel1State:
					begin
						if( (sdone1 ==1) && (sdone2 ==1) && (sdone3 ==1) && (sdone4 ==1))
							begin
								next_state <= Sobel2State;
							end
						else
							begin
								next_state <= Sobel1State;
							end
					end

				Sobel2State:
					begin
						tGG1 <= GG1;
						tGG2 <= GG2;
						tGG3 <= GG3;
						tGG4 <= GG4;

						tdk1 <= DK1;
						tdk2 <= DK2;
						tdk3 <= DK3;
						tdk4 <= DK4;

						next_state <= Sobel3State;
					end
				Sobel3State:
					begin
						if(tGdone)
							begin
								next_state <= Sobel4State;
							end
						else
							begin
								next_state <= Sobel3State;
							end
					end
				Sobel4State:
					begin
						t_o_out_data <= nans1;
						t_o_out_valid <= 1;
						next_state <= Sobel5State;
					end
				Sobel5State:
					begin
						t_o_out_data <= nans2;
						t_o_out_valid <= 1;
						next_state <= Sobel6State;
					end
				Sobel6State:
					begin
						t_o_out_data <= nans3;
						t_o_out_valid <= 1;
						next_state <= Sobel7State;
					end
				Sobel7State:
					begin
						t_o_out_data <= nans4;
						t_o_out_valid <= 1;
						next_state <= Sobel8State;
					end
				Sobel8State:
					begin
						t_o_out_valid <= 0;

						if(cdep == 5'b00011)
							begin
								next_state <= ReadyState;
							end
						else
							begin
								cdep <= cdep +1;
								block <=0;
								next_state <= PreState;
							end
					end
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			endcase

		end

end



////////////////////////////////////////////////////////////////////////////////////////////////////
endmodule










/*
Conv0State:
	begin

						//sram1(.Q(sramout1),.CLK(i_clk),.CEN(enable1),.WEN(writable1),.A(sramaddr1),.D(sramin1));
						////////////////////////////////////////////////////////////
						
						sramaddr1 <= cpos1;
						sramaddr2 <= cpos2;
						sramaddr3 <= cpos3;
						sramaddr4 <= cpos4;

						writable1 <= 1'b1;
						writable2 <= 1'b1;
						writable3 <= 1'b1;
						writable4 <= 1'b1;

						next_state <= Conv1State;
					end
				//0	//131 31313
				//1	//242 42424
				//2	//131 31313
				//3	//242 42424
				//4	//131 31313
				//5	//242 42424
				//6 //131 31313
				//7 //242 42424




Conv1State:
					begin

						case(discon)
							2'b00:
								//center
								//13
								//24
								begin
									//block
									//42
									//31

									if(cpos4valid)
										begin
											dataLU <= sramout4;
										end
									else
										begin
											dataLU <= 0;
										end

									if(cpos2valid)
										begin
											dataRU <= sramout2;
										end
									else
										begin
											dataRU <= 0;
										end

									if(cpos3valid)
										begin
											dataLD <= sramout3;
										end
									else
										begin
											dataLD <= 0;
										end									
									
									if(cpos1valid)
										begin
											dataRD <= sramout1;
										end
									else
										begin
											dataRD <= 0;
										end
								end
							2'b01:
								//center
								//31
								//42
								begin
									//block
									//24
									//13
									if(cpos2valid)
										begin
											dataLU <= sramout2;
										end
									else
										begin
											dataLU <= 0;
										end

									if(cpos4valid)
										begin
											dataRU <= sramout4;
										end
									else
										begin
											dataRU <= 0;
										end

									if(cpos1valid)
										begin
											dataLD <= sramout1;
										end
									else
										begin
											dataLD <= 0;
										end
									
									if(cpos3valid)
										begin
											dataRD <= sramout3;
										end
									else
										begin
											dataRD <= 0;
										end
								end
							2'b10:
								//center
								//24
								//13
								begin
									//block
									//31
									//42
									if(cpos3valid)
										begin
											dataLU <= sramout3;
										end
									else
										begin
											dataLU <= 0;
										end

									if(cpos1valid)
										begin
											dataRU <= sramout1;
										end
									else
										begin
											dataRU <= 0;
										end

									if(cpos4valid)
										begin
											dataLD <= sramout4;
										end
									else
										begin
											dataLD <= 0;
										end

									if(cpos2valid)
										begin
											dataRD <= sramout2;
										end
									else
										begin
											dataRD <= 0;
										end
									
								end
							//2'b11:
							default:
								//center
								//42
								//31
								begin
									//block
									//13
									//24

									if(cpos1valid)
										begin
											dataLU <= sramout1;
										end
									else
										begin
											dataLU <= 0;
										end

									if(cpos3valid)
										begin
											dataRU <= sramout3;
										end
									else
										begin
											dataRU <= 0;
										end

									if(cpos2valid)
										begin
											dataLD <= sramout2;
										end
									else
										begin
											dataLD <= 0;
										end
									
									if(cpos4valid)
										begin
											dataRD <= sramout4;
										end
									else
										begin
											dataRD <= 0;
										end
								end
						endcase

						next_state <= Conv2State;
					end


*/