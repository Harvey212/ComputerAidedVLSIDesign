module core #( // DO NOT MODIFY INTERFACE!!!
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32
) ( 
    input i_clk,
    input i_rst_n,

    // Testbench IOs
    output [2:0] o_status, 
    output       o_status_valid,

    // Memory IOs
    output [ADDR_WIDTH-1:0] o_addr,
    output [DATA_WIDTH-1:0] o_wdata,
    output                  o_we,
    input  [DATA_WIDTH-1:0] i_rdata
);



`include "../00_TB/define.v" 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ---------------------------------------------------------------------------
// Wires and Registers
// ---------------------------------------------------------------------------
// ---- Add your own wires and registers here if needed ---- //

///////////////////////////////////////////////////////
//            FSM
/////////////////////////////////////////////////////
localparam ReadyState =3'b000;
localparam InstAddrState =3'b001;
localparam GetInstState = 3'b010;
localparam ProcessInstState = 3'b011; 
localparam BufferState =3'b100;
localparam OutState =3'b101;
localparam SaveState =3'b110;
localparam LoadState =3'b111;

reg [2:0] state;
reg [2:0] next_state;

//for deciding which state to go
reg [4:0] con; //con = 8 //
//for stop processing
reg dead;
reg dead2;
//////////////////////////////////////////////////////////





////////////////////////////////////////////////////////
//              Instruction
///////////////////////////////////////////////////
reg [4:0] whatInst;
//add: 1
//sub: 2
//addi: 3
//lw:4
//sw:5
//beq:6
//blt:7
//slt:8
//sll:9
//srl:10
//fadd:11
//fsub:12
//flw:13
//fsw:14
//fclass:15
//flt:16
//eof:17
///////////////////////////////////////////////////////////
reg [2:0] whichType;
//R_TYPE 0
//I_TYPE 1
//S_TYPE 2
//B_TYPE 3
//INVALID_TYPE 4
//EOF_TYPE 5
//////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////
//                Register
//////////////////////////////////////////////////////////
//32 signed 32-bit registers
//reg signed [(DATA_WIDTH -1):0] ireg [0:4];
//reg [WIDTH-1:0] array_name [ROWS-1:0];
reg signed [(DATA_WIDTH -1):0] ireg [0:31];

//32 precision floating-point registers
reg [(DATA_WIDTH -1):0] freg [0:31];

parameter signed [(DATA_WIDTH-1):0] MAX_VAL = 32'sb01111111111111111111111111111111;
parameter signed [(DATA_WIDTH-1):0] MIN_VAL = 32'sb10000000000000000000000000000000;

//for temporary register info
reg [4:0] rdidx;//register index from 0~31
reg signed [(DATA_WIDTH -1):0] rdval;

reg [4:0] fdidx;
reg [(DATA_WIDTH -1):0] fdval;

//
integer i;
integer j;
////////////////////////////////////////////////////////////






///////////////////////////////////////////////////////////
//                 Memory
//////////////////////////////////////////////////////////
//program counter for instruction
reg	signed [(ADDR_WIDTH-1):0] pc;//address is valid only [12:2] , so even with sign , range is ok. signed for judge

//for next instruction pc
reg	signed [(ADDR_WIDTH-1):0] pc2;

//for data pc
reg signed [(ADDR_WIDTH-1):0] pc3;

//Instructions: 0~4095
// From 0000_0000_0000_0000_000[0_0000_0000_00]00  :0 
// To 0000_0000_0000_0000_000[0_1111_1111_11]11  : 4095
//But actually the last valid iaddr for instruction should be 0000_0000_0000_0000_000[0_1111_1111_11]00
parameter signed [(ADDR_WIDTH-1):0] InstMin = 32'sb00000000000000000000000000000000;
parameter signed [(ADDR_WIDTH-1):0] InstMax = 32'sb00000000000000000000111111111111;


//Data
//From /0000_0000_0000_0000_000[1_0000_0000_00]00 : 4096
//To 0000_0000_0000_0000_000[1_1111_1111_11]11 :8191
//But actually the last valid iaddr for data should be 0000_0000_0000_0000_000[1_1111_1111_11]00 
parameter signed [(ADDR_WIDTH-1):0] DataMin = 32'sb00000000000000000001000000000000; 
parameter signed [(ADDR_WIDTH-1):0] DataMax = 32'sb00000000000000000001111111111111;

////////////////////////////////////////////////////////////////////






/////////////////////////////////////////////////////////////////////////
//                   Temporary Input/Output
/////////////////////////////////////////////////////////////////////////
//Output
//for status ouput
reg [2:0] t_o_status;//0~5
reg t_o_status_valid;

//to memory's ouput from core
reg [(ADDR_WIDTH-1) :0] t_o_addr;
reg [(DATA_WIDTH-1) :0] t_o_wdata;
reg t_o_we;
//////////////////////////////
//Input
//from memory's input to core
reg [(DATA_WIDTH-1) : 0] t_i_rdata;
//reg [(DATA_WIDTH-1) : 0] faketemp;
///////////////////////////////////////////////////////////////////////////






//////////////////////////////////////////////////////////////////////////////
//                           Decode
//////////////////////////////////////////////////////////////////////////////
//check add/sub/addi
reg signed [32:0] TEMP; //to avoid overflow

//for checking address //for imm
reg signed [32:0] TEMP2; //to avoid overflow //because it may be negative 

//for fadd, fsub //precision format
reg [31:0] TEMP3;

//for fsub //precision format
reg [31:0] buf1;
reg [31:0] buf2;

//check fclass
reg [3:0] check;

//for checking second fclass
reg [3:0] check2;

//for checking third fclass
reg [3:0] check3;

//check if alu is completed
reg done;
///////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ---------------------------------------------------------------------------
// Continuous Assignment
// ---------------------------------------------------------------------------
// ---- Add your own wire data assignments here if needed ---- //

//Testbench IOs
assign o_status = t_o_status;
assign o_status_valid = t_o_status_valid;

// Memory IOs
assign o_addr = t_o_addr;
assign o_wdata = t_o_wdata;
assign o_we = t_o_we;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// ---------------------------------------------------------------------------
// Combinational Blocks
// ---------------------------------------------------------------------------
// ---- Write your conbinational block design here ---- //


////////////////////////////////////////////////////////////////////////////////
//                      Find What Instruction
/////////////////////////////////////////////////////////////////////////////////
function automatic [4:0] judge;
input [(DATA_WIDTH-1) :0] tInst;

reg [6:0] optmp;
reg [6:0] funct7;
reg [2:0] funct3;

begin
    //////////////////////////////////
    optmp=0;
    funct7=0;
    funct3=0;
    ////////////////////////////////////
    optmp = tInst[6:0];

    //$display("start:");
    //$display("my inst: %b", tInst);


    case(optmp)
        `OP_ADD:
            //opcode/ 7'b0110011 //all R type
            //OP_ADD
            //OP_SUB
            //OP_SLT
            //OP_SLL
            //OP_SRL
            //
            begin
                funct7 = tInst[31:25];
                funct3 = tInst[14:12];

                if(funct7 == `FUNCT7_SUB)
                    //funct7/7'b0100000 //sub
                    begin
                        judge = 2;
                    end
                else
                    begin
                        if(funct3 == `FUNCT3_ADD)//funct3/3'b000 //add
                            begin
                                judge = 1;
                            end
                        else if(funct3 == `FUNCT3_SLT)//funct3 /3'b010 //slt
                            begin
                                judge = 8;
                            end
                        else if(funct3 == `FUNCT3_SLL)//funct3 /3'b001 //sll
                            begin
                                judge = 9;
                            end
                        else //funct3 /3'b101 //srl
                            begin
                                judge = 10;
                            end
                    end
            end

        `OP_FADD:
            //opcode/ 7'b1010011 // all R type
            //OP_FADD
            //OP_FSUB
            //OP_FCLASS
            //OP_FLT
            begin
                funct7 = tInst[31:25];
                funct3 = tInst[14:12];

                if (funct7 == `FUNCT7_FADD)//7'b0000000 //fadd
                    begin
                        judge=11;
                    end
                else if(funct7 == `FUNCT7_FSUB) //7'b0000100 //fsub
                    begin
                        judge=12;
                    end
                else if(funct7 == `FUNCT7_FCLASS) // 7'b1110000//fclass
                    begin
                        judge=15;
                    end
                else //7'b1010000 //flt
                    begin
                        judge=16;
                    end
            end
        
        `OP_BEQ:
            //opcode/7'b1100011/all B type
            //OP_BEQ
            //OP_BLT
            begin
                funct3 = tInst[14:12];

                //$display("beq inst: %b", funct3);


                




                if(funct3 == `FUNCT3_BEQ)//beq/3'b000
                    begin
                        //$display("choice A");
                        judge =6;
                    end
                else//blt/3'b100
                    begin
                        //$display("choice B");
                        judge =7;
                    end
            end
        `OP_LW://opcode/7'b0000011/I type
            begin
                judge=4;
            end
        `OP_FLW://opcode/7'b0000111/I type
            begin
                judge=13;
            end
        `OP_FSW://opcode/7'b0100111 //S type
            begin
                judge=14;
            end
        `OP_ADDI://opcode/7'b0010011 //I type
            begin
                judge=3;
            end
        `OP_SW://opcode/7'b0100011 // S type
            begin
                judge =5;
            end
        default://opcode/7'b1110011/eof type//OP_EOF//
            begin
                judge=17;
            end
    endcase



    //$display("end:");
end
endfunction
//////////////////////////////////////////////////////////////////////////////////







///////////////////////////////////////////////////////////////////////////////////////////
//                            Find What Type
///////////////////////////////////////////////////////////////////////////////////////////
function automatic [2:0] findType;
input [4:0] see;

begin
    if((see == 1) || (see == 2) || (see == 8) || (see == 9) || (see ==10) || (see == 11) || (see == 12) || (see == 15) || (see == 16)) //R
        begin
            findType = `R_TYPE;
        end
    else if ((see == 6) || (see == 7)) //B
        begin
            findType = `B_TYPE;
        end
    else if ((see == 4) || (see == 13) || (see == 3) )//I
        begin
            findType = `I_TYPE;
        end
    else if ((see == 14) || (see == 5)) //S
        begin
            findType = `S_TYPE;
        end
    else
        begin
            findType = `EOF_TYPE;
        end
