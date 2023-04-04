clear
clc

%% parameters
data_len = 4096;
seed = 12345;
filename = 'pn_rom.v';
data_width = nextpow2(data_len);

%% prepare data
rng(seed);
data = randi([0 1],data_len,1);

%% generate verilog file
fileid = fopen(filename,'w');
fprintf(fileid,'`timescale 1ns/100ps\n');
fprintf(fileid,'\n');
fprintf(fileid,'module data_rom ( \n');
fprintf(fileid,'// write input and output here.\n');
fprintf(fileid,'input           clk;\n');
fprintf(fileid,'input           rst_n;\n');
fprintf(fileid,'input           ena;\n');
fprintf(fileid,');\n');
fprintf(fileid,'always @(posedge clk) begin \n');
fprintf(fileid,'    case(address)\n');
for i = 1:data_len
    fprintf(fileid,'        ''d%d :data = ''d%d;\n',i-1,data(i));
end
fprintf(fileid,'        default: data = ''d0;\n');
fprintf(fileid,'    endcase\n');
fprintf(fileid,'end\n');
fprintf(fileid,'endmodule\n');
fclose(fileid);