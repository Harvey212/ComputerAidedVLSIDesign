module alu #(
    parameter INST_W = 4,
    parameter INT_W  = 6,
    parameter FRAC_W = 10,
    parameter DATA_W = INT_W + FRAC_W
)(
    input                      i_clk,
    input                      i_rst_n,

    input                      i_in_valid,
    output                     o_busy,
    input         [INST_W-1:0] i_inst,
    input  signed [DATA_W-1:0] i_data_a,
    input  signed [DATA_W-1:0] i_data_b,

    output                     o_out_valid,
    output        [DATA_W-1:0] o_data
);

    ///my code start here

    //////////////////////////////////////////////////////////////////
    // Local Parameters
    //FSM
    //localparam rstate = 2'b00; 
    //localparam estate = 2'b01; 
    //localparam pstate = 2'b10; 
    //localparam ostate = 2'b11;


    localparam estate = 2'b00; 
    localparam pstate = 2'b01; 
    localparam ostate = 2'b10;

    //for saturation
    parameter signed [DATA_W-1:0] MAX_VAL = 16'sb0111111111111111;
    parameter signed [DATA_W-1:0] MIN_VAL = 16'sb1000000000000000;
    
    //for accumulation
    parameter IMbit = 20;
    /////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////////////////////
    // Wires and Regs
    //////////////////////////////////////////////////////////////////////////////////////
    //for input and output storage
    reg signed [DATA_W-1:0] dataA;
    reg signed [DATA_W-1:0] dataB;
    reg signed [DATA_W-1:0] oANS;

    reg [INST_W-1:0] dataINS;
    ///////////////////////////////////////////

    ///////////////////////////////////////////
    //for FSM
    reg [1:0] state;
    reg [1:0] next_state;
    //////////////////////////////////////////
    
    ///////////////////////////////////////////
    //to check if ALU computation has completed
    reg done;
    //////////////////////////////////////////


    //////////////////////////////////////
    //for accumulation 
    reg signed [IMbit-1:0] data_acc [0:DATA_W-1];
    reg signed [IMbit-1:0] faketmp;

    //reg signed [IMbit-1:0] faketmp2;
    integer i;
    reg [3:0] idx1;
    ///////////////////////////////////////

    //////////////////////////////////////
    //for left rotation
    //reg [2*DATA_W-1:0] LRarray;
    //integer m,n;//,k;

    //reg [2*DATA_W-1:0] TMP;

    //reg [3:0] idx;
    //////////////////////////////////////

    /////////////////////////////////////
    //count leading zero
    reg stop;
    integer a;
    
    ////////////////////////////////////////

    //////////////////////////////////////
    //Reverse Match4
    //integer j;
    //////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////////////////////////////

    // to avoid Net type cannot be used on the left side of this assignment.
    reg t_o_busy;
    reg t_o_out_valid;
    reg [DATA_W-1:0] t_o_data;





    
    

    ////////////////////////////////////////////////////////////////////////////////////////////////
    //Signed Addition
    function automatic [DATA_W-1:0] SignAdd;
        input signed [DATA_W-1:0] dataA;
        input signed [DATA_W-1:0] dataB;
        
        //
        reg signed [DATA_W:0] tmp; //avoid overflow
        //reg signed [DATA_W:0] tmp2;

        //reg signed [INT_W:0] inttmp;
        //

        begin
            ///
            tmp = dataA + dataB;

            /////////////////////////////////////////////////////////
            //No rounding is needed
            /*rounding
            inttmp = tmp[DATA_W:FRAC_W];
            if(tmp[9]==1)
                begin
                    if(tmp[8]==1)
                        begin
                            tmp2 = {inttmp+1,10'b0000000000);
                        end
                    else
                        begin
                            tmp2 = {inttmp,10'b1000000000);
                        end
                end
            else
                begin
                    if(tmp[8]==1)
                        begin
                            tmp2 = {inttmp,10'b1000000000);
                        end
                    else
                        begin
                            tmp2 = {inttmp,10'b0000000000);
                        end
                end
            */
            ///////////////////////////////////////////////////////////
            //Saturation
            if(tmp>MAX_VAL)
                begin
                    SignAdd = MAX_VAL[DATA_W-1:0];
                end
            else
                begin
                    if(tmp<MIN_VAL)
                        begin
                            SignAdd = MIN_VAL[DATA_W-1:0];
                        end
                    else
                        begin
                            SignAdd = tmp[DATA_W-1:0];
                        end
                end
            ////////////////////////////////////////////////////////////
        end
    endfunction
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //Signed Subtraction
    function automatic [DATA_W-1:0] SignSub;
        input signed [DATA_W-1:0] dataA;
        input signed [DATA_W-1:0] dataB;
        
        //
        reg signed [DATA_W:0] tmp; //avoid overflow
        //

        begin
            ///
            tmp = dataA - dataB;
            ///////////////////////////////////////////////////////////
            //Saturation
            if(tmp>MAX_VAL)
                begin
                    SignSub = MAX_VAL[DATA_W-1:0];
                end
            else
                begin
                    if(tmp<MIN_VAL)
                        begin
                            SignSub = MIN_VAL[DATA_W-1:0];
                        end
                    else
                        begin
                            SignSub = tmp[DATA_W-1:0];
                        end
                end
            ////////////////////////////////////////////////////////////
        end
    endfunction
    ////////////////////////////////////////////////////////////////////////////////////////////////




    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //Signed Multiplication
    function automatic [DATA_W-1:0] Mul;
        input signed [DATA_W-1:0] dataA;
        input signed [DATA_W-1:0] dataB;

        //
        reg signed [2*DATA_W-1:0] tmp; //avoid overflow
        reg signed [2*DATA_W-1:0] tmp2;

        reg signed [2*DATA_W-1-10:0] tmp3;
        //


        begin


            tmp=0;
            tmp2=0;
            tmp3=0;
            //dataA: . 
            //6 bit integer with sign 2^0~ 2^4 ,5 bit number + 1 bit signed 
            //10 bit fraction. from 2^-1 ~ 2^-10

            //tmp: 31 bit
            //integer 2^0~2^8 + 2^9 because addition provide possibility of overflow
            //fraction 2^-1 ~ 2^-20
            //20 fraction bit , 10 integer bit, 1 signed bit

            //tmp3: 21 bit
            //1 signed bit
            //2^0 ~ 2^9
            //2^-1 ~ 2^-10
            //
            tmp = (dataA * dataB);
            /////////////////////////////////////////////////////////
            //rounding
            if(tmp[9]==1)
                begin
                    tmp2 = tmp + 31'sb0000000000000000000010000000000;//11'b10000000000;
                end
            else
                begin
                    tmp2 = tmp;
                end
            /////////////////////////////////////////////////////////
            
            tmp3 = $signed({tmp2[2*DATA_W-1:10]});//{tmp2[2*DATA_W-1:10]};
            ///////////////////////////////////////////////////////////
            //Saturation
            if(tmp3>MAX_VAL)
                begin
                    Mul = MAX_VAL[DATA_W-1:0];
                end
            else
                begin
                    if(tmp3<MIN_VAL)
                        begin
                            Mul = MIN_VAL[DATA_W-1:0];
                        end
                    else
                        begin
                            Mul = tmp3[DATA_W-1:0];
                        end
                end
            ////////////////////////////////////////////////////////////
        end


    endfunction
    ////////////////////////////////////////////////////////////////////////////////////////////////




    ////////////////////////////////////////////////////////////////////////////////////////
    //Signed Accumulation
    //function [DATA_W-1:0] Acc;    
    //endfunction
    ///////////////////////////////////////////////////////////////////////////////////////////



    //////////////////////////////////////////////////////////////////////////////////
    //Softplus
    function automatic [DATA_W-1:0] Softplus;
        input signed [DATA_W-1:0] dataA;

        //////////////////////////////////////////////////////////
        //dataA: 16 bit
        //1 signed bit
        //5 integer bit 2^0~2^4
        //10 fraction bit 2^-1 ~2^-10
        //
        //reg signed [2*DATA_W-1:0] tmp;
        reg signed [5*DATA_W-1:0] tmp;

        //
        //reg signed [DATA_W-1:0] tmp2;
        reg signed [5*DATA_W-1:0] tmp2;
        //reg signed [(2*DATA_W)*2-1:0] tmp2;
        //reg signed [47:0] tmp2;
        //
        reg signed [5*DATA_W-1:0] tmp3;
        //reg signed [(2*DATA_W)*2-1:0] tmp3;
        //
        reg signed [5*DATA_W-1:0] tmp4;
        //reg signed [(2*DATA_W)*2-1:0] tmp4;

        //
        //reg up;
        //reg signed [(2*DATA_W)*2-1:0] tmp5;

        //up =1'b0;

        reg signed [5*DATA_W-1:0] TMP0;
        reg signed [5*DATA_W-1:0] TMP1;
        reg signed [5*DATA_W-1:0] TMP2;
        reg signed [5*DATA_W-1:0] TMP3;
        reg signed [5*DATA_W-1:0] TMP4;
        reg signed [5*DATA_W-1:0] TMP5;
        reg signed [5*DATA_W-1:0] TMP6;
        reg signed [5*DATA_W-1:0] TMP7;
        reg signed [5*DATA_W-1:0] TMP8;
        reg signed [5*DATA_W-1:0] TMP9;

        begin
        tmp=0;
        tmp2=0;
        tmp3=0;
        tmp4=0;

        
        //tmp5=0;
        //
       
        ///////////////////////////////////////////////
        TMP0=0;
        TMP1=0;
        TMP2=0;
        TMP3=0;
        TMP4=0;
        TMP5=0;
        TMP6=0;
        TMP7=0;
        TMP8=0;
        TMP9=0;

        ///////////////////////////////////////////////

        if (dataA >= 16'sb0000100000000000)
            begin
                Softplus = dataA;
            end
        else if((dataA >= 0) && (dataA < 16'sb0000100000000000))
            begin
                //////////////////
                //tmp: 32bit
                //1 signed bit
                //now possible value from right to left as 2^-10 ~ 2^-1, 2^0~2^5 , plus signed bit afterwards
                //but in 32 bit system, it only represent 1 signed bit leftmost, 10 fraction bit from the, 21 bit integer from 2^1 ~2^21
                //
                //1. 2x
                tmp = (dataA <<<1 )  + 16'sb0000100000000000;//(dataA <<< 1);
                ///////////////////


                TMP1 = tmp <<< 47;
                ////////////////////

                TMP2 = ((TMP1 >>>  2) + TMP1) >>> 2; /* Q = A*0.0101 */
                TMP3 = ((TMP2      ) + TMP1) >>> 2; /* Q = A*0.010101 */
                TMP4 = ((TMP3      ) + TMP1) >>> 2; /* Q = A*0.01010101 */
                TMP5 = ((TMP4      ) + TMP1) >>> 2; /* Q = A*0.0101010101 */
                TMP6 = ((TMP5      ) + TMP1) >>> 1; /* Q = A*0.10101010101 */
                TMP7 = ((TMP6 >>> 12) + TMP6)     ; /* Q = A*0.10101010101010101010101 */
                ///////////
                tmp2 = ((TMP7 >>> 24) + TMP7); /* Q = A*0.010101010101001010101010101 ... */
                if(tmp2[47]==1)
                    begin
                        tmp3 =tmp2 + 80'sb00000000000000000000000000000000100000000000000000000000000000000000000000000000;//48'b100000000000000000000000000000000000000000000000;//32'sb00000000000000000000010000000000;

                        TMP8= tmp3 >>> 47;
                    end
                else
                    begin
                        tmp3 =tmp2;

                        TMP8= tmp3 >>> 47;
                    end


                tmp4 =TMP8 >>> 1;
                Softplus = (tmp4 > MAX_VAL) ? MAX_VAL : (tmp4 < MIN_VAL) ? MIN_VAL : tmp4[DATA_W-1:0];
                /////////////////////////////////////////////////
            end
        else if((dataA >= 16'sb1111110000000000) && (dataA < 16'sb0000000000000000))
            begin
                tmp = dataA+ 16'sb0000100000000000;

                


                if(tmp>=16'sb0000000000000000)
                    begin
                       

                        
                        //tmp = tmp <<< 47;


                       //////////////////////////////////
                        //tmp2 =   ((tmp >>>  2) + tmp) >>> 2; /* Q = A*0.0101 */
                        //tmp2 =   ((tmp2      ) + tmp) >>> 2; /* Q = A*0.010101 */
                        //tmp2 =   ((tmp2      ) + tmp) >>> 2; /* Q = A*0.01010101 */
                        //tmp2 =   ((tmp2      ) + tmp) >>> 2; /* Q = A*0.0101010101 */
                        //tmp2 =   ((tmp2      ) + tmp) >>> 1; /* Q = A*0.10101010101 */
                        //tmp2 = ((tmp2 >>> 12) + tmp2)     ; /* Q = A*0.10101010101010101010101 */

                        //tmp2 = ((tmp2 >>> 24) + tmp2); /* Q = A*0.010101010101001010101010101 ... */
                        

                        TMP1 = tmp <<< 47;
                        ////////////////////

                        TMP2 = ((TMP1 >>>  2) + TMP1) >>> 2; /* Q = A*0.0101 */
                        TMP3 = ((TMP2      ) + TMP1) >>> 2; /* Q = A*0.010101 */
                        TMP4 = ((TMP3      ) + TMP1) >>> 2; /* Q = A*0.01010101 */
                        TMP5 = ((TMP4      ) + TMP1) >>> 2; /* Q = A*0.0101010101 */
                        TMP6 = ((TMP5      ) + TMP1) >>> 1; /* Q = A*0.10101010101 */
                        TMP7 = ((TMP6 >>> 12) + TMP6)     ; /* Q = A*0.10101010101010101010101 */
                        ///////////
                        tmp2 = ((TMP7 >>> 24) + TMP7); /* Q = A*0.010101010101001010101010101 ... */

                        if(tmp2[47]==1)
                            begin
                                tmp3 =tmp2 + 80'sb00000000000000000000000000000000100000000000000000000000000000000000000000000000;

                                TMP8= tmp3 >>> 47;
                            end
                        else
                            begin
                                tmp3 =tmp2;

                                TMP8= tmp3 >>> 47;
                            end

                        tmp4 =TMP8 >>> 1;
                        
                        Softplus = (tmp4 > MAX_VAL) ? MAX_VAL : (tmp4 < MIN_VAL) ? MIN_VAL : tmp4[DATA_W-1:0];

                    end

                else
                    begin
                        TMP0 = ~tmp + 2'sb01 ;//1'b1;


                        TMP1 = TMP0 <<< 47;
                        ////////////////////

                        TMP2 = ((TMP1 >>>  2) + TMP1) >>> 2; /* Q = A*0.0101 */
                        TMP3 = ((TMP2      ) + TMP1) >>> 2; /* Q = A*0.010101 */
                        TMP4 = ((TMP3      ) + TMP1) >>> 2; /* Q = A*0.01010101 */
                        TMP5 = ((TMP4      ) + TMP1) >>> 2; /* Q = A*0.0101010101 */
                        TMP6 = ((TMP5      ) + TMP1) >>> 1; /* Q = A*0.10101010101 */
                        TMP7 = ((TMP6 >>> 12) + TMP6)     ; /* Q = A*0.10101010101010101010101 */
                        ///////////
                        tmp2 = ((TMP7 >>> 24) + TMP7); /* Q = A*0.010101010101001010101010101 ... */

                        if(tmp2[47]==1)
                            begin
                                tmp3 =tmp2 - 80'sb00000000000000000000000000000000100000000000000000000000000000000000000000000000;//48'b100000000000000000000000000000000000000000000000;

                                TMP8= tmp3 >>> 47;
                            end
                        else
                            begin
                                tmp3 =tmp2;

                                TMP8= tmp3 >>> 47;
                            end

                        TMP9 =TMP8 >>> 1;
                        tmp4 = ~TMP9 +  2'sb01 ;//1'b1;
                        Softplus = (tmp4 > MAX_VAL) ? MAX_VAL : (tmp4 < MIN_VAL) ? MIN_VAL : tmp4[DATA_W-1:0];
                    end

                
            end
        else if((dataA >= 16'sb1111100000000000) && (dataA < 16'sb1111110000000000))
            begin
                tmp = (dataA <<< 1) + 16'sb0001010000000000;
                //tmp2 = tmp + 16'sb0001010000000000;//32'sb00000000000000000001010000000000;

                if(tmp>=16'sb0000000000000000)
                    begin

                        TMP0 = tmp <<< 47;


                        ///////////////////////////////////////
                        TMP1 = ((TMP0 >>>  1) + TMP0) >>> 1; /* Q = A*0.11 */
	                    TMP2 = ((TMP1      ) + TMP0) >>> 1; /* Q = A*0.111 */
	                    TMP3 = ((TMP2 >>>  6) + TMP2)     ; /* Q = A*0.111000111 */
	                    TMP4 = ((TMP3 >>> 12) + TMP3)     ; /* Q = A*0.111000111000111000111 */

                        
                        tmp2 = ((TMP4 >>> 12) + TMP4); /* Q = A*0.000111000111000111000111000... */


                        if(tmp2[49]==1)
                            begin
                                tmp3 =tmp2 + 80'sb00000000000000000000000000000010000000000000000000000000000000000000000000000000;
                                
                                TMP5= tmp3 >>> 47;
                            end
                        else
                            begin
                                tmp3 =tmp2;

                                TMP5= tmp3 >>> 47;
                            end

                        tmp4 = TMP5 >>> 3;
                        Softplus = (tmp4 > MAX_VAL) ? MAX_VAL : (tmp4 < MIN_VAL) ? MIN_VAL : tmp4[DATA_W-1:0];

                    end

                else
                    begin
                        TMP0 = ~tmp+ 2'sb01 ;//1'b1;

                        ///////////////////////////

                        TMP1 = TMP0 <<< 47;
                        ///////////////////////////////////////////////////////
                        
                        TMP2 = ((TMP1 >>>  1) + TMP1) >>> 1; /* Q = A*0.11 */
	                    TMP3 = ((TMP2      ) + TMP1) >>> 1; /* Q = A*0.111 */
	                    TMP4 = ((TMP3 >>>  6) + TMP3)     ; /* Q = A*0.111000111 */
	                    TMP5 = ((TMP4 >>> 12) + TMP4)     ; /* Q = A*0.111000111000111000111 */
	            
                        tmp2 = ((TMP5 >>> 12) + TMP5); /* Q = A*0.000111000111000111000111000... */

                        if(tmp2[49]==1)
                            begin
                                tmp3 =tmp2 - 80'sb00000000000000000000000000000010000000000000000000000000000000000000000000000000;//50'b10000000000000000000000000000000000000000000000000;

                                TMP6= tmp3 >>> 47;
                            end
                        else
                            begin
                                tmp3 =tmp2;

                                TMP6= tmp3 >>> 47;
                            end


                        TMP7 = TMP6 >>> 3;
                        tmp4 = ~TMP7 +  2'sb01 ; //1'b1;
                        Softplus = (tmp4 > MAX_VAL) ? MAX_VAL : (tmp4 < MIN_VAL) ? MIN_VAL : tmp4[DATA_W-1:0];
                    end
               

            end
        else if((dataA >= 16'sb1111010000000000) && (dataA < 16'sb1111100000000000))
            begin
                tmp = (dataA) + 16'sb0000110000000000;
                if(tmp>=16'sb0000000000000000)
                    begin



                        TMP0 = tmp <<< 47;

                        ////////////////////////////////////////////////////////
                        TMP1 = ((TMP0 >>>  1) + TMP0) >>> 1; /* Q = A*0.11 */
	                    TMP2 = ((TMP1      ) + TMP0) >>> 1; /* Q = A*0.111 */
	                    TMP3 = ((TMP2 >>>  6) + TMP2)     ; /* Q = A*0.111000111 */
	                    TMP4 = ((TMP3 >>> 12) + TMP3)     ; /* Q = A*0.111000111000111000111 */

                        
                        tmp2 = ((TMP4 >>> 12) + TMP4); /* Q = A*0.000111000111000111000111000... */


                        if(tmp2[49]==1)
                            begin
                                tmp3 =tmp2 + 80'sb00000000000000000000000000000010000000000000000000000000000000000000000000000000;//50'b10000000000000000000000000000000000000000000000000;

                                TMP5= tmp3 >>> 47;
                            end
                        else
                            begin
                                tmp3 =tmp2;

                                TMP5= tmp3 >>> 47;
                            end

                        tmp4 = TMP5 >>> 3;


                        Softplus = (tmp4 > MAX_VAL) ? MAX_VAL : (tmp4 < MIN_VAL) ? MIN_VAL : tmp4[DATA_W-1:0];



                    end

                else
                    begin
                        TMP0 = ~tmp+ 2'sb01 ;//1'b1;

                        ///////////////////////////////////
                        TMP1 = TMP0 <<< 47;

                        ///////////////////////////////////////
                        
                        TMP2 = ((TMP1 >>>  1) + TMP1) >>> 1; /* Q = A*0.11 */
	                    TMP3 = ((TMP2      ) + TMP1) >>> 1; /* Q = A*0.111 */
	                    TMP4 = ((TMP3 >>>  6) + TMP3)     ; /* Q = A*0.111000111 */
	                    TMP5 = ((TMP4 >>> 12) + TMP4)     ; /* Q = A*0.111000111000111000111 */
	            
                        tmp2 = ((TMP5 >>> 12) + TMP5); /* Q = A*0.000111000111000111000111000... */

                        if(tmp2[49]==1)
                            begin
                                tmp3 =tmp2 - 80'sb00000000000000000000000000000010000000000000000000000000000000000000000000000000;//50'b10000000000000000000000000000000000000000000000000;

                                TMP6= tmp3 >>> 47;
                            end
                        else
                            begin
                                tmp3 =tmp2;

                                TMP6= tmp3 >>> 47;
                            end


                        TMP7 = TMP6 >>> 3;
                        tmp4 = ~TMP7 +   2'sb01 ; //1'b1;
                        Softplus = (tmp4 > MAX_VAL) ? MAX_VAL : (tmp4 < MIN_VAL) ? MIN_VAL : tmp4[DATA_W-1:0];
                    end
            end
        else
            begin
                
                Softplus = 0;
            end

        end
    endfunction
    //////////////////////////////////////////////////////////////////////////////////

    //////////////////////////////////////////////////////////////////////////////////
    //XOR
    //function [DATA_W-1:0] XO;
    //endfunction
    ////////////////////////////////////////////////////////////////////////////////////////

    //Arithmetic Right Shift
    //function [DATA_W-1:0] RShift;
    //endfunction
    /////////////////////////////////////////////////////////////////////////////////////


    ////////////////////////////////////////////////////
    //Left Rotation
    function automatic [DATA_W-1:0] LeftRot;
        input signed [DATA_W-1:0] dataA;
        input signed [DATA_W-1:0] dataB;

        reg [2*DATA_W-1:0] LRarray;
        reg [2*DATA_W-1:0] TMP;
        integer m,n;//,k;

    
        begin

            for (m = 0; m < 2; m = m + 1) 
                begin
                    for (n = 0; n<DATA_W; n = n+1)
                        begin
                            //k = DATA_W* m + n;
                            LRarray[16*m + n] = dataA[n];
                        end
                end
            /////////////////////////////////
            //data range need to be confirmed out of bound, you cannot just put dataB inside the index
            //idx = dataB[3:0];
            //LRarray[2*DATA_W-1-idx:DATA_W-idx];
            //to avoid unknown part select
            TMP = LRarray << dataB;
            LeftRot = TMP[2*DATA_W-1:DATA_W];
        end
    endfunction
    ///////////////////////////////////////////////////



    ///////////////////////////////////
    //Count Leading Zeros
    /*
    function automatic [DATA_W-1:0] CountLeadZero;
        input signed [DATA_W-1:0] dataA;
        
        reg signed [DATA_W-1:0] buf;
        reg stop;
        integer a;


        begin
            buf =0;
            stop = 1'b0;
            for (a=0; a<DATA_W; a =a+1)
                begin
                    if(stop == 1'b0)
                        begin
                            if (dataA[DATA_W-1-a]==0)
                                begin
                                    stop = 1'b0; 
                                end
                            else
                                begin
                                    stop = 1'b1;
                                    buf = a;
                                end
                        end
                    else
                        begin
                            stop = 1'b1;
                        end
                end
            ///////////////////////////////
            CountLeadZero = buf;
        end
    endfunction
    ///////////////////////////////////
    */

    //////////////////////////////////////////////////////
    //Reverse Match4
    function automatic [DATA_W-1:0] Matchf;
        input signed [DATA_W-1:0] dataA;
        input signed [DATA_W-1:0] dataB;

        integer j;
        reg [DATA_W-1:0] mANS;

        begin
            for (j=0; j<DATA_W; j=j+1)
                begin
                    if((j>12) && (j<DATA_W))
                        begin
                            mANS[j] =0;
                        end
                    else
                        begin
                            //use this way so that it can be synthesized
                            if(dataA[j +: 4] == dataB[12-j +: 4])
                            //if(dataA[j+3:j] == dataB[15-j:12-j])
                                begin
                                    mANS[j] = 1;
                                end
                            else
                                begin
                                    mANS[j] = 0;
                                end
                        end
                end
            //////////////////////////
            Matchf = mANS;
        end
    endfunction
    //////////////////////////////////////////////////////////////////////////






    

    
    
    //right 
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    //reg doing; //=1'b0;
    ///////
    //Combinatorial Blocks
    //dataINS or dataA or dataB
    always@(*)
    begin

        //if(state != pstate)
        //    begin
                //doing =1'b0;
        //        done = 1'b0;
                
        //        stop = 1'b0;
        //        faketmp=0;
                //oANS =0;
                //k=0;
        //        LRarray=0;
        //        TMP=0;
        //        idx1=0;
                
        //    end

        //else
        //    begin
                done = 1'b0;
                stop= 1'b0;
                
                
                faketmp=0;
                //oANS =0;
                //k=0;
                //LRarray=0;
                //TMP=0;
                idx1=0;
                //doing =1'b1;
                
                ////////////////////////////////////////////////////////////////////////////
                //Signed input data with 2’s complement representation
                //o_data
                //1. For instructions 0000~0100, fixed point number (6-bit signed integer + 10-bit fraction)
                //2. For instructions 0101~1001, integer
                //
                ////////////////////////////////////////////////////////////////////////////////
                case(dataINS)
                    4'b0000:
                        //Signed Addition
                        begin
                            oANS = SignAdd(dataA,dataB);
                        end
                    4'b0001:
                        //Signed Subtraction
                        begin
                            oANS = SignSub(dataA,dataB);
                        end
                    4'b0010:
                        //Signed Multiplication
                        begin
                            oANS = Mul(dataA,dataB);
                        end
                    4'b0011:
                        begin
                        //Signed Accumulation
                        //oANS = Acc;
                            idx1 = dataA[3:0];
                            faketmp = data_acc[idx1] + dataB;
                            //data_acc[dataA] = faketmp;
                            oANS = (faketmp > MAX_VAL) ? MAX_VAL : (faketmp < MIN_VAL) ? MIN_VAL : faketmp[DATA_W-1:0];
                            //saturation
                        end

                    4'b0100:
                        //Softplus 
                        begin
                            oANS = Softplus(dataA);
                        end
                    ///////////////////////////////////////////////////////////////////////////////////////////////////////    
                    4'b0101:
                        //XOR
                        begin
                            oANS = dataA ^ dataB;
                        end
                    4'b0110:
                        //Arithmetic Right Shift
                        begin
                            oANS = dataA >>> dataB;
                        end
                    4'b0111:
                        begin
                            //add begin end within case
                            //Left Rotation
                            ///////////////////////////////
                            //for (m = 0; m < 2; m = m + 1) 
                            //    begin
                            //        for (n = 0; n<DATA_W; n = n+1)
                            //            begin
                                            //k = DATA_W* m + n;
                            //                LRarray[16*m + n] = dataA[n];
                            //            end
                            //    end
                            /////////////////////////////////
                            ////data range need to be confirmed out of bound, you cannot just put dataB inside the index
                            ////idx = dataB[3:0];
                            ////LRarray[2*DATA_W-1-idx:DATA_W-idx];
                            //to avoid unknown part select
                            //TMP = LRarray << dataB;
                            //oANS = TMP[2*DATA_W-1:DATA_W];
                            oANS =LeftRot(dataA,dataB);
                        end

                    4'b1000:
                        begin
                            //Count Leading Zeros

                            //oANS =CountLeadZero(dataA);

                            
                            oANS = 0;
                            for (a=0; a<DATA_W; a =a+1)
                                begin
                                    if(stop == 1'b0)
                                        begin
                                            if (dataA[DATA_W-1-a]==0)
                                                begin
                                                    
                                                    ///////////////////////
                                                    if (a == (DATA_W-1))
                                                        begin
                                                            oANS = DATA_W;
                                                            stop = 1'b0;
                                                        end
                                                    else
                                                        begin
                                                            stop = 1'b0;
                                                        end
                                                    ///////////////////////////
                                                end
                                            else
                                                begin
                                                    stop = 1'b1;
                                                    oANS = a;
                                                end
                                        end
                                    else
                                        begin
                                            stop = 1'b1;
                                        end


                                end
                            
                        ///////////////////////////////
                        end
                    4'b1001:
                        begin
                            //Reverse Match4
                            //////////////////////
                            /*
                            for (j=0; j<DATA_W; j=j+1)
                                begin
                                    if((j>12) && (j<DATA_W))
                                        begin
                                            oANS[j] =0;
                                        end
                                    else
                                        begin
                                            //use this way so that it can be synthesized
                                            if(dataA[j +: 4] == dataB[12-j +: 4])
                                            //if(dataA[j+3:j] == dataB[15-j:12-j])
                                                begin
                                                    oANS[j] = 1;
                                                end
                                            else
                                                begin
                                                    oANS[j] = 0;
                                                end
                                        end
                                end
                            //////////////////////////
                            */
                            oANS = Matchf(dataA,dataB);
                        end
                    default:
                        begin
                            oANS =0;
                        end
                endcase
                ///////
                done = 1'b1;
                //doing =1'b0;
            //end
        /////////////////////////////////////////////////////////////////////////////
    end
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    //Continuous Assignments 
    ////////////////////////////////////////////////////////////////////////////////////////////////////////   
    // Net type cannot be used on the left side of this assignment. 
    //Net Types: Variables declared with wire are net types. They represent connections and can only be driven by continuous assignments (e.g., assign statements). You cannot assign values to them within always blocks.

    assign o_busy = t_o_busy;
    assign o_out_valid = t_o_out_valid;
    assign o_data = t_o_data;


    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // Sequential Blocks
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    ////////////////////////////////////////////////
    //Thought 1
    ////////////////////////////////////////////////
    
    //////////////////////////////////////////////////////
    








    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /*
    always @(state or done or i_in_valid or t_o_busy) 
    begin
                case (state)
                    rstate:
                        begin
                            next_state = estate;
                        end

                    estate: 
                        begin
                            
                            if ((i_in_valid) && (!t_o_busy)) 
                                begin
                                    next_state = pstate;
                                end
                            else
                                begin
                                    next_state = estate;
                                end
                            
                        end
            
                    pstate: 
                        begin
                        
                            if(done)
                                begin
                                    next_state = ostate;
                                end
                            else
                                begin
                                    next_state = pstate;
                                end
                        end
            
                    ostate: 
                        begin
                            next_state = estate;
                        end
                    default:
                        begin
                            next_state = estate;
                        end
                ////////////////////////////

                endcase
    end
    //////////////////////////////////////////////////////////////////////////
    */

    





    /*
    reg che;


    
    always @(posedge i_clk or negedge i_rst_n) 
    begin
        if(!i_rst_n)
            begin
                state <= rstate;
            end
        else
            begin
                state <= next_state;
            end
    end


    //////////////////////////////////////////////////////
    always @(state or i_in_valid) // or done or i_in_valid or t_o_busy
    begin
                case (state)
                    rstate:
                        begin
                            t_o_busy = 0;
                            t_o_out_valid = 0;
                            t_o_data = 16'b0;
                            /////////////////////////
                            for (i = 0; i < DATA_W; i = i + 1) 
                                begin
                                    data_acc[i] = 0;
                                end
                            ////////////////////////////
                            che=0;
                            next_state = estate;
                        end



                    estate:
                        begin
                            if ((i_in_valid) && (!t_o_busy)) 
                                begin
                                    next_state = pstate;
                                    t_o_busy = 1;
                                    t_o_out_valid = 0; 
                                    //////////////////////////////
                                    dataINS = i_inst;
                                    dataA = i_data_a;
                                    dataB = i_data_b; 

                                    che=1;

                                    //$display("dataA = %b", dataA);
                                    //$display("dataB = %b", dataB);
                                    //$display("state = %b", state);

                                    $display("dataA = %b", i_data_a);
                                    $display("dataB = %b", i_data_b);
                                    $display("state = %b", state);
                                    $display("i_in_valid = %b", i_in_valid);
                                    $display("t_o_busy = %b", t_o_busy);
                                    $display("che = %b", che);
                                end
                            else
                                begin
                                    next_state = estate;
                                    t_o_busy = 0;
                                    t_o_out_valid = 0; 
                                    ////////////////////////////
                                    dataINS = -1;
                                    dataA = 0;
                                    dataB = 0;

                                    che=0;
                                    $display("dataA = %b", i_data_a);
                                    $display("dataB = %b", i_data_b);
                                    $display("state = %b", state);
                                    $display("i_in_valid = %b", i_in_valid);
                                    $display("t_o_busy = %b", t_o_busy);
                                    $display("che = %b", che);

                                end
                        end
                    pstate: 
                        begin

                            //if ((i_in_valid) && (!t_o_busy)) 
                            //    begin
                                            //////////////////////////////////////////////
                                            

                                            /////////////////////////
                                            stop = 1'b0;
                                            faketmp=0;
                
                                            LRarray=0;
                                            TMP=0;
                                            idx1=0;
                                            //////////////////////////
                                            
                
                                            case(dataINS)
                                                4'b0000:
                                                    //Signed Addition
                                                    begin
                                                        oANS = SignAdd(dataA,dataB);
                                                    end
                                                4'b0001:
                                                    //Signed Subtraction
                                                    begin
                                                        oANS = SignSub(dataA,dataB);
                                                    end
                                                4'b0010:
                                                    //Signed Multiplication
                                                    begin
                                                        oANS = Mul(dataA,dataB);
                                                    end
                                                4'b0011:
                                                    //Signed Accumulation
                                                    begin
                                                        //oANS = Acc;
                                                        idx1 = dataA[3:0];
                                                        faketmp = data_acc[idx1] + dataB;
                                                        //data_acc[idx1] = faketmp;
                                                        //saturation
                                                        oANS = (faketmp > MAX_VAL) ? MAX_VAL : (faketmp < MIN_VAL) ? MIN_VAL : faketmp[DATA_W-1:0];
                                                    end
                                                4'b0100:
                                                    //Softplus 
                                                    begin
                                                        oANS = Softplus(dataA);
                                                    end
                                                ///////////////////////////////////////////////////////////////////////////////////////////////////////    
                                                4'b0101:
                                                    //XOR
                                                    begin
                                                        oANS = dataA ^ dataB;
                                                    end
                                                4'b0110:
                                                    //Arithmetic Right Shift
                                                    begin
                                                        oANS = dataA >>> dataB;
                                                    end
                                                4'b0111:
                                                    begin
                                                        //add begin end within case
                                                        //Left Rotation
                                                        ///////////////////////////////
                                                        for (m = 0; m < 2; m = m + 1) 
                                                            begin
                                                                for (n = 0; n<DATA_W; n = n+1)
                                                                    begin
                                                                    //k = DATA_W* m + n;
                                                                        LRarray[16*m + n] = dataA[n];
                                                                    end
                                                            end
                                                        /////////////////////////////////
                                                        //data range need to be confirmed out of bound, you cannot just put dataB inside the index
                                                        //idx = dataB[3:0];
                                                        //LRarray[2*DATA_W-1-idx:DATA_W-idx];
                                                        //to avoid unknown part select
                                                        TMP = LRarray << dataB;
                                                        oANS = TMP[2*DATA_W-1:DATA_W];
                                                    end

                                                4'b1000:
                                                    begin
                                                        //Count Leading Zeros
                                                        oANS = 0;
                                                        for (a=0; a<DATA_W; a =a+1)
                                                            begin
                                                                if(stop == 1'b0)
                                                                    begin
                                                                        if (dataA[DATA_W-1-a]==0)
                                                                            begin
                                                                                stop = 1'b0;
                                                                            end
                                                                        else
                                                                            begin
                                                                                stop = 1'b1;
                                                                                oANS = a;
                                                                            end
                                                                    end
                                                                else
                                                                    begin
                                                                        stop = 1'b1;
                                                                    end
                                                            end
                                                        ///////////////////////////////
                                                    end
                                                4'b1001:
                                                    begin
                                                        //Reverse Match4
                                                        //////////////////////
                                                        for (j=0; j<DATA_W; j=j+1)
                                                            begin
                                                                if((j>12) && (j<DATA_W))
                                                                    begin
                                                                        oANS[j] =0;
                                                                    end
                                                                else
                                                                    begin
                                                                        //use this way so that it can be synthesized
                                                                        if(dataA[j +: 4] == dataB[12-j +: 4])
                                                                            //if(dataA[j+3:j] == dataB[15-j:12-j])
                                                                            begin
                                                                                oANS[j] = 1;
                                                                            end
                                                                        else
                                                                            begin
                                                                                oANS[j] = 0;
                                                                            end
                                                                    end
                                                            end
                                                    //////////////////////////
                                                    end
                                                default:
                                                    begin
                                                        oANS =0;
                                                    end
                                            endcase
                                            ///////
                                            ////////////////////////////////////////////////////////////////////////
                                            next_state = ostate;
                                            t_o_data = oANS;
                                             

                                            //stored reg should be updated within always clock
                                            //data_acc[dataA[3:0]] <= faketmp;
                            //    end
                            //else
                            //    begin
                                    /////////////////////////////////////////////////////////////////////////
                            //        next_state = estate;
                            //    end
                        end   

                    

                    ostate: 
                        begin
                            t_o_out_valid = 1; 
                            t_o_busy = 0;
                            next_state = estate;
                        end
                    default:
                        begin
                            t_o_busy = 0;
                            t_o_out_valid = 0;
                            t_o_data = 16'b0;
                
                            //dataINS = -1;
                            //dataA = 0;
                            //dataB = 0;

                            /////////////////////////
                            for (i = 0; i < DATA_W; i = i + 1) 
                                begin
                                    data_acc[i] = 0;
                                end
                            ////////////////////////////

                        end
                ////////////////////////////

                endcase
    end
    //////////////////////////////////////////////////////////////////////////
    */
    always@(next_state)//negedge i_clk or negedge i_rst_n
    begin

        state = next_state;
        //if (!i_rst_n) 
        //    begin
        //        state <= estate;
        //    end
        //else
        //    begin
        //        state <= next_state;
        //    end
    end    


    always @(posedge i_clk or negedge i_rst_n) 
    begin
        if (!i_rst_n) 
            begin
                next_state <= estate;
                t_o_busy <= 0;
                t_o_out_valid <= 0;
                t_o_data <= 16'b0;
                
                dataINS <= -1;
                dataA <= 0;
                dataB <= 0;

                /////////////////////////
                for (i = 0; i < DATA_W; i = i + 1) 
                    begin
                        data_acc[i] <= 0;
                    end
                ////////////////////////////
                ///////////////////////////////////////////
            end 
        else 
            begin
                case (state)
                    estate: 
                        begin
                            t_o_out_valid <= 0;
                            
                            if ((i_in_valid) && (!t_o_busy)) 
                                begin
                                    dataINS <= i_inst;
                                    dataA <= i_data_a;
                                    dataB <= i_data_b; 

                                    t_o_busy <= 1;
                                    next_state <= pstate;
                                end
                            else
                                begin
                                    next_state <= estate;
                                    t_o_busy <= 0;

                                    dataINS <= -1;
                                    dataA <= 0;
                                    dataB <= 0; 
                                end
                            
                        end
            
                    pstate: 
                        begin
                        
                            if(done)
                                begin
                                    t_o_data <= oANS;
                                    t_o_out_valid <= 1;  
                                    next_state <= ostate;

                                    //stored reg should be updated within always clock
                                    data_acc[dataA[3:0]] <= faketmp;
                                end
                            else
                                begin
                                    //no data_acc is ok because it is sequential logic
                                    next_state <= pstate;
                                    t_o_out_valid <= 0;  
                                    t_o_data <= 0;
                                end
                        end
            
                    ostate: 
                        begin
                            t_o_out_valid <= 0;
                            t_o_busy <= 0;
                            next_state <= estate;
                        end
              
                    default:
                        begin
                            next_state <= estate;
                            t_o_busy <= 0;
                            t_o_out_valid <= 0;
                            t_o_data <= 16'b0;
                
                            dataINS <= -1;
                            dataA <= 0;
                            dataB <= 0;

                            /////////////////////////
                            for (i = 0; i < DATA_W; i = i + 1) 
                                begin
                                    data_acc[i] <= 0;
                                end
                        end
                ////////////////////////////

                endcase
            end
    end
    





   
   
  











    //Right result
    /*
    //////////////////////////////////////////////////////
    always @(posedge i_clk or negedge i_rst_n) 
    begin
        if (!i_rst_n) 
            begin
                state <= estate;
                t_o_busy <= 0;
                t_o_out_valid <= 0;
                t_o_data <= 16'b0;
                
                dataINS <= -1;
                dataA <= 0;
                dataB <= 0;

                /////////////////////////
                for (i = 0; i < DATA_W; i = i + 1) 
                    begin
                        data_acc[i] <= 0;
                    end
                ////////////////////////////
                ///////////////////////////////////////////
            end 
        else 
            begin
                case (state)
                    estate: 
                        begin
                            t_o_out_valid <= 0;
                            
                            if ((i_in_valid) && (!t_o_busy)) 
                                begin
                                    dataINS <= i_inst;
                                    dataA <= i_data_a;
                                    dataB <= i_data_b; 

                                    t_o_busy <= 1;
                                    state <= pstate;
                                end
                            else
                                begin
                                    state <= estate;
                                    t_o_busy <= 0;

                                    dataINS <= -1;
                                    dataA <= 0;
                                    dataB <= 0; 
                                end
                            
                        end
            
                    pstate: 
                        begin
                        
                            if(done)
                                begin
                                    t_o_data <= oANS;
                                    t_o_out_valid <= 1;  
                                    state <= ostate;

                                    //stored reg should be updated within always clock
                                    data_acc[dataA[3:0]] <= faketmp;
                                end
                            else
                                begin
                                    state <= pstate;
                                    t_o_out_valid <= 0;  
                                    t_o_data <= 0;
                                end
                        end
            
                    ostate: 
                        begin
                            t_o_out_valid <= 0;
                            t_o_busy <= 0;
                            state <= estate;
                        end
                    default:
                        begin
                            state <= estate;
                            t_o_busy <= 0;
                            t_o_out_valid <= 0;
                            t_o_data <= 16'b0;
                
                            dataINS <= -1;
                            dataA <= 0;
                            dataB <= 0;

                            /////////////////////////
                            for (i = 0; i < DATA_W; i = i + 1) 
                                begin
                                    data_acc[i] <= 0;
                                end
                        end
                ////////////////////////////

                endcase
            end
    end
    //////////////////////////////////////////////////////////////////////////
    
    */







    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //Thought 2
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /*
    always@(negedge i_rst_n or posedge i_clk)
    begin
        if(!doing) //have done calculation or no input yet
            begin
                if(o_busy) //there is input, have done calculation
                    begin
                        o_data = oANS;
                        ////
                        o_out_valid =1;
                        o_busy =0;

                    end
                else //no input yet
                    begin
                        o_out_valid =0;
                    end

                //the new input finish calculation before the next positive edge: doing =0
                ?

            end
        else
            //the new input hasn't finished calculation after the next positive edge: doing =1
            begin
                o_out_valid =0;
                o_busy =1;
            end
    end

    //////////////////////////////////////////////////////////////
    
    /////////////////////////////////////////////////////////////////
    //The testbench will sample o_data at negative clock edge if o_out_valid is high.
    //o_out_valid should be high for only one cycle for each o_data.
    
    //All outputs should be synchronized with the positive clock edge.
    //All inputs are synchronized with the negative clock edge.

    //i_in_valid
    //o_busy
    //o_out_valid
    //fin

    always@(negedge i_rst_n or negedge i_clk)
    begin
        if(!i_rst_n)
            begin
                for (i = 0; i < 16; i = i + 1) 
                    begin
                        data_acc[i] = 0;
                    end
                
            end

            dataA=0;
            dataB=0;
            dataINS=-1;

        else
            begin
                if(i_in_valid)
                    begin
                        if(!o_busy)
                            begin
                                
                                dataA = i_data_a;
                                dataB = i_data_b;
                                dataINS = i_inst;
                            end 
                        else
                            //no need for any action
                    end
                else
                    begin
                       //no need for any action
                    end
            end
    end
    */
    /////////////////////////////////////////////////////////////////////////////////////////////////////







    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //Thought 3
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    /*
    parameter rstate =2'b00;
    parameter estate =2'b01;
    parameter pstate =2'b10;
    parameter ostate =2'b11;

    reg [1:0] currstate;
    reg [1:0] nextstate;
    */

    //////////////////////////////////////////////////////
    //Active low asynchronous reset is used only once
    //i_rst_n: Active low asynchronous reset

    //All inputs are synchronized with the negative clock edge.
    //All outputs should be synchronized with the positive clock edge.

    /*
    always@(negedge i_rst_n or posedge i_clk)
    begin
        if(!i_rst_n)
            begin
                currstate <= rstate;
            end
        else
            begin
                currstate <= nextstate;;
            end
    end
    */
    ///////////////////////////////////////////////////////
    /*
    always@(*)
    begin
        case(currstate)
            rstate:
                nextstate = estate;
                o_busy = 1;
                o_out_valid = 0;
                o_data =0;

                dataA = 0;
                dataB = 0;
                dataINS =-1;

                //////
                //for accumulation
                for (i = 0; i < 16; i = i + 1) 
                    begin
                        data_acc[i] = 0;
                    end
                //////

                //
                //for leading zero
                stop = 0;
                //

            estate:
                ///////////////////
                //New pattern (i_inst, i_data_a and i_data_b) is ready only when i_in_valid is high.
                //i_in_valid will be randomly pulled high only if o_busy is low.
                //i_in_valid: The signal is high if input data is ready
                //=> testbench will make sure this happen

                //o_busy :Set low if ready for next input data.
                //       :Set high to pause input sequence.
                ////////////////////
                nextstate = pstate;
                o_busy = 0;
                o_out_valid = 0;

                dataA = i_data_a;
                dataB = i_data_b;
                dataINS = i_inst;


            pstate:
                nextstate = ostate;
                o_busy = 1;
                o_out_valid = 0;


            ostate:
                ///////////////
                //The testbench will sample o_data at negative clock edge if o_out_valid is high.
                //o_out_valid: Set high if ready to output result
                //o_out_valid should be high for only one cycle for each o_data.
                //You can raise o_out_valid at any moment

                //o_data: Signed output data with 2’s complement representation
                ///////////////
                nextstate = estate;


                o_busy = 1;
                o_out_valid = 1;

                o_data = oANS;
            default:
                nextstate = estate;
                o_busy = 1;
                o_out_valid = 0;
                o_data =0;

                dataA = 0;
                dataB = 0;
                dataINS =-1;


                //////
                //for accumulation
                for (i = 0; i < 16; i = i + 1) 
                    begin
                        data_acc[i] = 0;
                    end
                //////
        endcase
    end

    */
    //////////////////////////////////////////////////////////////////////////////////////////////////



endmodule
