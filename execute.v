`timescale 1ns / 1ps
/*
Execute Stage: This uses the outputs of Fetch and Decode Stages as well as combining the modules: adder, bottom_mux(5-bit), alu_control, alu, top_mux (32-bit),
and ex_mem.
*/
module execute(
    input wire clk,
    input wire [1:0] ctlwb_in,
    input wire [2:0] ctlm_in,
    input wire [31:0] npc, rdata1, rdata2, s_extend,
    input wire [4:0] instr_2016, instr_1511,
    input wire [1:0] alu_op,
    input wire [5:0] funct,
    input wire alusrc, regdst,
    output wire [1:0] ctlwb_out,
    output wire [2:0] ctlm_out,
    output wire [31:0] adder_out, alu_result_out, rdata2_out,
    output wire zero,
    output wire [4:0] muxout_out
);
    // signals
    wire [31:0] adder_internal,
                mux_internal,
                alu_internal;  //internal wires to connect internal EXECUTE components together
    wire [4:0] muxout_internal;
    wire [2:0] control_internal;
    wire zero_internal;

    adder adder3(
        .add_in1(npc),
        .add_in2(s_extend),
        .add_out(adder_internal)
    );

    bottom_mux bottom_mux3(
        .y(muxout_internal),
        .a(instr_1511),
        .b(instr_2016),
        .sel(regdst)
    );

    alu_control alu_control3(
        .funct(funct),
        .aluop(alu_op),
        .select(control_internal)
    );

    top_mux top_mux3(
        .y(mux_internal),
        .a(s_extend),
        .b(rdata2),
        .sel(alusrc)
    );

    alu alu3(
        .a(rdata1),
        .b(mux_internal),
        .control(control_internal),
        .result(alu_internal),
        .zero(zero_internal)
    );

    ex_mem ex_mem3(
        .clk(clk),
        .ctlwb_out(ctlwb_in), // inputs, which should stem from intermediate modules 
        .ctlm_out(ctlm_in),
        .adder_out(adder_internal),
        .aluzero(zero_internal),
        .aluout(alu_internal),
        .readdat2(rdata2),
        .muxout(muxout_internal),
        .wb_ctlout(ctlwb_out), // outputs going to FETCH or MEM/WB
        .branch(ctlm_out[2]),
        .memread(ctlm_out[1]),
        .memwrite(ctlm_out[0]),
        .add_result(adder_out),
        .zero(zero),
        .alu_result(alu_result_out),
        .rdata2out(rdata2_out),
        .five_bit_muxout(muxout_out)
    );

endmodule // IEXECUTE
