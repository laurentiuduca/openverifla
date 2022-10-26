`timescale 1ns / 10ps

module capture_20221025_181602(clk_of_verifla, la_trigger_matched, data_o, state, busy_o, r_wait_busy, none, memory_line_id);

output clk_of_verifla;
output la_trigger_matched;
output [16:0] memory_line_id;
output [15:0] data_o;
output [3:0] state;
output busy_o;
output r_wait_busy;
output [1:0] none;
reg [15:0] data_o;
reg [3:0] state;
reg busy_o;
reg r_wait_busy;
reg [1:0] none;
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
memory_line_id=21;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  5070*(1ns) 
memory_line_id=22;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  10130*(1ns) 
memory_line_id=23;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  15190*(1ns) 
memory_line_id=0;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  20250*(1ns) 
memory_line_id=1;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  25310*(1ns) 
memory_line_id=2;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  30370*(1ns) 
memory_line_id=3;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  35430*(1ns) 
memory_line_id=4;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  40490*(1ns) 
memory_line_id=5;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  45550*(1ns) 
memory_line_id=6;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  50610*(1ns) 
memory_line_id=7;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  55670*(1ns) 
memory_line_id=8;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  60730*(1ns) 
memory_line_id=9;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  65790*(1ns) 
memory_line_id=10;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#5060;
// -------------  Current Time:  70850*(1ns) 
memory_line_id=11;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100000000000000000000;
#3480;
// -------------  Current Time:  74330*(1ns) 
memory_line_id=12;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000000000000000000000000;
#20;
// -------------  Current Time:  74350*(1ns) 
memory_line_id=13;
{none,r_wait_busy,busy_o,state,data_o} = 24'b001000010000000000000000;
#20;
// -------------  Current Time:  74370*(1ns) 
memory_line_id=14;
{none,r_wait_busy,busy_o,state,data_o} = 24'b001100010000000000000000;
#20;
// -------------  Current Time:  74390*(1ns) 
memory_line_id=15;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100010000000000000000;
#140;
// -------------  Current Time:  74530*(1ns) 
memory_line_id=16;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000000010000000000000000;
#20;
// -------------  Current Time:  74550*(1ns) 
memory_line_id=17;
{none,r_wait_busy,busy_o,state,data_o} = 24'b001100100000000000000000;
#20;
// -------------  Current Time:  74570*(1ns) 
memory_line_id=18;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100100000000000000000;
#140;
// -------------  Current Time:  74710*(1ns) 
memory_line_id=19;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000000100000000000000000;
#20;
// -------------  Current Time:  74730*(1ns) 
memory_line_id=20;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000100110000000000000000;
#160;
// -------------  Current Time:  74890*(1ns) 
memory_line_id=24;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000000110000010100000011;
la_trigger_matched = 1;
#20;
// -------------  Current Time:  74910*(1ns) 
memory_line_id=25;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  79970*(1ns) 
memory_line_id=26;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  85030*(1ns) 
memory_line_id=27;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  90090*(1ns) 
memory_line_id=28;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  95150*(1ns) 
memory_line_id=29;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  100210*(1ns) 
memory_line_id=30;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  105270*(1ns) 
memory_line_id=31;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  110330*(1ns) 
memory_line_id=32;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  115390*(1ns) 
memory_line_id=33;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  120450*(1ns) 
memory_line_id=34;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  125510*(1ns) 
memory_line_id=35;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  130570*(1ns) 
memory_line_id=36;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  135630*(1ns) 
memory_line_id=37;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  140690*(1ns) 
memory_line_id=38;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  145750*(1ns) 
memory_line_id=39;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  150810*(1ns) 
memory_line_id=40;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  155870*(1ns) 
memory_line_id=41;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  160930*(1ns) 
memory_line_id=42;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  165990*(1ns) 
memory_line_id=43;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  171050*(1ns) 
memory_line_id=44;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  176110*(1ns) 
memory_line_id=45;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  181170*(1ns) 
memory_line_id=46;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  186230*(1ns) 
memory_line_id=47;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  191290*(1ns) 
memory_line_id=48;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  196350*(1ns) 
memory_line_id=49;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  201410*(1ns) 
memory_line_id=50;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  206470*(1ns) 
memory_line_id=51;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  211530*(1ns) 
memory_line_id=52;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  216590*(1ns) 
memory_line_id=53;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  221650*(1ns) 
memory_line_id=54;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  226710*(1ns) 
memory_line_id=55;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  231770*(1ns) 
memory_line_id=56;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  236830*(1ns) 
memory_line_id=57;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  241890*(1ns) 
memory_line_id=58;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  246950*(1ns) 
memory_line_id=59;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  252010*(1ns) 
memory_line_id=60;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  257070*(1ns) 
memory_line_id=61;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  262130*(1ns) 
memory_line_id=62;
{none,r_wait_busy,busy_o,state,data_o} = 24'b000001000000010100000011;
#5060;
// -------------  Current Time:  267190*(1ns) 
$stop;
end
endmodule
/*
ORIGINAL CAPTURE DUMP
memory_line_id=0: 0xfd 0x10 0x0 0x0 
memory_line_id=1: 0xfd 0x10 0x0 0x0 
memory_line_id=2: 0xfd 0x10 0x0 0x0 
memory_line_id=3: 0xfd 0x10 0x0 0x0 
memory_line_id=4: 0xfd 0x10 0x0 0x0 
memory_line_id=5: 0xfd 0x10 0x0 0x0 
memory_line_id=6: 0xfd 0x10 0x0 0x0 
memory_line_id=7: 0xfd 0x10 0x0 0x0 
memory_line_id=8: 0xfd 0x10 0x0 0x0 
memory_line_id=9: 0xfd 0x10 0x0 0x0 
memory_line_id=10: 0xfd 0x10 0x0 0x0 
memory_line_id=11: 0xae 0x10 0x0 0x0 
memory_line_id=12: 0x1 0x0 0x0 0x0 
memory_line_id=13: 0x1 0x21 0x0 0x0 
memory_line_id=14: 0x1 0x31 0x0 0x0 
memory_line_id=15: 0x7 0x11 0x0 0x0 
memory_line_id=16: 0x1 0x1 0x0 0x0 
memory_line_id=17: 0x1 0x32 0x0 0x0 
memory_line_id=18: 0x7 0x12 0x0 0x0 
memory_line_id=19: 0x1 0x2 0x0 0x0 
memory_line_id=20: 0x8 0x13 0x0 0x0 
memory_line_id=21: 0xfd 0x10 0x0 0x0 
memory_line_id=22: 0xfd 0x10 0x0 0x0 
memory_line_id=23: 0xfd 0x10 0x0 0x0 
memory_line_id=24: 0x1 0x3 0x5 0x3 
memory_line_id=25: 0xfd 0x4 0x5 0x3 
memory_line_id=26: 0xfd 0x4 0x5 0x3 
memory_line_id=27: 0xfd 0x4 0x5 0x3 
memory_line_id=28: 0xfd 0x4 0x5 0x3 
memory_line_id=29: 0xfd 0x4 0x5 0x3 
memory_line_id=30: 0xfd 0x4 0x5 0x3 
memory_line_id=31: 0xfd 0x4 0x5 0x3 
memory_line_id=32: 0xfd 0x4 0x5 0x3 
memory_line_id=33: 0xfd 0x4 0x5 0x3 
memory_line_id=34: 0xfd 0x4 0x5 0x3 
memory_line_id=35: 0xfd 0x4 0x5 0x3 
memory_line_id=36: 0xfd 0x4 0x5 0x3 
memory_line_id=37: 0xfd 0x4 0x5 0x3 
memory_line_id=38: 0xfd 0x4 0x5 0x3 
memory_line_id=39: 0xfd 0x4 0x5 0x3 
memory_line_id=40: 0xfd 0x4 0x5 0x3 
memory_line_id=41: 0xfd 0x4 0x5 0x3 
memory_line_id=42: 0xfd 0x4 0x5 0x3 
memory_line_id=43: 0xfd 0x4 0x5 0x3 
memory_line_id=44: 0xfd 0x4 0x5 0x3 
memory_line_id=45: 0xfd 0x4 0x5 0x3 
memory_line_id=46: 0xfd 0x4 0x5 0x3 
memory_line_id=47: 0xfd 0x4 0x5 0x3 
memory_line_id=48: 0xfd 0x4 0x5 0x3 
memory_line_id=49: 0xfd 0x4 0x5 0x3 
memory_line_id=50: 0xfd 0x4 0x5 0x3 
memory_line_id=51: 0xfd 0x4 0x5 0x3 
memory_line_id=52: 0xfd 0x4 0x5 0x3 
memory_line_id=53: 0xfd 0x4 0x5 0x3 
memory_line_id=54: 0xfd 0x4 0x5 0x3 
memory_line_id=55: 0xfd 0x4 0x5 0x3 
memory_line_id=56: 0xfd 0x4 0x5 0x3 
memory_line_id=57: 0xfd 0x4 0x5 0x3 
memory_line_id=58: 0xfd 0x4 0x5 0x3 
memory_line_id=59: 0xfd 0x4 0x5 0x3 
memory_line_id=60: 0xfd 0x4 0x5 0x3 
memory_line_id=61: 0xfd 0x4 0x5 0x3 
memory_line_id=62: 0xfd 0x4 0x5 0x3 
memory_line_id=63: 0x0 0x0 0x0 0x14 
*/
