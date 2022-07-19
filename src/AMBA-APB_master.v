module AMBA_APB_mas(
	input 				Pclk,
	input 				Prst, 	// active-low reset
	input  		[1:0]	add_i, 	// 00 - No Operation
								// 01 - Read Operation
								// 10 - No Operation
								// 11 - Write Operation
							
	output 		[31:0]	Paddr,
	output 				PSELx,
	output 				P_en,
	output 				P_WR,
	output     	[31:0]	PWdata,
	output reg  		P_slverr,
    input  reg 	[31:0]	PRdata,
	input 				P_ready
);

//State declaration communication
parameter [1:0] idle_state=2'b00;
parameter [1:0] setup_state=2'b01;
parameter [1:0] access_state=2'b10;

//State declaration of present and next 
reg [1:0] pstate;
reg [1:0] nstate;

wire apb_setup, apb_access;
reg P_WR_next, P_WR_present;

reg [31:0] PRdata_present, PRdata_next;

always @(posedge Pclk or negedge Prst)
begin
	if(~Prst) 
		pstate <= idle_state;
	else
		pstate <= nstate;
end

always @(*) 
begin
	P_WR_next = P_WR_present;
	PRdata_next = PRdata_present;
	
	case (pstate) //nstate =pstate
		idle_state: 
		begin
			if (add_i[0])
			begin
				nstate = setup_state;
				P_WR_next = add_i[1];
			end
			else
				nstate = idle_state;
		end

		setup_state:
		begin
			nstate = access_state;
		end
		
		access_state:
		begin
			if (P_ready)
			begin
				if (~P_WR_present)
					PRdata_next = PRdata;
				nstate = idle_state;
			end
			else
				nstate = access_state;
		end
		
		default:
		nstate = access_state;
	endcase
end

assign apb_setup  = (pstate == setup_state);
assign apb_access = (pstate == setup_state);

assign PSELx = apb_setup | apb_access;
assign P_en  = apb_access;

// APB Address 
assign Paddr = {32{apb_access}} & 32'hA000; // [1 Fixed Stable Address taken because APB will be sending/receiving from only 
											// one particular address at any instant so given address taken manually]

// APB PWRITE Control Signal
always @(posedge Pclk or negedge Prst)
begin
	if(~Prst)
		P_WR_present <= 1'b0;
	else
		P_WR_present <= P_WR_next;
end

assign P_WR = P_WR_present;


// APB PWDATA Data Signal [this Signal can change ONLY in IDLE/SETUP states] 
// NEVER CHANGE PWDATA when in ACCESS State because that will cause Protocol Violations
// PWDATA Must remain STABLE when in ACCESS State

// Adder
// Read value from the slave [design testbench] at addr = 0xA000
// Incrememt that value and send it back using write operation

assign PWdata = {32{apb_access}} & (PRdata_present);

always @(posedge Pclk or posedge Prst)
begin
	if(~Prst) 
		PRdata_present <= 32'h0;
	else
		PRdata_present <= PRdata_next;
end

endmodule
