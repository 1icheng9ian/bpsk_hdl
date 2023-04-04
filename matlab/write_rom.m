clear
clc

%% parameters
data_len = 1024;
seed = 12345;
modulename = 'pn_rom';
filename = [modulename,'.v'];
add_width = nextpow2(data_len);
data_width = 1;

%% prepare data
rng(seed);
data = randi([0 1],data_len,1);

%% generate verilog file
fileid = fopen(filename,'w');
fprintf(fileid,'`timescale 1ns/100ps\n');
fprintf(fileid,'\n');
fprintf(fileid,['module ',modulename,' ( \n']);
fprintf(fileid,'// write input and output here\n');
fprintf(fileid,'    input               clk,\n');
fprintf(fileid,'    input               rst_n,\n');
fprintf(fileid,'    input               ena,\n');
fprintf(fileid,'    input       [%d:0]  address_in,\n',add_width-1);
fprintf(fileid,'    output  reg [%d:0]  data_out,\n',data_width-1);
fprintf(fileid,'    output  reg         valid_out\n');
fprintf(fileid,');\n');
fprintf(fileid,'\n');
fprintf(fileid,'// declare wires and regsiters here\n');
fprintf(fileid,'reg [%d:0]  data;\n',data_width-1);
fprintf(fileid,'\n');
fprintf(fileid,'// rom table here\n');
fprintf(fileid,'always @(posedge clk) begin \n');
fprintf(fileid,'    if (!rst_n) begin\n');
fprintf(fileid,'        data_out <= ''b0;\n');
fprintf(fileid,'        valid_out <= ''b0;\n');
fprintf(fileid,'    end\n');
fprintf(fileid,'    else if (!ena) begin\n');
fprintf(fileid,'        data_out <= ''b0;\n');
fprintf(fileid,'        valid_out <= ''b0;\n');
fprintf(fileid,'    end\n');
fprintf(fileid,'    else begin\n');
fprintf(fileid,'        data_out <= data;\n');
fprintf(fileid,'        valid_out <= 1''b1;\n');
fprintf(fileid,'    end\n');
fprintf(fileid,'end\n');
fprintf(fileid,'\n');
fprintf(fileid,'always @(posedge clk) begin\n');
fprintf(fileid,'    case(address_in)\n');
for i = 1:data_len
    fprintf(fileid,'        %d''d%d :data = ''b%d;\n',add_width,i-1,data(i));
end
fprintf(fileid,'        default: data = ''b0;\n');
fprintf(fileid,'    endcase\n');
fprintf(fileid,'end\n');
fprintf(fileid,'\n');
fprintf(fileid,'endmodule\n');
fclose(fileid);