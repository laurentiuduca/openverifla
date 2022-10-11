`timescale 1ns / 10ps

module capture_20221011_125033(clk_of_verifla, la_trigger_matched, cnta, cntb, memory_line_id);

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
memory_line_id=0;
{cntb,cnta} = 16'b0000000000000000;
#20;
// -------------  Current Time:  30*(1ns) 
memory_line_id=1;
{cntb,cnta} = 16'b0000000000000001;
#20;
// -------------  Current Time:  50*(1ns) 
memory_line_id=2;
{cntb,cnta} = 16'b0000000100000010;
#20;
// -------------  Current Time:  70*(1ns) 
memory_line_id=3;
{cntb,cnta} = 16'b0000000100000011;
#20;
// -------------  Current Time:  90*(1ns) 
memory_line_id=8;
{cntb,cnta} = 16'b0000001000000100;
la_trigger_matched = 1;
#20;
// -------------  Current Time:  110*(1ns) 
memory_line_id=9;
{cntb,cnta} = 16'b0000001000000101;
#20;
// -------------  Current Time:  130*(1ns) 
memory_line_id=10;
{cntb,cnta} = 16'b0000001100000110;
#20;
// -------------  Current Time:  150*(1ns) 
memory_line_id=11;
{cntb,cnta} = 16'b0000001100000111;
#20;
// -------------  Current Time:  170*(1ns) 
memory_line_id=12;
{cntb,cnta} = 16'b0000010000001000;
#20;
// -------------  Current Time:  190*(1ns) 
memory_line_id=13;
{cntb,cnta} = 16'b0000010000001001;
#20;
// -------------  Current Time:  210*(1ns) 
memory_line_id=14;
{cntb,cnta} = 16'b0000010100001010;
#20;
// -------------  Current Time:  230*(1ns) 
memory_line_id=15;
{cntb,cnta} = 16'b0000010100001011;
#20;
// -------------  Current Time:  250*(1ns) 
memory_line_id=16;
{cntb,cnta} = 16'b0000011000001100;
#20;
// -------------  Current Time:  270*(1ns) 
memory_line_id=17;
{cntb,cnta} = 16'b0000011000001101;
#20;
// -------------  Current Time:  290*(1ns) 
memory_line_id=18;
{cntb,cnta} = 16'b0000011100001110;
#20;
// -------------  Current Time:  310*(1ns) 
memory_line_id=19;
{cntb,cnta} = 16'b0000011100001111;
#20;
// -------------  Current Time:  330*(1ns) 
memory_line_id=20;
{cntb,cnta} = 16'b0000100000010000;
#20;
// -------------  Current Time:  350*(1ns) 
memory_line_id=21;
{cntb,cnta} = 16'b0000100000010001;
#20;
// -------------  Current Time:  370*(1ns) 
memory_line_id=22;
{cntb,cnta} = 16'b0000100100010010;
#20;
// -------------  Current Time:  390*(1ns) 
memory_line_id=23;
{cntb,cnta} = 16'b0000100100010011;
#20;
// -------------  Current Time:  410*(1ns) 
memory_line_id=24;
{cntb,cnta} = 16'b0000101000010100;
#20;
// -------------  Current Time:  430*(1ns) 
memory_line_id=25;
{cntb,cnta} = 16'b0000101000010101;
#20;
// -------------  Current Time:  450*(1ns) 
memory_line_id=26;
{cntb,cnta} = 16'b0000101100010110;
#20;
// -------------  Current Time:  470*(1ns) 
memory_line_id=27;
{cntb,cnta} = 16'b0000101100010111;
#20;
// -------------  Current Time:  490*(1ns) 
memory_line_id=28;
{cntb,cnta} = 16'b0000110000011000;
#20;
// -------------  Current Time:  510*(1ns) 
memory_line_id=29;
{cntb,cnta} = 16'b0000110000011001;
#20;
// -------------  Current Time:  530*(1ns) 
memory_line_id=30;
{cntb,cnta} = 16'b0000110100011010;
#20;
// -------------  Current Time:  550*(1ns) 
memory_line_id=31;
{cntb,cnta} = 16'b0000110100011011;
#20;
// -------------  Current Time:  570*(1ns) 
memory_line_id=32;
{cntb,cnta} = 16'b0000111000011100;
#20;
// -------------  Current Time:  590*(1ns) 
memory_line_id=33;
{cntb,cnta} = 16'b0000111000011101;
#20;
// -------------  Current Time:  610*(1ns) 
memory_line_id=34;
{cntb,cnta} = 16'b0000111100011110;
#20;
// -------------  Current Time:  630*(1ns) 
memory_line_id=35;
{cntb,cnta} = 16'b0000111100011111;
#20;
// -------------  Current Time:  650*(1ns) 
memory_line_id=36;
{cntb,cnta} = 16'b0001000000100000;
#20;
// -------------  Current Time:  670*(1ns) 
memory_line_id=37;
{cntb,cnta} = 16'b0001000000100001;
#20;
// -------------  Current Time:  690*(1ns) 
memory_line_id=38;
{cntb,cnta} = 16'b0001000100100010;
#20;
// -------------  Current Time:  710*(1ns) 
memory_line_id=39;
{cntb,cnta} = 16'b0001000100100011;
#20;
// -------------  Current Time:  730*(1ns) 
memory_line_id=40;
{cntb,cnta} = 16'b0001001000100100;
#20;
// -------------  Current Time:  750*(1ns) 
memory_line_id=41;
{cntb,cnta} = 16'b0001001000100101;
#20;
// -------------  Current Time:  770*(1ns) 
memory_line_id=42;
{cntb,cnta} = 16'b0001001100100110;
#20;
// -------------  Current Time:  790*(1ns) 
memory_line_id=43;
{cntb,cnta} = 16'b0001001100100111;
#20;
// -------------  Current Time:  810*(1ns) 
memory_line_id=44;
{cntb,cnta} = 16'b0001010000101000;
#20;
// -------------  Current Time:  830*(1ns) 
memory_line_id=45;
{cntb,cnta} = 16'b0001010000101001;
#20;
// -------------  Current Time:  850*(1ns) 
memory_line_id=46;
{cntb,cnta} = 16'b0001010100101010;
#20;
// -------------  Current Time:  870*(1ns) 
memory_line_id=47;
{cntb,cnta} = 16'b0001010100101011;
#20;
// -------------  Current Time:  890*(1ns) 
memory_line_id=48;
{cntb,cnta} = 16'b0001011000101100;
#20;
// -------------  Current Time:  910*(1ns) 
memory_line_id=49;
{cntb,cnta} = 16'b0001011000101101;
#20;
// -------------  Current Time:  930*(1ns) 
memory_line_id=50;
{cntb,cnta} = 16'b0001011100101110;
#20;
// -------------  Current Time:  950*(1ns) 
memory_line_id=51;
{cntb,cnta} = 16'b0001011100101111;
#20;
// -------------  Current Time:  970*(1ns) 
memory_line_id=52;
{cntb,cnta} = 16'b0001100000110000;
#20;
// -------------  Current Time:  990*(1ns) 
memory_line_id=53;
{cntb,cnta} = 16'b0001100000110001;
#20;
// -------------  Current Time:  1010*(1ns) 
memory_line_id=54;
{cntb,cnta} = 16'b0001100100110010;
#20;
// -------------  Current Time:  1030*(1ns) 
memory_line_id=55;
{cntb,cnta} = 16'b0001100100110011;
#20;
// -------------  Current Time:  1050*(1ns) 
memory_line_id=56;
{cntb,cnta} = 16'b0001101000110100;
#20;
// -------------  Current Time:  1070*(1ns) 
memory_line_id=57;
{cntb,cnta} = 16'b0001101000110101;
#20;
// -------------  Current Time:  1090*(1ns) 
memory_line_id=58;
{cntb,cnta} = 16'b0001101100110110;
#20;
// -------------  Current Time:  1110*(1ns) 
memory_line_id=59;
{cntb,cnta} = 16'b0001101100110111;
#20;
// -------------  Current Time:  1130*(1ns) 
memory_line_id=60;
{cntb,cnta} = 16'b0001110000111000;
#20;
// -------------  Current Time:  1150*(1ns) 
memory_line_id=61;
{cntb,cnta} = 16'b0001110000111001;
#20;
// -------------  Current Time:  1170*(1ns) 
memory_line_id=62;
{cntb,cnta} = 16'b0001110100111010;
#20;
// -------------  Current Time:  1190*(1ns) 
$stop;
end
endmodule
/*
ORIGINAL CAPTURE DUMP
memory_line_id=0: 0x1 0x0 0x0 
memory_line_id=1: 0x1 0x0 0x1 
memory_line_id=2: 0x1 0x1 0x2 
memory_line_id=3: 0x1 0x1 0x3 
memory_line_id=4: 0x0 0x0 0x0 
memory_line_id=5: 0x0 0x0 0x0 
memory_line_id=6: 0x0 0x0 0x0 
memory_line_id=7: 0x0 0x0 0x0 
memory_line_id=8: 0x1 0x2 0x4 
memory_line_id=9: 0x1 0x2 0x5 
memory_line_id=10: 0x1 0x3 0x6 
memory_line_id=11: 0x1 0x3 0x7 
memory_line_id=12: 0x1 0x4 0x8 
memory_line_id=13: 0x1 0x4 0x9 
memory_line_id=14: 0x1 0x5 0xa 
memory_line_id=15: 0x1 0x5 0xb 
memory_line_id=16: 0x1 0x6 0xc 
memory_line_id=17: 0x1 0x6 0xd 
memory_line_id=18: 0x1 0x7 0xe 
memory_line_id=19: 0x1 0x7 0xf 
memory_line_id=20: 0x1 0x8 0x10 
memory_line_id=21: 0x1 0x8 0x11 
memory_line_id=22: 0x1 0x9 0x12 
memory_line_id=23: 0x1 0x9 0x13 
memory_line_id=24: 0x1 0xa 0x14 
memory_line_id=25: 0x1 0xa 0x15 
memory_line_id=26: 0x1 0xb 0x16 
memory_line_id=27: 0x1 0xb 0x17 
memory_line_id=28: 0x1 0xc 0x18 
memory_line_id=29: 0x1 0xc 0x19 
memory_line_id=30: 0x1 0xd 0x1a 
memory_line_id=31: 0x1 0xd 0x1b 
memory_line_id=32: 0x1 0xe 0x1c 
memory_line_id=33: 0x1 0xe 0x1d 
memory_line_id=34: 0x1 0xf 0x1e 
memory_line_id=35: 0x1 0xf 0x1f 
memory_line_id=36: 0x1 0x10 0x20 
memory_line_id=37: 0x1 0x10 0x21 
memory_line_id=38: 0x1 0x11 0x22 
memory_line_id=39: 0x1 0x11 0x23 
memory_line_id=40: 0x1 0x12 0x24 
memory_line_id=41: 0x1 0x12 0x25 
memory_line_id=42: 0x1 0x13 0x26 
memory_line_id=43: 0x1 0x13 0x27 
memory_line_id=44: 0x1 0x14 0x28 
memory_line_id=45: 0x1 0x14 0x29 
memory_line_id=46: 0x1 0x15 0x2a 
memory_line_id=47: 0x1 0x15 0x2b 
memory_line_id=48: 0x1 0x16 0x2c 
memory_line_id=49: 0x1 0x16 0x2d 
memory_line_id=50: 0x1 0x17 0x2e 
memory_line_id=51: 0x1 0x17 0x2f 
memory_line_id=52: 0x1 0x18 0x30 
memory_line_id=53: 0x1 0x18 0x31 
memory_line_id=54: 0x1 0x19 0x32 
memory_line_id=55: 0x1 0x19 0x33 
memory_line_id=56: 0x1 0x1a 0x34 
memory_line_id=57: 0x1 0x1a 0x35 
memory_line_id=58: 0x1 0x1b 0x36 
memory_line_id=59: 0x1 0x1b 0x37 
memory_line_id=60: 0x1 0x1c 0x38 
memory_line_id=61: 0x1 0x1c 0x39 
memory_line_id=62: 0x1 0x1d 0x3a 
memory_line_id=63: 0x0 0x0 0x3 
*/
