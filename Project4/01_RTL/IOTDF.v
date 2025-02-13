`timescale 1ns/10ps
module IOTDF( clk, rst, in_en, iot_in, fn_sel, busy, valid, iot_out);
input          clk;
input          rst;
input          in_en;
input  [7:0]   iot_in;
input  [2:0]   fn_sel;
output         busy;
output         valid;
output [127:0] iot_out;
/////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////
//            WIRE AND REG
////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////
//                 IO
///////////////////////////////////////////////////////////////
//////////////////////
//input


//output
reg [127:0] t_iot_out;
reg t_busy;
reg t_valid;

///////////////////////


//////////////////////
//for data record
//reg [63:0] mainkey;
//reg [63:0] text;
/*
reg [7:0] d1;
reg [7:0] d2;
reg [7:0] d3;
reg [7:0] d4;
reg [7:0] d5;
reg [7:0] d6;
reg [7:0] d7;
reg [7:0] d8;
reg [7:0] d9;
reg [7:0] d10;
reg [7:0] d11;
reg [7:0] d12;
reg [7:0] d13;
reg [7:0] d14;
reg [7:0] d15;
reg [7:0] d16;
*/
////////////////////////



////////////////////////////////////////////////////////////////////////////////////////////
//             ENCRIPTION
//////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////
//step0:
//for recording up stream or downstream
//reg [31:0] UPP;
//reg [31:0] DOWN;// will wait for upstream calculation


//for starting generating subkey
//pc1
//reg [63:0] PC1IN;
//reg [55:0] PC1OUT;

//initial permutation
//reg [63:0] TEXT;
//reg [63:0] INIP;
////////////////////////////

///////////////////////////////
//STEP1-1: 
//calculate subkey
//for shifting
//reg [27:0] cipherupIN;
//reg [27:0] cipherupOUT;

//reg [27:0] cipherdownIN;
//reg [27:0] cipherdownOUT;

//reg [27:0] ncipherupIN;
//reg [27:0] ncipherdownIN;

//for recording which round of encription
//reg [3:0] enround;
//reg [3:0] tenround;
///////////////////////////////

////////////////////////////
//STEP1-2: 
//expansion
//reg [31:0] EXPIN;
//reg [47:0] EXPOUT;
////////////////////////////


//////////////////////////////
//STEP1-3:
//for generating Kn of each round
//pc2
//reg [55:0] PC2IN;
//reg [47:0] PC2OUT;
///////////////////////////////



/////////////////////////////
//STEP2:
//for xor of expansion out and kn
//reg [47:0] SS;
//reg [47:0] texpout;//expansion out
//reg [47:0] tk;//Kn
/////////////////////////////


/////////////////////////////
//STEP3:
//for S box
//reg [3:0] P1;
//reg [3:0] P2;
//reg [3:0] P3;
//reg [3:0] P4;
//reg [3:0] P5;
//reg [3:0] P6;
//reg [3:0] P7;
//reg [3:0] P8;

//reg [5:0] S1;
//reg [5:0] S2;
//reg [5:0] S3;
//reg [5:0] S4;
//reg [5:0] S5;
//reg [5:0] S6;
//reg [5:0] S7;
//reg [5:0] S8;
/////////////////////////////


////////////////////////////
//STEP4:
//p permutation
//reg [31:0] P;
//reg [31:0] FOUT;
/////////////////////////////


///////////////////////////
//STEP5:
//for xor of downstream and fout at the final step of each round
//reg [31:0] tfout;
//reg [31:0] tdown;
////////////////////////////


///////////////////////////////
//STEP6:
//record next upstream downstream
//reg [31:0] nUPP;
//reg [31:0] nDOWN;

////////////////////////////////


////////////////////////////////
//STEP7:
//final permutaion
//reg [63:0] FINP;
//reg [63:0] FINR;
/////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////
//////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
//                     CRC
/////////////////////////////////////////////////////////////////////////////////////
//reg [3:0] tAA;
//reg [3:0] tBB;
//reg [3:0] tCC;

//reg move;
//reg stop;
//reg [6:0] tind;
//reg [6:0] ind;
///////////////////////////////////////////////////////////
reg [7:0] tind;
//reg [130:0] BB;
//reg [2:0] ans;
/////////////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////////////
//                          Top2 Max
//////////////////////////////////////////////////////////////////////////////////////
//reg [2:0] count;
//reg [127:0] newd;
//reg [127:0] cand [1:0];
//reg smind;
///////////////////////////////////////////////////////////

///////////////////////////////
// Top 2 min
//////////////////////////////
//reg bigind;
///////////////////////////////////////////////////////////////////
reg [130:0] BB;
reg [130:0] BB2;



///////////////////////////////////////////////////////////////////////////
//                              FSM
///////////////////////////////////////////////////////////////////////////

reg [4:0] state;
reg [4:0] next_state;

//reg [3:0] state;
//reg [3:0] next_state;


localparam ReadyState   = 5'b00000;
localparam Buffer1State = 5'b00001;

///
localparam D1State       = 5'b00010;
localparam D2State       = 5'b00011;
localparam D3State       = 5'b00100;
localparam D4State       = 5'b00101;
localparam D5State       = 5'b00110;
localparam D6State       = 5'b00111;
localparam D7State       = 5'b01000;
localparam D8State       = 5'b01001;
localparam D9State       = 5'b01010;
localparam D10State      = 5'b01011;
localparam D11State      = 5'b01100;
localparam D12State      = 5'b01101;
localparam D13State      = 5'b01110;
localparam D14State      = 5'b01111;
localparam D15State      = 5'b10000;
localparam D16State      = 5'b10001;


////////////////////////////////////////////////
localparam Buffer2State = 5'b10010;

localparam En0State     = 5'b10011;
localparam En1State     = 5'b10100;
localparam En2State     = 5'b10101;
//localparam En3State     = 4'b0110;
//localparam En4State     = 4'b0111;
//localparam En5State     = 4'b1000;
//localparam En6State     = 4'b1001;
//localparam En7State     = 4'b1010;
//localparam En8State     = 4'b1011;


localparam CR0State     = 5'b10110;
localparam CR1State     = 5'b10111;
//localparam CR2State     = 5'b01110;
localparam Big0State    = 5'b11000;
localparam Big1State    = 5'b11001;
//localparam Big2State    = 5'b10001;

//localparam Small0State  = 5'b10010;
//localparam Small1State  = 5'b10011;
//localparam Small2State  = 5'b10100;


////////////////////////////////////////




///////////////////////////////////////


///////////////////////////////////////////////////////////////////////////


/*
reg [4:0] state2;
reg [4:0] next_state2;

localparam ReadyState2    = 5'b00000;
localparam Buffer1State2  = 5'b00001;

localparam D1State2       = 5'b00010;
localparam D2State2       = 5'b00011;
localparam D3State2       = 5'b00100;
localparam D4State2       = 5'b00101;
localparam D5State2       = 5'b00110;
localparam D6State2       = 5'b00111;
localparam D7State2       = 5'b01000;
localparam D8State2       = 5'b01001;
localparam D9State2       = 5'b01010;
localparam D10State2      = 5'b01011;
localparam D11State2      = 5'b01100;
localparam D12State2      = 5'b01101;
localparam D13State2      = 5'b01110;
localparam D14State2      = 5'b01111;
localparam D15State2      = 5'b10000;
localparam D16State2      = 5'b10001;
*/
//localparam Buffer2State2  = 5'b10010;
//////////////////////////////////////////////////////////////////
//reg flush;
//reg fin;




/////////////////////////////////////////////////////////
//wire enable;

///////////////////////////////////////////////////////////////////
//                 CONTINUOUS ASSIGNMENT
//////////////////////////////////////////////////////////////////
assign iot_out = t_iot_out;
assign busy = t_busy;
assign valid = t_valid;

//////////////////////////////////////
//assign enable = (!fin) || (flush) ;

/////////////////////////////////////////////////////////////////////
//                       SEQUENTIAL
////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

/*
always@(posedge clk or posedge rst)
begin
    if(rst)
        begin
            d1<=0;
            d2<=0;
            d3<=0;
            d4<=0;
            d5<=0;
            d6<=0;
            d7<=0;
            d8<=0;
            d9<=0;
            d10<=0;
            d11<=0;
            d12<=0;
            d13<=0;
            d14<=0;
            d15<=0;
            d16<=0;

            t_busy <=1;
            fin <=0;

            next_state2 <= ReadyState2;

        end
    else
        begin

            //$display("State2: %b", state2);


            if(enable)//(!fin) || (flush)
            begin


            case(state2)
                ReadyState2:
                    begin
                        t_busy <=0;
                        fin <=0;

                        next_state2 <= Buffer1State2;
                    end
                Buffer1State2:
                    begin
                        next_state2 <= D1State2;
                    end
                D1State2:
                    begin
                        if(in_en)
                            begin
                                d1 <= iot_in;
                                next_state2 <= D2State2;
                            end
                        else
                            begin
                                next_state2 <= ReadyState2;
                            end
                        
                    end
                 D2State2:
                    begin
                        d2 <= iot_in;
                        next_state2 <= D3State2;
                    end
                D3State2:
                    begin
                        d3 <= iot_in;
                        next_state2 <= D4State2;
                    end
                D4State2:
                    begin
                        d4 <= iot_in;
                        next_state2 <= D5State2;
                    end
                D5State2:
                    begin
                        d5 <= iot_in;
                        next_state2 <= D6State2;
                    end
                D6State2:
                    begin
                        d6 <= iot_in;
                        next_state2 <= D7State2;
                    end
                D7State2:
                    begin
                        d7 <= iot_in;
                        next_state2 <= D8State2;
                    end
                D8State2:
                    begin
                        d8 <= iot_in;
                        next_state2 <= D9State2;
                    end
                D9State2:
                    begin
                        d9 <= iot_in;
                        next_state2 <= D10State2;
                    end
                D10State2:
                    begin
                        d10 <= iot_in;
                        next_state2 <= D11State2;
                    end
                D11State2:
                    begin
                        d11 <= iot_in;
                        next_state2 <= D12State2;
                    end
                D12State2:
                    begin
                        d12 <= iot_in;
                        next_state2 <= D13State2;
                    end
                D13State2:
                    begin
                        d13 <= iot_in;
                        next_state2 <= D14State2;
                    end
                D14State2:
                    begin
                        d14 <= iot_in;
                        next_state2 <= D15State2;
                    end
                D15State2:
                    begin
                        t_busy <=1;
                        //fin <=1;

                        d15 <= iot_in;
                        next_state2 <= D16State2;
                    end
                D16State2:
                    begin
                        d16 <= iot_in;

                        fin <=1;
                        //next_state2 <= Buffer2State2;
                        next_state2 <= ReadyState2;

                    end

                ///////////////////////////////////////////////////
                //Buffer2State2:
                //    begin
                //        if(flush)
                //            begin
                //                next_state2 <= ReadyState2;
                //            end
                //        else
                //            begin
                //                next_state2 <= Buffer2State2;
                //            end
                //    end
                ///////////////////////////////////////////////////////
                
            endcase


            end
        end
end
*/






///////////////////////////////////////////////////////////////////////////
always@(posedge clk or posedge rst)
begin
    if(rst)
        begin
            //////////////////////////////////////
            //state
            next_state <= ReadyState;
            /////////////////////////////////////

            /////////////////////////////////////
            //output
            //t_busy <=1;
            t_valid <=0;
            t_iot_out <=0;

            //////////////////////////////////////////
            //
            //flush <=1;
            t_busy <=1;
            //////////////////////////////////////////
            //encrypt

            //STEP1:
            //tenround <= 0;
            //enround <= 0;

            //TEXT <=0;
            //PC1IN<=0;
            //PC2IN<=0;

            //UPP <=0;
            //DOWN <=0;

            //nDOWN <=0;

            //STEP2:
            //cipherupIN <=0;
            //cipherdownIN <=0;

            //ncipherupIN <=0;
            //ncipherdownIN <=0;

            //STEP3:
            //EXPIN <=0;

            //STEP4:
            //tk <=0;
            //texpout <=0;

            //STEP5:
            //S1 <=0;
            //S2 <=0;
            //S3 <=0;
            //S4 <=0;

            //S5 <=0;
            //S6 <=0;
            //S7 <=0;
            //S8 <=0;

            //step6:
            //P <=0;
            //tfout <=0;
            //tdown <=0;

            //step7:
            //FINR <=0;
            ////////////////////////////////////////////////////
            

            //////////////////////////////////////////////////////
            //CRC
            BB <=0;
            //tAA <= 4'b1110;
            //tBB <= 0;
            //ind <=0;

            //tind <= 130;
            tind <= 0;
            //ans <= 0;

            //////////////////////////////////////////////////////



            /////////////////////////////////////////////////////////
            //Top2
            //newd <=0;
            //count <=0;

            //cand[0] <= 0;
            //cand[1] <= 0;

            //smind <=0;
            ////////////////////////////////////////////////////////////
            BB2 <=0;
        end
    else
        begin

            //$display("State1: %b", state);


            case(state)
                ReadyState:
                    begin
                        t_busy <=0;
                        //////////////////////////////////////
                        t_valid <=0;
                        next_state <= Buffer1State;
                    end
                ///////////////////////////////////////////
                Buffer1State:
                    begin
                        /////////////////////////////////////////////
                        //if(fin)
                        //    begin
                        //        next_state <= Buffer2State;
                        //    end
                        //else
                        //    begin
                        //        next_state <= Buffer1State;
                        //    end

                        //flush <=1;
                        ////////////////////////////////////////////////

                        next_state <= D1State;
                    end
                /////////////////////////////////////////////



                D1State:
                    begin
                        if(in_en)
                            begin
                                t_iot_out[7:0] <= iot_in;
                                next_state <= D2State;
                            end
                        else
                            begin
                                next_state <= ReadyState;
                            end
                        
                    end
                 D2State:
                    begin
                        //d2 <= iot_in;
                        t_iot_out[15:8] <= iot_in;
                        next_state <= D3State;
                    end
                D3State:
                    begin
                        //d3 <= iot_in;
                        t_iot_out[23:16] <= iot_in;
                        next_state <= D4State;
                    end
                D4State:
                    begin
                        //d4 <= iot_in;
                        t_iot_out[31:24] <= iot_in;
                        next_state <= D5State;
                    end
                D5State:
                    begin
                        //d5 <= iot_in;
                        t_iot_out[39:32] <= iot_in;
                        next_state <= D6State;
                    end
                D6State:
                    begin
                        //d6 <= iot_in;
                        t_iot_out[47:40] <= iot_in;
                        next_state <= D7State;
                    end
                D7State:
                    begin
                        //d7 <= iot_in;
                        t_iot_out[55:48] <= iot_in;
                        next_state <= D8State;
                    end
                D8State:
                    begin
                        //d8 <= iot_in;
                        t_iot_out[63:56] <= iot_in;
                        next_state <= D9State;
                    end
                D9State:
                    begin
                        //d9 <= iot_in;
                        t_iot_out[71:64] <= iot_in;
                        next_state <= D10State;
                    end
                D10State:
                    begin
                        //d10 <= iot_in;
                        t_iot_out[79:72] <= iot_in;
                        next_state <= D11State;
                    end
                D11State:
                    begin
                        //d11 <= iot_in;
                        t_iot_out[87:80] <= iot_in;
                        next_state <= D12State;
                    end
                D12State:
                    begin
                        //d12 <= iot_in;
                        t_iot_out[95:88] <= iot_in;
                        next_state <= D13State;
                    end
                D13State:
                    begin
                        //d13 <= iot_in;
                        t_iot_out[103:96] <= iot_in;
                        next_state <= D14State;
                    end
                D14State:
                    begin
                        //d14 <= iot_in;
                        t_iot_out[111:104] <= iot_in;
                        next_state <= D15State;
                    end
                D15State:
                    begin
                        t_busy <=1;
                        //fin <=1;

                        //d15 <= iot_in;
                        t_iot_out[119:112] <= iot_in;
                        next_state <= D16State;
                    end
                D16State:
                    begin
                        //d16 <= iot_in;
                        t_iot_out[127:120] <= iot_in;
                        //fin <=1;
                        //next_state2 <= Buffer2State2;
                        next_state <= Buffer2State;

                    end






                
                ////////////////////////////////////////////////////////////
                Buffer2State:
                    begin

                        //flush <=0;
                        ////////////////////////////////////////
                        case(fn_sel)
                            3'b011:// CRC_gen
                                begin
                                    
                                    //BB <= {d16, d15, d14, d13, d12, d11, d10, d9, d8, d7, d6, d5, d4, d3, d2, d1, 3'b000};
                                    BB <= {t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0], 3'b000};
                                    //////////////////////////////////////////////////////
                                    //tAA <= 4'b1110;
                                    //tBB <= d16[7:4];
                                    //ind <= 127;
                                    tind <= 130;

                                    next_state <= CR1State;
                                end
                            3'b100://Top2Max
                                begin
                                    //newd <= {d16, d15, d14, d13, d12, d11, d10, d9, d8, d7, d6, d5, d4, d3, d2, d1};
                                    
                                    //////////////////////////////////////////////////////////////////////////////////////////////////
                                    
                                    if(tind == 0)//smind
                                        begin
                                            ////////
                                            if({t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]} > BB[127:0])
                                                begin
                                                    if(BB[130:128]== 3'b111)
                                                        begin
                                                            BB <= {BB[130:128], t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]};
                                                            //BB2 <= {BB2[130:128], BB2[127:0]};

                                                            next_state <= Big0State;
                                                        end
                                                    else
                                                        begin
                                                            BB <= {BB[130:128]+1, t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]};
                                                            BB2 <= {BB2[130:128]+1, BB2[127:0]};

                                                            next_state <= ReadyState;
                                                        end
                                                end
                                            else
                                                begin
                                                    if(BB[130:128]== 3'b111)
                                                        begin
                                                            next_state <= Big0State;

                                                        end
                                                    else
                                                        begin
                                                            BB <= {BB[130:128]+1, BB[127:0]};
                                                            BB2 <= {BB2[130:128]+1, BB2[127:0]};

                                                            next_state <= ReadyState;
                                                        end
                                                end
                                            ////////////////////////////////
                                            if({t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]} > BB2[127:0])
                                                begin
                                                    tind <= 1;
                                                end
                                        end
                                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                    else
                                        begin
                                            if({t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]} > BB2[127:0])
                                                begin

                                                    /////////////////////////////////////////////////////
                                                    if(BB2[130:128]== 3'b111)
                                                        begin
                                                            BB2 <= {BB2[130:128], t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]};
                                                            //BB <= {BB[130:128], BB[127:0]};

                                                            next_state <= Big0State;
                                                        end
                                                    else
                                                        begin
                                                            BB2 <= {BB2[130:128]+1, t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]};
                                                            BB <= {BB[130:128]+1, BB[127:0]};

                                                            next_state <= ReadyState;
                                                        end
                                                    /////////////////////////////////////////////////////////
                                                    
                                                end
                                            else
                                                begin
                                                    if(BB2[130:128] ==3'b111)
                                                        begin
                                                            next_state <= Big0State;
                                                        end
                                                    else
                                                        begin
                                                            BB <= {BB[130:128]+1, BB[127:0]};
                                                            BB2 <= {BB2[130:128]+1, BB2[127:0]};

                                                            next_state <= ReadyState;
                                                        end

                                                end
                                            /////////////////////////////////////////////////////////////
                                            if({t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]} > BB[127:0])
                                                begin
                                                    tind <= 0;
                                                end
                                        end

                                    ///////////////////////////////////////////////////////////////////////////////////////////////////
                                    //next_state <= Big0State;
                                end
                            3'b101://3'b101 // Last2Min
                                begin
                                    //newd <= {d16, d15, d14, d13, d12, d11, d10, d9, d8, d7, d6, d5, d4, d3, d2, d1};
                                    /////////////////////////////////////////////////////////////////////////////////////////
                                    if(BB[130:128] == 3'b000)
                                        begin
                                            BB <= {3'b001 ,t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]};
                                            BB2 <= {3'b001, 128'b0};

                                            next_state <= ReadyState;
                                        end
                                    else if(BB[130:128] == 3'b001)
                                        begin
                                            BB <= {3'b010, BB[127:0]};
                                            BB2 <= {3'b010, t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]};


                                            if({t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]} > BB[127:0] )
                                                begin
                                                    tind <=1;//bigind
                                                end
                                            else
                                                begin
                                                    tind <=0;//bigind
                                                end

                                            next_state <= ReadyState;
                                        end
                                    else
                                        begin
                                            

                                            ////////////////////////////////////////
                                            if(tind == 0)
                                                begin
                                                ////////
                                                    if({t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]} < BB[127:0])
                                                        begin
                                                            if(BB[130:128]== 3'b111)
                                                                begin
                                                                    BB <= {BB[130:128], t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]};
                                                                    //BB2 <= {BB2[130:128], BB2[127:0]};

                                                                    next_state <= Big0State;
                                                                end
                                                            else
                                                                begin
                                                                    BB <= {BB[130:128]+1, t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]};
                                                                    BB2 <= {BB2[130:128]+1, BB2[127:0]};

                                                                    next_state <= ReadyState;
                                                                end
                                                        end
                                                    else
                                                        begin
                                                            if(BB[130:128]== 3'b111)
                                                                begin
                                                                    next_state <= Big0State;

                                                                end
                                                            else
                                                                begin
                                                                    BB <= {BB[130:128]+1, BB[127:0]};
                                                                    BB2 <= {BB2[130:128]+1, BB2[127:0]};

                                                                    next_state <= ReadyState;
                                                                end
                                                        end
                                                    ////////////////////////////////
                                                    if({t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]} < BB2[127:0])
                                                        begin
                                                            tind <= 1;
                                                        end
                                                end
                                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                            else
                                                begin
                                                    if({t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]} < BB2[127:0])
                                                        begin

                                                            /////////////////////////////////////////////////////
                                                            if(BB2[130:128]== 3'b111)
                                                                begin
                                                                    BB2 <= {BB2[130:128], t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]};
                                                                    //BB <= {BB[130:128], BB[127:0]};
                                                                    next_state <= Big0State;
                                                                end
                                                            else
                                                                begin
                                                                    BB2 <= {BB2[130:128]+1, t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]};
                                                                    BB <= {BB[130:128]+1, BB[127:0]};

                                                                    next_state <= ReadyState;
                                                                end
                                                            /////////////////////////////////////////////////////////
                                                    
                                                        end
                                                    else
                                                        begin
                                                            if(BB2[130:128] ==3'b111)
                                                                begin
                                                                    next_state <= Big0State;
                                                                end
                                                            else
                                                                begin
                                                                    BB <= {BB[130:128]+1, BB[127:0]};
                                                                    BB2 <= {BB2[130:128]+1, BB2[127:0]};

                                                                    next_state <= ReadyState;
                                                                end

                                                        end
                                                    /////////////////////////////////////////////////////////////
                                                    if({t_iot_out[127:120],t_iot_out[119:112],t_iot_out[111:104],t_iot_out[103:96],t_iot_out[95:88],t_iot_out[87:80],t_iot_out[79:72],t_iot_out[71:64],t_iot_out[63:56],t_iot_out[55:48],t_iot_out[47:40], t_iot_out[39:32], t_iot_out[31:24],t_iot_out[23:16], t_iot_out[15:8], t_iot_out[7:0]} < BB[127:0])
                                                        begin
                                                            tind <= 0;
                                                        end
                                                end
                                        end
                                    ///////////////////////////////////////////////////////////////////////////////////////////
                                    //next_state <= Small0State;
                                end
                            default://Encrypt, Decrypt
                                begin
                                    //PC1IN <= {d16, d15, d14, d13, d12, d11, d10, d9};//mainkey
                                    //TEXT <= {d8, d7, d6, d5, d4, d3, d2, d1};//text
                                    //next_state <= En0State;
                                    //////////////////////////////////////////////////////////////////////
                                    next_state <= En0State;
                                    //t_iot_out <= {t_iot_out[127:64] , 64'b0};//{d16, d15, d14, d13, d12, d11, d10, d9, 64'b0};
                                    ///////////////////////////////////////////////////////
                                    //tenround <= 0;
                                    //enround <=0;

                                    tind <= 0;
                                    ////////////////////////////////////////////////////////
                                    //d9  :0~7
                                    //d10 :8~15
                                    //d11 :16~23
                                    //d12 :24~31
                                    //d13 :32~39
                                    //d14 :40~47
                                    //d15 :48~55
                                    //d16 :56~63
                                    //
                                    //t_iot_out[127:120], d16
                                    //t_iot_out[119:112], d15
                                    //t_iot_out[111:104], d14
                                    //t_iot_out[103:96], d13
                                    //t_iot_out[95:88], d12
                                    //t_iot_out[87:80], d11
                                    //t_iot_out[79:72], d10
                                    //t_iot_out[71:64], d9
                                    //t_iot_out[63:56], d8
                                    //t_iot_out[55:48], d7
                                    //t_iot_out[47:40], d6
                                    //t_iot_out[39:32], d5
                                    //t_iot_out[31:24], d4
                                    //t_iot_out[23:16], d3
                                    //t_iot_out[15:8], d2
                                    //t_iot_out[7:0] , d1
                                    ///////////////////////////////////////////////
                                    BB2[55] <= t_iot_out[71];//t_iot_out[71:64][7];//PC1IN[7];
                                    BB2[54] <= t_iot_out[79];//d10[7];//PC1IN[15];
                                    BB2[53] <= t_iot_out[87];//d11[7];//PC1IN[23];
                                    BB2[52] <= t_iot_out[95];//d12[7];//PC1IN[31];
                                    BB2[51] <= t_iot_out[103];//d13[7];//PC1IN[39];
                                    BB2[50] <= t_iot_out[111];//d14[7];//PC1IN[47];
                                    BB2[49] <= t_iot_out[119];//d15[7];//PC1IN[55];
                                    BB2[48] <= t_iot_out[127];//d16[7];//PC1IN[63];
                                    BB2[47] <= t_iot_out[70];//t_iot_out[71:64][6];//PC1IN[6];
                                    BB2[46] <= t_iot_out[78];//d10[6];//PC1IN[14];
                                    BB2[45] <= t_iot_out[86];//d11[6];//PC1IN[22];
                                    BB2[44] <= t_iot_out[94];//d12[6];//PC1IN[30];
                                    BB2[43] <= t_iot_out[102];//d13[6];//PC1IN[38];
                                    BB2[42] <= t_iot_out[110];//d14[6];//PC1IN[46];
                                    BB2[41] <= t_iot_out[118];//d15[6];//PC1IN[54];
                                    BB2[40] <= t_iot_out[126];//d16[6];//PC1IN[62];
                                    BB2[39] <= t_iot_out[69];//t_iot_out[71:64][5];//PC1IN[5];
                                    BB2[38] <= t_iot_out[77];//d10[5];//PC1IN[13];
                                    BB2[37] <= t_iot_out[85];//d11[5];//PC1IN[21];
                                    BB2[36] <= t_iot_out[93];//d12[5];//PC1IN[29];
                                    BB2[35] <= t_iot_out[101];//d13[5];//PC1IN[37];
                                    BB2[34] <= t_iot_out[109];//d14[5];//PC1IN[45];
                                    BB2[33] <= t_iot_out[117];//d15[5];//PC1IN[53];
                                    BB2[32] <= t_iot_out[125];//d16[5];//PC1IN[61];
                                    BB2[31] <= t_iot_out[68];//t_iot_out[71:64][4];//PC1IN[4];
                                    BB2[30] <= t_iot_out[76];//d10[4];//PC1IN[12];
                                    BB2[29] <= t_iot_out[84];//d11[4];//PC1IN[20];
                                    BB2[28] <= t_iot_out[92];//d12[4];//PC1IN[28];

                                    BB2[27] <= t_iot_out[65];//t_iot_out[71:64][1];//PC1IN[1];
                                    BB2[26] <= t_iot_out[73];//d10[1];//PC1IN[9];
                                    BB2[25] <= t_iot_out[81];//d11[1];//PC1IN[17];
                                    BB2[24] <= t_iot_out[89];//d12[1];//PC1IN[25];
                                    BB2[23] <= t_iot_out[97];//d13[1];//PC1IN[33];
                                    BB2[22] <= t_iot_out[105];//d14[1];//PC1IN[41];
                                    BB2[21] <= t_iot_out[113];//d15[1];//PC1IN[49];
                                    BB2[20] <= t_iot_out[121];//d16[1];//PC1IN[57];


                                    BB2[19] <= t_iot_out[66];//t_iot_out[71:64][2];//PC1IN[2];
                                    BB2[18] <= t_iot_out[74];//d10[2];//PC1IN[10];
                                    BB2[17] <= t_iot_out[82];//d11[2];//PC1IN[18];
                                    BB2[16] <= t_iot_out[90];//d12[2];//PC1IN[26];
                                    BB2[15] <= t_iot_out[98];//d13[2];//PC1IN[34];
                                    BB2[14] <= t_iot_out[106];//d14[2];//PC1IN[42];
                                    BB2[13] <= t_iot_out[114];//d15[2];//PC1IN[50];
                                    BB2[12] <= t_iot_out[122];//d16[2];//PC1IN[58];

                                    BB2[11] <= t_iot_out[67];//t_iot_out[71:64][3];//PC1IN[3];
                                    BB2[10] <= t_iot_out[75];//d10[3];//PC1IN[11];
                                    BB2[9] <= t_iot_out[83];//d11[3];//PC1IN[19];
                                    BB2[8] <= t_iot_out[91];//d12[3];//PC1IN[27];
                                    BB2[7] <= t_iot_out[99];//d13[3];//PC1IN[35];
                                    BB2[6] <= t_iot_out[107];//d14[3];//PC1IN[43];
                                    BB2[5] <= t_iot_out[115];//d15[3];//PC1IN[51];
                                    BB2[4] <= t_iot_out[123];//d16[3];//PC1IN[59];

                                    BB2[3] <= t_iot_out[100];//d13[4];//PC1IN[36];
                                    BB2[2] <= t_iot_out[108];//d14[4];//PC1IN[44];
                                    BB2[1] <= t_iot_out[116];//d15[4];//PC1IN[52];
                                    BB2[0] <= t_iot_out[124];//d16[4];//PC1IN[60];

                                    BB2[130:56] <= 0;
                                    ////////////////////////////////////////
                                    //TEXT <= {d8, d7, d6, d5, d4, d3, d2, d1};//text

                                    ///////////////////
                                    //d1:0~7
                                    //d2:8~15
                                    //d3:16~23
                                    //d4:24~31
                                    //d5:32~39
                                    //d6:40~47
                                    //d7:48~55
                                    //d8:56~63

                                    BB[63] <= t_iot_out[6];//d1[6];//TEXT[6];
                                    BB[62] <= t_iot_out[14];//d2[6];//TEXT[14];
                                    BB[61] <= t_iot_out[22];//d3[6];//TEXT[22];
                                    BB[60] <= t_iot_out[30];
                                    BB[59] <= t_iot_out[38];
                                    BB[58] <= t_iot_out[46];
                                    BB[57] <= t_iot_out[54];
                                    BB[56] <= t_iot_out[62];

                                    BB[55] <= t_iot_out[4];//d1[4];//TEXT[4];
                                    BB[54] <= t_iot_out[12];//d2[4];//TEXT[12];
                                    BB[53] <= t_iot_out[20];//d3[4];//TEXT[20];
                                    BB[52] <= t_iot_out[28];
                                    BB[51] <= t_iot_out[36];
                                    BB[50] <= t_iot_out[44];
                                    BB[49] <= t_iot_out[52];
                                    BB[48] <= t_iot_out[60];

                                    BB[47] <= t_iot_out[2];//d1[2];//TEXT[2];
                                    BB[46] <= t_iot_out[10];//d2[2];//TEXT[10];
                                    BB[45] <= t_iot_out[18];//d3[2];//TEXT[18];
                                    BB[44] <= t_iot_out[26];
                                    BB[43] <= t_iot_out[34];
                                    BB[42] <= t_iot_out[42];
                                    BB[41] <= t_iot_out[50];
                                    BB[40] <= t_iot_out[58];

                                    BB[39] <= t_iot_out[0];//d1[0];//TEXT[0];
                                    BB[38] <= t_iot_out[8];//d2[0];//TEXT[8];
                                    BB[37] <= t_iot_out[16];//d3[0];//TEXT[16];
                                    BB[36] <= t_iot_out[24];
                                    BB[35] <= t_iot_out[32];
                                    BB[34] <= t_iot_out[40];
                                    BB[33] <= t_iot_out[48];
                                    BB[32] <= t_iot_out[56];

                                    BB[31] <= t_iot_out[7];//d1[7];//TEXT[7];
                                    BB[30] <= t_iot_out[15];//d2[7];//TEXT[15];
                                    BB[29] <= t_iot_out[23];//d3[7];//TEXT[23];
                                    BB[28] <= t_iot_out[31];
                                    BB[27] <= t_iot_out[39];
                                    BB[26] <= t_iot_out[47];
                                    BB[25] <= t_iot_out[55];
                                    BB[24] <= t_iot_out[63];

                                    BB[23] <= t_iot_out[5];//d1[5];//TEXT[5];
                                    BB[22] <= t_iot_out[13];//d2[5];//TEXT[13];
                                    BB[21] <= t_iot_out[21];//d3[5];//TEXT[21];
                                    BB[20] <= t_iot_out[29];
                                    BB[19] <= t_iot_out[37];
                                    BB[18] <= t_iot_out[45];
                                    BB[17] <= t_iot_out[53];
                                    BB[16] <= t_iot_out[61];

                                    BB[15] <= t_iot_out[3];//d1[3];//TEXT[3];
                                    BB[14] <= t_iot_out[11];//d2[3];//TEXT[11];
                                    BB[13] <= t_iot_out[19];//d3[3];//TEXT[19];
                                    BB[12] <= t_iot_out[27];
                                    BB[11] <= t_iot_out[35];
                                    BB[10] <= t_iot_out[43];
                                    BB[9] <= t_iot_out[51];
                                    BB[8] <= t_iot_out[59];

                                    BB[7] <= t_iot_out[1];//d1[1];//TEXT[1];
                                    BB[6] <= t_iot_out[9];//d2[1];//TEXT[9];
                                    BB[5] <= t_iot_out[17];
                                    BB[4] <= t_iot_out[25];
                                    BB[3] <= t_iot_out[33];
                                    BB[2] <= t_iot_out[41];
                                    BB[1] <= t_iot_out[49];
                                    BB[0] <= t_iot_out[57];

                                    BB[130:64] <=0;
                                    /////////////////////////////



                                end

                        endcase
                    end
                ////////////////////////////////////////////////
                En0State:
                    begin
                        ///////////////////////////////////////////
                        //cipherupIN <= PC1OUT[27:0];
                        //cipherdownIN <= PC1OUT[55:28];
                        //tenround <= 0;
                        //UPP <= INIP[31:0];
                        //DOWN <= INIP[63:32];
                        //next_state <= En1State;
                        /////////////////////////////////////////////////
                        next_state <= En1State;
                        /////////////////////////////////////////////////////////

                        BB[127:96] <= BB[31:0];


                        /////////////////////////////////////////////////////////

                        case(fn_sel)
                            3'b010://decrypt // right shift
                                begin
                                    case(tind)//tenround
                                        4'b0000:
                                            begin
                                                //cipherupOUT = {cipherupIN[27:1], cipherupIN[0]};
                                                BB2[27:0] <= BB2[27:0];
                                                //////////////////////////
                                                BB2[55:28] <= BB2[55:28];
                                            end
                                        4'b0001:
                                            begin
                                                //cipherupOUT = {cipherupIN[0], cipherupIN[27:1]};
                                                BB2[27:0] <= {BB2[0], BB2[27:1]};
                                                //////////////////////////////////////
                                                BB2[55:28] <= {BB2[28], BB2[55:29]};   
                                            end
                                        4'b1000:
                                            begin
                                                //cipherupOUT = {cipherupIN[0], cipherupIN[27:1]};
                                                BB2[27:0] <= {BB2[0], BB2[27:1]};
                                                BB2[55:28] <= {BB2[28], BB2[55:29]};  
                                            end
                                        4'b1111:
                                            begin
                                                //cipherupOUT = {cipherupIN[0], cipherupIN[27:1]};
                                                BB2[27:0] <= {BB2[0], BB2[27:1]}; 
                                                BB2[55:28] <= {BB2[28], BB2[55:29]};  
                                            end
                                        default:
                                            begin
                                                //cipherupOUT = {cipherupIN[1:0], cipherupIN[27:2]};
                                                BB2[27:0] <= {BB2[1:0], BB2[27:2]};
                                                BB2[55:28] <= {BB2[29:28], BB2[55:30]};

                                            end
                                    endcase
                                end
                            default://encrypt //left shift
                                begin
                                    case(tind)//tenround
                                        4'b0000:
                                            begin
                                                //cipherupOUT = {cipherupIN[26:0], cipherupIN[27]}; 
                                                BB2[27:0] <= {BB2[26:0], BB2[27]};
                                                BB2[55:28] <= {BB2[54:28], BB2[55]};  

                                            end
                                        4'b0001:
                                            begin
                                                //cipherupOUT = {cipherupIN[26:0], cipherupIN[27]};
                                                BB2[27:0] <= {BB2[26:0], BB2[27]};
                                                BB2[55:28] <= {BB2[54:28], BB2[55]};  
                                            end
                                        4'b1000:
                                            begin
                                                //cipherupOUT = {cipherupIN[26:0], cipherupIN[27]};
                                                BB2[27:0] <= {BB2[26:0], BB2[27]};
                                                BB2[55:28] <= {BB2[54:28], BB2[55]};  
                                            end
                                        4'b1111:
                                            begin
                                                //cipherupOUT = {cipherupIN[26:0], cipherupIN[27]};
                                                BB2[27:0] <= {BB2[26:0], BB2[27]};
                                                BB2[55:28] <= {BB2[54:28], BB2[55]};
                                            end
                                        default:
                                            begin
                                                //cipherupOUT = {cipherupIN[25:0], cipherupIN[27:26]};
                                                BB2[27:0] <= {BB2[25:0], BB2[27:26]};
                                                BB2[55:28] <= {BB2[53:28], BB2[55:54]};   
                                            end
                                    endcase
                                end
                        endcase
                        ///////////////////////////////////////////////

                    end
                

                /*
                En1State:
                    begin
                        enround <= tenround;
                        //nDOWN <= UPP;
                        //ncipherupIN <= cipherupOUT;
                        //ncipherdownIN <= cipherdownOUT;
                        //PC2IN <= {cipherdownOUT, cipherupOUT};
                        //EXPIN <= UPP;
                        next_state <= En2State;
                        ///////////////////////////////////////////////////////
                        //bb2 0~27: CIPHERUP
                        //bb2 28~55: cipherdown
                        //bb2 56~103 : key // 48 bit

                        BB2[103] <= BB2[42];//PC2IN[42];
                        BB2[102] <= BB2[39];//PC2IN[39];
                        BB2[101] <= BB2[45];//PC2IN[45];
                        BB2[100] <= BB2[32];//PC2IN[32];
                        BB2[99] <= BB2[55];//PC2IN[55];
                        BB2[98] <= BB2[51];//PC2IN[51];
                        BB2[97] <= BB2[53];//PC2IN[53];
                        BB2[96] <= BB2[28];//PC2IN[28];
                        BB2[95] <= BB2[41];//PC2IN[41];
                        BB2[94] <= BB2[50];//PC2IN[50];
                        BB2[93] <= BB2[35];//PC2IN[35];
                        BB2[92] <= BB2[46];//PC2IN[46];
                        BB2[91] <= BB2[33];//PC2IN[33];
                        BB2[90] <= BB2[37];//PC2IN[37];
                        BB2[89] <= BB2[44];//PC2IN[44];
                        BB2[88] <= BB2[52];//PC2IN[52];
                        BB2[87] <= BB2[30];//PC2IN[30];
                        BB2[86] <= BB2[48];//PC2IN[48];
                        BB2[85] <= BB2[40];//PC2IN[40];
                        BB2[84] <= BB2[49];//PC2IN[49];
                        BB2[83] <= BB2[29];//PC2IN[29];
                        BB2[82] <= BB2[36];//PC2IN[36];
                        BB2[81] <= BB2[43];//PC2IN[43];
                        BB2[80] <= BB2[54];//PC2IN[54];
                        BB2[79] <= BB2[15];//PC2IN[15];
                        BB2[78] <= BB2[4];//PC2IN[4];
                        BB2[77] <= BB2[25];//PC2IN[25];
                        BB2[76] <= BB2[19];//PC2IN[19];
                        BB2[75] <= BB2[9];//PC2IN[9];
                        BB2[74] <= BB2[1];//PC2IN[1];
                        BB2[73] <= BB2[26];//PC2IN[26];
                        BB2[72] <= BB2[16];//PC2IN[16];
                        BB2[71] <= BB2[5];//PC2IN[5];
                        BB2[70] <= BB2[11];//PC2IN[11];
                        BB2[69] <= BB2[23];//PC2IN[23];
                        BB2[68] <= BB2[8];//PC2IN[8];
                        BB2[67] <= BB2[12];//PC2IN[12];
                        BB2[66] <= BB2[7];//PC2IN[7];
                        BB2[65] <= BB2[17];//PC2IN[17];
                        BB2[64] <= BB2[0];//PC2IN[0];
                        BB2[63] <= BB2[22];//PC2IN[22];
                        BB2[62] <= BB2[3];//PC2IN[3];
                        BB2[61] <= BB2[10];//PC2IN[10];
                        BB2[60] <= BB2[14];//PC2IN[14];
                        BB2[59] <= BB2[6];//PC2IN[6];
                        BB2[58] <= BB2[20];//PC2IN[20];
                        BB2[57] <= BB2[27];//PC2IN[27];
                        BB2[56] <= BB2[24];//PC2IN[24];
                        /////////////////////////////////
                        ////////////////////////////////


                        ////////////////////////////////
                        BB[111] <= BB[0];
                        BB[110] <= BB[31];
                        BB[109] <= BB[30];
                        BB[108] <= BB[29];
                        BB[107] <= BB[28];
                        BB[106] <= BB[27];
                        BB[105] <= BB[28];
                        BB[104] <= BB[27];
                        BB[103] <= BB[26];
                        BB[102] <= BB[25];
                        BB[101] <= BB[24];
                        BB[100] <= BB[23];
                        BB[99] <= BB[24];
                        BB[98] <= BB[23];
                        BB[97] <= BB[22];
                        BB[96] <= BB[21];
                        BB[95] <= BB[20];
                        BB[94] <= BB[19];
                        BB[93] <= BB[20];
                        BB[92] <= BB[19];
                        BB[91] <= BB[18];
                        BB[90] <= BB[17];
                        BB[89] <= BB[16];
                        BB[88] <= BB[15];
                        BB[87] <= BB[16];
                        BB[86] <= BB[15];
                        BB[85] <= BB[14];
                        BB[84] <= BB[13];
                        BB[83] <= BB[12];
                        BB[82] <= BB[11];
                        BB[81] <= BB[12];
                        BB[80] <= BB[11];
                        BB[79] <= BB[10];
                        BB[78] <= BB[9];
                        BB[77] <= BB[8];
                        BB[76] <= BB[7];
                        BB[75] <= BB[8];
                        BB[74] <= BB[7];
                        BB[73] <= BB[6];
                        BB[72] <= BB[5];
                        BB[71] <= BB[4];
                        BB[70] <= BB[3];
                        BB[69] <= BB[4];
                        BB[68] <= BB[3];
                        BB[67] <= BB[2];
                        BB[66] <= BB[1];
                        BB[65] <= BB[0];
                        BB[64] <= BB[31];

                        ///////////////////////////////

                    end


                 */   
                En1State:
                    begin
                        //enround <= tenround;
                        next_state <= En2State;
                        //////////////////////////////////
                        //tk <= PC2OUT;
                        //texpout <= EXPOUT;
                        /////////////////////////////////
                        //expout:
                        //bb
                        //s8:64~69 
                        //s7:70~75
                        //s6:76~81
                        //s5:82~87
                        //s4:88~93
                        //s3:94~99
                        //s2:100~105
                        //s1:106~111

                        //tk
                        //bb2
                        //s8:56~61
                        //s7:62~67
                        //s6:68~73
                        //s5:74~79
                        //s4:80~85
                        //s3:86~91
                        //s2:92~97
                        //s1:98~103

                        //////////////////////////////////////////////////////////////////////////////////
                        //P1
                        //31 ->23 ->55
                        //30 ->15 ->47
                        //29 ->9 ->41
                        //28 ->1 ->33

                       
                        

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        case( ( ({BB[31], BB[30], BB[29], BB[28]}) ^ ({BB2[39], BB2[45], BB2[32], BB2[55]}) ) )
                            //S1[4:1] // BB 110, 109, 108, 107 // BB2: 102, 101, 100, 99
                                      // BB  31, 30, 29, 28    // BB2: 39,   45, 32, 55
                            4'b0000:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        //S1[5],S1[0] // BB 111 106 //BB2: 103, 98
                                                      // BB  0   27 //BB2:  42, 51
                                        2'b00:
                                            begin
                                                //P1 = 4'd14;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd0;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd4;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd15;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0001:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd4;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd15;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd1;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd12;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0010:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd13;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd7;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd14;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd8;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0011:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd1;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd4;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd8;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd2;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0100:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd2;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd14;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd13;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd4;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0101:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd15;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd2;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd6;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd9;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0110:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd11;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd13;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd2;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd1;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0111:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd8;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd1;
                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd11;
                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd7;
                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1000:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd3;
                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd10;
                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd15;
                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd5;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1001:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd10;
                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd6;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd12;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd11;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1010:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd6;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd12;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd9;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd3;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1011:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd12;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd11;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd7;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd14;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1100:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd5;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd9;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd3;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd10;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1101:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd9;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd5;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd10;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd0;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1110:
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd0;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd3;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd5;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd6;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            default://4'b1111
                                begin
                                    case( ( ({BB[0], BB[27]}) ^ ({BB2[42], BB2[51]})    )    )
                                        2'b00:
                                            begin
                                                //P1 = 4'd7;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b1 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P1 = 4'd8;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P1 = 4'd0;

                                                BB[87] <= BB[55] ^ 1'b0 ;
                                                BB[79] <= BB[47] ^ 1'b0 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P1 = 4'd13;

                                                BB[87] <= BB[55] ^ 1'b1 ;
                                                BB[79] <= BB[47] ^ 1'b1 ;
                                                BB[73] <= BB[41] ^ 1'b0 ;
                                                BB[65] <= BB[33] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            
                        
                        endcase
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////


                        //expout:
                        //bb
                        //s8:64~69 
                        //s7:70~75
                        //s6:76~81
                        //s5:82~87
                        //s4:88~93
                        //s3:94~99
                        //s2:100~105
                        //s1:106~111

                        //tk
                        //bb2
                        //s8:56~61
                        //s7:62~67
                        //s6:68~73
                        //s5:74~79
                        //s4:80~85
                        //s3:86~91
                        //s2:92~97
                        //s1:98~103
                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        //P2
                        //27 ->19 ->51
                        //26 ->4 ->36
                        //25 ->30 ->62
                        //24 ->14 ->46

                        /////////////////////////////////////////////////////////
                        


                        /////////////////////////////////////////////////////////////////////////////////////////////////
                        case(( ({BB[27],BB[26], BB[25], BB[24]}) ^ ({BB2[28], BB2[41], BB2[50], BB2[35]})      ))
                            //S2[4:1]
                            //bb: 104, 103, 102, 101 //bb2: 96, 95, 94, 93
                            //bb: 27 , 26, 25, 24    //bb2: 28, 41, 50, 35
                            4'b0000:
                                begin
                                    //{S2[5],S2[0]}
                                    //bb:105 ,100    //bb2: 97, 92
                                    //bb:28, 23      //bb2: 53, 46

                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd15;

                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd3;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd0;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd13;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0001:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd1;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd13;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd14;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd8;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end                    
                                    endcase
                 
                                end
                            4'b0010:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd8;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd4;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd7;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd10;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end                    
                                    endcase
                 
                                end
                            4'b0011:
                                begin
                                   case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd14;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd7;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd11;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd1;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end                    
                                    endcase
                 
                                end
                            4'b0100:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd6;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd15;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd10;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd3;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end                    
                                    endcase
                
                                end
                            4'b0101:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd11;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd2;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd4;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd15;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end                    
                                    endcase
                
                                end
                            4'b0110:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd3;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd8;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd13;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd4;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end                    
                                    endcase
                
                                end
                            4'b0111:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd4;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd14;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd1;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd2;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end                    
                                    endcase
                
                                end
                            4'b1000:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd9;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd12;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd5;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd11;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end                    
                                    endcase
                
                                end
                            4'b1001:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd7;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd0;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd8;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd6;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end                    
                                    endcase
                
                                end
                            4'b1010:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd2;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd1;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd12;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd7;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end                    
                                    endcase
                
                                end
                            4'b1011:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd13;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd10;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd6;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd12;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end                    
                                    endcase
                
                                end
                            4'b1100:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd12;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd6;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd9;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd0;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end                    
                                    endcase
                 
                                end
                            4'b1101:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd0;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd9;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd3;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd5;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end                    
                                    endcase
                 
                                end
                            4'b1110:
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd5;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd11;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd2;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd14;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end                    
                                    endcase
                
                                end
                            default://4'b1111
                                begin
                                    case( ({BB[28],BB[23]})  ^ ({BB2[53], BB2[46]})        )
                                        2'b00:
                                            begin
                                                //P2 = 4'd10;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P2 = 4'd5;
                                                BB[83] <= BB[51] ^ 1'b0 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P2 = 4'd15;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b1 ;
                                                BB[94] <= BB[62] ^ 1'b1 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P2 = 4'd9;
                                                BB[83] <= BB[51] ^ 1'b1 ;
                                                BB[68] <= BB[36] ^ 1'b0 ;
                                                BB[94] <= BB[62] ^ 1'b0 ;
                                                BB[78] <= BB[46] ^ 1'b1 ;
                                            end                    
                                    endcase
                 
                                end
                        endcase
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////////



                         //expout:
                        //bb
                        //s8:64~69 
                        //s7:70~75
                        //s6:76~81
                        //s5:82~87
                        //s4:88~93
                        //s3:94~99
                        //s2:100~105
                        //s1:106~111

                        //tk
                        //bb2
                        //s8:56~61
                        //s7:62~67
                        //s6:68~73
                        //s5:74~79
                        //s4:80~85
                        //s3:86~91
                        //s2:92~97
                        //s1:98~103
                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        //P3
                        //23 ->8 ->40
                        //22 ->16 ->48
                        //21 ->2 ->34
                        //20 ->26 ->58
                        ///////////////////////////////////////////////////
                        
                        

                        //////////////////////////////////////////////

                        case( ( ( {BB[23], BB[22], BB[21], BB[20]} ) ^ ( {BB2[37], BB2[44], BB2[52], BB2[30] } ) ) )
                            //S3[4:1]
                            //bb:98, 97, 96, 95   bb2: 90, 89, 88, 87
                            //bb:23, 22, 21. 20,  bb2: 37, 44, 52, 30
                            //
                            4'b0000:
                                //{S3[5],S3[0]}
                                //bb:99, 94   bb2: 91, 86
                                //bb:24, 19   bb2: 33, 48 
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd10;

                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;

                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd13;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd13;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd1;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0001:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd0;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd7;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd6;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd10;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end                    
                                    endcase
                 
                                end
                            4'b0010:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd9;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd0;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd4;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd13;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end                    
                                    endcase
                 
                                end
                            4'b0011:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd14;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd9;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd9;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd0;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end                    
                                    endcase
                 
                                end
                            4'b0100:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd6;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd3;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd8;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd6;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end                    
                                    endcase
                
                                end
                            4'b0101:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd3;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd4;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd15;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd9;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end                    
                                    endcase
                
                                end
                            4'b0110:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd15;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd6;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd3;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd8;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end                    
                                    endcase
                
                                end
                            4'b0111:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd5;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd10;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd0;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd7;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end                    
                                    endcase
                
                                end
                            4'b1000:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd1;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd2;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd11;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd4;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end                    
                                    endcase
                
                                end
                            4'b1001:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd13;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd8;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd1;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd15;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end                    
                                    endcase
                
                                end
                            4'b1010:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd12;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd5;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd2;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd14;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end                    
                                    endcase
                
                                end
                            4'b1011:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd7;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd14;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd12;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd3;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end                    
                                    endcase
                
                                end
                            4'b1100:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd11;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd12;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd5;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd11;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end                    
                                    endcase
                 
                                end
                            4'b1101:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd4;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd11;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd10;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd5;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end                    
                                    endcase
                 
                                end
                            4'b1110:
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd2;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd15;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd14;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd2;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end                    
                                    endcase
                
                                end
                            default://4'b1111
                                begin
                                    case(  (  ({BB[24], BB[19]}) ^ ({BB2[33], BB2[48]})   )            )
                                        2'b00:
                                            begin
                                                //P3 = 4'd8;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P3 = 4'd1;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b0 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P3 = 4'd7;
                                                BB[72] <= BB[40] ^ 1'b0 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b1 ;
                                                BB[90] <= BB[58] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P3 = 4'd12;
                                                BB[72] <= BB[40] ^ 1'b1 ;
                                                BB[80] <= BB[48] ^ 1'b1 ;
                                                BB[66] <= BB[34] ^ 1'b0 ;
                                                BB[90] <= BB[58] ^ 1'b0 ;
                                            end                    
                                    endcase
                 
                                end
                        endcase
                        ////////////////////////////////////////////////////////////////////////////////





                        //expout:
                        //bb
                        //s8:64~69 
                        //s7:70~75
                        //s6:76~81
                        //s5:82~87
                        //s4:88~93
                        //s3:94~99
                        //s2:100~105
                        //s1:106~111

                        //tk
                        //bb2
                        //s8:56~61
                        //s7:62~67
                        //s6:68~73
                        //s5:74~79
                        //s4:80~85
                        //s3:86~91
                        //s2:92~97
                        //s1:98~103

                        /////////////////////////////////////////////////////
                        //P4
                        //19 ->6 ->38
                        //18 ->12 ->44
                        //17 ->22 ->54
                        //16 ->31 ->63
                        ///////////////////////////////////////////////////////////////////////////////


                        

                        case( ( ({BB[19], BB[18], BB[17], BB[16]}) ^ ({BB2[49], BB2[29], BB2[36], BB2[43]})       )  )
                            //S4[4:1]
                            //BB:92 91 90 89      //BB2:84, 83, 82, 81
                            //BB:19, 18, 17, 16   //BB2:49, 29, 36, 43
                            4'b0000:
                                //S4[5],S4[0]
                                //bb:93, 88   //bb2:85, 80
                                //bb:20, 15   //bb2:40, 54
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd7;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd13;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd10;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd3;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0001:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd13;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd8;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd6;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd15;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0010:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd14;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd11;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd9;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd0;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0011:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd3;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd5;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd0;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd6;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0100:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd0;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd6;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd12;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd10;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0101:
                                begin
                                   case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd6;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd15;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd11;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd1;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0110:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd9;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd0;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd7;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd13;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0111:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd10;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd3;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd13;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd8;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1000:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd1;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd4;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd15;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd9;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1001:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd2;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd7;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd1;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd4;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1010:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd8;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd2;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd3;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd5;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1011:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd5;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd12;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd14;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd11;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1100:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd11;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd1;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd5;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd12;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1101:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd12;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd10;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd2;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd7;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1110:
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd4;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd14;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd8;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd2;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            default://4'b1111
                                begin
                                    case( ( ({BB[20], BB[15]}) ^ ({BB2[40], BB2[54]}) )  )
                                        2'b00:
                                            begin
                                                //P4 = 4'd15;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P4 = 4'd9;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b0 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P4 = 4'd4;
                                                BB[70] <= BB[38] ^ 1'b0 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b0 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P4 = 4'd14;
                                                BB[70] <= BB[38] ^ 1'b1 ;
                                                BB[76] <= BB[44] ^ 1'b1 ;
                                                BB[86] <= BB[54] ^ 1'b1 ;
                                                BB[95] <= BB[63] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                        endcase
                        /////////////////////////////////////////////////////////////////////////////////



                        //expout:
                        //bb
                        //s8:64~69 
                        //s7:70~75
                        //s6:76~81
                        //s5:82~87
                        //s4:88~93
                        //s3:94~99
                        //s2:100~105
                        //s1:106~111

                        //tk
                        //bb2
                        //s8:56~61
                        //s7:62~67
                        //s6:68~73
                        //s5:74~79
                        //s4:80~85
                        //s3:86~91
                        //s2:92~97
                        //s1:98~103


                        ///////////////////////////////////////////////////
                        //P5
                        //15 ->24 ->56
                        //14 ->18 ->50
                        //13 ->7 ->39
                        //12 ->29 ->61
                        /////////////////////////////////

                        


                        /////////////////////////////////////////////////////////////////////////////////

                        case( ( ({BB[15], BB[14], BB[13], BB[12]}) ^ ({BB2[4], BB2[25], BB2[19], BB2[9]})       )  )
                            //s5 4:1
                            //bb:86, 85, 84, 83  //bb2: 78, 77, 76, 75
                            //bb:15, 14, 13, 12  //bb2:  4, 25, 19, 9
                            4'b0000:
                                //s5 5 0
                                //bb:87, 82     //bb2:79, 74
                                //bb:16, 11     //bb2:15, 1
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        
                                        2'b00:
                                            begin
                                                //P5 = 4'd2;

                                                BB[88] <= BB[56] ^ 1'b0;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd14;

                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;


                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd4;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd11;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0001:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd12;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd11;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd2;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd8;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0010:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd4;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd2;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd1;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd12;

                                                BB[88] <= BB[56] ^ 1'b1;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0011:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd1;

                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd12;

                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd11;

                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd7;

                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0100:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd7;

                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd4;

                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd10;

                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd1;

                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0101:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd10;

                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd7;

                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd13;

                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd14;

                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0110:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd11;

                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd13;

                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd7;

                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd2;

                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0111:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd6;

                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd1;

                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd8;

                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd13;

                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1000:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd8;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd5;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd15;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd6;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1001:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd5;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd0;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd9;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd15;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1010:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd3;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd15;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd12;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd0;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1011:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd15;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd10;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd5;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd9;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1100:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd13;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd3;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd6;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd10;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1101:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd0;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd9;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd3;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd4;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1110:
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd14;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd8;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd0;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd5;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            default://4'b1111
                                begin
                                    case( ( ({BB[16], BB[11]}) ^ ({BB2[15], BB2[1]}) )  )
                                        2'b00:
                                            begin
                                                //P5 = 4'd9;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b0 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P5 = 4'd6;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P5 = 4'd14;
                                                BB[88] <= BB[56] ^ 1'b1 ;
                                                BB[82] <= BB[50] ^ 1'b1 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P5 = 4'd3;
                                                BB[88] <= BB[56] ^ 1'b0 ;
                                                BB[82] <= BB[50] ^ 1'b0 ;
                                                BB[71] <= BB[39] ^ 1'b1 ;
                                                BB[93] <= BB[61] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                        endcase
                        //////////////////////////////////////////////////




                        //expout:
                        //bb
                        //s8:64~69 
                        //s7:70~75
                        //s6:76~81
                        //s5:82~87
                        //s4:88~93
                        //s3:94~99
                        //s2:100~105
                        //s1:106~111

                        //tk
                        //bb2
                        //s8:56~61
                        //s7:62~67
                        //s6:68~73
                        //s5:74~79
                        //s4:80~85
                        //s3:86~91
                        //s2:92~97
                        //s1:98~103
                        /////////////////////////////////////////////////////////////////
                        //s6 4:0
                        //bb:80 79 78 77  //bb2:72 71 70 69
                        //bb:11 10 9  8   //bb2:16 5 11 23

                        ////////////////////////////////////////////////////
                        //P6
                        //11 ->28 ->60
                        //10 ->3 ->35
                        //9 ->21 ->53
                        //8 ->13 ->45

                        /////////////////////////////

                       

                        case( ( ({BB[11], BB[10], BB[9], BB[8]}) ^ ({BB2[16], BB2[5], BB2[11], BB2[23]})       )  )
                            //s6 5 0
                            //bb:81 76  //bb2:73 68
                            //bb:12  7  //bb2:26 8
                            4'b0000:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd12;
                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;

                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd10;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd9;
                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd4;
                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0001:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd1;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd15;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd14;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd3;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0010:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd10;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd4;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd15;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd2;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0011:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd15;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd2;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd5;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd12;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0100:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd9;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd7;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd2;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd9;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0101:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd2;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd12;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd8;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd5;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0110:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd6;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd9;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd12;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd15;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0111:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd8;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd5;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd3;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd10;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1000:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd0;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd6;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd7;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd11;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1001:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd13;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd1;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd0;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd14;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1010:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd3;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd13;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd4;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd1;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1011:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd4;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd14;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd10;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd7;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1100:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd14;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd0;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd1;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd6;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1101:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd7;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd11;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd13;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd0;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1110:
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd5;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd3;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd11;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd8;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            default://4'b1111
                                begin
                                    case( ( ({BB[12], BB[7]}) ^ ({BB2[26], BB2[8]}) )  )
                                        2'b00:
                                            begin
                                                //P6 = 4'd11;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P6 = 4'd8;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b0 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P6 = 4'd6;

                                                BB[92] <= BB[60] ^ 1'b0 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b1 ;
                                                BB[77] <= BB[45] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P6 = 4'd13;

                                                BB[92] <= BB[60] ^ 1'b1 ;
                                                BB[67] <= BB[35] ^ 1'b1 ;
                                                BB[85] <= BB[53] ^ 1'b0 ;
                                                BB[77] <= BB[45] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                        endcase
                        /////////////////////////////////////////////////////////////////////////////

                        //expout:
                        //bb
                        //s8:64~69 
                        //s7:70~75
                        //s6:76~81
                        //s5:82~87
                        //s4:88~93
                        //s3:94~99
                        //s2:100~105
                        //s1:106~111

                        //tk
                        //bb2
                        //s8:56~61
                        //s7:62~67
                        //s6:68~73
                        //s5:74~79
                        //s4:80~85
                        //s3:86~91
                        //s2:92~97
                        //s1:98~103
                        //////////////////////////
                        //s7 4 :1
                        //bb:74 73 72 71  //bb2:66 65 64 63
                        //bb:7  6  5  4   //bb2:7  17 0 22


                        //////////////////////////////////////////////////////////////
                        //P7
                        //7 ->0 ->32
                        //6 ->20 ->52
                        //5 ->10 ->42
                        //4 ->25 ->57


                        

                        ///////////////////////////////////////////////////////////////////////////////
                        case( ( ({BB[7], BB[6], BB[5], BB[4]}) ^ ({BB2[7], BB2[17], BB2[0], BB2[22]})       )  )
                            //s7 5 0
                            //bb:75 70    //bb2:67 62
                            //bb:8   3    //bb2:12 3
                            4'b0000:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd4;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd13;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd1;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd6;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0001:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd11;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd0;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd4;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd11;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0010:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd2;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd11;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd11;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd13;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0011:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd14;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd7;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd13;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd8;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0100:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd15;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd4;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd12;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd1;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0101:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd0;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd9;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd3;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd4;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0110:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd8;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd1;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd7;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd10;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0111:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd13;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd10;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd14;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd7;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1000:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd3;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd14;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd10;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd9;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1001:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd12;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd3;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd15;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd5;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1010:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd9;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd5;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd6;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd0;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1011:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd7;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd12;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd8;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd15;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1100:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd5;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd2;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd0;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd14;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1101:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd10;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd15;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd5;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd2;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1110:
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd6;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd8;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd9;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd3;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            default://4'b1111
                                begin
                                    case( ( ({BB[8], BB[3]}) ^ ({BB2[12], BB2[3]}) )  )
                                        2'b00:
                                            begin
                                                //P7 = 4'd1;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P7 = 4'd6;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P7 = 4'd2;
                                                BB[64] <= BB[32] ^ 1'b0 ;
                                                BB[84] <= BB[52] ^ 1'b0 ;
                                                BB[74] <= BB[42] ^ 1'b1 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P7 = 4'd12;
                                                BB[64] <= BB[32] ^ 1'b1 ;
                                                BB[84] <= BB[52] ^ 1'b1 ;
                                                BB[74] <= BB[42] ^ 1'b0 ;
                                                BB[89] <= BB[57] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                        endcase

                        //////////////////////////////////////////////////////




                         //expout:
                        //bb
                        //s8:64~69 
                        //s7:70~75
                        //s6:76~81
                        //s5:82~87
                        //s4:88~93
                        //s3:94~99
                        //s2:100~105
                        //s1:106~111

                        //tk
                        //bb2
                        //s8:56~61
                        //s7:62~67
                        //s6:68~73
                        //s5:74~79
                        //s4:80~85
                        //s3:86~91
                        //s2:92~97
                        //s1:98~103
                        /////////////////////////////////////////////////////////
                        
                        //s8 4:1
                        //bb:68 67 66 65  //bb2:60 59 58 57
                        //bb:3  2  1  0   //bb2:14 6 20 27
                        //////////////////////////////////////////



                        //p8
                        //3 ->27 ->59
                        //2 ->5 ->37
                        //1 ->17 ->49
                        //0 ->11 ->43



                        ////////////////////////////////////
                        


                        case( ( ({BB[3], BB[2], BB[1], BB[0]}) ^ ({BB2[14], BB2[6], BB2[20], BB2[27]})       )  )
                            //s8 5 0
                            //bb:69 64   //bb2:61 56
                            //bb:4  31   //bb2:10 24
                            4'b0000:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd13;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd1;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;

                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd7;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd2;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0001:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd2;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd15;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd11;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd1;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0010:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd8;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd13;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd4;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd14;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0011:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd4;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd8;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd1;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd7;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b0100:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd6;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd10;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd9;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd4;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0101:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd15;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd3;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd12;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd10;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0110:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd11;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd7;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd14;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd8;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b0111:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd1;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd4;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd2;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd13;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1000:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd10;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd12;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd0;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd15;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1001:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd9;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd5;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd6;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd12;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1010:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd3;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd6;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd10;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd9;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1011:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd14;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd11;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd13;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd0;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            4'b1100:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd5;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd0;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd15;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd3;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1101:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd0;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd14;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd3;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd5;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                            4'b1110:
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd12;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd9;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd5;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd6;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end                    
                                    endcase
                                end
                            default://4'b1111
                                begin
                                    case( ( ({BB[4], BB[31]}) ^ ({BB2[10], BB2[24]}) )  )
                                        2'b00:
                                            begin
                                                //P8 = 4'd7;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b1 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end
                                        2'b01:
                                            begin
                                                //P8 = 4'd2;
                                                BB[91] <= BB[59] ^ 1'b0 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b10:
                                            begin
                                                //P8 = 4'd8;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b0 ;
                                                BB[75] <= BB[43] ^ 1'b0 ;
                                            end
                                        2'b11:
                                            begin
                                                //P8 = 4'd11;
                                                BB[91] <= BB[59] ^ 1'b1 ;
                                                BB[69] <= BB[37] ^ 1'b0 ;
                                                BB[81] <= BB[49] ^ 1'b1 ;
                                                BB[75] <= BB[43] ^ 1'b1 ;
                                            end                    
                                    endcase
                                end
                        endcase
                        ///////////////////////////////////////////////////////////////////////////////






                        //next_state <= En3State;
                    end

                /*    
                En3State:
                    begin
                        S1 <= SS[47:42];
                        S2 <= SS[41:36];
                        S3 <= SS[35:30];
                        S4 <= SS[29:24];
                        S5 <= SS[23:18];    
                        S6 <= SS[17:12];
                        S7 <= SS[11:6];
                        S8 <= SS[5:0];

                        next_state <= En4State;
                    end
                
                En4State:
                    begin
                        P <= {P1, P2, P3, P4, P5, P6, P7, P8};

                        next_state <= En5State;
                    end

                */    
                //En5State:
                //    begin
                //        tfout <= FOUT;
                //        tdown <= DOWN;

                //        next_state <= En6State;
                //    end

                En2State:
                    begin
                        case(tind)//enround
                            4'b1111:
                                begin
                                    //UPP <= nDOWN;
                                    //DOWN <= nUPP;
                                    //enround <= 0;

                                    //B[31:0] <= BB[127:96];
                                    //BB[63:32] <= BB[95:64];
                                    
                                    //next_state <= En7State;
                                    next_state <= ReadyState;
                                    t_valid <=1;


                                    

                                    t_iot_out[63] <= BB[120];
                                    t_iot_out[62] <= BB[88];
                                    t_iot_out[61] <= BB[112];
                                    t_iot_out[60] <= BB[80];
                                    t_iot_out[59] <= BB[104];
                                    t_iot_out[58] <= BB[72];
                                    t_iot_out[57] <= BB[96];
                                    t_iot_out[56] <= BB[64];
                                    t_iot_out[55] <=  BB[121];
                                    t_iot_out[54] <= BB[89];
                                    t_iot_out[53] <= BB[113];

                                    t_iot_out[52] <= BB[81];
                                    t_iot_out[51] <= BB[105];
                                    t_iot_out[50] <= BB[73];
                                    t_iot_out[49] <= BB[97];
                                    t_iot_out[48] <= BB[65];

                                    t_iot_out[47] <= BB[122];
                                    t_iot_out[46] <= BB[90];
                                    t_iot_out[45] <= BB[114];
                                    t_iot_out[44] <= BB[82];
                                    t_iot_out[43] <= BB[106];
                                    t_iot_out[42] <= BB[74];

                                    t_iot_out[41] <= BB[98];
                                    t_iot_out[40] <= BB[66];


                                    t_iot_out[39] <= BB[123];
                                    t_iot_out[38] <= BB[91];
                                    t_iot_out[37] <= BB[115];
                                    t_iot_out[36] <= BB[83];

                                    t_iot_out[35] <= BB[107];
                                    t_iot_out[34] <= BB[75];
                                    t_iot_out[33] <= BB[99];
                                    t_iot_out[32] <= BB[67];
                                    t_iot_out[31] <= BB[124];

                                    t_iot_out[30] <= BB[92];
                                    t_iot_out[29] <= BB[116];
                                    t_iot_out[28] <= BB[84];
                                    t_iot_out[27] <= BB[108];
                                    t_iot_out[26] <= BB[76];
                                    t_iot_out[25] <= BB[100];
                                    t_iot_out[24] <= BB[68];
                                    t_iot_out[23] <= BB[125];
                                    t_iot_out[22] <= BB[93];
                                    t_iot_out[21] <= BB[117];
                                    t_iot_out[20] <= BB[85];

                                    t_iot_out[19] <= BB[109];
                                    t_iot_out[18] <= BB[77];
                                    t_iot_out[17] <= BB[101];
                                    t_iot_out[16] <= BB[69];
                                    t_iot_out[15] <= BB[126];

                                    t_iot_out[14] <= BB[94];
                                    t_iot_out[13] <= BB[118];

                                    t_iot_out[12] <= BB[86];
                                    t_iot_out[11] <= BB[110];
                                    t_iot_out[10] <= BB[78];
                                    t_iot_out[9] <= BB[102];

                                    t_iot_out[8] <= BB[70];
                                    t_iot_out[7] <= BB[127];

                                    t_iot_out[6] <= BB[95];
                                    t_iot_out[5] <= BB[119];

                                    t_iot_out[4] <= BB[87];
                                    t_iot_out[3] <= BB[111];
                                    t_iot_out[2] <= BB[79];
                                    t_iot_out[1] <= BB[103];
                                    t_iot_out[0] <= BB[71];
                                   

                                end
                            default:
                                begin
                                    BB[31:0] <= BB[95:64];
                                    BB[63:32] <= BB[127:96];

                                    /////////////////////////////////////////////////
                                    //UPP <= nUPP;
                                    //DOWN <= nDOWN;

                                    //cipherupIN <= ncipherupIN;
                                    //cipherdownIN <= ncipherdownIN;

                                    //tenround <= enround +1;
                                    tind <= tind +1;
                                    //next_state <= En1State;
                                    next_state <= En0State;
                                end
                        endcase
                       
                    end
                //En7State:
                //    begin
                //        FINR <= {DOWN, UPP};
                //        next_state <= En8State;
                //    end
                //En8State:
                //    begin
                //        t_iot_out <= {PC1IN,FINP};
                //        t_valid <=1;

                //        next_state <= ReadyState;//En9State;
                //    end
                
                ////////////////////////////////////////////////////
                CR0State:
                    begin

                        //flush <=0;
                        /////////////////////////////////////////////////
                        //if(stop)
                        //    begin
                        //        t_iot_out <= {125'b0,tCC[2:0]};
                        //        t_valid <=1;
                        //        next_state <= ReadyState;//CR1State;
                        //    end
                        //else
                        //    begin
                        //        if(move)
                        //            begin
                        //                tBB <= {tCC[2:0], BB[tind]};
                        //            end
                        //        else
                        //            begin
                        //                tBB <= tCC;
                        //            end

                        //        ind <= tind;
                        //        next_state <= CR0State;
                        //    end
                        ////////////////////////////////////////////////////////
                        if(tind>3)
                        begin

                        case (BB[(tind-1) -:3])
                            3'b000:
                                begin
                                    BB[(tind)] <= 0;
                                    BB[(tind-1)] <= 1;
                                    BB[(tind-2)] <= 1;
                                    BB[(tind-3)] <= 0;

                                    

                                    tind <= tind -1;
                                    next_state <= CR0State;
                                end
                            3'b001:
                                begin
                                    BB[(tind)] <= 0;
                                    BB[(tind-1)] <= 1;
                                    BB[(tind-2)] <= 1;
                                    BB[(tind-3)] <= 1;

                                    tind <= tind -1;

                                    next_state <= CR0State;
                                end
                            3'b010:
                                begin
                                    BB[(tind)] <= 0;
                                    BB[(tind-1)] <= 1;
                                    BB[(tind-2)] <= 0;
                                    BB[(tind-3)] <= 0;

                                    tind <= tind -1;

                                    next_state <= CR0State;
                                end
                            3'b011:
                                begin
                                    BB[(tind)] <= 0;
                                    BB[(tind-1)] <= 1;
                                    BB[(tind-2)] <= 0;
                                    BB[(tind-3)] <= 1;

                                    tind <= tind -1;

                                    next_state <= CR0State;
                                end
                            3'b100:
                                begin
                                    BB[(tind)] <= 0;
                                    BB[(tind-1)] <= 0;
                                    BB[(tind-2)] <= 1;
                                    BB[(tind-3)] <= 0;

                                    tind <= tind -2;

                                    next_state <= CR0State;
                                end
                            3'b101:
                                begin
                                    BB[(tind)] <= 0;
                                    BB[(tind-1)] <= 0;
                                    BB[(tind-2)] <= 1;
                                    BB[(tind-3)] <= 1;

                                    tind <= tind -2;

                                    next_state <= CR0State;
                                end
                            3'b110:
                                begin
                                    BB[(tind)] <= 0;
                                    BB[(tind-1)] <= 0;
                                    BB[(tind-2)] <= 0;
                                    BB[(tind-3)] <= 0;

                                    tind <= tind -4;

                                    next_state <= CR1State;
                                end
                            default:
                                begin
                                    BB[(tind)] <= 0;
                                    BB[(tind-1)] <= 0;
                                    BB[(tind-2)] <= 0;
                                    BB[(tind-3)] <= 1;

                                    tind <= tind -3;

                                    next_state <= CR0State;
                                end
                        endcase
                        ///////////////////////////////////////////////////////
                        end
                        else if(tind ==3)
                        begin
                            //ans <= (BB[(tind-1) -:3]) ^ 3'b110;
                            //next_state <= CR2State;
                            /////////////////////////////////////////////
                            t_iot_out <= {125'b0, ((BB[(tind-1) -:3]) ^ 3'b110)};
                            t_valid <=1;
                            next_state <= ReadyState;
                        end
                        else
                        begin
                            //ans <= BB[2:0];
                            //next_state <= CR2State;
                            /////////////////////////////////
                            t_iot_out <= {125'b0, BB[2:0] };
                            
                            t_valid <=1;
                            next_state <= ReadyState;
                        end


                        
                    end
                CR1State:
                    begin
                        
                        if(BB[tind]==1)
                            begin
                                next_state <= CR0State;
                                //ind <= tind;
                            end
                        else
                            begin
                                if(tind <4)
                                    begin
                                        //ans <= BB[2:0];
                                        //next_state <= CR2State;
                                        /////////////////////////////////////
                                        t_iot_out <= {125'b0, BB[2:0] };
                                        t_valid <=1;

                                        next_state <= ReadyState;
                                        
                                    end
                                else
                                    begin
                                        next_state <= CR1State;
                                        tind <= tind -1;
                                    end
                            end
                    end

                //CR2State:
                //    begin
                //        t_iot_out <= {125'b0, ans};
                //        t_valid <=1;

                //        next_state <= ReadyState;
                //    end
               
                //////////////////////////////////////////////////////
                //Big0State:
                //    begin
                        
                        //////////////////////////////////

                        //if(newd > cand[smind])
                        //    begin
                        //        cand[smind] <= newd;

                        //        if(newd > cand[~smind])
                        //            begin
                        //                smind <= ~smind;
                        //            end
                        //    end
                //        next_state <= Big1State;
                //    end
                //////////////////////////////////////////////////////////
                Big0State:
                    begin
                        /////////////////////////////////////
                        //if(count == 3'b111)
                        //    begin
                        //        t_iot_out <= cand[~smind];
                        //        t_valid <=1;
                                
                        //        next_state <= Big2State;
                        //    end
                        //else
                        //    begin
                        //         count <= count +1;

                        //         next_state <= ReadyState;
                        //    end
                        ///////////////////////////////////////
                        if(tind ==0)
                            begin
                                t_iot_out <= BB2;
                                t_valid <=1;
                            end
                        else
                            begin
                                t_iot_out <= BB;
                                t_valid <=1;
                            end

                        next_state <= Big1State;
                    end
                Big1State:
                    begin
                        //t_iot_out <= cand[smind];
                        //t_valid <=1;
                        
                        //count <=0;
                        //cand[0] <=0;
                        //cand[1] <=0;

                        //next_state <= ReadyState;
                        ////////////////////////
                        if(tind ==0)
                            begin
                                t_iot_out <= BB;
                                t_valid <=1;
                            end
                        else
                            begin
                                t_iot_out <= BB2;
                                t_valid <=1;
                            end

                        BB <=0;
                        BB2 <=0;

                        tind <=0;

                        next_state <= ReadyState;

                    end
                //////////////////////////////////////////////////////////////
                //Small0State:
                //    begin
                        //flush <=0;
                        ////////////////////////////////////////////////
                        //if(count==3'b000)
                        //    begin
                        //        cand[0] <= newd;
                        //    end
                        //else if(count == 3'b001)
                        //    begin
                        //        cand[1] <= newd;

                        //        if(newd >cand[0])
                        //            begin
                        //                smind <=1;//bigind
                        //            end
                        //        else
                        //            begin
                        //                smind <=0;//bigind
                        //            end
                        //    end
                        //else
                        //    begin
                        //        if(newd < cand[smind])//bigind
                        //            begin
                        //                cand[smind] <= newd;//bigind

                        //                if(newd < cand[~smind])//bigind
                        //                    begin
                        //                        smind <= ~smind;//bigind
                        //                    end
                        //            end
                        //    end
                        ////////////////////////////////////////////////////

                        
                //        next_state <= Small1State;
                //    end
                //Small0State:
                //    begin
                //        if(count == 3'b111)
                //            begin
                //                t_iot_out <= cand[~smind];//bigind
                //                t_valid <=1;
                                
                //                next_state <= Small2State;
                //            end
                //        else
                //            begin
                //                 count <= count +1;
                //                 next_state <= ReadyState;
                //            end
                //    end
                //
                //Small1State:
                //    begin
                //        t_iot_out <= cand[smind];//bigind
                //        t_valid <=1;

                        ///////////////////////
                //        count <=0;
                //        cand[0] <=0;
                //        cand[1] <=0;


                //        next_state <= ReadyState;
                //    end
                //////////////////////////////////////////////////////////////

            endcase

        end
end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                     COMBINATIONAL
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                   CRC
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//always@(*)
//begin
//    tCC = tAA ^ tBB;

//    if(tCC[3]==0)
//        begin
//            move =1;
//            if(ind==0)
//                begin
//                    stop =1;
//                    tind = 0;
//                end
//            else
//                begin
//                    tind = ind -1;
//                    stop =0;
//                end
//        end
//    else
//        begin
//            move =0;
//            stop =0;
//            tind = ind;
//        end
//end
//////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                      FSM
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always@(next_state)
begin
    state = next_state;
end

//always@(next_state2)
//begin
//    state2 = next_state2;
//end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                     ENCRIPT
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////
//          For final output of downstream
////////////////////////////////////////////////////
//always@(*)
//begin
//    nUPP = tfout ^ tdown;
//end
//////////////////////////////////////////////////////


//////////////////////////////////////////////////////
//       For before S BOX preparation
//////////////////////////////////////////////////////
/*
always@(*)
begin
    SS = texpout ^ tk;
end
*/
///////////////////////////////////////////////////////
//               circulat shift Left  
///////////////////////////////////////////////////////

/*
always@(*)
begin

    case(fn_sel)
        3'b010:
            begin
                case(tenround)
                    4'b0000:
                        begin
                            cipherupOUT = {cipherupIN[27:1], cipherupIN[0]}; 
                        end
                    4'b0001:
                        begin
                            cipherupOUT = {cipherupIN[0], cipherupIN[27:1]}; 
                        end
                    4'b1000:
                        begin
                            cipherupOUT = {cipherupIN[0], cipherupIN[27:1]}; 
                        end
                    4'b1111:
                        begin
                            cipherupOUT = {cipherupIN[0], cipherupIN[27:1]}; 
                        end
                    default:
                        begin
                            cipherupOUT = {cipherupIN[1:0], cipherupIN[27:2]}; 
                        end
                endcase
            end
        default:
            begin
                case(tenround)
                    4'b0000:
                        begin
                            cipherupOUT = {cipherupIN[26:0], cipherupIN[27]};  
                        end
                    4'b0001:
                        begin
                            cipherupOUT = {cipherupIN[26:0], cipherupIN[27]};  
                        end
                    4'b1000:
                        begin
                            cipherupOUT = {cipherupIN[26:0], cipherupIN[27]};  
                        end
                    4'b1111:
                        begin
                           cipherupOUT = {cipherupIN[26:0], cipherupIN[27]};
                        end
                    default:
                        begin
                            cipherupOUT = {cipherupIN[25:0], cipherupIN[27:26]}; 
                        end
                endcase
            end
    endcase
end

always@(*)
begin
    case(fn_sel)
        3'b010:
            begin
                case(tenround)
                    4'b0000:
                        begin
                            cipherdownOUT = {cipherdownIN[27:1], cipherdownIN[0]}; 
                        end
                    4'b0001:
                        begin
                            cipherdownOUT = {cipherdownIN[0], cipherdownIN[27:1]}; 
                        end
                    4'b1000:
                        begin
                            cipherdownOUT = {cipherdownIN[0], cipherdownIN[27:1]}; 
                        end
                    4'b1111:
                        begin
                            cipherdownOUT = {cipherdownIN[0], cipherdownIN[27:1]}; 
                        end
                    default:
                        begin
                            cipherdownOUT = {cipherdownIN[1:0], cipherdownIN[27:2]}; 
                        end
                endcase
            end
        default:
            begin
                 case(tenround)
                    4'b0000:
                        begin
                            cipherdownOUT = {cipherdownIN[26:0], cipherdownIN[27]};  
                        end
                    4'b0001:
                        begin
                            cipherdownOUT = {cipherdownIN[26:0], cipherdownIN[27]};  
                        end
                    4'b1000:
                        begin
                            cipherdownOUT = {cipherdownIN[26:0], cipherdownIN[27]};  
                        end
                    4'b1111:
                        begin
                           cipherdownOUT = {cipherdownIN[26:0], cipherdownIN[27]};
                        end
                    default:
                        begin
                            cipherdownOUT = {cipherdownIN[25:0], cipherdownIN[27:26]}; 
                        end
                endcase
            end
    endcase
end


*/
////////////////////////////////////////////////////////////////////////
//                        LUT
///////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//                      EXPANSION
////////////////////////////////////////////////////////////////////////

/*
always@(*)
begin
    EXPOUT[47] = EXPIN[0];
    EXPOUT[46] = EXPIN[31];
    EXPOUT[45] = EXPIN[30];
    EXPOUT[44] = EXPIN[29];
    EXPOUT[43] = EXPIN[28];
    EXPOUT[42] = EXPIN[27];
    EXPOUT[41] = EXPIN[28];
    EXPOUT[40] = EXPIN[27];
    EXPOUT[39] = EXPIN[26];
    EXPOUT[38] = EXPIN[25];
    EXPOUT[37] = EXPIN[24];
    EXPOUT[36] = EXPIN[23];
    EXPOUT[35] = EXPIN[24];
    EXPOUT[34] = EXPIN[23];
    EXPOUT[33] = EXPIN[22];
    EXPOUT[32] = EXPIN[21];
    EXPOUT[31] = EXPIN[20];
    EXPOUT[30] = EXPIN[19];
    EXPOUT[29] = EXPIN[20];
    EXPOUT[28] = EXPIN[19];
    EXPOUT[27] = EXPIN[18];
    EXPOUT[26] = EXPIN[17];
    EXPOUT[25] = EXPIN[16];
    EXPOUT[24] = EXPIN[15];
    EXPOUT[23] = EXPIN[16];
    EXPOUT[22] = EXPIN[15];
    EXPOUT[21] = EXPIN[14];
    EXPOUT[20] = EXPIN[13];
    EXPOUT[19] = EXPIN[12];
    EXPOUT[18] = EXPIN[11];
    EXPOUT[17] = EXPIN[12];
    EXPOUT[16] = EXPIN[11];
    EXPOUT[15] = EXPIN[10];
    EXPOUT[14] = EXPIN[9];
    EXPOUT[13] = EXPIN[8];
    EXPOUT[12] = EXPIN[7];
    EXPOUT[11] = EXPIN[8];
    EXPOUT[10] = EXPIN[7];
    EXPOUT[9] = EXPIN[6];
    EXPOUT[8] = EXPIN[5];
    EXPOUT[7] = EXPIN[4];
    EXPOUT[6] = EXPIN[3];
    EXPOUT[5] = EXPIN[4];
    EXPOUT[4] = EXPIN[3];
    EXPOUT[3] = EXPIN[2];
    EXPOUT[2] = EXPIN[1];
    EXPOUT[1] = EXPIN[0];
    EXPOUT[0] = EXPIN[31];

end
////////////////////////////////////////////////////////////////////////////
*/

//////////////////////////////////////////////////////////////////////////
//                         PC1 PERMUTATION
//////////////////////////////////////////////////////////////////////////

/*
always@(*)
begin
    PC1OUT[55] = PC1IN[7];
    PC1OUT[54] = PC1IN[15];
    PC1OUT[53] = PC1IN[23];
    PC1OUT[52] = PC1IN[31];
    PC1OUT[51] = PC1IN[39];
    PC1OUT[50] = PC1IN[47];
    PC1OUT[49] = PC1IN[55];
    PC1OUT[48] = PC1IN[63];
    PC1OUT[47] = PC1IN[6];
    PC1OUT[46] = PC1IN[14];
    PC1OUT[45] = PC1IN[22];
    PC1OUT[44] = PC1IN[30];
    PC1OUT[43] = PC1IN[38];
    PC1OUT[42] = PC1IN[46];
    PC1OUT[41] = PC1IN[54];
    PC1OUT[40] = PC1IN[62];
    PC1OUT[39] = PC1IN[5];
    PC1OUT[38] = PC1IN[13];
    PC1OUT[37] = PC1IN[21];
    PC1OUT[36] = PC1IN[29];
    PC1OUT[35] = PC1IN[37];
    PC1OUT[34] = PC1IN[45];
    PC1OUT[33] = PC1IN[53];
    PC1OUT[32] = PC1IN[61];
    PC1OUT[31] = PC1IN[4];
    PC1OUT[30] = PC1IN[12];
    PC1OUT[29] = PC1IN[20];
    PC1OUT[28] = PC1IN[28];
    PC1OUT[27] = PC1IN[1];
    PC1OUT[26] = PC1IN[9];
    PC1OUT[25] = PC1IN[17];
    PC1OUT[24] = PC1IN[25];
    PC1OUT[23] = PC1IN[33];
    PC1OUT[22] = PC1IN[41];
    PC1OUT[21] = PC1IN[49];
    PC1OUT[20] = PC1IN[57];
    PC1OUT[19] = PC1IN[2];
    PC1OUT[18] = PC1IN[10];
    PC1OUT[17] = PC1IN[18];
    PC1OUT[16] = PC1IN[26];
    PC1OUT[15] = PC1IN[34];
    PC1OUT[14] = PC1IN[42];
    PC1OUT[13] = PC1IN[50];
    PC1OUT[12] = PC1IN[58];
    PC1OUT[11] = PC1IN[3];
    PC1OUT[10] = PC1IN[11];
    PC1OUT[9] = PC1IN[19];
    PC1OUT[8] = PC1IN[27];
    PC1OUT[7] = PC1IN[35];
    PC1OUT[6] = PC1IN[43];
    PC1OUT[5] = PC1IN[51];
    PC1OUT[4] = PC1IN[59];
    PC1OUT[3] = PC1IN[36];
    PC1OUT[2] = PC1IN[44];
    PC1OUT[1] = PC1IN[52];
    PC1OUT[0] = PC1IN[60];
   
end
*/
////////////////////////////////////////////////////////////////////////////
//                           PC2 PERMUTATION
////////////////////////////////////////////////////////////////////////////

/*
always@(*)
begin

    PC2OUT[47] = PC2IN[42];
    PC2OUT[46] = PC2IN[39];
    PC2OUT[45] = PC2IN[45];
    PC2OUT[44] = PC2IN[32];
    PC2OUT[43] = PC2IN[55];
    PC2OUT[42] = PC2IN[51];
    PC2OUT[41] = PC2IN[53];
    PC2OUT[40] = PC2IN[28];
    PC2OUT[39] = PC2IN[41];
    PC2OUT[38] = PC2IN[50];
    PC2OUT[37] = PC2IN[35];
    PC2OUT[36] = PC2IN[46];
    PC2OUT[35] = PC2IN[33];
    PC2OUT[34] = PC2IN[37];
    PC2OUT[33] = PC2IN[44];
    PC2OUT[32] = PC2IN[52];
    PC2OUT[31] = PC2IN[30];
    PC2OUT[30] = PC2IN[48];
    PC2OUT[29] = PC2IN[40];
    PC2OUT[28] = PC2IN[49];
    PC2OUT[27] = PC2IN[29];
    PC2OUT[26] = PC2IN[36];
    PC2OUT[25] = PC2IN[43];
    PC2OUT[24] = PC2IN[54];
    PC2OUT[23] = PC2IN[15];
    PC2OUT[22] = PC2IN[4];
    PC2OUT[21] = PC2IN[25];
    PC2OUT[20] = PC2IN[19];
    PC2OUT[19] = PC2IN[9];
    PC2OUT[18] = PC2IN[1];
    PC2OUT[17] = PC2IN[26];
    PC2OUT[16] = PC2IN[16];
    PC2OUT[15] = PC2IN[5];
    PC2OUT[14] = PC2IN[11];
    PC2OUT[13] = PC2IN[23];
    PC2OUT[12] = PC2IN[8];
    PC2OUT[11] = PC2IN[12];
    PC2OUT[10] = PC2IN[7];
    PC2OUT[9] = PC2IN[17];
    PC2OUT[8] = PC2IN[0];
    PC2OUT[7] = PC2IN[22];
    PC2OUT[6] = PC2IN[3];
    PC2OUT[5] = PC2IN[10];
    PC2OUT[4] = PC2IN[14];
    PC2OUT[3] = PC2IN[6];
    PC2OUT[2] = PC2IN[20];
    PC2OUT[1] = PC2IN[27];
    PC2OUT[0] = PC2IN[24];
end
*/

///////////////////////////////////////////////////////////////////////////////////////
//                   FINAL PERMUTATION
///////////////////////////////////////////////////////////////////////////////////////

/*
always@(*)
begin
    FINP[63] = FINR[24];
    FINP[62] = FINR[56];
    FINP[61] = FINR[16];
    FINP[60] = FINR[48];
    FINP[59] = FINR[8];
    FINP[58] = FINR[40];
    FINP[57] = FINR[0];
    FINP[56] = FINR[32];
    FINP[55] = FINR[25];
    FINP[54] = FINR[57];
    FINP[53] = FINR[17];
    FINP[52] = FINR[49];
    FINP[51] = FINR[9];
    FINP[50] = FINR[41];
    FINP[49] = FINR[1];
    FINP[48] = FINR[33];
    FINP[47] = FINR[26];
    FINP[46] = FINR[58];
    FINP[45] = FINR[18];
    FINP[44] = FINR[50];
    FINP[43] = FINR[10];
    FINP[42] = FINR[42];
    FINP[41] = FINR[2];
    FINP[40] = FINR[34];
    FINP[39] = FINR[27];
    FINP[38] = FINR[59];
    FINP[37] = FINR[19];
    FINP[36] = FINR[51];
    FINP[35] = FINR[11];
    FINP[34] = FINR[43];
    FINP[33] = FINR[3];
    FINP[32] = FINR[35];
    FINP[31] = FINR[28];
    FINP[30] = FINR[60];
    FINP[29] = FINR[20];
    FINP[28] = FINR[52];
    FINP[27] = FINR[12];
    FINP[26] = FINR[44];
    FINP[25] = FINR[4];
    FINP[24] = FINR[36];
    FINP[23] = FINR[29];
    FINP[22] = FINR[61];
    FINP[21] = FINR[21];
    FINP[20] = FINR[53];
    FINP[19] = FINR[13];
    FINP[18] = FINR[45];
    FINP[17] = FINR[5];
    FINP[16] = FINR[37];
    FINP[15] = FINR[30];
    FINP[14] = FINR[62];
    FINP[13] = FINR[22];
    FINP[12] = FINR[54];
    FINP[11] = FINR[14];
    FINP[10] = FINR[46];
    FINP[9] = FINR[6];
    FINP[8] = FINR[38];
    FINP[7] = FINR[31];
    FINP[6] = FINR[63];
    FINP[5] = FINR[23];
    FINP[4] = FINR[55];
    FINP[3] = FINR[15];
    FINP[2] = FINR[47];
    FINP[1] = FINR[7];
    FINP[0] = FINR[39];
end
*/

////////////////////////////////////////////////////////////////////////////////////////
//                    INITIAL PERMUTATION
/////////////////////////////////////////////////////////////////////////////////////////
/*
always@(*)
begin
    INIP[63] = TEXT[6];
    INIP[62] = TEXT[14];
    INIP[61] = TEXT[22];
    INIP[60] = TEXT[30];
    INIP[59] = TEXT[38];
    INIP[58] = TEXT[46];
    INIP[57] = TEXT[54];
    INIP[56] = TEXT[62];
    INIP[55] = TEXT[4];
    INIP[54] = TEXT[12];
    INIP[53] = TEXT[20];
    INIP[52] = TEXT[28];
    INIP[51] = TEXT[36];
    INIP[50] = TEXT[44];
    INIP[49] = TEXT[52];
    INIP[48] = TEXT[60];
    INIP[47] = TEXT[2];
    INIP[46] = TEXT[10];
    INIP[45] = TEXT[18];
    INIP[44] = TEXT[26];
    INIP[43] = TEXT[34];
    INIP[42] = TEXT[42];
    INIP[41] = TEXT[50];
    INIP[40] = TEXT[58];
    INIP[39] = TEXT[0];
    INIP[38] = TEXT[8];
    INIP[37] = TEXT[16];
    INIP[36] = TEXT[24];
    INIP[35] = TEXT[32];
    INIP[34] = TEXT[40];
    INIP[33] = TEXT[48];
    INIP[32] = TEXT[56];
    INIP[31] = TEXT[7];
    INIP[30] = TEXT[15];
    INIP[29] = TEXT[23];
    INIP[28] = TEXT[31];
    INIP[27] = TEXT[39];
    INIP[26] = TEXT[47];
    INIP[25] = TEXT[55];
    INIP[24] = TEXT[63];
    INIP[23] = TEXT[5];

    INIP[22] = TEXT[13];
    INIP[21] = TEXT[21];
    INIP[20] = TEXT[29];
    INIP[19] = TEXT[37];
    INIP[18] = TEXT[45];
    INIP[17] = TEXT[53];
    INIP[16] = TEXT[61];
    INIP[15] = TEXT[3];
    INIP[14] = TEXT[11];
    INIP[13] = TEXT[19];
    INIP[12] = TEXT[27];
    INIP[11] = TEXT[35];
    INIP[10] = TEXT[43];
    INIP[9] = TEXT[51];
    INIP[8] = TEXT[59];
    INIP[7] = TEXT[1];
    INIP[6] = TEXT[9];
    INIP[5] = TEXT[17];
    INIP[4] = TEXT[25];
    INIP[3] = TEXT[33];
    INIP[2] = TEXT[41];
    INIP[1] = TEXT[49];
    INIP[0] = TEXT[57];
end
*/



/////////////////////////////////////////////////////////////////////////////////////
//                    P PERMUTATION
//////////////////////////////////////////////////////////////////////////////////
/*
always@(*)
begin
    FOUT[31] = P[16];
    FOUT[30] = P[25];
    FOUT[29] = P[12];
    FOUT[28] = P[11];
    FOUT[27] = P[3];
    FOUT[26] = P[20];
    FOUT[25] = P[4];
    FOUT[24] = P[15];
    FOUT[23] = P[31];
    FOUT[22] = P[17];
    FOUT[21] = P[9];
    FOUT[20] = P[6];
    FOUT[19] = P[27];
    FOUT[18] = P[14];
    FOUT[17] = P[1];
    FOUT[16] = P[22];
    FOUT[15] = P[30];
    FOUT[14] = P[24];
    FOUT[13] = P[8];
    FOUT[12] = P[18];
    FOUT[11] = P[0];
    FOUT[10] = P[5];
    FOUT[9] = P[29];
    FOUT[8] = P[23];
    FOUT[7] = P[13];
    FOUT[6] = P[19];
    FOUT[5] = P[2];
    FOUT[4] = P[26];
    FOUT[3] = P[10];
    FOUT[2] = P[21];
    FOUT[1] = P[28];
    FOUT[0] = P[7];
end
*/


//////////////////////////////////////////////////////////////////////////
//                               S BOX
///////////////////////////////////////////////////////////////////////////
//S1
/*
always@(*)
begin
    case(S1[4:1])
        4'b0000:
            begin
                case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd14;
                        end
                    2'b01:
                        begin
                            P1 = 4'd0;
                        end
                    2'b10:
                        begin
                            P1 = 4'd4;
                        end
                    2'b11:
                        begin
                            P1 = 4'd15;
                        end                    
                endcase
            end
        4'b0001:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd4;
                        end
                    2'b01:
                        begin
                            P1 = 4'd15;
                        end
                    2'b10:
                        begin
                            P1 = 4'd1;
                        end
                    2'b11:
                        begin
                            P1 = 4'd12;
                        end                    
                endcase
            end
        4'b0010:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd13;
                        end
                    2'b01:
                        begin
                            P1 = 4'd7;
                        end
                    2'b10:
                        begin
                            P1 = 4'd14;
                        end
                    2'b11:
                        begin
                            P1 = 4'd8;
                        end                    
                endcase
            end
        4'b0011:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd1;
                        end
                    2'b01:
                        begin
                            P1 = 4'd4;
                        end
                    2'b10:
                        begin
                            P1 = 4'd8;
                        end
                    2'b11:
                        begin
                            P1 = 4'd2;
                        end                    
                endcase
            end
        4'b0100:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd2;
                        end
                    2'b01:
                        begin
                            P1 = 4'd14;
                        end
                    2'b10:
                        begin
                            P1 = 4'd13;
                        end
                    2'b11:
                        begin
                            P1 = 4'd4;
                        end                    
                endcase
            end
        4'b0101:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd15;
                        end
                    2'b01:
                        begin
                            P1 = 4'd2;
                        end
                    2'b10:
                        begin
                            P1 = 4'd6;
                        end
                    2'b11:
                        begin
                            P1 = 4'd9;
                        end                    
                endcase
            end
        4'b0110:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd11;
                        end
                    2'b01:
                        begin
                            P1 = 4'd13;
                        end
                    2'b10:
                        begin
                            P1 = 4'd2;
                        end
                    2'b11:
                        begin
                            P1 = 4'd1;
                        end                    
                endcase
            end
        4'b0111:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd8;
                        end
                    2'b01:
                        begin
                            P1 = 4'd1;
                        end
                    2'b10:
                        begin
                            P1 = 4'd11;
                        end
                    2'b11:
                        begin
                            P1 = 4'd7;
                        end                    
                endcase
            end
        4'b1000:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd3;
                        end
                    2'b01:
                        begin
                            P1 = 4'd10;
                        end
                    2'b10:
                        begin
                            P1 = 4'd15;
                        end
                    2'b11:
                        begin
                            P1 = 4'd5;
                        end                    
                endcase
            end
        4'b1001:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd10;
                        end
                    2'b01:
                        begin
                            P1 = 4'd6;
                        end
                    2'b10:
                        begin
                            P1 = 4'd12;
                        end
                    2'b11:
                        begin
                            P1 = 4'd11;
                        end                    
                endcase
            end
        4'b1010:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd6;
                        end
                    2'b01:
                        begin
                            P1 = 4'd12;
                        end
                    2'b10:
                        begin
                            P1 = 4'd9;
                        end
                    2'b11:
                        begin
                            P1 = 4'd3;
                        end                    
                endcase
            end
        4'b1011:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd12;
                        end
                    2'b01:
                        begin
                            P1 = 4'd11;
                        end
                    2'b10:
                        begin
                            P1 = 4'd7;
                        end
                    2'b11:
                        begin
                            P1 = 4'd14;
                        end                    
                endcase
            end
        4'b1100:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd5;
                        end
                    2'b01:
                        begin
                            P1 = 4'd9;
                        end
                    2'b10:
                        begin
                            P1 = 4'd3;
                        end
                    2'b11:
                        begin
                            P1 = 4'd10;
                        end                    
                endcase
            end
        4'b1101:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd9;
                        end
                    2'b01:
                        begin
                            P1 = 4'd5;
                        end
                    2'b10:
                        begin
                            P1 = 4'd10;
                        end
                    2'b11:
                        begin
                            P1 = 4'd0;
                        end                    
                endcase
            end
        4'b1110:
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd0;
                        end
                    2'b01:
                        begin
                            P1 = 4'd3;
                        end
                    2'b10:
                        begin
                            P1 = 4'd5;
                        end
                    2'b11:
                        begin
                            P1 = 4'd6;
                        end                    
                endcase
            end
        default://4'b1111
            begin
                 case({S1[5],S1[0]})
                    2'b00:
                        begin
                            P1 = 4'd7;
                        end
                    2'b01:
                        begin
                            P1 = 4'd8;
                        end
                    2'b10:
                        begin
                            P1 = 4'd0;
                        end
                    2'b11:
                        begin
                            P1 = 4'd13;
                        end                    
                endcase
            end
    endcase
end
//////////////////////////////////////////////////////
*/

/*
always@(*)
begin
    case(S2[4:1])
        4'b0000:
            begin
                case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd15;
                        end
                    2'b01:
                        begin
                            P2 = 4'd3;
                        end
                    2'b10:
                        begin
                            P2 = 4'd0;
                        end
                    2'b11:
                        begin
                            P2 = 4'd13;
                        end                    
                endcase
            end
        4'b0001:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd1;
                        end
                    2'b01:
                        begin
                            P2 = 4'd13;
                        end
                    2'b10:
                        begin
                            P2 = 4'd14;
                        end
                    2'b11:
                        begin
                            P2 = 4'd8;
                        end                    
                endcase
                 
            end
        4'b0010:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd8;
                        end
                    2'b01:
                        begin
                            P2 = 4'd4;
                        end
                    2'b10:
                        begin
                            P2 = 4'd7;
                        end
                    2'b11:
                        begin
                            P2 = 4'd10;
                        end                    
                endcase
                 
            end
        4'b0011:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd14;
                        end
                    2'b01:
                        begin
                            P2 = 4'd7;
                        end
                    2'b10:
                        begin
                            P2 = 4'd11;
                        end
                    2'b11:
                        begin
                            P2 = 4'd1;
                        end                    
                endcase
                 
            end
        4'b0100:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd6;
                        end
                    2'b01:
                        begin
                            P2 = 4'd15;
                        end
                    2'b10:
                        begin
                            P2 = 4'd10;
                        end
                    2'b11:
                        begin
                            P2 = 4'd3;
                        end                    
                endcase
                
            end
        4'b0101:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd11;
                        end
                    2'b01:
                        begin
                            P2 = 4'd2;
                        end
                    2'b10:
                        begin
                            P2 = 4'd4;
                        end
                    2'b11:
                        begin
                            P2 = 4'd15;
                        end                    
                endcase
                
            end
        4'b0110:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd3;
                        end
                    2'b01:
                        begin
                            P2 = 4'd8;
                        end
                    2'b10:
                        begin
                            P2 = 4'd13;
                        end
                    2'b11:
                        begin
                            P2 = 4'd4;
                        end                    
                endcase
                
            end
        4'b0111:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd4;
                        end
                    2'b01:
                        begin
                            P2 = 4'd14;
                        end
                    2'b10:
                        begin
                            P2 = 4'd1;
                        end
                    2'b11:
                        begin
                            P2 = 4'd2;
                        end                    
                endcase
                
            end
        4'b1000:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd9;
                        end
                    2'b01:
                        begin
                            P2 = 4'd12;
                        end
                    2'b10:
                        begin
                            P2 = 4'd5;
                        end
                    2'b11:
                        begin
                            P2 = 4'd11;
                        end                    
                endcase
                
            end
        4'b1001:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd7;
                        end
                    2'b01:
                        begin
                            P2 = 4'd0;
                        end
                    2'b10:
                        begin
                            P2 = 4'd8;
                        end
                    2'b11:
                        begin
                            P2 = 4'd6;
                        end                    
                endcase
                
            end
        4'b1010:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd2;
                        end
                    2'b01:
                        begin
                            P2 = 4'd1;
                        end
                    2'b10:
                        begin
                            P2 = 4'd12;
                        end
                    2'b11:
                        begin
                            P2 = 4'd7;
                        end                    
                endcase
                
            end
        4'b1011:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd13;
                        end
                    2'b01:
                        begin
                            P2 = 4'd10;
                        end
                    2'b10:
                        begin
                            P2 = 4'd6;
                        end
                    2'b11:
                        begin
                            P2 = 4'd12;
                        end                    
                endcase
                
            end
        4'b1100:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd12;
                        end
                    2'b01:
                        begin
                            P2 = 4'd6;
                        end
                    2'b10:
                        begin
                            P2 = 4'd9;
                        end
                    2'b11:
                        begin
                            P2 = 4'd0;
                        end                    
                endcase
                 
            end
        4'b1101:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd0;
                        end
                    2'b01:
                        begin
                            P2 = 4'd9;
                        end
                    2'b10:
                        begin
                            P2 = 4'd3;
                        end
                    2'b11:
                        begin
                            P2 = 4'd5;
                        end                    
                endcase
                 
            end
        4'b1110:
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd5;
                        end
                    2'b01:
                        begin
                            P2 = 4'd11;
                        end
                    2'b10:
                        begin
                            P2 = 4'd2;
                        end
                    2'b11:
                        begin
                            P2 = 4'd14;
                        end                    
                endcase
                
            end
        default://4'b1111
            begin
                 case({S2[5],S2[0]})
                    2'b00:
                        begin
                            P2 = 4'd10;
                        end
                    2'b01:
                        begin
                            P2 = 4'd5;
                        end
                    2'b10:
                        begin
                            P2 = 4'd15;
                        end
                    2'b11:
                        begin
                            P2 = 4'd9;
                        end                    
                endcase
                 
            end
    endcase
end
//////////////////////////////////////////////////////




*/





/*
always@(*)
begin
    case(S3[4:1])
        4'b0000:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd10;
                        end
                    2'b01:
                        begin
                            P3 = 4'd13;
                        end
                    2'b10:
                        begin
                            P3 = 4'd13;
                        end
                    2'b11:
                        begin
                            P3 = 4'd1;
                        end                    
                endcase
            end
        4'b0001:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd0;
                        end
                    2'b01:
                        begin
                            P3 = 4'd7;
                        end
                    2'b10:
                        begin
                            P3 = 4'd6;
                        end
                    2'b11:
                        begin
                            P3 = 4'd10;
                        end                    
                endcase
                 
            end
        4'b0010:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd9;
                        end
                    2'b01:
                        begin
                            P3 = 4'd0;
                        end
                    2'b10:
                        begin
                            P3 = 4'd4;
                        end
                    2'b11:
                        begin
                            P3 = 4'd13;
                        end                    
                endcase
                 
            end
        4'b0011:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd14;
                        end
                    2'b01:
                        begin
                            P3 = 4'd9;
                        end
                    2'b10:
                        begin
                            P3 = 4'd9;
                        end
                    2'b11:
                        begin
                            P3 = 4'd0;
                        end                    
                endcase
                 
            end
        4'b0100:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd6;
                        end
                    2'b01:
                        begin
                            P3 = 4'd3;
                        end
                    2'b10:
                        begin
                            P3 = 4'd8;
                        end
                    2'b11:
                        begin
                            P3 = 4'd6;
                        end                    
                endcase
                
            end
        4'b0101:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd3;
                        end
                    2'b01:
                        begin
                            P3 = 4'd4;
                        end
                    2'b10:
                        begin
                            P3 = 4'd15;
                        end
                    2'b11:
                        begin
                            P3 = 4'd9;
                        end                    
                endcase
                
            end
        4'b0110:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd15;
                        end
                    2'b01:
                        begin
                            P3 = 4'd6;
                        end
                    2'b10:
                        begin
                            P3 = 4'd3;
                        end
                    2'b11:
                        begin
                            P3 = 4'd8;
                        end                    
                endcase
                
            end
        4'b0111:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd5;
                        end
                    2'b01:
                        begin
                            P3 = 4'd10;
                        end
                    2'b10:
                        begin
                            P3 = 4'd0;
                        end
                    2'b11:
                        begin
                            P3 = 4'd7;
                        end                    
                endcase
                
            end
        4'b1000:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd1;
                        end
                    2'b01:
                        begin
                            P3 = 4'd2;
                        end
                    2'b10:
                        begin
                            P3 = 4'd11;
                        end
                    2'b11:
                        begin
                            P3 = 4'd4;
                        end                    
                endcase
                
            end
        4'b1001:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd13;
                        end
                    2'b01:
                        begin
                            P3 = 4'd8;
                        end
                    2'b10:
                        begin
                            P3 = 4'd1;
                        end
                    2'b11:
                        begin
                            P3 = 4'd15;
                        end                    
                endcase
                
            end
        4'b1010:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd12;
                        end
                    2'b01:
                        begin
                            P3 = 4'd5;
                        end
                    2'b10:
                        begin
                            P3 = 4'd2;
                        end
                    2'b11:
                        begin
                            P3 = 4'd14;
                        end                    
                endcase
                
            end
        4'b1011:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd7;
                        end
                    2'b01:
                        begin
                            P3 = 4'd14;
                        end
                    2'b10:
                        begin
                            P3 = 4'd12;
                        end
                    2'b11:
                        begin
                            P3 = 4'd3;
                        end                    
                endcase
                
            end
        4'b1100:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd11;
                        end
                    2'b01:
                        begin
                            P3 = 4'd12;
                        end
                    2'b10:
                        begin
                            P3 = 4'd5;
                        end
                    2'b11:
                        begin
                            P3 = 4'd11;
                        end                    
                endcase
                 
            end
        4'b1101:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd4;
                        end
                    2'b01:
                        begin
                            P3 = 4'd11;
                        end
                    2'b10:
                        begin
                            P3 = 4'd10;
                        end
                    2'b11:
                        begin
                            P3 = 4'd5;
                        end                    
                endcase
                 
            end
        4'b1110:
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd2;
                        end
                    2'b01:
                        begin
                            P3 = 4'd15;
                        end
                    2'b10:
                        begin
                            P3 = 4'd14;
                        end
                    2'b11:
                        begin
                            P3 = 4'd2;
                        end                    
                endcase
                
            end
        default://4'b1111
            begin
                case({S3[5],S3[0]})
                    2'b00:
                        begin
                            P3 = 4'd8;
                        end
                    2'b01:
                        begin
                            P3 = 4'd1;
                        end
                    2'b10:
                        begin
                            P3 = 4'd7;
                        end
                    2'b11:
                        begin
                            P3 = 4'd12;
                        end                    
                endcase
                 
            end
    endcase
end
////////////////////////////////////////////////////////
*/







/*
always@(*)
begin
    case(S4[4:1])
        4'b0000:
            begin
                case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd7;
                        end
                    2'b01:
                        begin
                            P4 = 4'd13;
                        end
                    2'b10:
                        begin
                            P4 = 4'd10;
                        end
                    2'b11:
                        begin
                            P4 = 4'd3;
                        end                    
                endcase
            end
        4'b0001:
            begin
                 case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd13;
                        end
                    2'b01:
                        begin
                            P4 = 4'd8;
                        end
                    2'b10:
                        begin
                            P4 = 4'd6;
                        end
                    2'b11:
                        begin
                            P4 = 4'd15;
                        end                    
                endcase
            end
        4'b0010:
            begin
                 case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd14;
                        end
                    2'b01:
                        begin
                            P4 = 4'd11;
                        end
                    2'b10:
                        begin
                            P4 = 4'd9;
                        end
                    2'b11:
                        begin
                            P4 = 4'd0;
                        end                    
                endcase
            end
        4'b0011:
            begin
                 case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd3;
                        end
                    2'b01:
                        begin
                            P4 = 4'd5;
                        end
                    2'b10:
                        begin
                            P4 = 4'd0;
                        end
                    2'b11:
                        begin
                            P4 = 4'd6;
                        end                    
                endcase
            end
        4'b0100:
            begin
                case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd0;
                        end
                    2'b01:
                        begin
                            P4 = 4'd6;
                        end
                    2'b10:
                        begin
                            P4 = 4'd12;
                        end
                    2'b11:
                        begin
                            P4 = 4'd10;
                        end                    
                endcase
            end
        4'b0101:
            begin
                case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd6;
                        end
                    2'b01:
                        begin
                            P4 = 4'd15;
                        end
                    2'b10:
                        begin
                            P4 = 4'd11;
                        end
                    2'b11:
                        begin
                            P4 = 4'd1;
                        end                    
                endcase
            end
        4'b0110:
            begin
                case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd9;
                        end
                    2'b01:
                        begin
                            P4 = 4'd0;
                        end
                    2'b10:
                        begin
                            P4 = 4'd7;
                        end
                    2'b11:
                        begin
                            P4 = 4'd13;
                        end                    
                endcase
            end
        4'b0111:
            begin
                case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd10;
                        end
                    2'b01:
                        begin
                            P4 = 4'd3;
                        end
                    2'b10:
                        begin
                            P4 = 4'd13;
                        end
                    2'b11:
                        begin
                            P4 = 4'd8;
                        end                    
                endcase
            end
        4'b1000:
            begin
                case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd1;
                        end
                    2'b01:
                        begin
                            P4 = 4'd4;
                        end
                    2'b10:
                        begin
                            P4 = 4'd15;
                        end
                    2'b11:
                        begin
                            P4 = 4'd9;
                        end                    
                endcase
            end
        4'b1001:
            begin
                case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd2;
                        end
                    2'b01:
                        begin
                            P4 = 4'd7;
                        end
                    2'b10:
                        begin
                            P4 = 4'd1;
                        end
                    2'b11:
                        begin
                            P4 = 4'd4;
                        end                    
                endcase
            end
        4'b1010:
            begin
                case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd8;
                        end
                    2'b01:
                        begin
                            P4 = 4'd2;
                        end
                    2'b10:
                        begin
                            P4 = 4'd3;
                        end
                    2'b11:
                        begin
                            P4 = 4'd5;
                        end                    
                endcase
            end
        4'b1011:
            begin
                case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd5;
                        end
                    2'b01:
                        begin
                            P4 = 4'd12;
                        end
                    2'b10:
                        begin
                            P4 = 4'd14;
                        end
                    2'b11:
                        begin
                            P4 = 4'd11;
                        end                    
                endcase
            end
        4'b1100:
            begin
                 case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd11;
                        end
                    2'b01:
                        begin
                            P4 = 4'd1;
                        end
                    2'b10:
                        begin
                            P4 = 4'd5;
                        end
                    2'b11:
                        begin
                            P4 = 4'd12;
                        end                    
                endcase
            end
        4'b1101:
            begin
                 case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd12;
                        end
                    2'b01:
                        begin
                            P4 = 4'd10;
                        end
                    2'b10:
                        begin
                            P4 = 4'd2;
                        end
                    2'b11:
                        begin
                            P4 = 4'd7;
                        end                    
                endcase
            end
        4'b1110:
            begin
                case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd4;
                        end
                    2'b01:
                        begin
                            P4 = 4'd14;
                        end
                    2'b10:
                        begin
                            P4 = 4'd8;
                        end
                    2'b11:
                        begin
                            P4 = 4'd2;
                        end                    
                endcase
            end
        default://4'b1111
            begin
                 case({S4[5],S4[0]})
                    2'b00:
                        begin
                            P4 = 4'd15;
                        end
                    2'b01:
                        begin
                            P4 = 4'd9;
                        end
                    2'b10:
                        begin
                            P4 = 4'd4;
                        end
                    2'b11:
                        begin
                            P4 = 4'd14;
                        end                    
                endcase
            end
    endcase
end

///////////////////////////////////////////////////////
*/




/*
always@(*)
begin
    case(S5[4:1])
        4'b0000:
            begin
                case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd2;
                        end
                    2'b01:
                        begin
                            P5 = 4'd14;
                        end
                    2'b10:
                        begin
                            P5 = 4'd4;
                        end
                    2'b11:
                        begin
                            P5 = 4'd11;
                        end                    
                endcase
            end
        4'b0001:
            begin
                 case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd12;
                        end
                    2'b01:
                        begin
                            P5 = 4'd11;
                        end
                    2'b10:
                        begin
                            P5 = 4'd2;
                        end
                    2'b11:
                        begin
                            P5 = 4'd8;
                        end                    
                endcase
            end
        4'b0010:
            begin
                 case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd4;
                        end
                    2'b01:
                        begin
                            P5 = 4'd2;
                        end
                    2'b10:
                        begin
                            P5 = 4'd1;
                        end
                    2'b11:
                        begin
                            P5 = 4'd12;
                        end                    
                endcase
            end
        4'b0011:
            begin
                 case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd1;
                        end
                    2'b01:
                        begin
                            P5 = 4'd12;
                        end
                    2'b10:
                        begin
                            P5 = 4'd11;
                        end
                    2'b11:
                        begin
                            P5 = 4'd7;
                        end                    
                endcase
            end
        4'b0100:
            begin
                case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd7;
                        end
                    2'b01:
                        begin
                            P5 = 4'd4;
                        end
                    2'b10:
                        begin
                            P5 = 4'd10;
                        end
                    2'b11:
                        begin
                            P5 = 4'd1;
                        end                    
                endcase
            end
        4'b0101:
            begin
                case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd10;
                        end
                    2'b01:
                        begin
                            P5 = 4'd7;
                        end
                    2'b10:
                        begin
                            P5 = 4'd13;
                        end
                    2'b11:
                        begin
                            P5 = 4'd14;
                        end                    
                endcase
            end
        4'b0110:
            begin
                case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd11;
                        end
                    2'b01:
                        begin
                            P5 = 4'd13;
                        end
                    2'b10:
                        begin
                            P5 = 4'd7;
                        end
                    2'b11:
                        begin
                            P5 = 4'd2;
                        end                    
                endcase
            end
        4'b0111:
            begin
                case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd6;
                        end
                    2'b01:
                        begin
                            P5 = 4'd1;
                        end
                    2'b10:
                        begin
                            P5 = 4'd8;
                        end
                    2'b11:
                        begin
                            P5 = 4'd13;
                        end                    
                endcase
            end
        4'b1000:
            begin
                case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd8;
                        end
                    2'b01:
                        begin
                            P5 = 4'd5;
                        end
                    2'b10:
                        begin
                            P5 = 4'd15;
                        end
                    2'b11:
                        begin
                            P5 = 4'd6;
                        end                    
                endcase
            end
        4'b1001:
            begin
                case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd5;
                        end
                    2'b01:
                        begin
                            P5 = 4'd0;
                        end
                    2'b10:
                        begin
                            P5 = 4'd9;
                        end
                    2'b11:
                        begin
                            P5 = 4'd15;
                        end                    
                endcase
            end
        4'b1010:
            begin
                case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd3;
                        end
                    2'b01:
                        begin
                            P5 = 4'd15;
                        end
                    2'b10:
                        begin
                            P5 = 4'd12;
                        end
                    2'b11:
                        begin
                            P5 = 4'd0;
                        end                    
                endcase
            end
        4'b1011:
            begin
                case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd15;
                        end
                    2'b01:
                        begin
                            P5 = 4'd10;
                        end
                    2'b10:
                        begin
                            P5 = 4'd5;
                        end
                    2'b11:
                        begin
                            P5 = 4'd9;
                        end                    
                endcase
            end
        4'b1100:
            begin
                 case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd13;
                        end
                    2'b01:
                        begin
                            P5 = 4'd3;
                        end
                    2'b10:
                        begin
                            P5 = 4'd6;
                        end
                    2'b11:
                        begin
                            P5 = 4'd10;
                        end                    
                endcase
            end
        4'b1101:
            begin
                 case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd0;
                        end
                    2'b01:
                        begin
                            P5 = 4'd9;
                        end
                    2'b10:
                        begin
                            P5 = 4'd3;
                        end
                    2'b11:
                        begin
                            P5 = 4'd4;
                        end                    
                endcase
            end
        4'b1110:
            begin
                case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd14;
                        end
                    2'b01:
                        begin
                            P5 = 4'd8;
                        end
                    2'b10:
                        begin
                            P5 = 4'd0;
                        end
                    2'b11:
                        begin
                            P5 = 4'd5;
                        end                    
                endcase
            end
        default://4'b1111
            begin
                 case({S5[5],S5[0]})
                    2'b00:
                        begin
                            P5 = 4'd9;
                        end
                    2'b01:
                        begin
                            P5 = 4'd6;
                        end
                    2'b10:
                        begin
                            P5 = 4'd14;
                        end
                    2'b11:
                        begin
                            P5 = 4'd3;
                        end                    
                endcase
            end
    endcase
end
*/
//////////////////////////////////////////////////////////////

/*
always@(*)
begin
    case(S6[4:1])
        4'b0000:
            begin
                case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd12;
                        end
                    2'b01:
                        begin
                            P6 = 4'd10;
                        end
                    2'b10:
                        begin
                            P6 = 4'd9;
                        end
                    2'b11:
                        begin
                            P6 = 4'd4;
                        end                    
                endcase
            end
        4'b0001:
            begin
                 case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd1;
                        end
                    2'b01:
                        begin
                            P6 = 4'd15;
                        end
                    2'b10:
                        begin
                            P6 = 4'd14;
                        end
                    2'b11:
                        begin
                            P6 = 4'd3;
                        end                    
                endcase
            end
        4'b0010:
            begin
                 case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd10;
                        end
                    2'b01:
                        begin
                            P6 = 4'd4;
                        end
                    2'b10:
                        begin
                            P6 = 4'd15;
                        end
                    2'b11:
                        begin
                            P6 = 4'd2;
                        end                    
                endcase
            end
        4'b0011:
            begin
                 case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd15;
                        end
                    2'b01:
                        begin
                            P6 = 4'd2;
                        end
                    2'b10:
                        begin
                            P6 = 4'd5;
                        end
                    2'b11:
                        begin
                            P6 = 4'd12;
                        end                    
                endcase
            end
        4'b0100:
            begin
                case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd9;
                        end
                    2'b01:
                        begin
                            P6 = 4'd7;
                        end
                    2'b10:
                        begin
                            P6 = 4'd2;
                        end
                    2'b11:
                        begin
                            P6 = 4'd9;
                        end                    
                endcase
            end
        4'b0101:
            begin
                case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd2;
                        end
                    2'b01:
                        begin
                            P6 = 4'd12;
                        end
                    2'b10:
                        begin
                            P6 = 4'd8;
                        end
                    2'b11:
                        begin
                            P6 = 4'd5;
                        end                    
                endcase
            end
        4'b0110:
            begin
                case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd6;
                        end
                    2'b01:
                        begin
                            P6 = 4'd9;
                        end
                    2'b10:
                        begin
                            P6 = 4'd12;
                        end
                    2'b11:
                        begin
                            P6 = 4'd15;
                        end                    
                endcase
            end
        4'b0111:
            begin
                case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd8;
                        end
                    2'b01:
                        begin
                            P6 = 4'd5;
                        end
                    2'b10:
                        begin
                            P6 = 4'd3;
                        end
                    2'b11:
                        begin
                            P6 = 4'd10;
                        end                    
                endcase
            end
        4'b1000:
            begin
                case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd0;
                        end
                    2'b01:
                        begin
                            P6 = 4'd6;
                        end
                    2'b10:
                        begin
                            P6 = 4'd7;
                        end
                    2'b11:
                        begin
                            P6 = 4'd11;
                        end                    
                endcase
            end
        4'b1001:
            begin
                case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd13;
                        end
                    2'b01:
                        begin
                            P6 = 4'd1;
                        end
                    2'b10:
                        begin
                            P6 = 4'd0;
                        end
                    2'b11:
                        begin
                            P6 = 4'd14;
                        end                    
                endcase
            end
        4'b1010:
            begin
                case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd3;
                        end
                    2'b01:
                        begin
                            P6 = 4'd13;
                        end
                    2'b10:
                        begin
                            P6 = 4'd4;
                        end
                    2'b11:
                        begin
                            P6 = 4'd1;
                        end                    
                endcase
            end
        4'b1011:
            begin
                case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd4;
                        end
                    2'b01:
                        begin
                            P6 = 4'd14;
                        end
                    2'b10:
                        begin
                            P6 = 4'd10;
                        end
                    2'b11:
                        begin
                            P6 = 4'd7;
                        end                    
                endcase
            end
        4'b1100:
            begin
                 case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd14;
                        end
                    2'b01:
                        begin
                            P6 = 4'd0;
                        end
                    2'b10:
                        begin
                            P6 = 4'd1;
                        end
                    2'b11:
                        begin
                            P6 = 4'd6;
                        end                    
                endcase
            end
        4'b1101:
            begin
                 case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd7;
                        end
                    2'b01:
                        begin
                            P6 = 4'd11;
                        end
                    2'b10:
                        begin
                            P6 = 4'd13;
                        end
                    2'b11:
                        begin
                            P6 = 4'd0;
                        end                    
                endcase
            end
        4'b1110:
            begin
                case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd5;
                        end
                    2'b01:
                        begin
                            P6 = 4'd3;
                        end
                    2'b10:
                        begin
                            P6 = 4'd11;
                        end
                    2'b11:
                        begin
                            P6 = 4'd8;
                        end                    
                endcase
            end
        default://4'b1111
            begin
                 case({S6[5],S6[0]})
                    2'b00:
                        begin
                            P6 = 4'd11;
                        end
                    2'b01:
                        begin
                            P6 = 4'd8;
                        end
                    2'b10:
                        begin
                            P6 = 4'd6;
                        end
                    2'b11:
                        begin
                            P6 = 4'd13;
                        end                    
                endcase
            end
    endcase
end


*/





////////////////////////////////////////////////////
/*
always@(*)
begin
    case(S7[4:1])
        4'b0000:
            begin
                case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd4;
                        end
                    2'b01:
                        begin
                            P7 = 4'd13;
                        end
                    2'b10:
                        begin
                            P7 = 4'd1;
                        end
                    2'b11:
                        begin
                            P7 = 4'd6;
                        end                    
                endcase
            end
        4'b0001:
            begin
                 case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd11;
                        end
                    2'b01:
                        begin
                            P7 = 4'd0;
                        end
                    2'b10:
                        begin
                            P7 = 4'd4;
                        end
                    2'b11:
                        begin
                            P7 = 4'd11;
                        end                    
                endcase
            end
        4'b0010:
            begin
                 case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd2;
                        end
                    2'b01:
                        begin
                            P7 = 4'd11;
                        end
                    2'b10:
                        begin
                            P7 = 4'd11;
                        end
                    2'b11:
                        begin
                            P7 = 4'd13;
                        end                    
                endcase
            end
        4'b0011:
            begin
                 case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd14;
                        end
                    2'b01:
                        begin
                            P7 = 4'd7;
                        end
                    2'b10:
                        begin
                            P7 = 4'd13;
                        end
                    2'b11:
                        begin
                            P7 = 4'd8;
                        end                    
                endcase
            end
        4'b0100:
            begin
                case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd15;
                        end
                    2'b01:
                        begin
                            P7 = 4'd4;
                        end
                    2'b10:
                        begin
                            P7 = 4'd12;
                        end
                    2'b11:
                        begin
                            P7 = 4'd1;
                        end                    
                endcase
            end
        4'b0101:
            begin
                case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd0;
                        end
                    2'b01:
                        begin
                            P7 = 4'd9;
                        end
                    2'b10:
                        begin
                            P7 = 4'd3;
                        end
                    2'b11:
                        begin
                            P7 = 4'd4;
                        end                    
                endcase
            end
        4'b0110:
            begin
                case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd8;
                        end
                    2'b01:
                        begin
                            P7 = 4'd1;
                        end
                    2'b10:
                        begin
                            P7 = 4'd7;
                        end
                    2'b11:
                        begin
                            P7 = 4'd10;
                        end                    
                endcase
            end
        4'b0111:
            begin
                case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd13;
                        end
                    2'b01:
                        begin
                            P7 = 4'd10;
                        end
                    2'b10:
                        begin
                            P7 = 4'd14;
                        end
                    2'b11:
                        begin
                            P7 = 4'd7;
                        end                    
                endcase
            end
        4'b1000:
            begin
                case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd3;
                        end
                    2'b01:
                        begin
                            P7 = 4'd14;
                        end
                    2'b10:
                        begin
                            P7 = 4'd10;
                        end
                    2'b11:
                        begin
                            P7 = 4'd9;
                        end                    
                endcase
            end
        4'b1001:
            begin
                case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd12;
                        end
                    2'b01:
                        begin
                            P7 = 4'd3;
                        end
                    2'b10:
                        begin
                            P7 = 4'd15;
                        end
                    2'b11:
                        begin
                            P7 = 4'd5;
                        end                    
                endcase
            end
        4'b1010:
            begin
                case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd9;
                        end
                    2'b01:
                        begin
                            P7 = 4'd5;
                        end
                    2'b10:
                        begin
                            P7 = 4'd6;
                        end
                    2'b11:
                        begin
                            P7 = 4'd0;
                        end                    
                endcase
            end
        4'b1011:
            begin
                case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd7;
                        end
                    2'b01:
                        begin
                            P7 = 4'd12;
                        end
                    2'b10:
                        begin
                            P7 = 4'd8;
                        end
                    2'b11:
                        begin
                            P7 = 4'd15;
                        end                    
                endcase
            end
        4'b1100:
            begin
                 case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd5;
                        end
                    2'b01:
                        begin
                            P7 = 4'd2;
                        end
                    2'b10:
                        begin
                            P7 = 4'd0;
                        end
                    2'b11:
                        begin
                            P7 = 4'd14;
                        end                    
                endcase
            end
        4'b1101:
            begin
                 case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd10;
                        end
                    2'b01:
                        begin
                            P7 = 4'd15;
                        end
                    2'b10:
                        begin
                            P7 = 4'd5;
                        end
                    2'b11:
                        begin
                            P7 = 4'd2;
                        end                    
                endcase
            end
        4'b1110:
            begin
                case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd6;
                        end
                    2'b01:
                        begin
                            P7 = 4'd8;
                        end
                    2'b10:
                        begin
                            P7 = 4'd9;
                        end
                    2'b11:
                        begin
                            P7 = 4'd3;
                        end                    
                endcase
            end
        default://4'b1111
            begin
                 case({S7[5],S7[0]})
                    2'b00:
                        begin
                            P7 = 4'd1;
                        end
                    2'b01:
                        begin
                            P7 = 4'd6;
                        end
                    2'b10:
                        begin
                            P7 = 4'd2;
                        end
                    2'b11:
                        begin
                            P7 = 4'd12;
                        end                    
                endcase
            end
    endcase
end

//////////////////////////////////////////////////////////////
*/

/*

always@(*)
begin
    case(S8[4:1])
        4'b0000:
            begin
                case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd13;
                        end
                    2'b01:
                        begin
                            P8 = 4'd1;
                        end
                    2'b10:
                        begin
                            P8 = 4'd7;
                        end
                    2'b11:
                        begin
                            P8 = 4'd2;
                        end                    
                endcase
            end
        4'b0001:
            begin
                 case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd2;
                        end
                    2'b01:
                        begin
                            P8 = 4'd15;
                        end
                    2'b10:
                        begin
                            P8 = 4'd11;
                        end
                    2'b11:
                        begin
                            P8 = 4'd1;
                        end                    
                endcase
            end
        4'b0010:
            begin
                 case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd8;
                        end
                    2'b01:
                        begin
                            P8 = 4'd13;
                        end
                    2'b10:
                        begin
                            P8 = 4'd4;
                        end
                    2'b11:
                        begin
                            P8 = 4'd14;
                        end                    
                endcase
            end
        4'b0011:
            begin
                 case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd4;
                        end
                    2'b01:
                        begin
                            P8 = 4'd8;
                        end
                    2'b10:
                        begin
                            P8 = 4'd1;
                        end
                    2'b11:
                        begin
                            P8 = 4'd7;
                        end                    
                endcase
            end
        4'b0100:
            begin
                case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd6;
                        end
                    2'b01:
                        begin
                            P8 = 4'd10;
                        end
                    2'b10:
                        begin
                            P8 = 4'd9;
                        end
                    2'b11:
                        begin
                            P8 = 4'd4;
                        end                    
                endcase
            end
        4'b0101:
            begin
                case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd15;
                        end
                    2'b01:
                        begin
                            P8 = 4'd3;
                        end
                    2'b10:
                        begin
                            P8 = 4'd12;
                        end
                    2'b11:
                        begin
                            P8 = 4'd10;
                        end                    
                endcase
            end
        4'b0110:
            begin
                case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd11;
                        end
                    2'b01:
                        begin
                            P8 = 4'd7;
                        end
                    2'b10:
                        begin
                            P8 = 4'd14;
                        end
                    2'b11:
                        begin
                            P8 = 4'd8;
                        end                    
                endcase
            end
        4'b0111:
            begin
                case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd1;
                        end
                    2'b01:
                        begin
                            P8 = 4'd4;
                        end
                    2'b10:
                        begin
                            P8 = 4'd2;
                        end
                    2'b11:
                        begin
                            P8 = 4'd13;
                        end                    
                endcase
            end
        4'b1000:
            begin
                case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd10;
                        end
                    2'b01:
                        begin
                            P8 = 4'd12;
                        end
                    2'b10:
                        begin
                            P8 = 4'd0;
                        end
                    2'b11:
                        begin
                            P8 = 4'd15;
                        end                    
                endcase
            end
        4'b1001:
            begin
                case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd9;
                        end
                    2'b01:
                        begin
                            P8 = 4'd5;
                        end
                    2'b10:
                        begin
                            P8 = 4'd6;
                        end
                    2'b11:
                        begin
                            P8 = 4'd12;
                        end                    
                endcase
            end
        4'b1010:
            begin
                case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd3;
                        end
                    2'b01:
                        begin
                            P8 = 4'd6;
                        end
                    2'b10:
                        begin
                            P8 = 4'd10;
                        end
                    2'b11:
                        begin
                            P8 = 4'd9;
                        end                    
                endcase
            end
        4'b1011:
            begin
                case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd14;
                        end
                    2'b01:
                        begin
                            P8 = 4'd11;
                        end
                    2'b10:
                        begin
                            P8 = 4'd13;
                        end
                    2'b11:
                        begin
                            P8 = 4'd0;
                        end                    
                endcase
            end
        4'b1100:
            begin
                 case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd5;
                        end
                    2'b01:
                        begin
                            P8 = 4'd0;
                        end
                    2'b10:
                        begin
                            P8 = 4'd15;
                        end
                    2'b11:
                        begin
                            P8 = 4'd3;
                        end                    
                endcase
            end
        4'b1101:
            begin
                 case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd0;
                        end
                    2'b01:
                        begin
                            P8 = 4'd14;
                        end
                    2'b10:
                        begin
                            P8 = 4'd3;
                        end
                    2'b11:
                        begin
                            P8 = 4'd5;
                        end                    
                endcase
            end
        4'b1110:
            begin
                case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd12;
                        end
                    2'b01:
                        begin
                            P8 = 4'd9;
                        end
                    2'b10:
                        begin
                            P8 = 4'd5;
                        end
                    2'b11:
                        begin
                            P8 = 4'd6;
                        end                    
                endcase
            end
        default://4'b1111
            begin
                 case({S8[5],S8[0]})
                    2'b00:
                        begin
                            P8 = 4'd7;
                        end
                    2'b01:
                        begin
                            P8 = 4'd2;
                        end
                    2'b10:
                        begin
                            P8 = 4'd8;
                        end
                    2'b11:
                        begin
                            P8 = 4'd11;
                        end                    
                endcase
            end
    endcase
end
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
endmodule
