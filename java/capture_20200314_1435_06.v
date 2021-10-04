`timescale 1ns / 10ps

module capture_20200314_1435_06(clk_of_verifla, la_trigger_matched, cnta, cntb, memory_line_id);

output clk_of_verifla;
output la_trigger_matched;
output [16:0] memory_line_id;
output [7:0] cnta;
output [7:0] cntb;
reg [7:0] cnta;
reg [7:0] cntb;
reg [16:0] memory_line_id;
reg la_trigger_matched;
reg clk_of_verifla;

parameter PERIOD = 20;
initial    // Clock process for clk_of_verifla
begin
    forever
    begin
        clk_of_verifla = 1'b0;
        #(10); clk_of_verifla = 1'b1;
        #(10);
    end
end

initial begin
#(10);
la_trigger_matched = 0;
memory_line_id=1;
{cntb,cnta} = 16'b0000000000000001;
#20;
// -------------  Current Time:  30*(1ns) 
memory_line_id=2;
{cntb,cnta} = 16'b0000000100000010;
#20;
// -------------  Current Time:  50*(1ns) 
memory_line_id=3;
{cntb,cnta} = 16'b0000000100000011;
#20;
// -------------  Current Time:  70*(1ns) 
memory_line_id=8;
{cntb,cnta} = 16'b0000001000000100;
la_trigger_matched = 1;
#20;
// -------------  Current Time:  90*(1ns) 
memory_line_id=9;
{cntb,cnta} = 16'b0000001000000101;
#20;
// -------------  Current Time:  110*(1ns) 
memory_line_id=10;
{cntb,cnta} = 16'b0000001100000110;
#20;
// -------------  Current Time:  130*(1ns) 
memory_line_id=11;
{cntb,cnta} = 16'b0000001100000111;
#20;
// -------------  Current Time:  150*(1ns) 
memory_line_id=12;
{cntb,cnta} = 16'b0000010000001000;
#20;
// -------------  Current Time:  170*(1ns) 
memory_line_id=13;
{cntb,cnta} = 16'b0000010000001001;
#20;
// -------------  Current Time:  190*(1ns) 
memory_line_id=14;
{cntb,cnta} = 16'b0000010100001010;
#20;
// -------------  Current Time:  210*(1ns) 
memory_line_id=15;
{cntb,cnta} = 16'b0000010100001011;
#20;
// -------------  Current Time:  230*(1ns) 
memory_line_id=16;
{cntb,cnta} = 16'b0000011000001100;
#20;
// -------------  Current Time:  250*(1ns) 
memory_line_id=17;
{cntb,cnta} = 16'b0000011000001101;
#20;
// -------------  Current Time:  270*(1ns) 
memory_line_id=18;
{cntb,cnta} = 16'b0000011100001110;
#20;
// -------------  Current Time:  290*(1ns) 
memory_line_id=19;
{cntb,cnta} = 16'b0000011100001111;
#20;
// -------------  Current Time:  310*(1ns) 
memory_line_id=20;
{cntb,cnta} = 16'b0000100000010000;
#20;
// -------------  Current Time:  330*(1ns) 
memory_line_id=21;
{cntb,cnta} = 16'b0000100000010001;
#20;
// -------------  Current Time:  350*(1ns) 
memory_line_id=22;
{cntb,cnta} = 16'b0000100100010010;
#20;
// -------------  Current Time:  370*(1ns) 
memory_line_id=23;
{cntb,cnta} = 16'b0000100100010011;
#20;
// -------------  Current Time:  390*(1ns) 
memory_line_id=24;
{cntb,cnta} = 16'b0000101000010100;
#20;
// -------------  Current Time:  410*(1ns) 
memory_line_id=25;
{cntb,cnta} = 16'b0000101000010101;
#20;
// -------------  Current Time:  430*(1ns) 
memory_line_id=26;
{cntb,cnta} = 16'b0000101100010110;
#20;
// -------------  Current Time:  450*(1ns) 
memory_line_id=27;
{cntb,cnta} = 16'b0000101100010111;
#20;
// -------------  Current Time:  470*(1ns) 
memory_line_id=28;
{cntb,cnta} = 16'b0000110000011000;
#20;
// -------------  Current Time:  490*(1ns) 
memory_line_id=29;
{cntb,cnta} = 16'b0000110000011001;
#20;
// -------------  Current Time:  510*(1ns) 
memory_line_id=30;
{cntb,cnta} = 16'b0000110100011010;
#20;
// -------------  Current Time:  530*(1ns) 
memory_line_id=31;
{cntb,cnta} = 16'b0000110100011011;
#20;
// -------------  Current Time:  550*(1ns) 
memory_line_id=32;
{cntb,cnta} = 16'b0000111000011100;
#20;
// -------------  Current Time:  570*(1ns) 
memory_line_id=33;
{cntb,cnta} = 16'b0000111000011101;
#20;
// -------------  Current Time:  590*(1ns) 
memory_line_id=34;
{cntb,cnta} = 16'b0000111100011110;
#20;
// -------------  Current Time:  610*(1ns) 
memory_line_id=35;
{cntb,cnta} = 16'b0000111100011111;
#20;
// -------------  Current Time:  630*(1ns) 
memory_line_id=36;
{cntb,cnta} = 16'b0001000000100000;
#20;
// -------------  Current Time:  650*(1ns) 
memory_line_id=37;
{cntb,cnta} = 16'b0001000000100001;
#20;
// -------------  Current Time:  670*(1ns) 
memory_line_id=38;
{cntb,cnta} = 16'b0001000100100010;
#20;
// -------------  Current Time:  690*(1ns) 
memory_line_id=39;
{cntb,cnta} = 16'b0001000100100011;
#20;
// -------------  Current Time:  710*(1ns) 
memory_line_id=40;
{cntb,cnta} = 16'b0001001000100100;
#20;
// -------------  Current Time:  730*(1ns) 
memory_line_id=41;
{cntb,cnta} = 16'b0001001000100101;
#20;
// -------------  Current Time:  750*(1ns) 
memory_line_id=42;
{cntb,cnta} = 16'b0001001100100110;
#20;
// -------------  Current Time:  770*(1ns) 
memory_line_id=43;
{cntb,cnta} = 16'b0001001100100111;
#20;
// -------------  Current Time:  790*(1ns) 
memory_line_id=44;
{cntb,cnta} = 16'b0001010000101000;
#20;
// -------------  Current Time:  810*(1ns) 
memory_line_id=45;
{cntb,cnta} = 16'b0001010000101001;
#20;
// -------------  Current Time:  830*(1ns) 
memory_line_id=46;
{cntb,cnta} = 16'b0001010100101010;
#20;
// -------------  Current Time:  850*(1ns) 
memory_line_id=47;
{cntb,cnta} = 16'b0001010100101011;
#20;
// -------------  Current Time:  870*(1ns) 
memory_line_id=48;
{cntb,cnta} = 16'b0001011000101100;
#20;
// -------------  Current Time:  890*(1ns) 
memory_line_id=49;
{cntb,cnta} = 16'b0001011000101101;
#20;
// -------------  Current Time:  910*(1ns) 
memory_line_id=50;
{cntb,cnta} = 16'b0001011100101110;
#20;
// -------------  Current Time:  930*(1ns) 
memory_line_id=51;
{cntb,cnta} = 16'b0001011100101111;
#20;
// -------------  Current Time:  950*(1ns) 
memory_line_id=52;
{cntb,cnta} = 16'b0001100000110000;
#20;
// -------------  Current Time:  970*(1ns) 
memory_line_id=53;
{cntb,cnta} = 16'b0001100000110001;
#20;
// -------------  Current Time:  990*(1ns) 
memory_line_id=54;
{cntb,cnta} = 16'b0001100100110010;
#20;
// -------------  Current Time:  1010*(1ns) 
memory_line_id=55;
{cntb,cnta} = 16'b0001100100110011;
#20;
// -------------  Current Time:  1030*(1ns) 
memory_line_id=56;
{cntb,cnta} = 16'b0001101000110100;
#20;
// -------------  Current Time:  1050*(1ns) 
memory_line_id=57;
{cntb,cnta} = 16'b0001101000110101;
#20;
// -------------  Current Time:  1070*(1ns) 
memory_line_id=58;
{cntb,cnta} = 16'b0001101100110110;
#20;
// -------------  Current Time:  1090*(1ns) 
memory_line_id=59;
{cntb,cnta} = 16'b0001101100110111;
#20;
// -------------  Current Time:  1110*(1ns) 
memory_line_id=60;
{cntb,cnta} = 16'b0001110000111000;
#20;
// -------------  Current Time:  1130*(1ns) 
memory_line_id=61;
{cntb,cnta} = 16'b0001110000111001;
#20;
// -------------  Current Time:  1150*(1ns) 
memory_line_id=62;
{cntb,cnta} = 16'b0001110100111010;
#20;
// -------------  Current Time:  1170*(1ns) 
$stop;
end
endmodule
/*
ORIGINAL CAPTURE DUMP
memory_line_id=0: 01 00 00 
memory_line_id=1: 01 00 01 
memory_line_id=2: 01 01 02 
memory_line_id=3: 01 01 03 
memory_line_id=4: 00 00 00 
memory_line_id=5: 00 00 00 
memory_line_id=6: 00 00 00 
memory_line_id=7: 00 00 00 
memory_line_id=8: 01 02 04 
memory_line_id=9: 01 02 05 
memory_line_id=10: 01 03 06 
memory_line_id=11: 01 03 07 
memory_line_id=12: 01 04 08 
memory_line_id=13: 01 04 09 
memory_line_id=14: 01 05 0A 
memory_line_id=15: 01 05 0B 
memory_line_id=16: 01 06 0C 
memory_line_id=17: 01 06 0D 
memory_line_id=18: 01 07 0E 
memory_line_id=19: 01 07 0F 
memory_line_id=20: 01 08 10 
memory_line_id=21: 01 08 11 
memory_line_id=22: 01 09 12 
memory_line_id=23: 01 09 13 
memory_line_id=24: 01 0A 14 
memory_line_id=25: 01 0A 15 
memory_line_id=26: 01 0B 16 
memory_line_id=27: 01 0B 17 
memory_line_id=28: 01 0C 18 
memory_line_id=29: 01 0C 19 
memory_line_id=30: 01 0D 1A 
memory_line_id=31: 01 0D 1B 
memory_line_id=32: 01 0E 1C 
memory_line_id=33: 01 0E 1D 
memory_line_id=34: 01 0F 1E 
memory_line_id=35: 01 0F 1F 
memory_line_id=36: 01 10 20 
memory_line_id=37: 01 10 21 
memory_line_id=38: 01 11 22 
memory_line_id=39: 01 11 23 
memory_line_id=40: 01 12 24 
memory_line_id=41: 01 12 25 
memory_line_id=42: 01 13 26 
memory_line_id=43: 01 13 27 
memory_line_id=44: 01 14 28 
memory_line_id=45: 01 14 29 
memory_line_id=46: 01 15 2A 
memory_line_id=47: 01 15 2B 
memory_line_id=48: 01 16 2C 
memory_line_id=49: 01 16 2D 
memory_line_id=50: 01 17 2E 
memory_line_id=51: 01 17 2F 
memory_line_id=52: 01 18 30 
memory_line_id=53: 01 18 31 
memory_line_id=54: 01 19 32 
memory_line_id=55: 01 19 33 
memory_line_id=56: 01 1A 34 
memory_line_id=57: 01 1A 35 
memory_line_id=58: 01 1B 36 
memory_line_id=59: 01 1B 37 
memory_line_id=60: 01 1C 38 
memory_line_id=61: 01 1C 39 
memory_line_id=62: 01 1D 3A 
memory_line_id=63: 00 00 03 
*/
