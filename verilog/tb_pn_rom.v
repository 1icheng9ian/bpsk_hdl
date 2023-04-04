`timescale 1ns/100ps

module testbench();

parameter DATA_WIDTH = 1;
parameter ADDR_WIDTH = 10;
parameter MAIN_FRE   = 100; //unit MHz
reg                   sys_clk = 0;
reg                   sys_rst = 0;
reg                   ena = 0;
reg [ADDR_WIDTH-1:0]  addr = 0;

always begin
    #(500/MAIN_FRE) sys_clk = ~sys_clk;
end

always begin
    #50 sys_rst = 1;
    #50 ena = 1;
end

always @(posedge sys_clk) begin
    if (~sys_rst) 
        addr = 0;
    else if (~ena)
        addr = 0;
    else
        addr = addr + 1;
end

//Instance 
wire [0:0]	data_out;
wire 	valid_out;

pn_rom u_pn_rom(
	//ports
	.clk        		( sys_clk        		),
	.rst_n      		( sys_rst      		),
	.ena        		( ena        		),
	.address_in 		( addr 		),
	.data_out   		( data_out   		),
	.valid_out  		( valid_out  		)
);

initial begin            
    $dumpfile("wave.vcd");        
    $dumpvars(0, testbench);    
    #50000 $finish;
end

endmodule  //TOP
