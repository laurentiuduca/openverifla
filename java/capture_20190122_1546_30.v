`timescale 1ns / 10ps

module capture_20190122_1546_30(clk_of_verifla, la_trigger_matched, cnta, cntb, memory_line_id);

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
{cntb,cnta} = 16'b0000000000000001;
#40;
// -------------  Current Time:  50*(1ns) 
memory_line_id=1;
{cntb,cnta} = 16'b0000000100000011;
#40;
// -------------  Current Time:  90*(1ns) 
memory_line_id=8;
{cntb,cnta} = 16'b0000001000000101;
la_trigger_matched = 1;
#40;
// -------------  Current Time:  130*(1ns) 
memory_line_id=9;
{cntb,cnta} = 16'b0000001100000111;
#40;
// -------------  Current Time:  170*(1ns) 
memory_line_id=10;
{cntb,cnta} = 16'b0000010000001001;
#40;
// -------------  Current Time:  210*(1ns) 
memory_line_id=11;
{cntb,cnta} = 16'b0000010100001011;
#40;
// -------------  Current Time:  250*(1ns) 
memory_line_id=12;
{cntb,cnta} = 16'b0000011000001101;
#40;
// -------------  Current Time:  290*(1ns) 
memory_line_id=13;
{cntb,cnta} = 16'b0000011100001111;
#40;
// -------------  Current Time:  330*(1ns) 
memory_line_id=14;
{cntb,cnta} = 16'b0000100000010001;
#40;
// -------------  Current Time:  370*(1ns) 
memory_line_id=15;
{cntb,cnta} = 16'b0000100100010011;
#40;
// -------------  Current Time:  410*(1ns) 
memory_line_id=16;
{cntb,cnta} = 16'b0000101000010101;
#40;
// -------------  Current Time:  450*(1ns) 
memory_line_id=17;
{cntb,cnta} = 16'b0000101100010111;
#40;
// -------------  Current Time:  490*(1ns) 
memory_line_id=18;
{cntb,cnta} = 16'b0000110000011001;
#40;
// -------------  Current Time:  530*(1ns) 
memory_line_id=19;
{cntb,cnta} = 16'b0000110100011011;
#40;
// -------------  Current Time:  570*(1ns) 
memory_line_id=20;
{cntb,cnta} = 16'b0000111000011101;
#40;
// -------------  Current Time:  610*(1ns) 
memory_line_id=21;
{cntb,cnta} = 16'b0000111100011111;
#40;
// -------------  Current Time:  650*(1ns) 
memory_line_id=22;
{cntb,cnta} = 16'b0001000000100001;
#40;
// -------------  Current Time:  690*(1ns) 
memory_line_id=23;
{cntb,cnta} = 16'b0001000100100011;
#40;
// -------------  Current Time:  730*(1ns) 
memory_line_id=24;
{cntb,cnta} = 16'b0001001000100101;
#40;
// -------------  Current Time:  770*(1ns) 
memory_line_id=25;
{cntb,cnta} = 16'b0001001100100111;
#40;
// -------------  Current Time:  810*(1ns) 
memory_line_id=26;
{cntb,cnta} = 16'b0001010000101001;
#40;
// -------------  Current Time:  850*(1ns) 
memory_line_id=27;
{cntb,cnta} = 16'b0001010100101011;
#40;
// -------------  Current Time:  890*(1ns) 
memory_line_id=28;
{cntb,cnta} = 16'b0001011000101101;
#40;
// -------------  Current Time:  930*(1ns) 
memory_line_id=29;
{cntb,cnta} = 16'b0001011100101111;
#40;
// -------------  Current Time:  970*(1ns) 
memory_line_id=30;
{cntb,cnta} = 16'b0001100000110001;
#40;
// -------------  Current Time:  1010*(1ns) 
memory_line_id=31;
{cntb,cnta} = 16'b0001100100110011;
#40;
// -------------  Current Time:  1050*(1ns) 
memory_line_id=32;
{cntb,cnta} = 16'b0001101000110101;
#40;
// -------------  Current Time:  1090*(1ns) 
memory_line_id=33;
{cntb,cnta} = 16'b0001101100110111;
#40;
// -------------  Current Time:  1130*(1ns) 
memory_line_id=34;
{cntb,cnta} = 16'b0001110000111001;
#40;
// -------------  Current Time:  1170*(1ns) 
memory_line_id=35;
{cntb,cnta} = 16'b0001110100111011;
#40;
// -------------  Current Time:  1210*(1ns) 
memory_line_id=36;
{cntb,cnta} = 16'b0001111000111101;
#40;
// -------------  Current Time:  1250*(1ns) 
memory_line_id=37;
{cntb,cnta} = 16'b0001111100111111;
#40;
// -------------  Current Time:  1290*(1ns) 
memory_line_id=38;
{cntb,cnta} = 16'b0010000001000001;
#40;
// -------------  Current Time:  1330*(1ns) 
memory_line_id=39;
{cntb,cnta} = 16'b0010000101000011;
#40;
// -------------  Current Time:  1370*(1ns) 
memory_line_id=40;
{cntb,cnta} = 16'b0010001001000101;
#40;
// -------------  Current Time:  1410*(1ns) 
memory_line_id=41;
{cntb,cnta} = 16'b0010001101000111;
#40;
// -------------  Current Time:  1450*(1ns) 
memory_line_id=42;
{cntb,cnta} = 16'b0010010001001001;
#40;
// -------------  Current Time:  1490*(1ns) 
memory_line_id=43;
{cntb,cnta} = 16'b0010010101001011;
#40;
// -------------  Current Time:  1530*(1ns) 
memory_line_id=44;
{cntb,cnta} = 16'b0010011001001101;
#40;
// -------------  Current Time:  1570*(1ns) 
memory_line_id=45;
{cntb,cnta} = 16'b0010011101001111;
#40;
// -------------  Current Time:  1610*(1ns) 
memory_line_id=46;
{cntb,cnta} = 16'b0010100001010001;
#40;
// -------------  Current Time:  1650*(1ns) 
memory_line_id=47;
{cntb,cnta} = 16'b0010100101010011;
#40;
// -------------  Current Time:  1690*(1ns) 
memory_line_id=48;
{cntb,cnta} = 16'b0010101001010101;
#40;
// -------------  Current Time:  1730*(1ns) 
memory_line_id=49;
{cntb,cnta} = 16'b0010101101010111;
#40;
// -------------  Current Time:  1770*(1ns) 
memory_line_id=50;
{cntb,cnta} = 16'b0010110001011001;
#40;
// -------------  Current Time:  1810*(1ns) 
memory_line_id=51;
{cntb,cnta} = 16'b0010110101011011;
#40;
// -------------  Current Time:  1850*(1ns) 
memory_line_id=52;
{cntb,cnta} = 16'b0010111001011101;
#40;
// -------------  Current Time:  1890*(1ns) 
memory_line_id=53;
{cntb,cnta} = 16'b0010111101011111;
#40;
// -------------  Current Time:  1930*(1ns) 
memory_line_id=54;
{cntb,cnta} = 16'b0011000001100001;
#40;
// -------------  Current Time:  1970*(1ns) 
memory_line_id=55;
{cntb,cnta} = 16'b0011000101100011;
#40;
// -------------  Current Time:  2010*(1ns) 
memory_line_id=56;
{cntb,cnta} = 16'b0011001001100101;
#40;
// -------------  Current Time:  2050*(1ns) 
memory_line_id=57;
{cntb,cnta} = 16'b0011001101100111;
#40;
// -------------  Current Time:  2090*(1ns) 
memory_line_id=58;
{cntb,cnta} = 16'b0011010001101001;
#40;
// -------------  Current Time:  2130*(1ns) 
memory_line_id=59;
{cntb,cnta} = 16'b0011010101101011;
#40;
// -------------  Current Time:  2170*(1ns) 
memory_line_id=60;
{cntb,cnta} = 16'b0011011001101101;
#40;
// -------------  Current Time:  2210*(1ns) 
memory_line_id=61;
{cntb,cnta} = 16'b0011011101101111;
#40;
// -------------  Current Time:  2250*(1ns) 
memory_line_id=62;
{cntb,cnta} = 16'b0011100001110001;
#40;
// -------------  Current Time:  2290*(1ns) 
$stop;
end
endmodule
/*
ORIGINAL CAPTURE DUMP
memory_line_id=0: 02 00 01 
memory_line_id=1: 02 01 03 
memory_line_id=2: 00 00 00 
memory_line_id=3: 00 00 00 
memory_line_id=4: 00 00 00 
memory_line_id=5: 00 00 00 
memory_line_id=6: 00 00 00 
memory_line_id=7: 00 00 00 
memory_line_id=8: 02 02 05 
memory_line_id=9: 02 03 07 
memory_line_id=10: 02 04 09 
memory_line_id=11: 02 05 0B 
memory_line_id=12: 02 06 0D 
memory_line_id=13: 02 07 0F 
memory_line_id=14: 02 08 11 
memory_line_id=15: 02 09 13 
memory_line_id=16: 02 0A 15 
memory_line_id=17: 02 0B 17 
memory_line_id=18: 02 0C 19 
memory_line_id=19: 02 0D 1B 
memory_line_id=20: 02 0E 1D 
memory_line_id=21: 02 0F 1F 
memory_line_id=22: 02 10 21 
memory_line_id=23: 02 11 23 
memory_line_id=24: 02 12 25 
memory_line_id=25: 02 13 27 
memory_line_id=26: 02 14 29 
memory_line_id=27: 02 15 2B 
memory_line_id=28: 02 16 2D 
memory_line_id=29: 02 17 2F 
memory_line_id=30: 02 18 31 
memory_line_id=31: 02 19 33 
memory_line_id=32: 02 1A 35 
memory_line_id=33: 02 1B 37 
memory_line_id=34: 02 1C 39 
memory_line_id=35: 02 1D 3B 
memory_line_id=36: 02 1E 3D 
memory_line_id=37: 02 1F 3F 
memory_line_id=38: 02 20 41 
memory_line_id=39: 02 21 43 
memory_line_id=40: 02 22 45 
memory_line_id=41: 02 23 47 
memory_line_id=42: 02 24 49 
memory_line_id=43: 02 25 4B 
memory_line_id=44: 02 26 4D 
memory_line_id=45: 02 27 4F 
memory_line_id=46: 02 28 51 
memory_line_id=47: 02 29 53 
memory_line_id=48: 02 2A 55 
memory_line_id=49: 02 2B 57 
memory_line_id=50: 02 2C 59 
memory_line_id=51: 02 2D 5B 
memory_line_id=52: 02 2E 5D 
memory_line_id=53: 02 2F 5F 
memory_line_id=54: 02 30 61 
memory_line_id=55: 02 31 63 
memory_line_id=56: 02 32 65 
memory_line_id=57: 02 33 67 
memory_line_id=58: 02 34 69 
memory_line_id=59: 02 35 6B 
memory_line_id=60: 02 36 6D 
memory_line_id=61: 02 37 6F 
memory_line_id=62: 02 38 71 
memory_line_id=63: 00 00 01 
*/