end
endfunction
//INVALID_TYPE
/////////////////////////////////////////////////////////////////////////////////////////














////////////////////////////////////////////////////////////////////////////////////////////
//                                 To Decide Floating Type
////////////////////////////////////////////////////////////////////////////////////////////
function automatic [3:0] myfclass;
input [(DATA_WIDTH-1):0] myfloat;
//
reg sign;
reg [7:0] exp;
reg [22:0] mantissa;

begin
    //
    sign = myfloat[31];
    exp = myfloat[30:23];
    mantissa = myfloat[22:0];



    if((exp>0) && (exp<255))
        begin
            //normal numbers
            if (sign ==0)
                begin
                    myfclass= `FLOAT_POS_NORM;
                end
            else
                begin
                    myfclass= `FLOAT_NEG_NORM;
                end
        
        end
    else if(exp == 255)
        begin
            //exp=255
            //positive infinity
            //negative infinity
            //Not-a-Number

            
            if (mantissa==0)
                begin
                    if (sign ==0)
                        begin
                            myfclass= `FLOAT_POS_INF;
                        end
                    else
                        begin
                            myfclass= `FLOAT_NEG_INF;
                        end
                end
            else
                begin
                    myfclass= `FLOAT_NAN;
                end
        end
    else
        begin
            //exp=0
            //subnormal numbers
            //signed zero
            if (mantissa==0)//signed zero
                begin
                    if (sign ==0)
                        begin
                            myfclass= `FLOAT_POS_ZERO;
                        end
                    else
                        begin
                            myfclass= `FLOAT_NEG_ZERO;
                        end
                end
            else
                begin
                    if (sign ==0)
                        begin
                            myfclass= `FLOAT_POS_SUBNORM;
                        end
                    else
                        begin
                            myfclass= `FLOAT_NEG_SUBNORM;
                        end
                end
        end
end
endfunction
///////////////////////////////////////////////////////////////////////////////////////////////////








//////////////////////////////////////////////////////////////////////////////////////////////
//                           fadd and fsub
////////////////////////////////////////////////////////////////////////////////////////////////
function automatic [31:0] myfadd;


/////////////////////////////////////////////////
//                    Step1
/////////////////////////////////////////////////
// in 32 bit single precision format
input [(DATA_WIDTH-1):0] dataA;
input [(DATA_WIDTH-1):0] dataB;


reg [3:0] type1;
reg [3:0] type2;
//////////////////////////////////////////////////

////////////////////////////////////////////////
////                   Step3
/////////////////////////////////////////////////

//dataA
reg [10:0] expo1; // unsigned
reg [22:0] man1; //unsigned
reg sign1;

//reg [10 : 0] sa0;
reg signed [10 : 0] sa1;
reg [511 : 0] ta1; //512 bit
reg [511 : 0] ta2; //512 bit
reg [511 : 0] ta3; //512 bit
reg [511 : 0] ta4; //512 bit

//////////////////////////////
//dataB
reg [10:0] expo2; // unsigned
reg [22:0] man2;
reg sign2;

//reg [10 : 0] sb0;
reg signed [10 : 0] sb1;
reg [511 : 0] tb1; //512 bit
reg [511 : 0] tb2; //512 bit
reg [511 : 0] tb3; //512 bit
reg [511 : 0] tb4; //512 bit
/////////////////////////////////////////////////////



////////////////////////////////////

/////////////////////////////////////////////
//               Step 4
////////////////////////////////////////////
reg signed [512 : 0] res;
reg signed [512 : 0] res2;

reg [8:0] msbpos;
reg [8:0] gidx;
reg [8:0] ridx;
reg [8:0] sidx;

reg sto;
integer m;
reg STOP;
reg sign3;

integer k;
////////////////////////////////////////////


//////////////////////////////////////////////////
//               Step 5
/////////////////////////////////////////////////
reg signed [512 : 0] res3;
reg [10:0] myE;

reg G;
reg R;
reg S;
///////////////////////////////////////////////////

reg [31 : 0] finn;


/////////////////////////////////////////////////////////////////////////////////////
//                          START
/////////////////////////////////////////////////////////////////////////////////////
begin
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    type1 =0;
    type2 =0;

    expo1 =0;
    man1 =0;
    sign1 =0;

    sa1 =0;
    ta1 =0;
    ta2 =0;
    ta3 =0; 
    ta4 =0;

    expo2 =0;
    man2 =0;
    sign2 =0;

    sb1 =0;
    tb1 =0;
    tb2 =0;
    tb3 =0; 
    tb4 =0; 

    res =0;
    res2 =0;

    msbpos =0;
    gidx=0;
    ridx=0;
    sidx=0;
    sto=0;

    STOP =0;
    sign3 =0;

    res3 =0;
    myE =0;

    G =0;
    R =0;
    S =0;

    

    finn =0;
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          STEP1: See Type
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    type1 = myfclass(dataA);
    type2 = myfclass(dataB);


    if((type1 == `FLOAT_NAN)  || (type2 == `FLOAT_NAN))
        begin
            finn = {1'b0, 8'b11111111,23'b1};
        end
    else if((type1 == `FLOAT_POS_INF) || (type2 == `FLOAT_POS_INF) || (type1 == `FLOAT_NEG_INF) || (type2 == `FLOAT_NEG_INF))
        begin
            if((type1 == `FLOAT_POS_INF) && (type2 == `FLOAT_POS_INF))
                begin
                    finn = {1'b0, 8'b11111111,23'b0};
                end
            else if((type1 == `FLOAT_NEG_INF) && (type2 == `FLOAT_NEG_INF))
                begin
                    finn = {1'b1, 8'b11111111,23'b0};
                end
            else
                //whatever
                begin
                    finn = {1'b0, 8'b11111111,23'b0};
                end
        end
    else if ((type1 == `FLOAT_POS_ZERO) || (type2 == `FLOAT_POS_ZERO) || (type1 == `FLOAT_NEG_ZERO) || (type2 == `FLOAT_NEG_ZERO))
        begin
            if( (type1 != `FLOAT_POS_ZERO)  && (type1 !=  `FLOAT_NEG_ZERO) )
                begin
                    finn = dataA;
                end
            else if ((type2 != `FLOAT_POS_ZERO)  && (type2 !=  `FLOAT_NEG_ZERO))
                begin
                    finn = dataB;
                end
            else
                begin
                    //tutor says +0 // avoid +0 -0 +0
                    finn = {1'b0, 8'b0, 23'b0};
                end
        end
    else
        begin
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //                                            STEP2
        ////////////////////////////////////////////////////////////////////////
        //CONSIDER
        //normal numbers
        //subnormal numbers
        /////////////////////////
        //DO NOT consider
        //+INF
        //-INF
        //NaN
        //+0
        //-0
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////
            //                                   STEP 3
            //Transform the format to binary data.
            ///////////////////////
            //from mantissa point
            //2^-23 is at ta2[256]
            //2^-1 is at ta2[278]
            //2^0 is at ta2 [279]
            ////////////////////////
            /////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////
            //                             Data A
            ////////////////////////////////////////////////////////////////////////////
            expo1 = dataA[30:23]; // expo1 is 11 bit unsigned
            man1 = dataA[22:0]; //man1 is 23 bit unsigned
            sign1 = dataA[31]; //1 bit
            
            ta1 = man1;// ta1 is 512 bit
            ta2 = ta1 << 256; //ta2 is 512 bit
            ///////////////////////////

            ///////////////////////////
            if ( (type1 == `FLOAT_POS_NORM)  || (type1 == `FLOAT_NEG_NORM)) // normal number
                begin
                    ////////////////////////////////////////////
                    //for normal number
                    //you have to add 2^0 as 1 by your self
                    ////////////////////////////////////////////
                    ta2[279] = 1; 
                    ///////////////////////////////////////////////////////
                    sa1 = $signed(expo1) - 8'sb01111111; //expo1: 11 bit   //e-127

                    if(sa1 >0)
                        begin
                            ta3 = ta2 << sa1;
                        end
                    else if(sa1 <0)
                        begin
                            ta3 = ta2 >> (~(sa1)+1);
                        end
                    else
                        begin
                            ta3 =ta2;
                        end
                    //////////////////////////////////

                    if(sign1 ==1)
                        begin
                            ta4 = ~(ta3) +1; //negative number
                        end
                    else
                        begin
                            ta4 = ta3;
                        end
             
                end
            ////////////////////////////////////////////
            else //subnormal number    //if ((type1 == `FLOAT_POS_SUBNORM)  || (type1 == `FLOAT_NEG_SUBNORM))
                begin
                    ta3 = ta2 >> 126;

                    if(sign1 ==1)
                        begin
                            ta4 = ~(ta3) +1;// become negative number
                        end
                    else
                        begin
                            ta4 = ta3;
                        end
                end
           
            ///////////////////////////////////////////////////////////////////////////
            //                        Data B
            ///////////////////////////////////////////////////////////////////////////
            expo2 = dataB[30:23];
            man2 = dataB[22:0];
            sign2 = dataB[31];

            tb1 = man2;    
            tb2 = tb1 << 256;

            if ( (type2 == `FLOAT_POS_NORM)  || (type2 == `FLOAT_NEG_NORM))
                begin
                    ////////////////////////////////////////////
                    //for normal number
                    //you have to add 2^0 as 1 by your self
                    ////////////////////////////////////////////
                    tb2[279] = 1; 
                    ///////////////////////////////////////////////////////
                    sb1 = $signed(expo2) - 8'sb01111111;//e-127

                    if(sb1 >0)
                        begin
                            tb3 = tb2 << sb1;
                        end
                    else if(sb1 <0)
                        begin
                            tb3 = tb2 >> (~(sb1)+1);
                        end
                    else
                        begin
                            tb3 =tb2;
                        end
                    //////////////////////////////////

                    if(sign2 ==1)
                        begin
                            tb4 = ~(tb3) +1;
                        end
                    else
                        begin
                            tb4 = tb3;
                        end
             
                end
            /////////////////////////////////////////////////////////////////
            else                   //if ((type2 == `FLOAT_POS_SUBNORM)  || (type2 == `FLOAT_NEG_SUBNORM))
                begin
                    tb3 = tb2 >> 126;

                    if(sign2 ==1)
                        begin
                            tb4 = ~(tb3) +1;
                        end
                    else
                        begin
                            tb4 = tb3;
                        end
                end
            ///////////////////////////////////////////////////////////////////////////








            ////////////////////////////////////////////////////////////////////////////
            //                                 Step 4
            /////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////
            //No matter what
            //2^-149 is at ta2[130]
            //2^-127 is at ta2[152]
            //2^-126 is at ta2[153]

            //2^-23 is at ta2[256]
            //2^-1 is at ta2[278]
            //2^0 is at ta2 [279]

            //2^127 is at ta2[406]
            //2^128 is at ta2[407]
            ///////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////
            //positive infinity
            //if any 1 is found above 2^128, then it is +INF
            ///////////////////////////////////////////////////////////////
            //normal numbers
            //the lowest range: (2^-126 ~2^-148)
            //the highest range: (2^127  ~ 2^105)
            //=>the msb 1 is during 2^127 ~2^-126, if no 1 is found, then it is not normal numbers. CHECK Subnormal
            ////////////////////////////////////////////////////////////
            //subnormal numbers
            //for 2^-126: normal number is 1, subnormal is 0
            //range : 2^-127 ~ -149
            //NO 1 is found at 2^-126 and above, then it MAY BE subnormal.
            //if no 1 is found above 2^-149, then it is positive zero
            /////////////////////////////////////////////////////////////
            //positive zero
            //NO msb 1 is found above 2^-149
            //////////////////////////////////////////////////////////////



            res = $signed(ta4) + $signed(tb4); // res is 513 bit


            ///////////////////////////////////////////////////////////
            //     When result is +0, -0
            ///////////////////////////////////////////////////////////
            if(res[511:0] ==0)//include +0, -0 //avoid 2-2=0 real 0, not near 0
                begin
                    //no matter what
                    finn = {1'b0,8'b0,23'b0};
                end

            
            else
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                // at least one 1 // not real 0
                begin
                    
                    //////////////////////////////////////////////////////////
                    //               use postive to calculate
                    //////////////////////////////////////////////////////////
                    if(res <0)
                        begin
                            res2 = ~(res) + 1;
                            sign3=1;
                        end
                    else
                        begin
                            res2 = res;
                            sign3=0;
                        end
                    //////////////////////////////////////
                    //////////////////////////////////////////////////////////
                    //               Find the MSB of  1
                    //////////////////////////////////////////////////////////
                    STOP=0;
                    msbpos=0;

                    for(k = 511; k > 0; k = k - 1)
                        begin
                            if(STOP)
                                begin
                                    STOP=1;
                                end
                            else
                                begin
                                    if(res2[k]==1)
                                        begin
                                            msbpos=k;
                                            STOP=1;
                                        end
                                    else
                                        begin
                                            STOP=0;
                                        end
                                end
                        end
                    /////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////
                    //                  Step 5
                    //                 Round to Nearest Even
                    //////////////////////////////////////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////////////////////////////////////
                    //                      +INF  or -INF
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    if(msbpos>406)
                        begin
                            //2^127 is at ta2[406]
                            //2^128 is at ta2[407]
                            //+INF
                            if(sign3==1)
                                begin
                                    finn = {1'b1,8'b11111111,23'b0};
                                end
                            else
                                begin
                                    finn = {1'b0,8'b11111111,23'b0};
                                end

                        end
                    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //                                Normal number
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    else if(msbpos >152)
                        begin
                            //////////////////////////////////////////
                            //normal numbers
                            //the lowest range: (2^-126 ~2^-148)
                            //the highest range: (2^127  ~ 2^105)
                            /////////////////////////////////////////
                            //2^-127 is at ta2[152]
                            //2^-126 is at ta2[153]

                            //2^-23 is at ta2[256]
                            //2^-1 is at ta2[278]
                            //2^0 is at ta2 [279]

                            //2^127 is at ta2[406]
                            //////////////////////////////////////////////
                            //////////////////////////////////////////////////////
                            gidx = msbpos-23;
                            G= res2[gidx];

                            ridx = msbpos-24;
                            R= res2[ridx];

                            sidx = msbpos-25;
                            //S= |(res2[0 +:sidx]);

                            sto=0;
                            S=0;
                            ////////////////////////////////////////////
                            for(m=406; m>0; m= m-1)
                                begin
                                    if( m< (sidx+1) )
                                        begin
                                            if(sto==0)
                                                begin
                                                    if(res2[m]==1)
                                                        begin
                                                            sto =1;
                                                            S=1;
                                                        end
                                                    else
                                                        begin
                                                            sto =0;
                                                            //S =0;
                                                        end
                                                end
                                            else
                                                begin
                                                    sto=1;
                                                end
                                        end
                                    else
                                        begin
                                            //S=0;
                                            sto=0;
                                        end
                                end
                            /////////////////////////////////////////////////





                        //////////////////////////////////////////////////////////////////
                        //                     If R is 0
                        /////////////////////////////////////////////////////////////////////
                            if(R==0)
                                begin
                                    //No up
                                    myE = (msbpos-279) +127; // myE is 11 bit unsigned
                                    if(sign3==1)
                                        begin
                                            //your exp:(msbpos-279)+127
                                            finn = {1'b1, myE[7:0], res2[(msbpos-1)  -:23]};
                                        end
                                    else
                                        begin
                                            finn = {1'b0, myE[7:0], res2[(msbpos-1)  -:23]};
                                        end
                                end
                            else
                                ///////////////////////////////////////////////////////////////////////
                                begin
                        /////////////////////////////////////////////////////////////////////////////
                        //                   IF R is 1
                        ////////////////////////////////////////////////////////////////////////////
                                    //////////////////////////////////////////////////////////////////
                                    //           If S is 1
                                    /////////////////////////////////////////////////////////////////////
                                
                                    if(S==1)
                                    //Yes up
                                        begin

                                            if(sign3 ==1)
                                                begin
                                                    res3 = res2 - (1'b1 << (msbpos-23));
                                                    ////////////////////////////////////
                                                    //check if it becomes subnormal number
                                                    if(msbpos==153)
                                                        begin
                                                            finn = {1'b1, 8'b0, res3[152:130]};
                                                        end
                                                    else
                                                        begin
                                                            if(res3[msbpos] ==1)
                                                                begin
                                                                    myE = (msbpos -279) +127;
                                                                    finn = {1'b1, myE[7:0], res3[(msbpos-1)  -:23]};
                                                                end
                                                            else
                                                                begin//only happen when res2 =1.000000 form, then it becomes 0.1111
                                                                    myE = (msbpos -1 -279) +127;
                                                                    finn = {1'b1, myE[7:0], res3[(msbpos-2)  -:23]};
                                                                end
                                                        end
                                                end
                                            else
                                                begin
                                                    //add 1 at guard bit
                                                    res3 = res2 + (1'b1 << (msbpos-23));

                                                    if(res3[(msbpos+1)] ==1)
                                                        //1 more bit
                                                        begin
                                                        ////////////////////////////////////////////////////////////////////////////////////////
                                                            if((msbpos+1) ==407)
                                                                //it become INF
                                                                begin
                                                                    finn = {1'b0,8'b11111111,23'b0};
                                                                end
                                                            else
                                                                begin
                                                                    myE = (msbpos + 1 -279) +127;
                                                                    finn = {1'b0, myE[7:0], res3[(msbpos)  -:23]};
                                                                end
                                                        ////////////////////////////////////////////////////////////////
                                    
                                                        end
                                                    else
                                                    /////////////////////////////////////////////////////////////////////////////////
                                                        begin
                                                            myE = (msbpos -279) +127;
                                                            finn = {1'b0, myE[7:0], res3[(msbpos-1)  -:23]};
                                                        end
                                                end
                                        end
                                    else
                                    ////////////////////////////////////////////////////////////////////////////
                                    //                IF  S is 0
                                    //////////////////////////////////////////////////////////////////////////////
                                    //
                                        begin
                                            //////////////////////////////////////////////////////////////
                                            //                IF G is 1
                                            /////////////////////////////////////////////////////////////
                                            if(G==1)
                                            //Yes up
                                                begin
                                                    if(sign3 ==1)
                                                        begin
                                                            res3 = res2 - (1'b1 << (msbpos-23));
                                                            ////////////////////////////////////
                                                            //check if it becomes subnormal number
                                                            if(msbpos==153)
                                                                begin
                                                                    finn = {1'b1, 8'b0, res3[152:130]};
                                                                end
                                                            else
                                                                begin
                                                                    if(res3[msbpos] ==1)
                                                                        begin
                                                                            myE = (msbpos -279) +127;
                                                                            finn = {1'b1, myE[7:0], res3[(msbpos-1)  -:23]};
                                                                        end
                                                                    else
                                                                        begin
                                                                            myE = (msbpos -1 -279) +127;
                                                                            finn = {1'b1, myE[7:0], res3[(msbpos-2)  -:23]};
                                                                        end
                                                                end
                                                        end
                                                    else
                                                        begin
                                                            //add 1 at guard bit
                                                            res3 = res2 + (1'b1 << (msbpos-23));

                                                            if(res3[(msbpos+1)] ==1)
                                                                //1 more bit
                                                                begin
                                                                ////////////////////////////////////////////////////////////////////////////////////////
                                                                if((msbpos+1) ==407)
                                                                    //it become INF
                                                                    begin
                                                                        finn = {1'b0,8'b11111111,23'b0};
                                                                    end
                                                                else
                                                                    begin
                                                                        myE = (msbpos + 1 -279) +127;
                                                                        finn = {1'b0, myE[7:0], res3[(msbpos)  -:23]};
                                                                    end
                                                                ////////////////////////////////////////////////////////////////
                                    
                                                                end
                                                            else
                                                                /////////////////////////////////////////////////////////////////////////////////
                                                                begin
                                                                    myE = (msbpos -279) +127;
                                                                    finn = {1'b0, myE[7:0], res3[(msbpos-1)  -:23]};
                                                                end
                                                        end


                                                end
                                            ///////////////////////////////////////////////////////////////////
                                            //                         IF G is 0
                                            ////////////////////////////////////////////////////////////////////
                                            else
                                                //No up
                                                begin
                                                    myE = (msbpos-279) +127;
                                                    if(sign3==1)
                                                        begin
                                                            //your exp:(msbpos-279)+127
                                                            finn = {1'b1, myE[7:0], res2[(msbpos-1)  -:23]};
                                                        end
                                                    else
                                                        begin
                                                            finn = {1'b0, myE[7:0], res2[(msbpos-1)  -:23]};
                                                        end
                                                end
                                    //////////////////////////////////////////////////////////////////////////
                                    //           End of S
                                    /////////////////////////////////////////////////////////////////////////
                                        end
                                end
                        //////////////////////////////////////////////////////////////////////////////////////
                        //                   End of R
                        ///////////////////////////////////////////////////////////////////////////////////////




                        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        end






                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //                           END OF Normal Numbers
                    //
                    //                           START OF SUBNORMAL NUMBERS
                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    else if(msbpos>129)
                        begin
                            //subnormal number
                            //2^-149 is at ta2[130]
                            //2^-127 is at ta2[152]
                            //2^-126 is at ta2[153]
                            ///////////////////////////////////
                            G= res2[130];
                            R= res2[129];
                            S= |(res2[128:0]);

                            //////////////////////////////////////////////////////////////////////
                            //                If R is 0
                            ///////////////////////////////////////////////////////////////////////////////////
                            if(R==0)
                                //No up
                                begin
                                    if(sign3==1)
                                        begin
                                            //res3 = res2 - (1'b1 << 130)
                                            finn = {1'b1,8'b0,res2[152:130]};
                                        end
                                    else
                                        begin
                                            finn = {1'b0,8'b0,res2[152:130]};
                                        end
                                end
                            else
                            ///////////////////////////////////////////////////////////////////////
                            //                   If R is 1
                            //////////////////////////////////////////////////////////////////////
                                begin
                                    ///////////////////////////////////////////////////////////
                                    //           If S is 1
                                    //////////////////////////////////////////////////////
                                    if(S==1)
                                        //Yes up
                                        begin

                                        ////////////////////////////////////////////
                                        if(sign3==1)
                                            begin
                                                res3 = res2 - (1'b1 << 130);
                                                //check after up , if it becomes -0
                                                if(msbpos==130)
                                                    begin
                                                        //tutor says take this as +0
                                                        finn = {1'b0, 8'b0, 23'b0};
                                                    end
                                                else
                                                    begin
                                                        //still a subnormal number
                                                        finn = {1'b1, 8'b0, res3[152:130]};
                                                    end
                                            end
                                        else
                                            begin
                                                res3 = res2 + (1'b1 << 130);

                                                //check after up, if it becomes normal number
                                                if(res3[153] ==1)
                                                    begin
                                                        finn = {1'b0, 8'b00000001, res3[152:130]};
                                                        end
                                                else
                                                    begin
                                                        finn = {1'b0, 8'b0, res3[152:130]};
                                                    end


                                            end

                                        /////////////////////////////////////////

                                        end
                                    //////////////////////////////////////////////////////////////////////////
                                    //                       If S is 0
                                    //////////////////////////////////////////////////////////////////////////
                                    else
                                        begin
                                            ////////////////////////////////////////////////////////
                                            //              If G is 1
                                            /////////////////////////////////////////////////////////
                                            if(G==1)
                                            //YES UP
                                                begin
                                                    ////////////////////////////////////////////
                                                    if(sign3==1)
                                                        begin
                                                            res3 = res2 - (1'b1 << 130);
                                                            //check after up , if it becomes -0
                                                            if(msbpos==130)
                                                                begin
                                                                    //tutor says take this as +0
                                                                    finn = {1'b0, 8'b0, 23'b0};
                                                                end
                                                            else
                                                                begin
                                                                    //still a subnormal number
                                                                    finn = {1'b1, 8'b0, res3[152:130]};
                                                                end
                                                        end
                                                    else
                                                        begin
                                                            res3 = res2 + (1'b1 << 130);

                                                            //check after up, if it becomes normal number
                                                            if(res3[153] ==1)
                                                                begin
                                                                    finn = {1'b0, 8'b00000001, res3[152:130]};
                                                                end
                                                            else
                                                                begin
                                                                    finn = {1'b0, 8'b0, res3[152:130]};
                                                                end


                                                        end

                                                    /////////////////////////////////////////
                                                end
                                            ////////////////////////////////////////////////////////
                                            //    If G is 0
                                            ////////////////////////////////////////////////////////
                                            else
                                                //NO UP
                                                begin
                                                    if(sign3==1)
                                                        begin
                                                            //res3 = res2 - (1'b1 << 130)
                                                            finn = {1'b1,8'b0,res2[152:130]};
                                                        end
                                                    else
                                                        begin
                                                            finn = {1'b0,8'b0,res2[152:130]};
                                                        end
                                                end
                                        end
                                    /////////////////////////////////////////////////////////////////////
                                    //           Ens of S
                                    ///////////////////////////////////////////////////////////////////////
                                end
                            ////////////////////////////////////////////////////////
                            //              End of R
                            ///////////////////////////////////////////////////////////

                        end
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //            End of Subnormal
                    //
                    //            Start of number  small enough to be 0 
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    else
                        begin
                        // tackle near 0
                            //positive zero
                            //if(sign3==1)
                            //    begin
                            //        finn = {1'b1,8'b0,23'b0};
                            //    end
                            //else
                            //    begin
                            //        finn = {1'b0,8'b0,23'b0};
                            //    end
                            ///////////////////////////////////////////
                            //no matter what, consider as +0
                            finn = {1'b0,8'b0,23'b0};
                        end
    
    
    
                ////////////////////////////////////////
                ////////////////////////////////////////////////////////
    

                end
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //                    End of  Normal, Subnormal Discussion
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        end
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                End of Discussion of any case
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    myfadd = finn;
    //////////////////////////////////
end
endfunction


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////











///////////////////////////////////////////////////////////////
//                    flt function
///////////////////////////////////////////////////////////////
function automatic myflt;

// in 32 bit single precision format
input [(DATA_WIDTH-1):0] dataA;
input [(DATA_WIDTH-1):0] dataB;


reg [3:0] see1;
reg [3:0] see2;

reg [30:0] w1;
reg [30:0] w2;

reg ress;
//
//onlt normal numbers or subnormal numbers will be in this function
//
begin

    see1 =0;
    see2 =0;

    w1 =0;
    w2=0;
    ress=0;
    //////////////////////////////////////////
    see1 = myfclass(dataA);
    see2 = myfclass(dataB);
    /////////////////////////////////////
    //FLOAT_NEG_NORM
    //FLOAT_NEG_SUBNORM
    //FLOAT_NEG_ZERO
    //FLOAT_POS_ZERO
    //FLOAT_POS_SUBNORM
    //FLOAT_POS_NORM
    ///////////////////////////////////
    //FLOAT_NEG_INF
    //FLOAT_POS_INF
    //FLOAT_NAN
    ///////////////////////////////////
    // you cannot compare using 2's complement
    //////////////////////////////////
    if((see1 == `FLOAT_NEG_NORM))
        begin
            if( (see2 == `FLOAT_POS_NORM) || (see2 == `FLOAT_POS_SUBNORM) || (see2 == `FLOAT_POS_ZERO) || (see2 == `FLOAT_NEG_ZERO) || (see2 == `FLOAT_NEG_SUBNORM) )
                begin
                    ress =1;
                end
            else
                begin
                    w1 = dataA[30:0];
                    w2 = dataB[30:0];

                    if(w1 > w2)
                        begin
                            ress =1;
                        end
                    else
                        begin
                            ress =0;
                        end
                end
        end
    else if((see1 == `FLOAT_NEG_SUBNORM))
        begin
            if( (see2 == `FLOAT_POS_ZERO) || (see2 == `FLOAT_POS_SUBNORM) || (see2 == `FLOAT_POS_NORM) || (see2 == `FLOAT_NEG_ZERO) )
                begin
                    ress =1;
                end
            else if( (see2 == `FLOAT_NEG_NORM ) )
                begin
                    ress =0;
                end 
            else
                begin
                    w1 = dataA[30:0];
                    w2 = dataB[30:0];

                    if(w1 > w2)
                        begin
                            ress =1;
                        end
                    else
                        begin
                            ress =0;
                        end
                end
        end
    else if( (see1 == `FLOAT_NEG_ZERO))
        begin
            if((see2 == `FLOAT_POS_SUBNORM) || (see2 == `FLOAT_POS_NORM))
                begin
                    ress =1;
                end
            else if( (see2 == `FLOAT_NEG_SUBNORM) || (see2 == `FLOAT_NEG_NORM) )
                begin
                    ress =0;
                end
            else //including +0 -0
                begin
                    ress =0;
                end
        end
    else if((see1 == `FLOAT_POS_ZERO))
        begin
            if( (see2 == `FLOAT_POS_SUBNORM) || (see2 == `FLOAT_POS_NORM) )
                begin
                    ress =1;
                end
            else if( (see2 ==`FLOAT_NEG_NORM) || (see2 == `FLOAT_NEG_SUBNORM))
                begin
                    ress =0;
                end
            else //+0 -0
                begin
                    ress =0;
                end

        end
    else if((see1 == `FLOAT_POS_SUBNORM))
        begin
            if((see2 == `FLOAT_POS_NORM))
                begin
                    ress =1;
                end
            else if((see2 ==`FLOAT_NEG_NORM) || (see2 == `FLOAT_NEG_SUBNORM) || (see2 == `FLOAT_NEG_ZERO) || (see2 == `FLOAT_POS_ZERO))
                begin
                    ress =0;
                end
            else
                begin
                    w1 = dataA[30:0];
                    w2 = dataB[30:0];

                    if(w1 < w2)
                        begin
                            ress =1;
                        end
                    else
                        begin
                            ress =0;
                        end

                end
        end
    else
        begin

            if((see2 ==`FLOAT_NEG_NORM) || (see2 == `FLOAT_NEG_SUBNORM) || (see2 == `FLOAT_NEG_ZERO) || (see2 == `FLOAT_POS_ZERO) || (see2 ==`FLOAT_POS_SUBNORM ))
                begin
                    ress=0;
                end
            else
                begin
                    w1 = dataA[30:0];
                    w2 = dataB[30:0];

                    if(w1 < w2)
                        begin
                            ress =1;
                        end
                    else
                        begin
                            ress =0;
                        end
                end
        end
    /////////////////////////////////////////////////////////////////////
    myflt = ress;
    
end
endfunction
////////////////////////////////////////////////////////////////////////////////















///////////////////////////////////////////////////////////////////////////////////////////////////
//                              Main ALU Logic
//////////////////////////////////////////////////////////////////////////////////////////////////
always@(*)//t_i_rdata
begin
    ///////////
    done =0;
    ///////////


    ///////////////////////
    //for add/sub/addi to check overflow
    TEMP =0;

    //for checking address //for imm
    TEMP2 =0;

    //for fadd. fsub
    TEMP3 =0;

    //for fclass check
    check =0;

    //for checking second fclass
    check2 =0;

    //for check third fclass
    check3 =0;

    //for fsub
    buf1 =0;
    buf2 =0;

    //for deciding state type afterwards
    con=0;
    ////////////////////////


    ///////////////////////////////
    //register related
    rdval=0;
    rdidx=0;

    fdval=0;
    fdidx=0;
    ////////////////////////////

    //////////////////////////////
    //for next instruction pc
    pc2=0;
    pc3=0;
    /////////////////////////////


    /////////////////////////////////
    whatInst=0;
    whichType=0;
    ///////////////////////////////////
    
    //dead =0;
    //if ((pc <= InstMax) && (pc >= InstMin))
    //begin
    //$display("MY INSTRUCTION: %b", t_i_rdata);
    ////////////////////////////////
    whatInst = judge(t_i_rdata);

    //$display("whatInst: %b", whatInst);

    whichType = findType(whatInst);
    /////////////////////////////////
    //$display("Inst Before: %b", whatInst);
    //$display("Type Before: %b", whichType);

    case(whatInst)
        1:
        //add: 1
            begin

                ///////////////////////////////////////////////////////////////
                TEMP=  $signed(ireg[(t_i_rdata[19:15])])   +   $signed(ireg[(t_i_rdata[24:20])]); //33 bit signed
                //TEMP=signed( ireg[(t_i_rdata[19:15])] )+ signed( ireg[(t_i_rdata[24:20])] );

                if(TEMP>MAX_VAL)
                    begin
                        whichType = `INVALID_TYPE;
                    end
                else
                    if(TEMP<MIN_VAL)
                        begin
                            whichType = `INVALID_TYPE;
                        end
                    else
                        begin
                            //ireg[(t_i_rdata[11:7])] = TEMP;
                            rdval = TEMP;
                            rdidx = t_i_rdata[11:7];
                        end 
                /////////////////////////////////////////////////////////////
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                /////////////////////////////////////////////////////////////////
                pc2 = pc + 4;
            end
        2:
        //sub: 2
            begin
                /////////////////////////////////////////////////////////////
                TEMP=  $signed(ireg[(t_i_rdata[19:15])]) -  $signed(ireg[(t_i_rdata[24:20])]) ;

                if(TEMP>MAX_VAL)
                    begin
                        whichType = `INVALID_TYPE;
                    end
                else
                    if(TEMP<MIN_VAL)
                        begin
                            whichType = `INVALID_TYPE;
                        end
                    else
                        begin
                            //ireg[(t_i_rdata[11:7])] = TEMP;
                            rdval =TEMP;
                            rdidx = t_i_rdata[11:7];
                        end 
                ////////////////////////////////////////////////////////////


                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                //////////////////////////////////////////////////////////////
                pc2 = pc + 4;

            end
        3:
        //addi: 3
            begin

                //$display("In ADDI: %b", whichType);
                ///////////////////////////////////////////////////////////
                TEMP = $signed(ireg[(t_i_rdata[19:15])]) + $signed(t_i_rdata[31:20]);
                if(TEMP> MAX_VAL)
                    begin
                        whichType = `INVALID_TYPE;
                    end
                else
                    if(TEMP<MIN_VAL)
                        begin
                            whichType = `INVALID_TYPE;
                        end
                    else
                        begin
                            //ireg[(t_i_rdata[11:7])] = TEMP;

                            rdval = TEMP;
                            rdidx = t_i_rdata[11:7];
                        end
                //////////////////////////////////////////////////////////////////////
                //$display("After ADDI: %b", whichType);
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                //////////////////////////////////////////////////////////////////////
                pc2 = pc + 4;
            end
        4:
        //lw:4
            begin
                //rd =t_i_rdata[11:7];
                //r1 =t_i_rdata[19:15];
                //im= t_i_rdata[31:20];
                

                
                TEMP2 = $signed(ireg[(t_i_rdata[19:15])]) + $signed(t_i_rdata[31:20]); // 33 bit signed
                //lwidx =t_i_rdata[11:7];


                //$display("lw: %b", ireg[(t_i_rdata[19:15])] );
                //$display("lw2: %b", $signed(t_i_rdata[31:20]) );
                //$display("lw3: %b", TEMP2 );


                rdidx = t_i_rdata[11:7];

                if (TEMP2 >DataMax)
                    begin
                        whichType = `INVALID_TYPE;
                    end
                else
                    if (TEMP2 < DataMin)
                        begin
                            whichType = `INVALID_TYPE;
                        end
                    else
                        begin
                            pc3 = TEMP2[31:0];

                            //$display("YES LW");
                            //$display("lw4: %b", pc3 );
                        end
                //////////////////////////////////////////////////////
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                //////////////////////////////////////////////////////////////
                pc2 = pc + 4;
            end
        5:
        //sw:5
            begin
                //r1=t_i_rdata[19:15];
                //r2=t_i_rdata[24:20];
                //im= signed({t_i_rdata[31:25],t_i_rdata[11:7]});

                
                TEMP2 = $signed(ireg[(t_i_rdata[19:15])]) + $signed({t_i_rdata[31:25],t_i_rdata[11:7]});
                //swidx = t_i_rdata[24:20];
                rdval = ireg[t_i_rdata[24:20]];

                if (TEMP2 >DataMax)
                    begin
                        whichType = `INVALID_TYPE;
                    end
                else
                    if (TEMP2 < DataMin)
                        begin
                            whichType = `INVALID_TYPE;
                        end
                    else
                        begin
                            pc3 = TEMP2[31:0];
                        end
                //////////////////////////////////////////////////////////
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                //////////////////////////////////////////////////////////////
                pc2 = pc + 4;
            end
        6:
        //beq:6
            begin

                //r1 = t_i_rdata[19:15];
                //r2 = t_i_rdata[24:20];

                //imm = {t_i_rdata[31],t_i_rdata[7],t_i_rdata[30:25],t_i_rdata[11:8]};

                TEMP2 = pc + $signed({t_i_rdata[31],t_i_rdata[7],t_i_rdata[30:25],t_i_rdata[11:8], 1'b0});

                //$display("r1: %b", ireg[(t_i_rdata[19:15])] );
                //$display("r2: %b", ireg[(t_i_rdata[24:20])] );
                
                if(  $signed(ireg[(t_i_rdata[19:15])]) == $signed(ireg[(t_i_rdata[24:20])])  )
                    begin

                        if ( TEMP2 > InstMax)
                            begin
                                pc2 = pc;
                                whichType = `INVALID_TYPE;
                            end
                        else
                            begin
                                if ( TEMP2 < InstMin)
                                    begin
                                        pc2 = pc;
                                        whichType = `INVALID_TYPE;
                                    end
                                else
                                    begin
                                        pc2 = TEMP2[31:0];
                                    end
                            end
                    
                    end
                else
                    begin
                        //if((pc + 4) > InstMax)
                        //    begin
                        //        whichType = INVALID_TYPE;
                        //        pc2 = pc;
                        //    end
                        //else
                        //    begin
                        //        pc2 = pc + 4;
                        //    end
                        ////////////////////////////////
                        pc2 = pc + 4;
                    end
                ////////////////////////////////////////////////////////////



            end
        7:
        //blt:7
            begin

                TEMP2 = pc + $signed({t_i_rdata[31],t_i_rdata[7],t_i_rdata[30:25],t_i_rdata[11:8], 1'b0});


                //$display("blt");
                //$display("r1: %b", ireg[(t_i_rdata[19:15])] );
                //$display("r2: %b", ireg[(t_i_rdata[24:20])] );






                if(  $signed(ireg[(t_i_rdata[19:15])]) < $signed(ireg[(t_i_rdata[24:20])]) )
                    begin
                        if (TEMP2 > InstMax)
                            begin
                                pc2 = pc;
                                whichType = `INVALID_TYPE;
                            end
                        else
                            begin
                                if (TEMP2 < InstMin)
                                    begin
                                        pc2 = pc;
                                        whichType = `INVALID_TYPE;
                                    end
                                else
                                    begin
                                        pc2 = TEMP2[31:0];
                                    end
                            end
                    end
                else
                    begin
                        //if((pc + 4) > InstMax)
                        //    begin
                        //        whichType = INVALID_TYPE;
                        //        pc2 = pc;
                        //    end
                        //else
                        //    begin
                        //        pc2 = pc + 4;
                        //    end
                        //////////////////////////////
                        pc2 = pc + 4;

                    end

            end
        8:
        //slt:8
            begin

                //r1= ireg[(t_i_rdata[19:15])];
                //r2 = ireg[(t_i_rdata[24:20])];

                //rd=ireg[(t_i_rdata[11:7])]
                if(  $signed( ireg[(t_i_rdata[19:15])] )<  $signed(ireg[(t_i_rdata[24:20])] ) )
                    begin
                        //ireg[(t_i_rdata[11:7])]= 1;
                        rdidx = t_i_rdata[11:7];
                        rdval = 32'sb00000000000000000000000000000001;
                    end
                else
                    begin
                        //ireg[(t_i_rdata[11:7])]= 0;
                        rdidx = t_i_rdata[11:7];
                        rdval = 32'sb00000000000000000000000000000000;

                    end
                ///////////////////////////////////////
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                ////////////////////////////////////////
                pc2 = pc + 4;
            end
        9:
        //sll:9
            begin
                //r1= ireg[(t_i_rdata[19:15])];
                //r2 = ireg[(t_i_rdata[24:20])];
                //rd=ireg[(t_i_rdata[11:7])];

                //ireg[(t_i_rdata[11:7])] = ireg[(t_i_rdata[19:15])] <<< (ireg[(t_i_rdata[24:20])]);
                ////////////////////////////////////////////////////////////////////////////////////////
                //you should avoid a negative shift count

                
                ///////////////////////////////////////////////////////////////////////////////
                //if(ireg[(t_i_rdata[24:20])] <0)
                //    begin
                //        rdval = ireg[(t_i_rdata[19:15])] >> (~(ireg[(t_i_rdata[24:20])]) +1)   ; //Unsigned Operation
                //    end
                //else
                //    begin
                //        rdval = ireg[(t_i_rdata[19:15])] << (ireg[(t_i_rdata[24:20])]); //Unsigned Operation
                //    end
                ///////////////////////////////////////////////////////////////////////////////////////
                rdval = ireg[(t_i_rdata[19:15])] << $unsigned(ireg[(t_i_rdata[24:20])]); //Unsigned Operation


                rdidx = t_i_rdata[11:7];
                
                //////////////////////////////
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                /////////////////////////////////
                pc2 = pc + 4;
            end
        10:
        //srl:10
            begin
                //ireg[(t_i_rdata[11:7])] = ireg[(t_i_rdata[19:15])] >>> (ireg[(t_i_rdata[24:20])]);
                
                

                ////////////////////////////////////////////////////////////////////////
                //if(ireg[(t_i_rdata[24:20])] <0)
                //    begin
                //        rdval = ireg[(t_i_rdata[19:15])] << ( ~(ireg[(t_i_rdata[24:20])]) +1);
                //    end
                //else
                //    begin
                //        rdval = ireg[(t_i_rdata[19:15])] >> (ireg[(t_i_rdata[24:20])]);
                //    end
                ////////////////////////////////////////////////////////////////////////////
                rdval = ireg[(t_i_rdata[19:15])] >> $unsigned(ireg[(t_i_rdata[24:20])]);


                rdidx= t_i_rdata[11:7];
                
                /////////////////////////
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                ////////////////////////////////
                pc2 = pc + 4;
            end
        11:
        //fadd:11
            begin
                //TEMP=freg[(t_i_rdata[19:15])]+freg[(t_i_rdata[24:20])];

                check = myfclass( freg[(t_i_rdata[19:15])] );
                check2 = myfclass( freg[(t_i_rdata[24:20])] );

                if((check == `FLOAT_NEG_INF) || (check == `FLOAT_POS_INF) || (check == `FLOAT_NAN) || (check2 == `FLOAT_NEG_INF) || (check2 == `FLOAT_POS_INF) || (check2 == `FLOAT_NAN) )
                    begin
                        whichType = `INVALID_TYPE;
                    end
                else
                    begin
                        TEMP3 = myfadd(  freg[(t_i_rdata[19:15])], freg[(t_i_rdata[24:20])]  );

                        check3 = myfclass( TEMP3 );
                        
                        if( (check3 == `FLOAT_NEG_INF) || (check3 == `FLOAT_POS_INF) || (check3 == `FLOAT_NAN))
                            begin
                                whichType = `INVALID_TYPE;
                            end
                        else
                            begin

                                //freg[(t_i_rdata[11:7])] = TEMP;
                                fdval = TEMP3;
                                fdidx = t_i_rdata[11:7];
                            end
                    end

                /////////////////////////////////
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                ///////////////////////////////////
                pc2 = pc + 4;
            end
        12:
        //fsub:12
            begin
                //TEMP=freg[(t_i_rdata[19:15])]-freg[(t_i_rdata[24:20])];
                check = myfclass( freg[(t_i_rdata[19:15])] );
                check2 = myfclass( freg[(t_i_rdata[24:20])] );

                if((check == `FLOAT_NEG_INF) || (check == `FLOAT_POS_INF) || (check == `FLOAT_NAN) || (check2 == `FLOAT_NEG_INF) || (check2 == `FLOAT_POS_INF) || (check2 == `FLOAT_NAN) )
                    begin
                        whichType = `INVALID_TYPE;
                    end
                else
                    begin

                        buf1 = freg[(t_i_rdata[24:20])];
                        if(buf1[31] == 0)
                            begin
                                buf2 = {1'b1, buf1[30:0]};
                            end
                        else
                            begin
                                buf2 = {1'b0, buf1[30:0]};
                            end

                        TEMP3 = myfadd(  freg[(t_i_rdata[19:15])], buf2  );

                        check3 = myfclass( TEMP3 );
                        
                        if( (check3 == `FLOAT_NEG_INF) || (check3 == `FLOAT_POS_INF) || (check3 == `FLOAT_NAN))
                            begin
                                whichType = `INVALID_TYPE;
                            end
                        else
                            begin

                                //freg[(t_i_rdata[11:7])] = TEMP;
                                fdval = TEMP3;
                                fdidx = t_i_rdata[11:7];
                            end
                    end

                /////////////////////////////////
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                ///////////////////////////////////
                pc2 = pc + 4;
                
                
            end
        13:
        //flw:13
            begin

                
                TEMP2 = $signed(ireg[(t_i_rdata[19:15])]) + $signed(t_i_rdata[31:20]);
                //flwidx =t_i_rdata[11:7];
                
                fdidx = t_i_rdata[11:7];
                if (TEMP2 >DataMax)
                    begin
                        whichType = `INVALID_TYPE;
                    end
                else
                    if (TEMP2 < DataMin)
                        begin
                            whichType = `INVALID_TYPE;
                        end
                    else
                        begin
                            pc3 = TEMP2[31:0];
                        end
                //////////////////////////////////////////////////////
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                ////////////////////////////////////////////////////
                pc2 = pc + 4;


            end
        14:
        //fsw:14
            begin



                
                TEMP2 = $signed(ireg[(t_i_rdata[19:15])])+ $signed({t_i_rdata[31:25],t_i_rdata[11:7]});
                //fswidx = t_i_rdata[24:20];
                fdval = freg[ (t_i_rdata[24:20]) ];

                if (TEMP2 >DataMax)
                    begin
                        whichType = `INVALID_TYPE;
                    end
                else
                    if (TEMP2 < DataMin)
                        begin
                            whichType = `INVALID_TYPE;
                        end
                    else
                        begin
                            pc3 = TEMP2[31:0];
                        end
                //////////////////////////////////////////////////
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                /////////////////////////////////////////////////////
                pc2 = pc + 4;
            end
        15:
        //fclass:15
            begin
                //fclass $rd $f1
                //r1= ireg[(t_i_rdata[19:15])];
                //r2 = ireg[(t_i_rdata[24:20])];

                //rd=ireg[(t_i_rdata[11:7])]
                //ireg[(t_i_rdata[11:7])] = myfclass(freg[(t_i_rdata[19:15])]);
                
                rdval = myfclass(freg[(t_i_rdata[19:15])]);
                rdidx = t_i_rdata[11:7];
                
                ////////////////////////////////
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                /////////////////////////////////
                pc2 = pc + 4;
            end
        16:
        //flt:16
            begin
                //r1= ireg[(t_i_rdata[19:15])];
                //r2 = ireg[(t_i_rdata[24:20])];

                //rd=ireg[(t_i_rdata[11:7])]

                check = myfclass(freg[(t_i_rdata[19:15])]);
                check2 = myfclass(freg[(t_i_rdata[24:20])]);

                if( (check == `FLOAT_NEG_INF) || (check == `FLOAT_POS_INF) || (check == `FLOAT_NAN))
                    begin
                        whichType = `INVALID_TYPE;
                    end
                else
                    begin
                        if( (check2 == `FLOAT_NEG_INF) || (check2 == `FLOAT_POS_INF) || (check2 == `FLOAT_NAN))
                            begin
                                whichType = `INVALID_TYPE;
                            end
                        else
                            begin
                                if( myflt(freg[(t_i_rdata[19:15])] , freg[(t_i_rdata[24:20])] ) ) //freg[(t_i_rdata[19:15])] < freg[(t_i_rdata[24:20])]
                                    begin
                                        //ireg[(t_i_rdata[11:7])]= 1;
                                        rdidx = t_i_rdata[11:7];
                                        rdval = 32'sb00000000000000000000000000000001;


                                    end
                                else
                                    begin
                                        //ireg[(t_i_rdata[11:7])]= 0;

                                        rdidx = t_i_rdata[11:7];
                                        rdval = 32'sb00000000000000000000000000000000;

                                    end
                            end
                    end
                /////////////////////////////////////////
                //if((pc + 4) > InstMax)
                //    begin
                //        whichType = INVALID_TYPE;
                //        pc2 = pc;
                //    end
                //else
                //    begin
                //        pc2 = pc + 4;
                //    end
                ////////////////////////////////////////////
                pc2 = pc + 4;        
            end
        default:
        //eof:17
            begin
                pc2 = pc;
            end

    endcase

    //end
    //else
    //begin
    //    whichType = `INVALID_TYPE;
        //dead=1;
    //end

    /////////////////////////////////////
    if((whichType == `INVALID_TYPE) || (whichType == `EOF_TYPE))
        begin
            con =1;//stop processing
            //dead=1;            
        end
    else
        begin
            //dead=0;
            if((whatInst == 5))
                begin
                    con=2;// save operation //sw
                end
            else if((whatInst == 14))
                begin
                    con=3;//save operation //fsw
                end
            else if((whatInst == 4))
                begin
                    con=4;//load operation //lw
                end
            else if((whatInst == 13))
                begin
                    con=5;//load operation //flw
                end
            else if((whatInst == 6) || (whatInst == 7))
                begin
                    con =6; // beq, blt
                end
            else if((whatInst == 11) || (whatInst == 12)) //fadd, fsub
                begin
                    con=7; //fd
                end
            else
                begin
                    //$display("check 8");
                    con=8;//rd
                end            
        end
    //////////////////////////////////
    //$display("Type After: %b", whichType);
    //$display("In con: %b", con);
    //$display("In pc2: %b", pc2);
    //if( (pc2 >= InstMin) && (pc2 <=InstMax))
    //    begin
    //        dead2=0;
    //    end
    //else
    //    begin
    //        dead2=1;
    //    end

    done =1;
end

//////////////////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////
always@(next_state)
begin
    state = next_state;
end
////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////
// ---------------------------------------------------------------------------
// Sequential Block
// ---------------------------------------------------------------------------
// ---- Write your sequential block design here ---- //


//
//step1: assign address
//step2: eat address
//step3: value is back
//



always@(negedge i_rst_n or posedge i_clk)
begin
    if(!i_rst_n)
        begin
            pc <=0;

            //////////////////////////
            t_o_status <= 0;
            t_o_status_valid <= 0;

            t_o_wdata <= 0;
            t_o_we <= 0;
            t_o_addr <= 0;

            //////////////////////////////
            t_i_rdata <=0;

            next_state <= ReadyState;
            //faketemp <= 0;
            /////////////////////////////////
            dead <=0;
            dead2<=0;
            ///////////////////////////////////
            for (i = 0; i < 32; i = i + 1) 
                begin
                        ireg[i] <= 0;
                end
            
            for (j = 0; j < 32; j = j + 1) 
                begin
                        freg[j] <= 0;
                end
            //////////////////////////////////////
            //$display("Reset");
            //$display("o_we : %b", o_we);
            //$display("address : %b", o_addr);
            //$display("i_rdata: %b", i_rdata);
            

        end
    else
        begin
            case(state)
                //////////////////////////////////////////////////////
                ReadyState:
                //tell memory which address of instruction
                    begin

                        /////////////////////////////
                        //important
                        t_o_status_valid <= 0;
                        t_o_we <= 0;//reading mode
                        
                        ////////////////////////////////
                        //Not important
                        //t_o_wdata <= 0;
                        //faketemp <= i_rdata;

                        //$display("instruction address");
                        //$display("MY INSTRUCTION 0: %b", i_rdata);
                        //$display("dead1: %b", dead);
                        //$display("dead2: %b", dead2);
                        ////////////////////////////////
                        if(dead)
                            begin
                                t_o_addr <= 0;
                                t_o_status <= 0;
                                next_state <= ReadyState;
                            end
                        else
                            begin
                                
                                if(dead2)
                                    begin
                                        t_o_addr <= 0;
                                        t_o_status <= `INVALID_TYPE;
                                        next_state <= OutState;
                                        dead <=1;
                                        
                                    end
                                else
                                    begin
                                        
                                        t_o_addr <= pc;
                                        //t_o_status <= 0;
                                        next_state <= InstAddrState;

                                        //$display("pc inst1: %b", pc);
                                        //$display("pc oaddr1: %b", o_addr);

                                    end
                            end
                        ////////////////////////////////////                        
                    end


                InstAddrState:
                    begin
                        next_state <= GetInstState;

                        //$display("pc inst2: %b", pc);
                        //$display("pc oaddr2: %b", o_addr);
                    end

                GetInstState:
                //get instruction from memory
                //judge what is instruction 
                    begin
                        ///////////////////////////////
                        //Not important
                        t_o_status <= 0;
                        t_o_addr <= pc;
                        t_o_wdata <= 0;
                        ////////////////////////////////
                        ///////////////////////////////
                        //Important
                        t_o_status_valid <= 0;
                        t_o_we <= 0;//reading mode
                        t_i_rdata <= i_rdata;//instruction
                        
                        //$display("Get");
                        //$display("MY INSTRUCTION 1: %b", i_rdata);
                        //$display("pc inst3: %b", pc);
                        //$display("pc oaddr3: %b", o_addr);

                        next_state <= ProcessInstState;
                        
                    end   
                ////////////////////////////////////////////////
                ProcessInstState: 
                //add register and modify write read mode
                // for normal operation
                    begin
                        //not important
                        t_o_status_valid <= 0;
                        t_o_we <= 0;//reading mode
                        t_o_status <= 0;
                        t_o_addr <= pc;
                        t_o_wdata <= 0;
                        //faketemp <= i_rdata;

                        //$display("process");
                        //$display("MY INSTRUCTION 2: %b", i_rdata);
                        ////////////////////////////////////////
                        ///////////////////////////////////
                        //important
                        if(done)
                            begin
                                next_state <=BufferState;
                            end
                        else
                            begin
                                next_state <=ProcessInstState;
                            end
                        ////////////////////////////////////
                        
                       

                    end
                BufferState:
                    ////////////////////////////////////
                    //con=1;//stop processing  
                    //con=2;// save operation //sw
                    //con=3;//save operation //fsw
                    //con=4;//load operation //lw
                    //con=5;//load operation //flw
                    //con =6; // beq, blt
                    //con=7; //fd
                    //con=8;//rd
                    /////////////////////////////////////

                    /////////////////////////////////
                    //t_o_status;
                    //t_o_status_valid;

                    // Memory 
                    //t_o_addr;
                    //t_o_wdata;
                    //t_o_we;
                    /////////////////////////////////

                    begin
                        //$display("buffer");
                        //$display("MY INSTRUCTION 3: %b", i_rdata);
                        //$display("Out con: %b", con);
                        /////////////////////////////////////////////////////////////
                        pc <= pc2;

                        if(pc2 > InstMax)
                            begin
                                dead2 <=1;
                            end
                        else
                            begin
                                dead2 <=0;
                            end
                        ///////////////////////////////////////////////////////////////
                        //faketemp <= i_rdata;


                        case(con)
                            1://stop processing  
                                begin
                                    
                                    t_o_status <= whichType;
                                    t_o_status_valid <= 0;
                                    dead <=1;
                                    next_state <= OutState;
                                    /////////////////////////
                                    t_o_addr <=0;
                                    t_o_wdata<=0;
                                    t_o_we <=0;
                                end
                            2://save operation /sw
                                begin
                                    t_o_status <= whichType;
                                    t_o_status_valid <= 0;
                                    t_o_wdata <= rdval;
                                    t_o_addr <= pc3;
                                    t_o_we <= 0;
                                    next_state <= SaveState;
                                    dead <=0;
                                    ///////////////////////////////////////////
                                end

                            3://fsw
                                begin

                                    t_o_status <= whichType;
                                    t_o_status_valid <= 0;
                                    t_o_wdata <= fdval; // unsigned data for memory
                                    t_o_addr <= pc3;
                                    t_o_we <= 0;
                                    next_state <= SaveState;
                                    dead <=0;
                                    /////////////////////////////////////////
                                end
                            4://load operation /lw
                                begin
                                    t_o_status <= whichType;
                                    t_o_addr <= pc3;
                                    t_o_we <= 0;
                                    t_o_status_valid <= 0;
                                    dead <=0;
                                    next_state <= LoadState;
                                    /////////////////////////
                                    t_o_wdata <= 0;
                                    ///////////////////////////////
                                end
                            5://flw
                                begin
                                    t_o_status <= whichType;
                                    t_o_addr <= pc3;
                                    t_o_we <= 0;
                                    t_o_status_valid <= 0;
                                    dead <=0;
                                    next_state <= LoadState;
                                    /////////////////////////
                                    t_o_wdata <= 0;
                                    ///////////////////////////////

                                end
                            6:// beq, blt
                                begin
                                    t_o_status <= whichType;
                                    t_o_status_valid <= 0;
                                    t_o_we <=0;
                                    dead <=0;
                                    next_state <= OutState;
                                    ///////////////////////////// 
                                    t_o_addr <=0;
                                    t_o_wdata <=0;
                                    
                                end

                            7://fd
                                begin
                                    freg[fdidx] <= fdval;
                                    t_o_status <= whichType;
                                    t_o_status_valid <= 0;

                                    next_state <= OutState;
                                    dead <=0;
                                    ////////////////////////////
                                    t_o_we <= 0;
                                    t_o_wdata <=0;
                                    t_o_addr <=0;
                                    
                                    
                                end

                            8://rd
                                begin
                                    ireg[rdidx] <= rdval;
                                    t_o_status <= whichType;
                                    t_o_status_valid <= 0;

                                    next_state <= OutState;
                                    dead <=0;
                                    ////////////////////////////
                                    t_o_we <= 0;
                                    t_o_wdata <=0;
                                    t_o_addr <=0;
                                end
                            default:
                                begin
                                    dead <=1;
                                    //t_o_status <= whichType;
                                    t_o_status_valid <= 0;
                                    next_state <= ReadyState;
                                end

                        endcase
                        ////////////////////////////////////////////////////////////
                        
                    end
                ///////////////////////////////////////////////////////
                OutState:
                    begin
                        


                         if(con == 4)//lw
                            begin
                                ireg[rdidx] <=  $signed(i_rdata); // unsigned data from memory

                                t_o_we <= 0;
                                t_o_status_valid <= 1;
                                next_state <= ReadyState;
                            end
                        else if(con == 5)//flw //5
                            begin
                                freg[fdidx] <= i_rdata;

                                t_o_we <= 0;
                                t_o_status_valid <= 1;
                                next_state <= ReadyState;
                            end
                        else
                            begin
                                t_o_we <= 0;
                                t_o_status_valid <= 1;
                                next_state <= ReadyState;
                            end

                        
                       
                        /////////////////////////////////
                        //t_o_addr <= pc;
                        //faketemp <= i_rdata;

                        //$display("out");
                        //$display("MY INSTRUCTION 4: %b", i_rdata);
                        //$display("Status O: %b", o_status);
                        //$display("out pc: %b", pc);
                        //////////////////////////////////////////////////

                    end                
                
                SaveState:
                    begin
                        t_o_we <= 1;
                        t_o_status_valid <= 0;
                        next_state <= OutState;
                        ///////////////////////////////////
                        //faketemp <= i_rdata;

                        //$display("Status S: %b", o_status);
                        //$display("out pc: %b", pc);
                        //////////////////////////////////////////
                    end
                LoadState:
                    begin

                        t_o_we <= 0;
                        t_o_status_valid <= 0;
                        next_state <= OutState;
                        ////////////////////////////////////////
                        //////////////////////////////////////////////////////////
                        //$display("Status L: %b", o_status);
                        //$display("out pc: %b", pc);
                        //if(con==4)//lw
                        //    begin
                        //        ireg[rdidx] <=  $signed(i_rdata); // unsigned data from memory
                        //    end
                        //else//flw //5
                        //    begin
                        //        freg[fdidx] <= i_rdata;
                        //    end
                        ///////////////////////////////////////////////////////////////
                    end               
                //////////////////////////////////////////////////////
                default:
                    begin

                        //$display("default");
                        pc <=0;

                        //////////////////////////
                        t_o_status <= 0;
                        t_o_status_valid <= 0;

                        t_o_wdata <= 0;
                        t_o_we <= 0;
                        t_o_addr <= 0;
                        //////////////////////////////
                        t_i_rdata <=0;


                        

                        //faketemp <= 0;

                        /////////////////////////////////
                        dead <=0;
                        dead2<=0;
                        ///////////////////////////////////
                        for (i = 0; i < 32; i = i + 1) 
                            begin
                                ireg[i] <= 0;
                            end
            
                        for (j = 0; j < 32; j = j + 1) 
                            begin
                                freg[j] <= 0;
                            end
                        next_state <= ReadyState;
            //////////////////////////////////////
                    end
            endcase

        end
end

/////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
endmodule