// Generator : SpinalHDL v1.2.2    git head : e9b0d66b695a390d658996a41268ddc32b5338bc
// Date      : 15/03/2019, 17:24:42
// Component : VexRiscv


`define BranchCtrlEnum_defaultEncoding_type [1:0]
`define BranchCtrlEnum_defaultEncoding_INC 2'b00
`define BranchCtrlEnum_defaultEncoding_B 2'b01
`define BranchCtrlEnum_defaultEncoding_JAL 2'b10
`define BranchCtrlEnum_defaultEncoding_JALR 2'b11

`define ShiftCtrlEnum_defaultEncoding_type [1:0]
`define ShiftCtrlEnum_defaultEncoding_DISABLE_1 2'b00
`define ShiftCtrlEnum_defaultEncoding_SLL_1 2'b01
`define ShiftCtrlEnum_defaultEncoding_SRL_1 2'b10
`define ShiftCtrlEnum_defaultEncoding_SRA_1 2'b11

`define DataCacheCpuCmdKind_defaultEncoding_type [0:0]
`define DataCacheCpuCmdKind_defaultEncoding_MEMORY 1'b0
`define DataCacheCpuCmdKind_defaultEncoding_MANAGMENT 1'b1

`define Src1CtrlEnum_defaultEncoding_type [1:0]
`define Src1CtrlEnum_defaultEncoding_RS 2'b00
`define Src1CtrlEnum_defaultEncoding_IMU 2'b01
`define Src1CtrlEnum_defaultEncoding_PC_INCREMENT 2'b10
`define Src1CtrlEnum_defaultEncoding_URS1 2'b11

`define EnvCtrlEnum_defaultEncoding_type [1:0]
`define EnvCtrlEnum_defaultEncoding_NONE 2'b00
`define EnvCtrlEnum_defaultEncoding_XRET 2'b01
`define EnvCtrlEnum_defaultEncoding_WFI 2'b10
`define EnvCtrlEnum_defaultEncoding_ECALL 2'b11

`define AluCtrlEnum_defaultEncoding_type [1:0]
`define AluCtrlEnum_defaultEncoding_ADD_SUB 2'b00
`define AluCtrlEnum_defaultEncoding_SLT_SLTU 2'b01
`define AluCtrlEnum_defaultEncoding_BITWISE 2'b10

`define AluBitwiseCtrlEnum_defaultEncoding_type [1:0]
`define AluBitwiseCtrlEnum_defaultEncoding_XOR_1 2'b00
`define AluBitwiseCtrlEnum_defaultEncoding_OR_1 2'b01
`define AluBitwiseCtrlEnum_defaultEncoding_AND_1 2'b10
`define AluBitwiseCtrlEnum_defaultEncoding_SRC1 2'b11

`define Src2CtrlEnum_defaultEncoding_type [1:0]
`define Src2CtrlEnum_defaultEncoding_RS 2'b00
`define Src2CtrlEnum_defaultEncoding_IMI 2'b01
`define Src2CtrlEnum_defaultEncoding_IMS 2'b10
`define Src2CtrlEnum_defaultEncoding_PC 2'b11

`define JtagState_defaultEncoding_type [3:0]
`define JtagState_defaultEncoding_RESET 4'b0000
`define JtagState_defaultEncoding_IDLE 4'b0001
`define JtagState_defaultEncoding_IR_SELECT 4'b0010
`define JtagState_defaultEncoding_IR_CAPTURE 4'b0011
`define JtagState_defaultEncoding_IR_SHIFT 4'b0100
`define JtagState_defaultEncoding_IR_EXIT1 4'b0101
`define JtagState_defaultEncoding_IR_PAUSE 4'b0110
`define JtagState_defaultEncoding_IR_EXIT2 4'b0111
`define JtagState_defaultEncoding_IR_UPDATE 4'b1000
`define JtagState_defaultEncoding_DR_SELECT 4'b1001
`define JtagState_defaultEncoding_DR_CAPTURE 4'b1010
`define JtagState_defaultEncoding_DR_SHIFT 4'b1011
`define JtagState_defaultEncoding_DR_EXIT1 4'b1100
`define JtagState_defaultEncoding_DR_PAUSE 4'b1101
`define JtagState_defaultEncoding_DR_EXIT2 4'b1110
`define JtagState_defaultEncoding_DR_UPDATE 4'b1111

module BufferCC (
      input   io_dataIn,
      output  io_dataOut,
      input   clk,
      input   reset);
  reg  buffers_0;
  reg  buffers_1;
  assign io_dataOut = buffers_1;
  always @ (posedge clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end

endmodule

module FlowCCByToggle (
      input   io_input_valid,
      input   io_input_payload_last,
      input  [0:0] io_input_payload_fragment,
      output  io_output_valid,
      output  io_output_payload_last,
      output [0:0] io_output_payload_fragment,
      input   io_jtag_tck,
      input   clk,
      input   reset);
  wire  _zz_1_;
  wire  outHitSignal;
  reg  inputArea_target = 0;
  reg  inputArea_data_last;
  reg [0:0] inputArea_data_fragment;
  wire  outputArea_target;
  reg  outputArea_hit;
  wire  outputArea_flow_valid;
  wire  outputArea_flow_payload_last;
  wire [0:0] outputArea_flow_payload_fragment;
  reg  outputArea_flow_m2sPipe_valid;
  reg  outputArea_flow_m2sPipe_payload_last;
  reg [0:0] outputArea_flow_m2sPipe_payload_fragment;
  BufferCC bufferCC_1_ ( 
    .io_dataIn(inputArea_target),
    .io_dataOut(_zz_1_),
    .clk(clk),
    .reset(reset) 
  );
  assign outputArea_target = _zz_1_;
  assign outputArea_flow_valid = (outputArea_target != outputArea_hit);
  assign outputArea_flow_payload_last = inputArea_data_last;
  assign outputArea_flow_payload_fragment = inputArea_data_fragment;
  assign io_output_valid = outputArea_flow_m2sPipe_valid;
  assign io_output_payload_last = outputArea_flow_m2sPipe_payload_last;
  assign io_output_payload_fragment = outputArea_flow_m2sPipe_payload_fragment;
  always @ (posedge io_jtag_tck) begin
    if(io_input_valid)begin
      inputArea_target <= (! inputArea_target);
      inputArea_data_last <= io_input_payload_last;
      inputArea_data_fragment <= io_input_payload_fragment;
    end
  end

  always @ (posedge clk) begin
    outputArea_hit <= outputArea_target;
    if(outputArea_flow_valid)begin
      outputArea_flow_m2sPipe_payload_last <= outputArea_flow_payload_last;
      outputArea_flow_m2sPipe_payload_fragment <= outputArea_flow_payload_fragment;
    end
  end

  always @ (posedge clk) begin
    if(reset) begin
      outputArea_flow_m2sPipe_valid <= 1'b0;
    end else begin
      outputArea_flow_m2sPipe_valid <= outputArea_flow_valid;
    end
  end

endmodule

module InstructionCache (
      input   io_flush_cmd_valid,
      output  io_flush_cmd_ready,
      output  io_flush_rsp,
      input   io_cpu_prefetch_isValid,
      output reg  io_cpu_prefetch_haltIt,
      input  [31:0] io_cpu_prefetch_pc,
      input   io_cpu_fetch_isValid,
      input   io_cpu_fetch_isStuck,
      input   io_cpu_fetch_isRemoved,
      input  [31:0] io_cpu_fetch_pc,
      output [31:0] io_cpu_fetch_data,
      output  io_cpu_fetch_mmuBus_cmd_isValid,
      output [31:0] io_cpu_fetch_mmuBus_cmd_virtualAddress,
      output  io_cpu_fetch_mmuBus_cmd_bypassTranslation,
      input  [31:0] io_cpu_fetch_mmuBus_rsp_physicalAddress,
      input   io_cpu_fetch_mmuBus_rsp_isIoAccess,
      input   io_cpu_fetch_mmuBus_rsp_allowRead,
      input   io_cpu_fetch_mmuBus_rsp_allowWrite,
      input   io_cpu_fetch_mmuBus_rsp_allowExecute,
      input   io_cpu_fetch_mmuBus_rsp_allowUser,
      input   io_cpu_fetch_mmuBus_rsp_miss,
      input   io_cpu_fetch_mmuBus_rsp_hit,
      output  io_cpu_fetch_mmuBus_end,
      output [31:0] io_cpu_fetch_physicalAddress,
      input   io_cpu_decode_isValid,
      input   io_cpu_decode_isStuck,
      input  [31:0] io_cpu_decode_pc,
      output [31:0] io_cpu_decode_physicalAddress,
      output [31:0] io_cpu_decode_data,
      output  io_cpu_decode_cacheMiss,
      output  io_cpu_decode_error,
      output  io_cpu_decode_mmuMiss,
      output  io_cpu_decode_illegalAccess,
      input   io_cpu_decode_isUser,
      input   io_cpu_fill_valid,
      input  [31:0] io_cpu_fill_payload,
      output  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output [31:0] io_mem_cmd_payload_address,
      output [2:0] io_mem_cmd_payload_size,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload_data,
      input   io_mem_rsp_payload_error,
      input   clk,
      input   reset);
  reg [21:0] _zz_12_;
  reg [31:0] _zz_13_;
  wire  _zz_14_;
  wire [0:0] _zz_15_;
  wire [0:0] _zz_16_;
  wire [21:0] _zz_17_;
  reg  _zz_1_;
  reg  _zz_2_;
  reg  lineLoader_fire;
  reg  lineLoader_valid;
  reg [31:0] lineLoader_address;
  reg  lineLoader_hadError;
  reg [7:0] lineLoader_flushCounter;
  reg  _zz_3_;
  reg  lineLoader_flushFromInterface;
  wire  _zz_4_;
  reg  _zz_4__regNext;
  reg  lineLoader_cmdSent;
  reg  lineLoader_wayToAllocate_willIncrement;
  wire  lineLoader_wayToAllocate_willClear;
  wire  lineLoader_wayToAllocate_willOverflowIfInc;
  wire  lineLoader_wayToAllocate_willOverflow;
  reg [2:0] lineLoader_wordIndex;
  wire  lineLoader_write_tag_0_valid;
  wire [6:0] lineLoader_write_tag_0_payload_address;
  wire  lineLoader_write_tag_0_payload_data_valid;
  wire  lineLoader_write_tag_0_payload_data_error;
  wire [19:0] lineLoader_write_tag_0_payload_data_address;
  wire  lineLoader_write_data_0_valid;
  wire [9:0] lineLoader_write_data_0_payload_address;
  wire [31:0] lineLoader_write_data_0_payload_data;
  wire  _zz_5_;
  wire [6:0] _zz_6_;
  wire  _zz_7_;
  wire  fetchStage_read_waysValues_0_tag_valid;
  wire  fetchStage_read_waysValues_0_tag_error;
  wire [19:0] fetchStage_read_waysValues_0_tag_address;
  wire [21:0] _zz_8_;
  wire [9:0] _zz_9_;
  wire  _zz_10_;
  wire [31:0] fetchStage_read_waysValues_0_data;
  reg [31:0] decodeStage_mmuRsp_physicalAddress;
  reg  decodeStage_mmuRsp_isIoAccess;
  reg  decodeStage_mmuRsp_allowRead;
  reg  decodeStage_mmuRsp_allowWrite;
  reg  decodeStage_mmuRsp_allowExecute;
  reg  decodeStage_mmuRsp_allowUser;
  reg  decodeStage_mmuRsp_miss;
  reg  decodeStage_mmuRsp_hit;
  reg  decodeStage_hit_0_valid;
  reg  decodeStage_hit_0_error;
  reg [19:0] decodeStage_hit_0_address;
  wire  decodeStage_hit_hits_0;
  wire  decodeStage_hit_valid;
  wire  decodeStage_hit_error;
  reg [31:0] _zz_11_;
  wire [31:0] decodeStage_hit_data;
  wire [31:0] decodeStage_hit_word;
  reg [21:0] ways_0_tags [0:127];
  reg [31:0] ways_0_datas [0:1023];
  assign _zz_14_ = (! lineLoader_flushCounter[7]);
  assign _zz_15_ = _zz_8_[0 : 0];
  assign _zz_16_ = _zz_8_[1 : 1];
  assign _zz_17_ = {lineLoader_write_tag_0_payload_data_address,{lineLoader_write_tag_0_payload_data_error,lineLoader_write_tag_0_payload_data_valid}};
  always @ (posedge clk) begin
    if(_zz_2_) begin
      ways_0_tags[lineLoader_write_tag_0_payload_address] <= _zz_17_;
    end
  end

  always @ (posedge clk) begin
    if(_zz_7_) begin
      _zz_12_ <= ways_0_tags[_zz_6_];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1_) begin
      ways_0_datas[lineLoader_write_data_0_payload_address] <= lineLoader_write_data_0_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_10_) begin
      _zz_13_ <= ways_0_datas[_zz_9_];
    end
  end

  always @ (*) begin
    _zz_1_ = 1'b0;
    if(lineLoader_write_data_0_valid)begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_2_ = 1'b0;
    if(lineLoader_write_tag_0_valid)begin
      _zz_2_ = 1'b1;
    end
  end

  always @ (*) begin
    io_cpu_prefetch_haltIt = 1'b0;
    if(lineLoader_valid)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if(_zz_14_)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if((! _zz_3_))begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if(io_flush_cmd_valid)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
  end

  always @ (*) begin
    lineLoader_fire = 1'b0;
    if(io_mem_rsp_valid)begin
      if((lineLoader_wordIndex == (3'b111)))begin
        lineLoader_fire = 1'b1;
      end
    end
  end

  assign io_flush_cmd_ready = (! (lineLoader_valid || io_cpu_fetch_isValid));
  assign _zz_4_ = lineLoader_flushCounter[7];
  assign io_flush_rsp = ((_zz_4_ && (! _zz_4__regNext)) && lineLoader_flushFromInterface);
  assign io_mem_cmd_valid = (lineLoader_valid && (! lineLoader_cmdSent));
  assign io_mem_cmd_payload_address = {lineLoader_address[31 : 5],(5'b00000)};
  assign io_mem_cmd_payload_size = (3'b101);
  always @ (*) begin
    lineLoader_wayToAllocate_willIncrement = 1'b0;
    if(lineLoader_fire)begin
      lineLoader_wayToAllocate_willIncrement = 1'b1;
    end
  end

  assign lineLoader_wayToAllocate_willClear = 1'b0;
  assign lineLoader_wayToAllocate_willOverflowIfInc = 1'b1;
  assign lineLoader_wayToAllocate_willOverflow = (lineLoader_wayToAllocate_willOverflowIfInc && lineLoader_wayToAllocate_willIncrement);
  assign _zz_5_ = 1'b1;
  assign lineLoader_write_tag_0_valid = ((_zz_5_ && lineLoader_fire) || (! lineLoader_flushCounter[7]));
  assign lineLoader_write_tag_0_payload_address = (lineLoader_flushCounter[7] ? lineLoader_address[11 : 5] : lineLoader_flushCounter[6 : 0]);
  assign lineLoader_write_tag_0_payload_data_valid = lineLoader_flushCounter[7];
  assign lineLoader_write_tag_0_payload_data_error = (lineLoader_hadError || io_mem_rsp_payload_error);
  assign lineLoader_write_tag_0_payload_data_address = lineLoader_address[31 : 12];
  assign lineLoader_write_data_0_valid = (io_mem_rsp_valid && _zz_5_);
  assign lineLoader_write_data_0_payload_address = {lineLoader_address[11 : 5],lineLoader_wordIndex};
  assign lineLoader_write_data_0_payload_data = io_mem_rsp_payload_data;
  assign _zz_6_ = io_cpu_prefetch_pc[11 : 5];
  assign _zz_7_ = (! io_cpu_fetch_isStuck);
  assign _zz_8_ = _zz_12_;
  assign fetchStage_read_waysValues_0_tag_valid = _zz_15_[0];
  assign fetchStage_read_waysValues_0_tag_error = _zz_16_[0];
  assign fetchStage_read_waysValues_0_tag_address = _zz_8_[21 : 2];
  assign _zz_9_ = io_cpu_prefetch_pc[11 : 2];
  assign _zz_10_ = (! io_cpu_fetch_isStuck);
  assign fetchStage_read_waysValues_0_data = _zz_13_;
  assign io_cpu_fetch_data = fetchStage_read_waysValues_0_data[31 : 0];
  assign io_cpu_fetch_mmuBus_cmd_isValid = io_cpu_fetch_isValid;
  assign io_cpu_fetch_mmuBus_cmd_virtualAddress = io_cpu_fetch_pc;
  assign io_cpu_fetch_mmuBus_cmd_bypassTranslation = 1'b0;
  assign io_cpu_fetch_mmuBus_end = ((! io_cpu_fetch_isStuck) || io_cpu_fetch_isRemoved);
  assign io_cpu_fetch_physicalAddress = io_cpu_fetch_mmuBus_rsp_physicalAddress;
  assign decodeStage_hit_hits_0 = (decodeStage_hit_0_valid && (decodeStage_hit_0_address == decodeStage_mmuRsp_physicalAddress[31 : 12]));
  assign decodeStage_hit_valid = (decodeStage_hit_hits_0 != (1'b0));
  assign decodeStage_hit_error = decodeStage_hit_0_error;
  assign decodeStage_hit_data = _zz_11_;
  assign decodeStage_hit_word = decodeStage_hit_data[31 : 0];
  assign io_cpu_decode_data = decodeStage_hit_word;
  assign io_cpu_decode_cacheMiss = (! decodeStage_hit_valid);
  assign io_cpu_decode_error = decodeStage_hit_error;
  assign io_cpu_decode_mmuMiss = decodeStage_mmuRsp_miss;
  assign io_cpu_decode_illegalAccess = ((! decodeStage_mmuRsp_allowExecute) || (io_cpu_decode_isUser && (! decodeStage_mmuRsp_allowUser)));
  assign io_cpu_decode_physicalAddress = decodeStage_mmuRsp_physicalAddress;
  always @ (posedge clk) begin
    if(reset) begin
      lineLoader_valid <= 1'b0;
      lineLoader_hadError <= 1'b0;
      lineLoader_flushCounter <= (8'b00000000);
      lineLoader_flushFromInterface <= 1'b0;
      lineLoader_cmdSent <= 1'b0;
      lineLoader_wordIndex <= (3'b000);
    end else begin
      if(lineLoader_fire)begin
        lineLoader_valid <= 1'b0;
      end
      if(lineLoader_fire)begin
        lineLoader_hadError <= 1'b0;
      end
      if(io_cpu_fill_valid)begin
        lineLoader_valid <= 1'b1;
      end
      if(_zz_14_)begin
        lineLoader_flushCounter <= (lineLoader_flushCounter + (8'b00000001));
      end
      if(io_flush_cmd_valid)begin
        if(io_flush_cmd_ready)begin
          lineLoader_flushCounter <= (8'b00000000);
          lineLoader_flushFromInterface <= 1'b1;
        end
      end
      if((io_mem_cmd_valid && io_mem_cmd_ready))begin
        lineLoader_cmdSent <= 1'b1;
      end
      if(lineLoader_fire)begin
        lineLoader_cmdSent <= 1'b0;
      end
      if(io_mem_rsp_valid)begin
        lineLoader_wordIndex <= (lineLoader_wordIndex + (3'b001));
        if(io_mem_rsp_payload_error)begin
          lineLoader_hadError <= 1'b1;
        end
      end
    end
  end

  always @ (posedge clk) begin
    if(io_cpu_fill_valid)begin
      lineLoader_address <= io_cpu_fill_payload;
    end
    _zz_3_ <= lineLoader_flushCounter[7];
    _zz_4__regNext <= _zz_4_;
    if((! io_cpu_decode_isStuck))begin
      decodeStage_mmuRsp_physicalAddress <= io_cpu_fetch_mmuBus_rsp_physicalAddress;
      decodeStage_mmuRsp_isIoAccess <= io_cpu_fetch_mmuBus_rsp_isIoAccess;
      decodeStage_mmuRsp_allowRead <= io_cpu_fetch_mmuBus_rsp_allowRead;
      decodeStage_mmuRsp_allowWrite <= io_cpu_fetch_mmuBus_rsp_allowWrite;
      decodeStage_mmuRsp_allowExecute <= io_cpu_fetch_mmuBus_rsp_allowExecute;
      decodeStage_mmuRsp_allowUser <= io_cpu_fetch_mmuBus_rsp_allowUser;
      decodeStage_mmuRsp_miss <= io_cpu_fetch_mmuBus_rsp_miss;
      decodeStage_mmuRsp_hit <= io_cpu_fetch_mmuBus_rsp_hit;
    end
    if((! io_cpu_decode_isStuck))begin
      decodeStage_hit_0_valid <= fetchStage_read_waysValues_0_tag_valid;
      decodeStage_hit_0_error <= fetchStage_read_waysValues_0_tag_error;
      decodeStage_hit_0_address <= fetchStage_read_waysValues_0_tag_address;
    end
    if((! io_cpu_decode_isStuck))begin
      _zz_11_ <= fetchStage_read_waysValues_0_data;
    end
  end

endmodule

module DataCache (
      input   io_cpu_execute_isValid,
      input   io_cpu_execute_isStuck,
      input  `DataCacheCpuCmdKind_defaultEncoding_type io_cpu_execute_args_kind,
      input   io_cpu_execute_args_wr,
      input  [31:0] io_cpu_execute_args_address,
      input  [31:0] io_cpu_execute_args_data,
      input  [1:0] io_cpu_execute_args_size,
      input   io_cpu_execute_args_forceUncachedAccess,
      input   io_cpu_execute_args_clean,
      input   io_cpu_execute_args_invalidate,
      input   io_cpu_execute_args_way,
      input   io_cpu_memory_isValid,
      input   io_cpu_memory_isStuck,
      input   io_cpu_memory_isRemoved,
      output  io_cpu_memory_haltIt,
      output  io_cpu_memory_mmuBus_cmd_isValid,
      output [31:0] io_cpu_memory_mmuBus_cmd_virtualAddress,
      output  io_cpu_memory_mmuBus_cmd_bypassTranslation,
      input  [31:0] io_cpu_memory_mmuBus_rsp_physicalAddress,
      input   io_cpu_memory_mmuBus_rsp_isIoAccess,
      input   io_cpu_memory_mmuBus_rsp_allowRead,
      input   io_cpu_memory_mmuBus_rsp_allowWrite,
      input   io_cpu_memory_mmuBus_rsp_allowExecute,
      input   io_cpu_memory_mmuBus_rsp_allowUser,
      input   io_cpu_memory_mmuBus_rsp_miss,
      input   io_cpu_memory_mmuBus_rsp_hit,
      output  io_cpu_memory_mmuBus_end,
      input   io_cpu_writeBack_isValid,
      input   io_cpu_writeBack_isStuck,
      input   io_cpu_writeBack_isUser,
      output reg  io_cpu_writeBack_haltIt,
      output [31:0] io_cpu_writeBack_data,
      output reg  io_cpu_writeBack_mmuMiss,
      output reg  io_cpu_writeBack_illegalAccess,
      output reg  io_cpu_writeBack_unalignedAccess,
      output  io_cpu_writeBack_accessError,
      output [31:0] io_cpu_writeBack_badAddr,
      output reg  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output reg  io_mem_cmd_payload_wr,
      output reg [31:0] io_mem_cmd_payload_address,
      output reg [31:0] io_mem_cmd_payload_data,
      output reg [3:0] io_mem_cmd_payload_mask,
      output reg [2:0] io_mem_cmd_payload_length,
      output reg  io_mem_cmd_payload_last,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload_data,
      input   io_mem_rsp_payload_error,
      input   clk,
      input   reset);
  reg [21:0] _zz_35_;
  reg [31:0] _zz_36_;
  reg [31:0] _zz_37_;
  wire  _zz_38_;
  wire  _zz_39_;
  wire  _zz_40_;
  wire  _zz_41_;
  wire  _zz_42_;
  wire  _zz_43_;
  wire  _zz_44_;
  wire [0:0] _zz_45_;
  wire [0:0] _zz_46_;
  wire [2:0] _zz_47_;
  wire [0:0] _zz_48_;
  wire [2:0] _zz_49_;
  wire [0:0] _zz_50_;
  wire [2:0] _zz_51_;
  wire [21:0] _zz_52_;
  reg  _zz_1_;
  reg  _zz_2_;
  reg  _zz_3_;
  wire  haltCpu;
  reg  tagsReadCmd_valid;
  reg [6:0] tagsReadCmd_payload;
  reg  tagsWriteCmd_valid;
  reg [6:0] tagsWriteCmd_payload_address;
  reg  tagsWriteCmd_payload_data_used;
  reg  tagsWriteCmd_payload_data_dirty;
  reg [19:0] tagsWriteCmd_payload_data_address;
  reg  tagsWriteLastCmd_valid;
  reg [6:0] tagsWriteLastCmd_payload_address;
  reg  tagsWriteLastCmd_payload_data_used;
  reg  tagsWriteLastCmd_payload_data_dirty;
  reg [19:0] tagsWriteLastCmd_payload_data_address;
  reg  dataReadCmd_valid;
  reg [9:0] dataReadCmd_payload;
  reg  dataWriteCmd_valid;
  reg [9:0] dataWriteCmd_payload_address;
  reg [31:0] dataWriteCmd_payload_data;
  reg [3:0] dataWriteCmd_payload_mask;
  reg [6:0] way_tagReadRspOneAddress;
  wire [21:0] _zz_4_;
  wire  _zz_5_;
  reg  tagsWriteCmd_valid_regNextWhen;
  reg [6:0] tagsWriteCmd_payload_address_regNextWhen;
  reg  tagsWriteCmd_payload_data_regNextWhen_used;
  reg  tagsWriteCmd_payload_data_regNextWhen_dirty;
  reg [19:0] tagsWriteCmd_payload_data_regNextWhen_address;
  wire  _zz_6_;
  wire  way_tagReadRspOne_used;
  wire  way_tagReadRspOne_dirty;
  wire [19:0] way_tagReadRspOne_address;
  reg  way_dataReadRspOneKeepAddress;
  reg [9:0] way_dataReadRspOneAddress;
  wire [31:0] way_dataReadRspOneWithoutBypass;
  wire  _zz_7_;
  wire  _zz_8_;
  reg  dataWriteCmd_valid_regNextWhen;
  reg [9:0] dataWriteCmd_payload_address_regNextWhen;
  reg [31:0] _zz_9_;
  reg [3:0] _zz_10_;
  reg [31:0] way_dataReadRspOne;
  wire  _zz_11_;
  wire  way_tagReadRspTwoEnable;
  wire  _zz_12_;
  wire  way_tagReadRspTwoRegIn_used;
  wire  way_tagReadRspTwoRegIn_dirty;
  wire [19:0] way_tagReadRspTwoRegIn_address;
  reg  way_tagReadRspTwo_used;
  reg  way_tagReadRspTwo_dirty;
  reg [19:0] way_tagReadRspTwo_address;
  wire  way_dataReadRspTwoEnable;
  reg [9:0] way_dataReadRspOneAddress_regNextWhen;
  wire  _zz_13_;
  wire  _zz_14_;
  reg [7:0] _zz_15_;
  reg [7:0] _zz_16_;
  reg [7:0] _zz_17_;
  reg [7:0] _zz_18_;
  wire [31:0] way_dataReadRspTwo;
  wire  cpuMemoryStageNeedReadData;
  reg  victim_requestIn_valid;
  wire  victim_requestIn_ready;
  reg [31:0] victim_requestIn_payload_address;
  wire  victim_requestIn_halfPipe_valid;
  reg  victim_requestIn_halfPipe_ready;
  wire [31:0] victim_requestIn_halfPipe_payload_address;
  reg  _zz_19_;
  reg  _zz_20_;
  reg [31:0] _zz_21_;
  reg [3:0] victim_readLineCmdCounter;
  reg  victim_dataReadCmdOccure;
  reg  victim_dataReadRestored;
  reg [3:0] victim_readLineRspCounter;
  reg  victim_dataReadCmdOccure_delay_1;
  reg [3:0] victim_bufferReadCounter;
  wire  victim_bufferReadStream_valid;
  wire  victim_bufferReadStream_ready;
  wire [2:0] victim_bufferReadStream_payload;
  wire  _zz_22_;
  wire  _zz_23_;
  reg  _zz_24_;
  wire  _zz_25_;
  reg  _zz_26_;
  reg  _zz_27_;
  reg [31:0] _zz_28_;
  reg [2:0] victim_bufferReadedCounter;
  reg  victim_memCmdAlreadyUsed;
  wire  victim_counter_willIncrement;
  wire  victim_counter_willClear;
  reg [2:0] victim_counter_valueNext;
  reg [2:0] victim_counter_value;
  wire  victim_counter_willOverflowIfInc;
  wire  victim_counter_willOverflow;
  reg `DataCacheCpuCmdKind_defaultEncoding_type stageA_request_kind;
  reg  stageA_request_wr;
  reg [31:0] stageA_request_address;
  reg [31:0] stageA_request_data;
  reg [1:0] stageA_request_size;
  reg  stageA_request_forceUncachedAccess;
  reg  stageA_request_clean;
  reg  stageA_request_invalidate;
  reg  stageA_request_way;
  reg `DataCacheCpuCmdKind_defaultEncoding_type stageB_request_kind;
  reg  stageB_request_wr;
  reg [31:0] stageB_request_address;
  reg [31:0] stageB_request_data;
  reg [1:0] stageB_request_size;
  reg  stageB_request_forceUncachedAccess;
  reg  stageB_request_clean;
  reg  stageB_request_invalidate;
  reg  stageB_request_way;
  reg [31:0] stageB_mmuRsp_baseAddress;
  reg  stageB_mmuRsp_isIoAccess;
  reg  stageB_mmuRsp_allowRead;
  reg  stageB_mmuRsp_allowWrite;
  reg  stageB_mmuRsp_allowExecute;
  reg  stageB_mmuRsp_allowUser;
  reg  stageB_mmuRsp_miss;
  reg  stageB_mmuRsp_hit;
  reg  stageB_waysHit;
  reg  stageB_loaderValid;
  reg  stageB_loaderReady;
  reg  stageB_loadingDone;
  reg  stageB_delayedIsStuck;
  reg  stageB_delayedWaysHitValid;
  reg  stageB_victimNotSent;
  reg  stageB_loadingNotDone;
  reg [3:0] _zz_29_;
  wire [3:0] stageB_writeMask;
  reg  stageB_hadMemRspErrorReg;
  wire  stageB_hadMemRspError;
  reg  stageB_bootEvicts_valid;
  wire [4:0] _zz_30_;
  wire  _zz_31_;
  wire  _zz_32_;
  reg  _zz_33_;
  wire [4:0] _zz_34_;
  reg  loader_valid;
  reg  loader_memCmdSent;
  reg  loader_counter_willIncrement;
  wire  loader_counter_willClear;
  reg [2:0] loader_counter_valueNext;
  reg [2:0] loader_counter_value;
  wire  loader_counter_willOverflowIfInc;
  wire  loader_counter_willOverflow;
  reg [21:0] way_tags [0:127];
  reg [7:0] way_data_symbol0 [0:1023];
  reg [7:0] way_data_symbol1 [0:1023];
  reg [7:0] way_data_symbol2 [0:1023];
  reg [7:0] way_data_symbol3 [0:1023];
  reg [7:0] _zz_53_;
  reg [7:0] _zz_54_;
  reg [7:0] _zz_55_;
  reg [7:0] _zz_56_;
  reg [31:0] victim_buffer [0:7];
  assign _zz_38_ = (! victim_readLineCmdCounter[3]);
  assign _zz_39_ = ((! victim_memCmdAlreadyUsed) && io_mem_cmd_ready);
  assign _zz_40_ = (stageB_mmuRsp_baseAddress[11 : 5] != (7'b1111111));
  assign _zz_41_ = (! victim_requestIn_halfPipe_valid);
  assign _zz_42_ = (! _zz_33_);
  assign _zz_43_ = (! _zz_19_);
  assign _zz_44_ = (! io_cpu_writeBack_isStuck);
  assign _zz_45_ = _zz_4_[0 : 0];
  assign _zz_46_ = _zz_4_[1 : 1];
  assign _zz_47_ = victim_readLineRspCounter[2:0];
  assign _zz_48_ = victim_counter_willIncrement;
  assign _zz_49_ = {2'd0, _zz_48_};
  assign _zz_50_ = loader_counter_willIncrement;
  assign _zz_51_ = {2'd0, _zz_50_};
  assign _zz_52_ = {tagsWriteCmd_payload_data_address,{tagsWriteCmd_payload_data_dirty,tagsWriteCmd_payload_data_used}};
  always @ (posedge clk) begin
    if(_zz_3_) begin
      way_tags[tagsWriteCmd_payload_address] <= _zz_52_;
    end
  end

  always @ (posedge clk) begin
    if(tagsReadCmd_valid) begin
      _zz_35_ <= way_tags[tagsReadCmd_payload];
    end
  end

  always @ (*) begin
    _zz_36_ = {_zz_56_, _zz_55_, _zz_54_, _zz_53_};
  end
  always @ (posedge clk) begin
    if(dataWriteCmd_payload_mask[0] && _zz_2_) begin
      way_data_symbol0[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[7 : 0];
    end
    if(dataWriteCmd_payload_mask[1] && _zz_2_) begin
      way_data_symbol1[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[15 : 8];
    end
    if(dataWriteCmd_payload_mask[2] && _zz_2_) begin
      way_data_symbol2[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[23 : 16];
    end
    if(dataWriteCmd_payload_mask[3] && _zz_2_) begin
      way_data_symbol3[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[31 : 24];
    end
  end

  always @ (posedge clk) begin
    if(dataReadCmd_valid) begin
      _zz_53_ <= way_data_symbol0[dataReadCmd_payload];
      _zz_54_ <= way_data_symbol1[dataReadCmd_payload];
      _zz_55_ <= way_data_symbol2[dataReadCmd_payload];
      _zz_56_ <= way_data_symbol3[dataReadCmd_payload];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1_) begin
      victim_buffer[_zz_47_] <= way_dataReadRspOneWithoutBypass;
    end
  end

  always @ (posedge clk) begin
    if(victim_bufferReadStream_ready) begin
      _zz_37_ <= victim_buffer[victim_bufferReadStream_payload];
    end
  end

  always @ (*) begin
    _zz_1_ = 1'b0;
    if(victim_dataReadCmdOccure_delay_1)begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_2_ = 1'b0;
    if(dataWriteCmd_valid)begin
      _zz_2_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_3_ = 1'b0;
    if(tagsWriteCmd_valid)begin
      _zz_3_ = 1'b1;
    end
  end

  assign haltCpu = 1'b0;
  always @ (*) begin
    tagsReadCmd_valid = 1'b0;
    tagsReadCmd_payload = (7'bxxxxxxx);
    dataReadCmd_valid = 1'b0;
    dataReadCmd_payload = (10'bxxxxxxxxxx);
    way_dataReadRspOneKeepAddress = 1'b0;
    if((io_cpu_execute_isValid && (! io_cpu_execute_isStuck)))begin
      tagsReadCmd_valid = 1'b1;
      tagsReadCmd_payload = io_cpu_execute_args_address[11 : 5];
      dataReadCmd_valid = 1'b1;
      dataReadCmd_payload = io_cpu_execute_args_address[11 : 2];
    end
    victim_dataReadCmdOccure = 1'b0;
    if(victim_requestIn_halfPipe_valid)begin
      if(_zz_38_)begin
        victim_dataReadCmdOccure = 1'b1;
        dataReadCmd_valid = 1'b1;
        dataReadCmd_payload = {victim_requestIn_halfPipe_payload_address[11 : 5],victim_readLineCmdCounter[2 : 0]};
        way_dataReadRspOneKeepAddress = 1'b1;
      end else begin
        if(((! victim_dataReadRestored) && cpuMemoryStageNeedReadData))begin
          dataReadCmd_valid = 1'b1;
          dataReadCmd_payload = way_dataReadRspOneAddress;
        end
      end
    end
  end

  always @ (*) begin
    tagsWriteCmd_valid = 1'b0;
    tagsWriteCmd_payload_address = (7'bxxxxxxx);
    tagsWriteCmd_payload_data_used = 1'bx;
    tagsWriteCmd_payload_data_dirty = 1'bx;
    tagsWriteCmd_payload_data_address = (20'bxxxxxxxxxxxxxxxxxxxx);
    dataWriteCmd_valid = 1'b0;
    dataWriteCmd_payload_address = (10'bxxxxxxxxxx);
    dataWriteCmd_payload_data = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    dataWriteCmd_payload_mask = (4'bxxxx);
    io_mem_cmd_valid = 1'b0;
    io_mem_cmd_payload_wr = 1'bx;
    io_mem_cmd_payload_address = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    io_mem_cmd_payload_data = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    io_mem_cmd_payload_mask = (4'bxxxx);
    io_mem_cmd_payload_length = (3'bxxx);
    io_mem_cmd_payload_last = 1'bx;
    victim_requestIn_valid = 1'b0;
    victim_requestIn_payload_address = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    victim_requestIn_halfPipe_ready = 1'b0;
    _zz_26_ = 1'b0;
    if(_zz_25_)begin
      io_mem_cmd_valid = 1'b1;
      io_mem_cmd_payload_wr = 1'b1;
      io_mem_cmd_payload_address = {victim_requestIn_halfPipe_payload_address[31 : 5],(5'b00000)};
      io_mem_cmd_payload_length = (3'b111);
      io_mem_cmd_payload_data = _zz_28_;
      io_mem_cmd_payload_mask = (4'b1111);
      io_mem_cmd_payload_last = (victim_bufferReadedCounter == (3'b111));
      if(_zz_39_)begin
        _zz_26_ = 1'b1;
        if((victim_bufferReadedCounter == (3'b111)))begin
          victim_requestIn_halfPipe_ready = 1'b1;
        end
      end
    end
    stageB_loaderValid = 1'b0;
    io_cpu_writeBack_haltIt = io_cpu_writeBack_isValid;
    io_cpu_writeBack_mmuMiss = 1'b0;
    io_cpu_writeBack_illegalAccess = 1'b0;
    io_cpu_writeBack_unalignedAccess = 1'b0;
    if(stageB_bootEvicts_valid)begin
      tagsWriteCmd_valid = stageB_bootEvicts_valid;
      tagsWriteCmd_payload_address = stageB_mmuRsp_baseAddress[11 : 5];
      tagsWriteCmd_payload_data_used = 1'b0;
      if(_zz_40_)begin
        io_cpu_writeBack_haltIt = 1'b1;
      end
    end
    if(io_cpu_writeBack_isValid)begin
      io_cpu_writeBack_mmuMiss = stageB_mmuRsp_miss;
      case(stageB_request_kind)
        `DataCacheCpuCmdKind_defaultEncoding_MANAGMENT : begin
          if((stageB_delayedIsStuck && (! stageB_mmuRsp_miss)))begin
            if((stageB_delayedWaysHitValid || (stageB_request_way && way_tagReadRspTwo_used)))begin
              if((! (victim_requestIn_valid && (! victim_requestIn_ready))))begin
                io_cpu_writeBack_haltIt = 1'b0;
              end
              victim_requestIn_valid = (stageB_request_clean && way_tagReadRspTwo_dirty);
              tagsWriteCmd_valid = victim_requestIn_ready;
            end else begin
              io_cpu_writeBack_haltIt = 1'b0;
            end
          end
          victim_requestIn_payload_address = {{way_tagReadRspTwo_address,stageB_mmuRsp_baseAddress[11 : 5]},_zz_30_};
          tagsWriteCmd_payload_address = stageB_mmuRsp_baseAddress[11 : 5];
          tagsWriteCmd_payload_data_used = (! stageB_request_invalidate);
          tagsWriteCmd_payload_data_dirty = (! stageB_request_clean);
        end
        default : begin
          io_cpu_writeBack_illegalAccess = _zz_31_;
          io_cpu_writeBack_unalignedAccess = _zz_32_;
          if((((1'b0 || (! stageB_mmuRsp_miss)) && (! _zz_31_)) && (! _zz_32_)))begin
            if((stageB_request_forceUncachedAccess || stageB_mmuRsp_isIoAccess))begin
              if(_zz_41_)begin
                io_mem_cmd_payload_wr = stageB_request_wr;
                io_mem_cmd_payload_address = {stageB_mmuRsp_baseAddress[31 : 2],(2'b00)};
                io_mem_cmd_payload_mask = stageB_writeMask;
                io_mem_cmd_payload_data = stageB_request_data;
                io_mem_cmd_payload_length = (3'b000);
                io_mem_cmd_payload_last = 1'b1;
                if(_zz_42_)begin
                  io_mem_cmd_valid = 1'b1;
                end
                if((_zz_33_ && (io_mem_rsp_valid || stageB_request_wr)))begin
                  io_cpu_writeBack_haltIt = 1'b0;
                end
              end
            end else begin
              if((stageB_waysHit || (! stageB_loadingNotDone)))begin
                io_cpu_writeBack_haltIt = 1'b0;
                dataWriteCmd_valid = stageB_request_wr;
                dataWriteCmd_payload_address = stageB_mmuRsp_baseAddress[11 : 2];
                dataWriteCmd_payload_data = stageB_request_data;
                dataWriteCmd_payload_mask = stageB_writeMask;
                tagsWriteCmd_valid = ((! stageB_loadingNotDone) || stageB_request_wr);
                tagsWriteCmd_payload_address = stageB_mmuRsp_baseAddress[11 : 5];
                tagsWriteCmd_payload_data_used = 1'b1;
                tagsWriteCmd_payload_data_dirty = stageB_request_wr;
                tagsWriteCmd_payload_data_address = stageB_mmuRsp_baseAddress[31 : 12];
              end else begin
                stageB_loaderValid = (stageB_loadingNotDone && (! (stageB_victimNotSent && (victim_requestIn_halfPipe_valid && (! victim_requestIn_halfPipe_ready)))));
                victim_requestIn_valid = ((way_tagReadRspTwo_used && way_tagReadRspTwo_dirty) && stageB_victimNotSent);
                victim_requestIn_payload_address = {{way_tagReadRspTwo_address,stageB_mmuRsp_baseAddress[11 : 5]},_zz_34_};
              end
            end
          end
        end
      endcase
    end
    if((loader_valid && (! loader_memCmdSent)))begin
      io_mem_cmd_valid = 1'b1;
      io_mem_cmd_payload_wr = 1'b0;
      io_mem_cmd_payload_address = {stageB_mmuRsp_baseAddress[31 : 5],(5'b00000)};
      io_mem_cmd_payload_length = (3'b111);
      io_mem_cmd_payload_last = 1'b1;
    end
    loader_counter_willIncrement = 1'b0;
    if((loader_valid && io_mem_rsp_valid))begin
      dataWriteCmd_valid = 1'b1;
      dataWriteCmd_payload_address = {stageB_mmuRsp_baseAddress[11 : 5],loader_counter_value};
      dataWriteCmd_payload_data = io_mem_rsp_payload_data;
      dataWriteCmd_payload_mask = (4'b1111);
      loader_counter_willIncrement = 1'b1;
    end
  end

  assign _zz_4_ = _zz_35_;
  assign _zz_5_ = (tagsReadCmd_valid || (tagsWriteCmd_valid && (tagsWriteCmd_payload_address == way_tagReadRspOneAddress)));
  assign _zz_6_ = (tagsWriteCmd_valid_regNextWhen && (tagsWriteCmd_payload_address_regNextWhen == way_tagReadRspOneAddress));
  assign way_tagReadRspOne_used = (_zz_6_ ? tagsWriteCmd_payload_data_regNextWhen_used : _zz_45_[0]);
  assign way_tagReadRspOne_dirty = (_zz_6_ ? tagsWriteCmd_payload_data_regNextWhen_dirty : _zz_46_[0]);
  assign way_tagReadRspOne_address = (_zz_6_ ? tagsWriteCmd_payload_data_regNextWhen_address : _zz_4_[21 : 2]);
  assign way_dataReadRspOneWithoutBypass = _zz_36_;
  assign _zz_7_ = (dataWriteCmd_valid && (dataWriteCmd_payload_address == way_dataReadRspOneAddress));
  assign _zz_8_ = (dataReadCmd_valid || _zz_7_);
  assign _zz_11_ = (dataWriteCmd_valid_regNextWhen && (dataWriteCmd_payload_address_regNextWhen == way_dataReadRspOneAddress));
  always @ (*) begin
    way_dataReadRspOne[7 : 0] = ((_zz_11_ && _zz_10_[0]) ? _zz_9_[7 : 0] : way_dataReadRspOneWithoutBypass[7 : 0]);
    way_dataReadRspOne[15 : 8] = ((_zz_11_ && _zz_10_[1]) ? _zz_9_[15 : 8] : way_dataReadRspOneWithoutBypass[15 : 8]);
    way_dataReadRspOne[23 : 16] = ((_zz_11_ && _zz_10_[2]) ? _zz_9_[23 : 16] : way_dataReadRspOneWithoutBypass[23 : 16]);
    way_dataReadRspOne[31 : 24] = ((_zz_11_ && _zz_10_[3]) ? _zz_9_[31 : 24] : way_dataReadRspOneWithoutBypass[31 : 24]);
  end

  assign way_tagReadRspTwoEnable = (! io_cpu_writeBack_isStuck);
  assign _zz_12_ = (tagsWriteCmd_valid && (tagsWriteCmd_payload_address == way_tagReadRspOneAddress));
  assign way_tagReadRspTwoRegIn_used = (_zz_12_ ? tagsWriteCmd_payload_data_used : way_tagReadRspOne_used);
  assign way_tagReadRspTwoRegIn_dirty = (_zz_12_ ? tagsWriteCmd_payload_data_dirty : way_tagReadRspOne_dirty);
  assign way_tagReadRspTwoRegIn_address = (_zz_12_ ? tagsWriteCmd_payload_data_address : way_tagReadRspOne_address);
  assign way_dataReadRspTwoEnable = (! io_cpu_writeBack_isStuck);
  assign _zz_13_ = (dataWriteCmd_valid && (way_dataReadRspOneAddress == dataWriteCmd_payload_address));
  assign _zz_14_ = (dataWriteCmd_valid && (way_dataReadRspOneAddress_regNextWhen == dataWriteCmd_payload_address));
  assign way_dataReadRspTwo = {_zz_18_,{_zz_17_,{_zz_16_,_zz_15_}}};
  assign victim_requestIn_halfPipe_valid = _zz_19_;
  assign victim_requestIn_halfPipe_payload_address = _zz_21_;
  assign victim_requestIn_ready = _zz_20_;
  assign io_cpu_memory_haltIt = ((cpuMemoryStageNeedReadData && victim_requestIn_halfPipe_valid) && (! victim_dataReadRestored));
  assign victim_bufferReadStream_valid = (victim_bufferReadCounter < victim_readLineRspCounter);
  assign victim_bufferReadStream_payload = victim_bufferReadCounter[2:0];
  assign victim_bufferReadStream_ready = ((! _zz_22_) || _zz_23_);
  assign _zz_22_ = _zz_24_;
  assign _zz_23_ = ((1'b1 && (! _zz_25_)) || _zz_26_);
  assign _zz_25_ = _zz_27_;
  always @ (*) begin
    victim_memCmdAlreadyUsed = 1'b0;
    if((loader_valid && (! loader_memCmdSent)))begin
      victim_memCmdAlreadyUsed = 1'b1;
    end
  end

  assign victim_counter_willIncrement = 1'b0;
  assign victim_counter_willClear = 1'b0;
  assign victim_counter_willOverflowIfInc = (victim_counter_value == (3'b111));
  assign victim_counter_willOverflow = (victim_counter_willOverflowIfInc && victim_counter_willIncrement);
  always @ (*) begin
    victim_counter_valueNext = (victim_counter_value + _zz_49_);
    if(victim_counter_willClear)begin
      victim_counter_valueNext = (3'b000);
    end
  end

  assign io_cpu_memory_mmuBus_cmd_isValid = (io_cpu_memory_isValid && (stageA_request_kind == `DataCacheCpuCmdKind_defaultEncoding_MEMORY));
  assign io_cpu_memory_mmuBus_cmd_virtualAddress = stageA_request_address;
  assign io_cpu_memory_mmuBus_cmd_bypassTranslation = stageA_request_way;
  assign io_cpu_memory_mmuBus_end = ((! io_cpu_memory_isStuck) || io_cpu_memory_isRemoved);
  assign cpuMemoryStageNeedReadData = ((io_cpu_memory_isValid && (stageA_request_kind == `DataCacheCpuCmdKind_defaultEncoding_MEMORY)) && (! stageA_request_wr));
  always @ (*) begin
    stageB_loaderReady = 1'b0;
    if(loader_counter_willOverflow)begin
      stageB_loaderReady = 1'b1;
    end
  end

  always @ (*) begin
    case(stageB_request_size)
      2'b00 : begin
        _zz_29_ = (4'b0001);
      end
      2'b01 : begin
        _zz_29_ = (4'b0011);
      end
      default : begin
        _zz_29_ = (4'b1111);
      end
    endcase
  end

  assign stageB_writeMask = (_zz_29_ <<< stageB_mmuRsp_baseAddress[1 : 0]);
  assign stageB_hadMemRspError = ((io_mem_rsp_valid && io_mem_rsp_payload_error) || stageB_hadMemRspErrorReg);
  assign io_cpu_writeBack_accessError = (stageB_hadMemRspError && (! io_cpu_writeBack_haltIt));
  assign io_cpu_writeBack_badAddr = stageB_request_address;
  assign _zz_30_[4 : 0] = (5'b00000);
  assign _zz_31_ = (((stageB_request_wr && (! stageB_mmuRsp_allowWrite)) || ((! stageB_request_wr) && (! stageB_mmuRsp_allowRead))) || (io_cpu_writeBack_isUser && (! stageB_mmuRsp_allowUser)));
  assign _zz_32_ = (((stageB_request_size == (2'b10)) && (stageB_mmuRsp_baseAddress[1 : 0] != (2'b00))) || ((stageB_request_size == (2'b01)) && (stageB_mmuRsp_baseAddress[0 : 0] != (1'b0))));
  assign _zz_34_[4 : 0] = (5'b00000);
  assign io_cpu_writeBack_data = ((stageB_request_forceUncachedAccess || stageB_mmuRsp_isIoAccess) ? io_mem_rsp_payload_data : way_dataReadRspTwo);
  assign loader_counter_willClear = 1'b0;
  assign loader_counter_willOverflowIfInc = (loader_counter_value == (3'b111));
  assign loader_counter_willOverflow = (loader_counter_willOverflowIfInc && loader_counter_willIncrement);
  always @ (*) begin
    loader_counter_valueNext = (loader_counter_value + _zz_51_);
    if(loader_counter_willClear)begin
      loader_counter_valueNext = (3'b000);
    end
  end

  always @ (posedge clk) begin
    tagsWriteLastCmd_valid <= tagsWriteCmd_valid;
    tagsWriteLastCmd_payload_address <= tagsWriteCmd_payload_address;
    tagsWriteLastCmd_payload_data_used <= tagsWriteCmd_payload_data_used;
    tagsWriteLastCmd_payload_data_dirty <= tagsWriteCmd_payload_data_dirty;
    tagsWriteLastCmd_payload_data_address <= tagsWriteCmd_payload_data_address;
    if(tagsReadCmd_valid)begin
      way_tagReadRspOneAddress <= tagsReadCmd_payload;
    end
    if(_zz_5_)begin
      tagsWriteCmd_valid_regNextWhen <= tagsWriteCmd_valid;
    end
    if(_zz_5_)begin
      tagsWriteCmd_payload_address_regNextWhen <= tagsWriteCmd_payload_address;
    end
    if(_zz_5_)begin
      tagsWriteCmd_payload_data_regNextWhen_used <= tagsWriteCmd_payload_data_used;
      tagsWriteCmd_payload_data_regNextWhen_dirty <= tagsWriteCmd_payload_data_dirty;
      tagsWriteCmd_payload_data_regNextWhen_address <= tagsWriteCmd_payload_data_address;
    end
    if((dataReadCmd_valid && (! way_dataReadRspOneKeepAddress)))begin
      way_dataReadRspOneAddress <= dataReadCmd_payload;
    end
    if(_zz_8_)begin
      dataWriteCmd_valid_regNextWhen <= dataWriteCmd_valid;
    end
    if(_zz_8_)begin
      dataWriteCmd_payload_address_regNextWhen <= dataWriteCmd_payload_address;
    end
    if((_zz_7_ && dataWriteCmd_payload_mask[0]))begin
      _zz_10_[0] <= 1'b1;
    end
    if(dataReadCmd_valid)begin
      _zz_10_[0] <= dataWriteCmd_payload_mask[0];
    end
    if((dataReadCmd_valid || (_zz_7_ && dataWriteCmd_payload_mask[0])))begin
      _zz_9_[7 : 0] <= dataWriteCmd_payload_data[7 : 0];
    end
    if((_zz_7_ && dataWriteCmd_payload_mask[1]))begin
      _zz_10_[1] <= 1'b1;
    end
    if(dataReadCmd_valid)begin
      _zz_10_[1] <= dataWriteCmd_payload_mask[1];
    end
    if((dataReadCmd_valid || (_zz_7_ && dataWriteCmd_payload_mask[1])))begin
      _zz_9_[15 : 8] <= dataWriteCmd_payload_data[15 : 8];
    end
    if((_zz_7_ && dataWriteCmd_payload_mask[2]))begin
      _zz_10_[2] <= 1'b1;
    end
    if(dataReadCmd_valid)begin
      _zz_10_[2] <= dataWriteCmd_payload_mask[2];
    end
    if((dataReadCmd_valid || (_zz_7_ && dataWriteCmd_payload_mask[2])))begin
      _zz_9_[23 : 16] <= dataWriteCmd_payload_data[23 : 16];
    end
    if((_zz_7_ && dataWriteCmd_payload_mask[3]))begin
      _zz_10_[3] <= 1'b1;
    end
    if(dataReadCmd_valid)begin
      _zz_10_[3] <= dataWriteCmd_payload_mask[3];
    end
    if((dataReadCmd_valid || (_zz_7_ && dataWriteCmd_payload_mask[3])))begin
      _zz_9_[31 : 24] <= dataWriteCmd_payload_data[31 : 24];
    end
    if(way_tagReadRspTwoEnable)begin
      way_tagReadRspTwo_used <= way_tagReadRspTwoRegIn_used;
      way_tagReadRspTwo_dirty <= way_tagReadRspTwoRegIn_dirty;
      way_tagReadRspTwo_address <= way_tagReadRspTwoRegIn_address;
    end
    if(way_dataReadRspTwoEnable)begin
      way_dataReadRspOneAddress_regNextWhen <= way_dataReadRspOneAddress;
    end
    if((way_dataReadRspTwoEnable || (_zz_14_ && dataWriteCmd_payload_mask[0])))begin
      _zz_15_ <= (((! way_dataReadRspTwoEnable) || (_zz_13_ && dataWriteCmd_payload_mask[0])) ? dataWriteCmd_payload_data[7 : 0] : way_dataReadRspOne[7 : 0]);
    end
    if((way_dataReadRspTwoEnable || (_zz_14_ && dataWriteCmd_payload_mask[1])))begin
      _zz_16_ <= (((! way_dataReadRspTwoEnable) || (_zz_13_ && dataWriteCmd_payload_mask[1])) ? dataWriteCmd_payload_data[15 : 8] : way_dataReadRspOne[15 : 8]);
    end
    if((way_dataReadRspTwoEnable || (_zz_14_ && dataWriteCmd_payload_mask[2])))begin
      _zz_17_ <= (((! way_dataReadRspTwoEnable) || (_zz_13_ && dataWriteCmd_payload_mask[2])) ? dataWriteCmd_payload_data[23 : 16] : way_dataReadRspOne[23 : 16]);
    end
    if((way_dataReadRspTwoEnable || (_zz_14_ && dataWriteCmd_payload_mask[3])))begin
      _zz_18_ <= (((! way_dataReadRspTwoEnable) || (_zz_13_ && dataWriteCmd_payload_mask[3])) ? dataWriteCmd_payload_data[31 : 24] : way_dataReadRspOne[31 : 24]);
    end
    if(_zz_43_)begin
      _zz_21_ <= victim_requestIn_payload_address;
    end
    if(_zz_23_)begin
      _zz_28_ <= _zz_37_;
    end
    if((! io_cpu_memory_isStuck))begin
      stageA_request_kind <= io_cpu_execute_args_kind;
      stageA_request_wr <= io_cpu_execute_args_wr;
      stageA_request_address <= io_cpu_execute_args_address;
      stageA_request_data <= io_cpu_execute_args_data;
      stageA_request_size <= io_cpu_execute_args_size;
      stageA_request_forceUncachedAccess <= io_cpu_execute_args_forceUncachedAccess;
      stageA_request_clean <= io_cpu_execute_args_clean;
      stageA_request_invalidate <= io_cpu_execute_args_invalidate;
      stageA_request_way <= io_cpu_execute_args_way;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_request_kind <= stageA_request_kind;
      stageB_request_wr <= stageA_request_wr;
      stageB_request_address <= stageA_request_address;
      stageB_request_data <= stageA_request_data;
      stageB_request_size <= stageA_request_size;
      stageB_request_forceUncachedAccess <= stageA_request_forceUncachedAccess;
      stageB_request_clean <= stageA_request_clean;
      stageB_request_invalidate <= stageA_request_invalidate;
      stageB_request_way <= stageA_request_way;
    end
    if(_zz_44_)begin
      stageB_mmuRsp_isIoAccess <= io_cpu_memory_mmuBus_rsp_isIoAccess;
      stageB_mmuRsp_allowRead <= io_cpu_memory_mmuBus_rsp_allowRead;
      stageB_mmuRsp_allowWrite <= io_cpu_memory_mmuBus_rsp_allowWrite;
      stageB_mmuRsp_allowExecute <= io_cpu_memory_mmuBus_rsp_allowExecute;
      stageB_mmuRsp_allowUser <= io_cpu_memory_mmuBus_rsp_allowUser;
      stageB_mmuRsp_miss <= io_cpu_memory_mmuBus_rsp_miss;
      stageB_mmuRsp_hit <= io_cpu_memory_mmuBus_rsp_hit;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_waysHit <= (way_tagReadRspTwoRegIn_used && (io_cpu_memory_mmuBus_rsp_physicalAddress[31 : 12] == way_tagReadRspTwoRegIn_address));
    end
    stageB_delayedIsStuck <= io_cpu_writeBack_isStuck;
    stageB_delayedWaysHitValid <= stageB_waysHit;
    if(!(! ((io_cpu_writeBack_isValid && (! io_cpu_writeBack_haltIt)) && io_cpu_writeBack_isStuck))) begin
      $display("ERROR writeBack stuck by another plugin is not allowed");
    end
  end

  always @ (posedge clk) begin
    if(reset) begin
      _zz_19_ <= 1'b0;
      _zz_20_ <= 1'b1;
      victim_readLineCmdCounter <= (4'b0000);
      victim_dataReadRestored <= 1'b0;
      victim_readLineRspCounter <= (4'b0000);
      victim_dataReadCmdOccure_delay_1 <= 1'b0;
      victim_bufferReadCounter <= (4'b0000);
      _zz_24_ <= 1'b0;
      _zz_27_ <= 1'b0;
      victim_bufferReadedCounter <= (3'b000);
      victim_counter_value <= (3'b000);
      stageB_loadingDone <= 1'b0;
      stageB_victimNotSent <= 1'b0;
      stageB_loadingNotDone <= 1'b0;
      stageB_hadMemRspErrorReg <= 1'b0;
      stageB_bootEvicts_valid <= 1'b1;
      stageB_mmuRsp_baseAddress <= (32'b00000000000000000000000000000000);
      loader_valid <= 1'b0;
      loader_memCmdSent <= 1'b0;
      loader_counter_value <= (3'b000);
    end else begin
      if(_zz_43_)begin
        _zz_19_ <= victim_requestIn_valid;
        _zz_20_ <= (! victim_requestIn_valid);
      end else begin
        _zz_19_ <= (! victim_requestIn_halfPipe_ready);
        _zz_20_ <= victim_requestIn_halfPipe_ready;
      end
      if(victim_requestIn_halfPipe_valid)begin
        if(_zz_38_)begin
          victim_readLineCmdCounter <= (victim_readLineCmdCounter + (4'b0001));
        end else begin
          victim_dataReadRestored <= 1'b1;
        end
      end
      if(victim_requestIn_halfPipe_ready)begin
        victim_dataReadRestored <= 1'b0;
      end
      victim_dataReadCmdOccure_delay_1 <= victim_dataReadCmdOccure;
      if(victim_dataReadCmdOccure_delay_1)begin
        victim_readLineRspCounter <= (victim_readLineRspCounter + (4'b0001));
      end
      if((victim_bufferReadStream_valid && victim_bufferReadStream_ready))begin
        victim_bufferReadCounter <= (victim_bufferReadCounter + (4'b0001));
      end
      if(_zz_23_)begin
        _zz_24_ <= 1'b0;
      end
      if(victim_bufferReadStream_ready)begin
        _zz_24_ <= victim_bufferReadStream_valid;
      end
      if(_zz_23_)begin
        _zz_27_ <= _zz_22_;
      end
      if(_zz_25_)begin
        if(_zz_39_)begin
          victim_bufferReadedCounter <= (victim_bufferReadedCounter + (3'b001));
        end
      end
      victim_counter_value <= victim_counter_valueNext;
      if(victim_requestIn_halfPipe_ready)begin
        victim_readLineCmdCounter[3] <= 1'b0;
        victim_readLineRspCounter[3] <= 1'b0;
        victim_bufferReadCounter[3] <= 1'b0;
      end
      if(_zz_44_)begin
        stageB_mmuRsp_baseAddress <= io_cpu_memory_mmuBus_rsp_physicalAddress;
      end
      stageB_loadingDone <= (stageB_loaderValid && stageB_loaderReady);
      if(victim_requestIn_ready)begin
        stageB_victimNotSent <= 1'b0;
      end
      if((! io_cpu_memory_isStuck))begin
        stageB_victimNotSent <= 1'b1;
      end
      if(stageB_loaderReady)begin
        stageB_loadingNotDone <= 1'b0;
      end
      if((! io_cpu_memory_isStuck))begin
        stageB_loadingNotDone <= 1'b1;
      end
      stageB_hadMemRspErrorReg <= (stageB_hadMemRspError && io_cpu_writeBack_haltIt);
      if(stageB_bootEvicts_valid)begin
        if(_zz_40_)begin
          stageB_mmuRsp_baseAddress[11 : 5] <= (stageB_mmuRsp_baseAddress[11 : 5] + (7'b0000001));
        end else begin
          stageB_bootEvicts_valid <= 1'b0;
        end
      end
      loader_valid <= stageB_loaderValid;
      if((loader_valid && io_mem_cmd_ready))begin
        loader_memCmdSent <= 1'b1;
      end
      loader_counter_value <= loader_counter_valueNext;
      if(loader_counter_willOverflow)begin
        loader_memCmdSent <= 1'b0;
        loader_valid <= 1'b0;
      end
    end
  end

  always @ (posedge clk) begin
    if(reset) begin
      _zz_33_ <= 1'b0;
    end else begin
      if(_zz_41_)begin
        if(_zz_42_)begin
          if(io_mem_cmd_ready)begin
            _zz_33_ <= 1'b1;
          end
        end
      end
      if((! io_cpu_writeBack_isStuck))begin
        _zz_33_ <= 1'b0;
      end
    end
  end

endmodule

module JtagBridge (
      input   io_jtag_tms,
      input   io_jtag_tdi,
      output reg  io_jtag_tdo,
      input   io_jtag_tck,
      output  io_remote_cmd_valid,
      input   io_remote_cmd_ready,
      output  io_remote_cmd_payload_last,
      output [0:0] io_remote_cmd_payload_fragment,
      input   io_remote_rsp_valid,
      output  io_remote_rsp_ready,
      input   io_remote_rsp_payload_error,
      input  [31:0] io_remote_rsp_payload_data,
      input   clk,
      input   reset);
  wire  _zz_2_;
  wire  _zz_3_;
  wire [0:0] _zz_4_;
  wire  _zz_5_;
  wire  _zz_6_;
  wire [5:0] _zz_7_;
  wire [5:0] _zz_8_;
  wire [5:0] _zz_9_;
  wire  system_cmd_valid;
  wire  system_cmd_payload_last;
  wire [0:0] system_cmd_payload_fragment;
  reg  system_rsp_valid;
  reg  system_rsp_payload_error;
  reg [31:0] system_rsp_payload_data;
  wire `JtagState_defaultEncoding_type jtag_tap_fsm_stateNext;
  reg `JtagState_defaultEncoding_type jtag_tap_fsm_state = `JtagState_defaultEncoding_RESET;
  reg `JtagState_defaultEncoding_type _zz_1_;
  reg [5:0] jtag_tap_instruction;
  reg [5:0] jtag_tap_instructionShift;
  reg  jtag_tap_bypass;
  wire [0:0] jtag_idcodeArea_instructionId;
  wire  jtag_idcodeArea_instructionHit;
  reg [31:0] jtag_idcodeArea_shifter;
  wire [1:0] jtag_writeArea_instructionId;
  wire  jtag_writeArea_instructionHit;
  reg  jtag_writeArea_source_valid;
  wire  jtag_writeArea_source_payload_last;
  wire [0:0] jtag_writeArea_source_payload_fragment;
  wire [1:0] jtag_readArea_instructionId;
  wire  jtag_readArea_instructionHit;
  reg [33:0] jtag_readArea_shifter;
  assign _zz_5_ = (jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_SHIFT);
  assign _zz_6_ = (jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_SHIFT);
  assign _zz_7_ = {5'd0, jtag_idcodeArea_instructionId};
  assign _zz_8_ = {4'd0, jtag_writeArea_instructionId};
  assign _zz_9_ = {4'd0, jtag_readArea_instructionId};
  FlowCCByToggle flowCCByToggle_1_ ( 
    .io_input_valid(jtag_writeArea_source_valid),
    .io_input_payload_last(jtag_writeArea_source_payload_last),
    .io_input_payload_fragment(jtag_writeArea_source_payload_fragment),
    .io_output_valid(_zz_2_),
    .io_output_payload_last(_zz_3_),
    .io_output_payload_fragment(_zz_4_),
    .io_jtag_tck(io_jtag_tck),
    .clk(clk),
    .reset(reset) 
  );
  assign io_remote_cmd_valid = system_cmd_valid;
  assign io_remote_cmd_payload_last = system_cmd_payload_last;
  assign io_remote_cmd_payload_fragment = system_cmd_payload_fragment;
  assign io_remote_rsp_ready = 1'b1;
  always @ (*) begin
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_IDLE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_SELECT : `JtagState_defaultEncoding_IDLE);
      end
      `JtagState_defaultEncoding_IR_SELECT : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_RESET : `JtagState_defaultEncoding_IR_CAPTURE);
      end
      `JtagState_defaultEncoding_IR_CAPTURE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_EXIT1 : `JtagState_defaultEncoding_IR_SHIFT);
      end
      `JtagState_defaultEncoding_IR_SHIFT : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_EXIT1 : `JtagState_defaultEncoding_IR_SHIFT);
      end
      `JtagState_defaultEncoding_IR_EXIT1 : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_UPDATE : `JtagState_defaultEncoding_IR_PAUSE);
      end
      `JtagState_defaultEncoding_IR_PAUSE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_EXIT2 : `JtagState_defaultEncoding_IR_PAUSE);
      end
      `JtagState_defaultEncoding_IR_EXIT2 : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_UPDATE : `JtagState_defaultEncoding_IR_SHIFT);
      end
      `JtagState_defaultEncoding_IR_UPDATE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_SELECT : `JtagState_defaultEncoding_IDLE);
      end
      `JtagState_defaultEncoding_DR_SELECT : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_SELECT : `JtagState_defaultEncoding_DR_CAPTURE);
      end
      `JtagState_defaultEncoding_DR_CAPTURE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_EXIT1 : `JtagState_defaultEncoding_DR_SHIFT);
      end
      `JtagState_defaultEncoding_DR_SHIFT : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_EXIT1 : `JtagState_defaultEncoding_DR_SHIFT);
      end
      `JtagState_defaultEncoding_DR_EXIT1 : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_UPDATE : `JtagState_defaultEncoding_DR_PAUSE);
      end
      `JtagState_defaultEncoding_DR_PAUSE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_EXIT2 : `JtagState_defaultEncoding_DR_PAUSE);
      end
      `JtagState_defaultEncoding_DR_EXIT2 : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_UPDATE : `JtagState_defaultEncoding_DR_SHIFT);
      end
      `JtagState_defaultEncoding_DR_UPDATE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_SELECT : `JtagState_defaultEncoding_IDLE);
      end
      default : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_RESET : `JtagState_defaultEncoding_IDLE);
      end
    endcase
  end

  assign jtag_tap_fsm_stateNext = _zz_1_;
  always @ (*) begin
    io_jtag_tdo = jtag_tap_bypass;
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_IR_CAPTURE : begin
      end
      `JtagState_defaultEncoding_IR_SHIFT : begin
        io_jtag_tdo = jtag_tap_instructionShift[0];
      end
      `JtagState_defaultEncoding_IR_UPDATE : begin
      end
      `JtagState_defaultEncoding_DR_SHIFT : begin
      end
      default : begin
      end
    endcase
    if(jtag_idcodeArea_instructionHit)begin
      if(_zz_5_)begin
        io_jtag_tdo = jtag_idcodeArea_shifter[0];
      end
    end
    if(jtag_readArea_instructionHit)begin
      if(_zz_6_)begin
        io_jtag_tdo = jtag_readArea_shifter[0];
      end
    end
  end

  assign jtag_idcodeArea_instructionId = (1'b1);
  assign jtag_idcodeArea_instructionHit = (jtag_tap_instruction == _zz_7_);
  assign jtag_writeArea_instructionId = (2'b10);
  assign jtag_writeArea_instructionHit = (jtag_tap_instruction == _zz_8_);
  always @ (*) begin
    jtag_writeArea_source_valid = 1'b0;
    if(jtag_writeArea_instructionHit)begin
      if((jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_SHIFT))begin
        jtag_writeArea_source_valid = 1'b1;
      end
    end
  end

  assign jtag_writeArea_source_payload_last = io_jtag_tms;
  assign jtag_writeArea_source_payload_fragment[0] = io_jtag_tdi;
  assign system_cmd_valid = _zz_2_;
  assign system_cmd_payload_last = _zz_3_;
  assign system_cmd_payload_fragment = _zz_4_;
  assign jtag_readArea_instructionId = (2'b11);
  assign jtag_readArea_instructionHit = (jtag_tap_instruction == _zz_9_);
  always @ (posedge clk) begin
    if(io_remote_cmd_valid)begin
      system_rsp_valid <= 1'b0;
    end
    if((io_remote_rsp_valid && io_remote_rsp_ready))begin
      system_rsp_valid <= 1'b1;
      system_rsp_payload_error <= io_remote_rsp_payload_error;
      system_rsp_payload_data <= io_remote_rsp_payload_data;
    end
  end

  always @ (posedge io_jtag_tck) begin
    jtag_tap_fsm_state <= jtag_tap_fsm_stateNext;
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_IR_CAPTURE : begin
        jtag_tap_instructionShift <= jtag_tap_instruction;
      end
      `JtagState_defaultEncoding_IR_SHIFT : begin
        jtag_tap_instructionShift <= ({io_jtag_tdi,jtag_tap_instructionShift} >>> 1);
      end
      `JtagState_defaultEncoding_IR_UPDATE : begin
        jtag_tap_instruction <= jtag_tap_instructionShift;
      end
      `JtagState_defaultEncoding_DR_SHIFT : begin
        jtag_tap_bypass <= io_jtag_tdi;
      end
      default : begin
      end
    endcase
    if(jtag_idcodeArea_instructionHit)begin
      if(_zz_5_)begin
        jtag_idcodeArea_shifter <= ({io_jtag_tdi,jtag_idcodeArea_shifter} >>> 1);
      end
    end
    if((jtag_tap_fsm_state == `JtagState_defaultEncoding_RESET))begin
      jtag_idcodeArea_shifter <= (32'b00010000000000000001111111111111);
      jtag_tap_instruction <= {5'd0, jtag_idcodeArea_instructionId};
    end
    if(jtag_readArea_instructionHit)begin
      if((jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_CAPTURE))begin
        jtag_readArea_shifter <= {{system_rsp_payload_data,system_rsp_payload_error},system_rsp_valid};
      end
      if(_zz_6_)begin
        jtag_readArea_shifter <= ({io_jtag_tdi,jtag_readArea_shifter} >>> 1);
      end
    end
  end

endmodule

module SystemDebugger (
      input   io_remote_cmd_valid,
      output  io_remote_cmd_ready,
      input   io_remote_cmd_payload_last,
      input  [0:0] io_remote_cmd_payload_fragment,
      output  io_remote_rsp_valid,
      input   io_remote_rsp_ready,
      output  io_remote_rsp_payload_error,
      output [31:0] io_remote_rsp_payload_data,
      output  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output [31:0] io_mem_cmd_payload_address,
      output [31:0] io_mem_cmd_payload_data,
      output  io_mem_cmd_payload_wr,
      output [1:0] io_mem_cmd_payload_size,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload,
      input   clk,
      input   reset);
  wire  _zz_2_;
  wire [0:0] _zz_3_;
  reg [66:0] dispatcher_dataShifter;
  reg  dispatcher_dataLoaded;
  reg [7:0] dispatcher_headerShifter;
  wire [7:0] dispatcher_header;
  reg  dispatcher_headerLoaded;
  reg [2:0] dispatcher_counter;
  wire [66:0] _zz_1_;
  assign _zz_2_ = (dispatcher_headerLoaded == 1'b0);
  assign _zz_3_ = _zz_1_[64 : 64];
  assign dispatcher_header = dispatcher_headerShifter[7 : 0];
  assign io_remote_cmd_ready = (! dispatcher_dataLoaded);
  assign _zz_1_ = dispatcher_dataShifter[66 : 0];
  assign io_mem_cmd_payload_address = _zz_1_[31 : 0];
  assign io_mem_cmd_payload_data = _zz_1_[63 : 32];
  assign io_mem_cmd_payload_wr = _zz_3_[0];
  assign io_mem_cmd_payload_size = _zz_1_[66 : 65];
  assign io_mem_cmd_valid = (dispatcher_dataLoaded && (dispatcher_header == (8'b00000000)));
  assign io_remote_rsp_valid = io_mem_rsp_valid;
  assign io_remote_rsp_payload_error = 1'b0;
  assign io_remote_rsp_payload_data = io_mem_rsp_payload;
  always @ (posedge clk) begin
    if(reset) begin
      dispatcher_dataLoaded <= 1'b0;
      dispatcher_headerLoaded <= 1'b0;
      dispatcher_counter <= (3'b000);
    end else begin
      if(io_remote_cmd_valid)begin
        if(_zz_2_)begin
          dispatcher_counter <= (dispatcher_counter + (3'b001));
          if((dispatcher_counter == (3'b111)))begin
            dispatcher_headerLoaded <= 1'b1;
          end
        end
        if(io_remote_cmd_payload_last)begin
          dispatcher_headerLoaded <= 1'b1;
          dispatcher_dataLoaded <= 1'b1;
          dispatcher_counter <= (3'b000);
        end
      end
      if((io_mem_cmd_valid && io_mem_cmd_ready))begin
        dispatcher_headerLoaded <= 1'b0;
        dispatcher_dataLoaded <= 1'b0;
      end
    end
  end

  always @ (posedge clk) begin
    if(io_remote_cmd_valid)begin
      if(_zz_2_)begin
        dispatcher_headerShifter <= ({io_remote_cmd_payload_fragment,dispatcher_headerShifter} >>> 1);
      end else begin
        dispatcher_dataShifter <= ({io_remote_cmd_payload_fragment,dispatcher_dataShifter} >>> 1);
      end
    end
  end

endmodule

module VexRiscv (
      input  [31:0] externalResetVector,
      input   timerInterrupt,
      input   externalInterrupt,
      input   timerInterruptS,
      input  [31:0] externalInterruptArray,
      output  debug_resetOut,
      output reg  iBusWishbone_CYC,
      output reg  iBusWishbone_STB,
      input   iBusWishbone_ACK,
      output  iBusWishbone_WE,
      output [29:0] iBusWishbone_ADR,
      input  [31:0] iBusWishbone_DAT_MISO,
      output [31:0] iBusWishbone_DAT_MOSI,
      output [3:0] iBusWishbone_SEL,
      input   iBusWishbone_ERR,
      output [1:0] iBusWishbone_BTE,
      output [2:0] iBusWishbone_CTI,
      output  dBusWishbone_CYC,
      output  dBusWishbone_STB,
      input   dBusWishbone_ACK,
      output  dBusWishbone_WE,
      output [29:0] dBusWishbone_ADR,
      input  [31:0] dBusWishbone_DAT_MISO,
      output [31:0] dBusWishbone_DAT_MOSI,
      output [3:0] dBusWishbone_SEL,
      input   dBusWishbone_ERR,
      output [1:0] dBusWishbone_BTE,
      output [2:0] dBusWishbone_CTI,
      input   jtag_tms,
      input   jtag_tdi,
      output  jtag_tdo,
      input   jtag_tck,
      input   clk,
      input   reset,
      input   debugReset);
  reg  _zz_272_;
  wire  _zz_273_;
  wire  _zz_274_;
  wire  _zz_275_;
  wire  _zz_276_;
  wire  _zz_277_;
  wire  _zz_278_;
  wire `DataCacheCpuCmdKind_defaultEncoding_type _zz_279_;
  wire [31:0] _zz_280_;
  wire  _zz_281_;
  wire  _zz_282_;
  wire  _zz_283_;
  wire  _zz_284_;
  wire  _zz_285_;
  wire  _zz_286_;
  wire  _zz_287_;
  wire  _zz_288_;
  reg [44:0] _zz_289_;
  reg [31:0] _zz_290_;
  reg [31:0] _zz_291_;
  reg [31:0] _zz_292_;
  reg  _zz_293_;
  reg [19:0] _zz_294_;
  reg [19:0] _zz_295_;
  reg  _zz_296_;
  reg  _zz_297_;
  reg  _zz_298_;
  reg  _zz_299_;
  reg  _zz_300_;
  reg [19:0] _zz_301_;
  reg [19:0] _zz_302_;
  reg  _zz_303_;
  reg  _zz_304_;
  reg  _zz_305_;
  reg  _zz_306_;
  wire  _zz_307_;
  wire  _zz_308_;
  wire  _zz_309_;
  wire [31:0] _zz_310_;
  wire [31:0] _zz_311_;
  wire  _zz_312_;
  wire [31:0] _zz_313_;
  wire  _zz_314_;
  wire  _zz_315_;
  wire  _zz_316_;
  wire  _zz_317_;
  wire  _zz_318_;
  wire [31:0] _zz_319_;
  wire  _zz_320_;
  wire [31:0] _zz_321_;
  wire  _zz_322_;
  wire [31:0] _zz_323_;
  wire [2:0] _zz_324_;
  wire  _zz_325_;
  wire  _zz_326_;
  wire [31:0] _zz_327_;
  wire  _zz_328_;
  wire  _zz_329_;
  wire  _zz_330_;
  wire [31:0] _zz_331_;
  wire  _zz_332_;
  wire  _zz_333_;
  wire  _zz_334_;
  wire  _zz_335_;
  wire [31:0] _zz_336_;
  wire  _zz_337_;
  wire  _zz_338_;
  wire [31:0] _zz_339_;
  wire [31:0] _zz_340_;
  wire [3:0] _zz_341_;
  wire [2:0] _zz_342_;
  wire  _zz_343_;
  wire  _zz_344_;
  wire  _zz_345_;
  wire  _zz_346_;
  wire [0:0] _zz_347_;
  wire  _zz_348_;
  wire  _zz_349_;
  wire  _zz_350_;
  wire  _zz_351_;
  wire [31:0] _zz_352_;
  wire  _zz_353_;
  wire [31:0] _zz_354_;
  wire [31:0] _zz_355_;
  wire  _zz_356_;
  wire [1:0] _zz_357_;
  wire  _zz_358_;
  wire  _zz_359_;
  wire  _zz_360_;
  wire [1:0] _zz_361_;
  wire  _zz_362_;
  wire  _zz_363_;
  wire  _zz_364_;
  wire  _zz_365_;
  wire  _zz_366_;
  wire [1:0] _zz_367_;
  wire  _zz_368_;
  wire  _zz_369_;
  wire  _zz_370_;
  wire  _zz_371_;
  wire  _zz_372_;
  wire  _zz_373_;
  wire [5:0] _zz_374_;
  wire  _zz_375_;
  wire [1:0] _zz_376_;
  wire [1:0] _zz_377_;
  wire [1:0] _zz_378_;
  wire  _zz_379_;
  wire [3:0] _zz_380_;
  wire [2:0] _zz_381_;
  wire [31:0] _zz_382_;
  wire [11:0] _zz_383_;
  wire [31:0] _zz_384_;
  wire [19:0] _zz_385_;
  wire [11:0] _zz_386_;
  wire [2:0] _zz_387_;
  wire [2:0] _zz_388_;
  wire [0:0] _zz_389_;
  wire [0:0] _zz_390_;
  wire [0:0] _zz_391_;
  wire [0:0] _zz_392_;
  wire [0:0] _zz_393_;
  wire [0:0] _zz_394_;
  wire [1:0] _zz_395_;
  wire [2:0] _zz_396_;
  wire [0:0] _zz_397_;
  wire [1:0] _zz_398_;
  wire [2:0] _zz_399_;
  wire [31:0] _zz_400_;
  wire [0:0] _zz_401_;
  wire [0:0] _zz_402_;
  wire [0:0] _zz_403_;
  wire [0:0] _zz_404_;
  wire [0:0] _zz_405_;
  wire [0:0] _zz_406_;
  wire [0:0] _zz_407_;
  wire [0:0] _zz_408_;
  wire [0:0] _zz_409_;
  wire [0:0] _zz_410_;
  wire [0:0] _zz_411_;
  wire [0:0] _zz_412_;
  wire [0:0] _zz_413_;
  wire [0:0] _zz_414_;
  wire [0:0] _zz_415_;
  wire [0:0] _zz_416_;
  wire [0:0] _zz_417_;
  wire [0:0] _zz_418_;
  wire [0:0] _zz_419_;
  wire [0:0] _zz_420_;
  wire [2:0] _zz_421_;
  wire [4:0] _zz_422_;
  wire [11:0] _zz_423_;
  wire [11:0] _zz_424_;
  wire [31:0] _zz_425_;
  wire [31:0] _zz_426_;
  wire [31:0] _zz_427_;
  wire [31:0] _zz_428_;
  wire [1:0] _zz_429_;
  wire [31:0] _zz_430_;
  wire [1:0] _zz_431_;
  wire [1:0] _zz_432_;
  wire [32:0] _zz_433_;
  wire [31:0] _zz_434_;
  wire [32:0] _zz_435_;
  wire [51:0] _zz_436_;
  wire [51:0] _zz_437_;
  wire [51:0] _zz_438_;
  wire [32:0] _zz_439_;
  wire [51:0] _zz_440_;
  wire [49:0] _zz_441_;
  wire [51:0] _zz_442_;
  wire [49:0] _zz_443_;
  wire [51:0] _zz_444_;
  wire [65:0] _zz_445_;
  wire [65:0] _zz_446_;
  wire [31:0] _zz_447_;
  wire [31:0] _zz_448_;
  wire [0:0] _zz_449_;
  wire [5:0] _zz_450_;
  wire [32:0] _zz_451_;
  wire [32:0] _zz_452_;
  wire [31:0] _zz_453_;
  wire [31:0] _zz_454_;
  wire [32:0] _zz_455_;
  wire [32:0] _zz_456_;
  wire [32:0] _zz_457_;
  wire [0:0] _zz_458_;
  wire [32:0] _zz_459_;
  wire [0:0] _zz_460_;
  wire [32:0] _zz_461_;
  wire [0:0] _zz_462_;
  wire [31:0] _zz_463_;
  wire [11:0] _zz_464_;
  wire [19:0] _zz_465_;
  wire [11:0] _zz_466_;
  wire [31:0] _zz_467_;
  wire [31:0] _zz_468_;
  wire [31:0] _zz_469_;
  wire [11:0] _zz_470_;
  wire [19:0] _zz_471_;
  wire [11:0] _zz_472_;
  wire [2:0] _zz_473_;
  wire [1:0] _zz_474_;
  wire [1:0] _zz_475_;
  wire [0:0] _zz_476_;
  wire [0:0] _zz_477_;
  wire [0:0] _zz_478_;
  wire [0:0] _zz_479_;
  wire [0:0] _zz_480_;
  wire [0:0] _zz_481_;
  wire [0:0] _zz_482_;
  wire [0:0] _zz_483_;
  wire [0:0] _zz_484_;
  wire [0:0] _zz_485_;
  wire [0:0] _zz_486_;
  wire [0:0] _zz_487_;
  wire [0:0] _zz_488_;
  wire [0:0] _zz_489_;
  wire [26:0] _zz_490_;
  wire  _zz_491_;
  wire [7:0] _zz_492_;
  wire [44:0] _zz_493_;
  wire  _zz_494_;
  wire  _zz_495_;
  wire [1:0] _zz_496_;
  wire [0:0] _zz_497_;
  wire [7:0] _zz_498_;
  wire  _zz_499_;
  wire [0:0] _zz_500_;
  wire [0:0] _zz_501_;
  wire  _zz_502_;
  wire [0:0] _zz_503_;
  wire [0:0] _zz_504_;
  wire  _zz_505_;
  wire [2:0] _zz_506_;
  wire [2:0] _zz_507_;
  wire  _zz_508_;
  wire [0:0] _zz_509_;
  wire [27:0] _zz_510_;
  wire [31:0] _zz_511_;
  wire [31:0] _zz_512_;
  wire [31:0] _zz_513_;
  wire [0:0] _zz_514_;
  wire [0:0] _zz_515_;
  wire [0:0] _zz_516_;
  wire [1:0] _zz_517_;
  wire [0:0] _zz_518_;
  wire [0:0] _zz_519_;
  wire  _zz_520_;
  wire [0:0] _zz_521_;
  wire [24:0] _zz_522_;
  wire [31:0] _zz_523_;
  wire [31:0] _zz_524_;
  wire [31:0] _zz_525_;
  wire [31:0] _zz_526_;
  wire [31:0] _zz_527_;
  wire [31:0] _zz_528_;
  wire [0:0] _zz_529_;
  wire [0:0] _zz_530_;
  wire  _zz_531_;
  wire [4:0] _zz_532_;
  wire [4:0] _zz_533_;
  wire  _zz_534_;
  wire [0:0] _zz_535_;
  wire [21:0] _zz_536_;
  wire [31:0] _zz_537_;
  wire [31:0] _zz_538_;
  wire [31:0] _zz_539_;
  wire [31:0] _zz_540_;
  wire  _zz_541_;
  wire [0:0] _zz_542_;
  wire [1:0] _zz_543_;
  wire  _zz_544_;
  wire  _zz_545_;
  wire  _zz_546_;
  wire [0:0] _zz_547_;
  wire [0:0] _zz_548_;
  wire  _zz_549_;
  wire [0:0] _zz_550_;
  wire [18:0] _zz_551_;
  wire [31:0] _zz_552_;
  wire [31:0] _zz_553_;
  wire [31:0] _zz_554_;
  wire  _zz_555_;
  wire  _zz_556_;
  wire [31:0] _zz_557_;
  wire [31:0] _zz_558_;
  wire [31:0] _zz_559_;
  wire [31:0] _zz_560_;
  wire [31:0] _zz_561_;
  wire [0:0] _zz_562_;
  wire [1:0] _zz_563_;
  wire [1:0] _zz_564_;
  wire [1:0] _zz_565_;
  wire  _zz_566_;
  wire [0:0] _zz_567_;
  wire [16:0] _zz_568_;
  wire [31:0] _zz_569_;
  wire [31:0] _zz_570_;
  wire [31:0] _zz_571_;
  wire [31:0] _zz_572_;
  wire  _zz_573_;
  wire  _zz_574_;
  wire [0:0] _zz_575_;
  wire [1:0] _zz_576_;
  wire [0:0] _zz_577_;
  wire [0:0] _zz_578_;
  wire  _zz_579_;
  wire [0:0] _zz_580_;
  wire [13:0] _zz_581_;
  wire [31:0] _zz_582_;
  wire [31:0] _zz_583_;
  wire [31:0] _zz_584_;
  wire [31:0] _zz_585_;
  wire [31:0] _zz_586_;
  wire [31:0] _zz_587_;
  wire [31:0] _zz_588_;
  wire [31:0] _zz_589_;
  wire [0:0] _zz_590_;
  wire [3:0] _zz_591_;
  wire [0:0] _zz_592_;
  wire [0:0] _zz_593_;
  wire  _zz_594_;
  wire [0:0] _zz_595_;
  wire [10:0] _zz_596_;
  wire [31:0] _zz_597_;
  wire [31:0] _zz_598_;
  wire  _zz_599_;
  wire [0:0] _zz_600_;
  wire [0:0] _zz_601_;
  wire [0:0] _zz_602_;
  wire [1:0] _zz_603_;
  wire  _zz_604_;
  wire [1:0] _zz_605_;
  wire [1:0] _zz_606_;
  wire  _zz_607_;
  wire [0:0] _zz_608_;
  wire [7:0] _zz_609_;
  wire [31:0] _zz_610_;
  wire [31:0] _zz_611_;
  wire [31:0] _zz_612_;
  wire [31:0] _zz_613_;
  wire [31:0] _zz_614_;
  wire [31:0] _zz_615_;
  wire [31:0] _zz_616_;
  wire  _zz_617_;
  wire  _zz_618_;
  wire [31:0] _zz_619_;
  wire  _zz_620_;
  wire  _zz_621_;
  wire  _zz_622_;
  wire [0:0] _zz_623_;
  wire [0:0] _zz_624_;
  wire  _zz_625_;
  wire [0:0] _zz_626_;
  wire [5:0] _zz_627_;
  wire [31:0] _zz_628_;
  wire [31:0] _zz_629_;
  wire [31:0] _zz_630_;
  wire [31:0] _zz_631_;
  wire [31:0] _zz_632_;
  wire [31:0] _zz_633_;
  wire [31:0] _zz_634_;
  wire [0:0] _zz_635_;
  wire [4:0] _zz_636_;
  wire [1:0] _zz_637_;
  wire [1:0] _zz_638_;
  wire  _zz_639_;
  wire [0:0] _zz_640_;
  wire [3:0] _zz_641_;
  wire [31:0] _zz_642_;
  wire [31:0] _zz_643_;
  wire [31:0] _zz_644_;
  wire  _zz_645_;
  wire [0:0] _zz_646_;
  wire [1:0] _zz_647_;
  wire [31:0] _zz_648_;
  wire [31:0] _zz_649_;
  wire [31:0] _zz_650_;
  wire [31:0] _zz_651_;
  wire [0:0] _zz_652_;
  wire [0:0] _zz_653_;
  wire [5:0] _zz_654_;
  wire [5:0] _zz_655_;
  wire  _zz_656_;
  wire [0:0] _zz_657_;
  wire [0:0] _zz_658_;
  wire [31:0] _zz_659_;
  wire [31:0] _zz_660_;
  wire [31:0] _zz_661_;
  wire  _zz_662_;
  wire  _zz_663_;
  wire [31:0] _zz_664_;
  wire [31:0] _zz_665_;
  wire [31:0] _zz_666_;
  wire [31:0] _zz_667_;
  wire [0:0] _zz_668_;
  wire [3:0] _zz_669_;
  wire  _zz_670_;
  wire [1:0] _zz_671_;
  wire [1:0] _zz_672_;
  wire [4:0] _zz_673_;
  wire [4:0] _zz_674_;
  wire [31:0] _zz_675_;
  wire [31:0] _zz_676_;
  wire [31:0] _zz_677_;
  wire  _zz_678_;
  wire [0:0] _zz_679_;
  wire [0:0] _zz_680_;
  wire [31:0] _zz_681_;
  wire [31:0] _zz_682_;
  wire [31:0] _zz_683_;
  wire [31:0] _zz_684_;
  wire [31:0] _zz_685_;
  wire [31:0] _zz_686_;
  wire  _zz_687_;
  wire [0:0] _zz_688_;
  wire [1:0] _zz_689_;
  wire [31:0] _zz_690_;
  wire [31:0] _zz_691_;
  wire [31:0] _zz_692_;
  wire  _zz_693_;
  wire [0:0] _zz_694_;
  wire [16:0] _zz_695_;
  wire [31:0] _zz_696_;
  wire [31:0] _zz_697_;
  wire [31:0] _zz_698_;
  wire  _zz_699_;
  wire [0:0] _zz_700_;
  wire [10:0] _zz_701_;
  wire [31:0] _zz_702_;
  wire [31:0] _zz_703_;
  wire [31:0] _zz_704_;
  wire  _zz_705_;
  wire [0:0] _zz_706_;
  wire [4:0] _zz_707_;
  wire [31:0] _zz_708_;
  wire [31:0] _zz_709_;
  wire [31:0] _zz_710_;
  wire [31:0] _zz_711_;
  wire [31:0] _zz_712_;
  wire  _zz_713_;
  wire  _zz_714_;
  wire  _zz_715_;
  wire  decode_MEMORY_ENABLE;
  wire `Src1CtrlEnum_defaultEncoding_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_1_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_2_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_3_;
  wire  decode_IS_TLB;
  wire [31:0] memory_PC;
  wire  memory_MEMORY_WR;
  wire  decode_MEMORY_WR;
  wire `AluCtrlEnum_defaultEncoding_type decode_ALU_CTRL;
  wire `AluCtrlEnum_defaultEncoding_type _zz_4_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_5_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_6_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_7_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_8_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_9_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_10_;
  wire `EnvCtrlEnum_defaultEncoding_type decode_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_11_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_12_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_13_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_14_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_15_;
  wire [31:0] writeBack_FORMAL_PC_NEXT;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire  decode_IS_DIV;
  wire `Src2CtrlEnum_defaultEncoding_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_16_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_17_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_18_;
  wire  decode_CSR_READ_OPCODE;
  wire  decode_PREDICTION_HAD_BRANCHED2;
  wire [33:0] execute_MUL_HL;
  wire [31:0] execute_SHIFT_RIGHT;
  wire  decode_IS_CSR;
  wire  decode_DO_EBREAK;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_19_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_20_;
  wire `ShiftCtrlEnum_defaultEncoding_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_21_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_22_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_23_;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire  execute_BRANCH_DO;
  wire  memory_IS_MUL;
  wire  execute_IS_MUL;
  wire  decode_IS_MUL;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  wire  decode_SRC_USE_SUB_LESS;
  wire [33:0] memory_MUL_HH;
  wire [33:0] execute_MUL_HH;
  wire [33:0] execute_MUL_LH;
  wire  execute_FLUSH_ALL;
  wire  decode_FLUSH_ALL;
  wire [51:0] memory_MUL_LOW;
  wire [31:0] execute_MUL_LL;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire  decode_IS_RS1_SIGNED;
  wire  decode_CSR_WRITE_OPCODE;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_24_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_25_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_26_;
  wire  decode_IS_RS2_SIGNED;
  wire  decode_MEMORY_MANAGMENT;
  wire [31:0] execute_BRANCH_CALC;
  wire  decode_SRC_LESS_UNSIGNED;
  wire  execute_DO_EBREAK;
  wire  decode_IS_EBREAK;
  wire  _zz_27_;
  wire  execute_CSR_READ_OPCODE;
  wire  execute_CSR_WRITE_OPCODE;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire  execute_IS_CSR;
  wire `EnvCtrlEnum_defaultEncoding_type memory_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_28_;
  wire `EnvCtrlEnum_defaultEncoding_type execute_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_29_;
  wire  _zz_30_;
  wire  _zz_31_;
  wire `EnvCtrlEnum_defaultEncoding_type writeBack_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_32_;
  wire  execute_IS_FENCEI;
  reg [31:0] _zz_33_;
  wire [31:0] memory_BRANCH_CALC;
  wire  memory_BRANCH_DO;
  wire [31:0] _zz_34_;
  wire [31:0] execute_PC;
  wire  execute_PREDICTION_HAD_BRANCHED2;
  wire  _zz_35_;
  wire  execute_BRANCH_COND_RESULT;
  wire `BranchCtrlEnum_defaultEncoding_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_36_;
  wire  _zz_37_;
  wire  decode_IS_FENCEI;
  wire  _zz_38_;
  wire  decode_RS2_USE;
  wire  decode_RS1_USE;
  reg [31:0] _zz_39_;
  wire  execute_REGFILE_WRITE_VALID;
  wire  execute_BYPASSABLE_EXECUTE_STAGE;
  wire  memory_REGFILE_WRITE_VALID;
  wire  memory_BYPASSABLE_MEMORY_STAGE;
  wire  writeBack_REGFILE_WRITE_VALID;
  reg [31:0] decode_RS2;
  reg [31:0] decode_RS1;
  wire  execute_IS_RS1_SIGNED;
  wire [31:0] execute_RS1;
  wire  execute_IS_DIV;
  wire  execute_IS_RS2_SIGNED;
  wire [31:0] memory_INSTRUCTION;
  wire  memory_IS_DIV;
  wire  writeBack_IS_MUL;
  wire [33:0] writeBack_MUL_HH;
  wire [51:0] writeBack_MUL_LOW;
  wire [33:0] memory_MUL_HL;
  wire [33:0] memory_MUL_LH;
  wire [31:0] memory_MUL_LL;
  wire [51:0] _zz_40_;
  wire [33:0] _zz_41_;
  wire [33:0] _zz_42_;
  wire [33:0] _zz_43_;
  wire [31:0] _zz_44_;
  wire [31:0] memory_SHIFT_RIGHT;
  reg [31:0] _zz_45_;
  wire `ShiftCtrlEnum_defaultEncoding_type memory_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_46_;
  wire [31:0] _zz_47_;
  wire `ShiftCtrlEnum_defaultEncoding_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_48_;
  wire  _zz_49_;
  wire [31:0] _zz_50_;
  wire [31:0] _zz_51_;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC_USE_SUB_LESS;
  wire [31:0] _zz_52_;
  wire `Src2CtrlEnum_defaultEncoding_type execute_SRC2_CTRL;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_53_;
  wire [31:0] _zz_54_;
  wire `Src1CtrlEnum_defaultEncoding_type execute_SRC1_CTRL;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_55_;
  wire [31:0] _zz_56_;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_defaultEncoding_type execute_ALU_CTRL;
  wire `AluCtrlEnum_defaultEncoding_type _zz_57_;
  wire [31:0] _zz_58_;
  wire [31:0] execute_SRC2;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_59_;
  wire [31:0] _zz_60_;
  wire  _zz_61_;
  reg  _zz_62_;
  wire [31:0] _zz_63_;
  wire [31:0] _zz_64_;
  wire [31:0] decode_INSTRUCTION_ANTICIPATED;
  reg  decode_REGFILE_WRITE_VALID;
  wire  decode_LEGAL_INSTRUCTION;
  wire  decode_INSTRUCTION_READY;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_65_;
  wire  _zz_66_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_67_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_68_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_69_;
  wire  _zz_70_;
  wire  _zz_71_;
  wire  _zz_72_;
  wire  _zz_73_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_74_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_75_;
  wire  _zz_76_;
  wire  _zz_77_;
  wire  _zz_78_;
  wire  _zz_79_;
  wire  _zz_80_;
  wire  _zz_81_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_82_;
  wire  _zz_83_;
  wire  _zz_84_;
  wire  _zz_85_;
  wire  _zz_86_;
  wire  _zz_87_;
  wire  _zz_88_;
  wire  _zz_89_;
  wire  _zz_90_;
  wire  _zz_91_;
  reg  _zz_92_;
  wire [31:0] execute_SRC1;
  wire  execute_IS_TLB;
  reg  MemoryTranslatorPlugin_shared_free;
  reg  _zz_93_;
  reg [31:0] _zz_94_;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire  writeBack_MEMORY_WR;
  wire  writeBack_MEMORY_ENABLE;
  wire  memory_MEMORY_ENABLE;
  wire [1:0] _zz_95_;
  wire  execute_MEMORY_MANAGMENT;
  wire [31:0] execute_RS2;
  wire [31:0] execute_SRC_ADD;
  wire  execute_MEMORY_WR;
  wire  execute_MEMORY_ENABLE;
  wire [31:0] execute_INSTRUCTION;
  wire  memory_FLUSH_ALL;
  reg  IBusCachedPlugin_issueDetected;
  reg  _zz_96_;
  wire [31:0] _zz_97_;
  wire `BranchCtrlEnum_defaultEncoding_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_98_;
  reg [31:0] _zz_99_;
  reg [31:0] _zz_100_;
  wire [31:0] _zz_101_;
  wire [31:0] _zz_102_;
  wire [31:0] _zz_103_;
  wire [31:0] writeBack_PC /* verilator public */ ;
  wire [31:0] writeBack_INSTRUCTION /* verilator public */ ;
  wire [31:0] decode_PC /* verilator public */ ;
  reg [31:0] decode_INSTRUCTION /* verilator public */ ;
  reg  decode_arbitration_haltItself /* verilator public */ ;
  reg  decode_arbitration_haltByOther;
  reg  decode_arbitration_removeIt;
  reg  decode_arbitration_flushAll /* verilator public */ ;
  wire  decode_arbitration_redoIt;
  reg  decode_arbitration_isValid /* verilator public */ ;
  wire  decode_arbitration_isStuck;
  wire  decode_arbitration_isStuckByOthers;
  wire  decode_arbitration_isFlushed;
  wire  decode_arbitration_isMoving;
  wire  decode_arbitration_isFiring;
  reg  execute_arbitration_haltItself;
  reg  execute_arbitration_haltByOther;
  reg  execute_arbitration_removeIt;
  reg  execute_arbitration_flushAll;
  wire  execute_arbitration_redoIt;
  reg  execute_arbitration_isValid;
  wire  execute_arbitration_isStuck;
  wire  execute_arbitration_isStuckByOthers;
  wire  execute_arbitration_isFlushed;
  wire  execute_arbitration_isMoving;
  wire  execute_arbitration_isFiring;
  reg  memory_arbitration_haltItself;
  wire  memory_arbitration_haltByOther;
  reg  memory_arbitration_removeIt;
  reg  memory_arbitration_flushAll;
  wire  memory_arbitration_redoIt;
  reg  memory_arbitration_isValid;
  wire  memory_arbitration_isStuck;
  wire  memory_arbitration_isStuckByOthers;
  wire  memory_arbitration_isFlushed;
  wire  memory_arbitration_isMoving;
  wire  memory_arbitration_isFiring;
  reg  writeBack_arbitration_haltItself;
  wire  writeBack_arbitration_haltByOther;
  reg  writeBack_arbitration_removeIt;
  wire  writeBack_arbitration_flushAll;
  wire  writeBack_arbitration_redoIt;
  reg  writeBack_arbitration_isValid /* verilator public */ ;
  wire  writeBack_arbitration_isStuck;
  wire  writeBack_arbitration_isStuckByOthers;
  wire  writeBack_arbitration_isFlushed;
  wire  writeBack_arbitration_isMoving;
  wire  writeBack_arbitration_isFiring /* verilator public */ ;
  reg  _zz_104_;
  reg  _zz_105_;
  reg  _zz_106_;
  wire  _zz_107_;
  wire [31:0] _zz_108_;
  wire  _zz_109_;
  wire  _zz_110_;
  wire [31:0] _zz_111_;
  reg  _zz_112_;
  wire  _zz_113_;
  wire [31:0] _zz_114_;
  wire  _zz_115_;
  reg [31:0] _zz_116_;
  reg  _zz_117_;
  reg  _zz_118_;
  reg  _zz_119_;
  reg  _zz_120_;
  wire  _zz_121_;
  reg  _zz_122_;
  wire  _zz_123_;
  wire [31:0] _zz_124_;
  wire  _zz_125_;
  reg [31:0] _zz_126_;
  reg  _zz_127_;
  reg  _zz_128_;
  reg  _zz_129_;
  reg  _zz_130_;
  wire  _zz_131_;
  reg  _zz_132_;
  wire  writeBack_exception_agregat_valid;
  reg [3:0] writeBack_exception_agregat_payload_code;
  wire [31:0] writeBack_exception_agregat_payload_badAddr;
  reg  decodeExceptionPort_valid;
  reg [3:0] decodeExceptionPort_1_code;
  reg [31:0] decodeExceptionPort_1_badAddr;
  wire  _zz_133_;
  wire [31:0] _zz_134_;
  wire  memory_exception_agregat_valid;
  wire [3:0] memory_exception_agregat_payload_code;
  wire [31:0] memory_exception_agregat_payload_badAddr;
  reg  _zz_135_;
  reg [31:0] _zz_136_;
  wire  externalInterruptS;
  wire  contextSwitching;
  reg [1:0] CsrPlugin_privilege;
  reg  _zz_137_;
  reg  _zz_138_;
  wire  debug_bus_cmd_valid;
  reg  debug_bus_cmd_ready;
  wire  debug_bus_cmd_payload_wr;
  wire [7:0] debug_bus_cmd_payload_address;
  wire [31:0] debug_bus_cmd_payload_data;
  reg [31:0] debug_bus_rsp_data;
  reg  _zz_139_;
  reg  _zz_140_;
  wire  IBusCachedPlugin_jump_pcLoad_valid;
  wire [31:0] IBusCachedPlugin_jump_pcLoad_payload;
  wire [3:0] _zz_141_;
  wire [3:0] _zz_142_;
  wire  _zz_143_;
  wire  _zz_144_;
  wire  _zz_145_;
  wire  IBusCachedPlugin_fetchPc_preOutput_valid;
  wire  IBusCachedPlugin_fetchPc_preOutput_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_preOutput_payload;
  wire  _zz_146_;
  wire  IBusCachedPlugin_fetchPc_output_valid;
  wire  IBusCachedPlugin_fetchPc_output_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_output_payload;
  reg [31:0] IBusCachedPlugin_fetchPc_pcReg /* verilator public */ ;
  reg  IBusCachedPlugin_fetchPc_inc;
  reg  IBusCachedPlugin_fetchPc_propagatePc;
  reg [31:0] IBusCachedPlugin_fetchPc_pc;
  reg  IBusCachedPlugin_fetchPc_samplePcNext;
  reg  _zz_147_;
  wire  IBusCachedPlugin_iBusRsp_stages_0_input_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  wire  IBusCachedPlugin_iBusRsp_stages_0_output_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_0_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_0_output_payload;
  reg  IBusCachedPlugin_iBusRsp_stages_0_halt;
  wire  IBusCachedPlugin_iBusRsp_stages_0_inputSample;
  wire  IBusCachedPlugin_iBusRsp_stages_1_input_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_1_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  wire  IBusCachedPlugin_iBusRsp_stages_1_output_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_1_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_1_output_payload;
  reg  IBusCachedPlugin_iBusRsp_stages_1_halt;
  wire  IBusCachedPlugin_iBusRsp_stages_1_inputSample;
  wire  IBusCachedPlugin_stages_2_input_valid;
  wire  IBusCachedPlugin_stages_2_input_ready;
  wire [31:0] IBusCachedPlugin_stages_2_input_payload;
  wire  IBusCachedPlugin_stages_2_output_valid;
  wire  IBusCachedPlugin_stages_2_output_ready;
  wire [31:0] IBusCachedPlugin_stages_2_output_payload;
  reg  IBusCachedPlugin_stages_2_halt;
  wire  IBusCachedPlugin_stages_2_inputSample;
  wire  _zz_148_;
  wire  _zz_149_;
  wire  _zz_150_;
  wire  _zz_151_;
  wire  _zz_152_;
  reg  _zz_153_;
  wire  _zz_154_;
  reg  _zz_155_;
  reg [31:0] _zz_156_;
  wire  IBusCachedPlugin_iBusRsp_readyForError;
  wire  IBusCachedPlugin_iBusRsp_decodeInput_valid;
  wire  IBusCachedPlugin_iBusRsp_decodeInput_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_decodeInput_payload_pc;
  wire  IBusCachedPlugin_iBusRsp_decodeInput_payload_rsp_error;
  wire [31:0] IBusCachedPlugin_iBusRsp_decodeInput_payload_rsp_rawInDecode;
  wire  IBusCachedPlugin_iBusRsp_decodeInput_payload_isRvc;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_0;
  reg  IBusCachedPlugin_injector_nextPcCalc_0;
  reg  IBusCachedPlugin_injector_nextPcCalc_1;
  reg  IBusCachedPlugin_injector_nextPcCalc_2;
  reg  IBusCachedPlugin_injector_nextPcCalc_3;
  reg  IBusCachedPlugin_injector_decodeRemoved;
  wire  _zz_157_;
  reg [18:0] _zz_158_;
  wire  _zz_159_;
  reg [10:0] _zz_160_;
  wire  _zz_161_;
  reg [18:0] _zz_162_;
  wire  iBus_cmd_valid;
  wire  iBus_cmd_ready;
  reg [31:0] iBus_cmd_payload_address;
  wire [2:0] iBus_cmd_payload_size;
  wire  iBus_rsp_valid;
  wire [31:0] iBus_rsp_payload_data;
  wire  iBus_rsp_payload_error;
  wire  IBusCachedPlugin_iBusRspOutputHalt;
  reg  IBusCachedPlugin_redoFetch;
  wire  dBus_cmd_valid;
  wire  dBus_cmd_ready;
  wire  dBus_cmd_payload_wr;
  wire [31:0] dBus_cmd_payload_address;
  wire [31:0] dBus_cmd_payload_data;
  wire [3:0] dBus_cmd_payload_mask;
  wire [2:0] dBus_cmd_payload_length;
  wire  dBus_cmd_payload_last;
  wire  dBus_rsp_valid;
  wire [31:0] dBus_rsp_payload_data;
  wire  dBus_rsp_payload_error;
  wire [1:0] execute_DBusCachedPlugin_size;
  reg [31:0] _zz_163_;
  reg [31:0] writeBack_DBusCachedPlugin_rspShifted;
  wire  _zz_164_;
  reg [31:0] _zz_165_;
  wire  _zz_166_;
  reg [31:0] _zz_167_;
  reg [31:0] writeBack_DBusCachedPlugin_rspFormated;
  reg [7:0] MemoryTranslatorPlugin_shared_readAddr;
  wire [44:0] _zz_168_;
  reg  MemoryTranslatorPlugin_shared_readData_valid;
  reg [19:0] MemoryTranslatorPlugin_shared_readData_virtualAddress;
  reg [19:0] MemoryTranslatorPlugin_shared_readData_physicalAddress;
  reg  MemoryTranslatorPlugin_shared_readData_allowRead;
  reg  MemoryTranslatorPlugin_shared_readData_allowWrite;
  reg  MemoryTranslatorPlugin_shared_readData_allowExecute;
  reg  MemoryTranslatorPlugin_shared_readData_allowUser;
  reg  MemoryTranslatorPlugin_mmuEnabled;
  reg  MemoryTranslatorPlugin_ports_0_cache_0_valid;
  reg [19:0] MemoryTranslatorPlugin_ports_0_cache_0_virtualAddress;
  reg [19:0] MemoryTranslatorPlugin_ports_0_cache_0_physicalAddress;
  reg  MemoryTranslatorPlugin_ports_0_cache_0_allowRead;
  reg  MemoryTranslatorPlugin_ports_0_cache_0_allowWrite;
  reg  MemoryTranslatorPlugin_ports_0_cache_0_allowExecute;
  reg  MemoryTranslatorPlugin_ports_0_cache_0_allowUser;
  reg  MemoryTranslatorPlugin_ports_0_cache_1_valid;
  reg [19:0] MemoryTranslatorPlugin_ports_0_cache_1_virtualAddress;
  reg [19:0] MemoryTranslatorPlugin_ports_0_cache_1_physicalAddress;
  reg  MemoryTranslatorPlugin_ports_0_cache_1_allowRead;
  reg  MemoryTranslatorPlugin_ports_0_cache_1_allowWrite;
  reg  MemoryTranslatorPlugin_ports_0_cache_1_allowExecute;
  reg  MemoryTranslatorPlugin_ports_0_cache_1_allowUser;
  reg  MemoryTranslatorPlugin_ports_0_cache_2_valid;
  reg [19:0] MemoryTranslatorPlugin_ports_0_cache_2_virtualAddress;
  reg [19:0] MemoryTranslatorPlugin_ports_0_cache_2_physicalAddress;
  reg  MemoryTranslatorPlugin_ports_0_cache_2_allowRead;
  reg  MemoryTranslatorPlugin_ports_0_cache_2_allowWrite;
  reg  MemoryTranslatorPlugin_ports_0_cache_2_allowExecute;
  reg  MemoryTranslatorPlugin_ports_0_cache_2_allowUser;
  reg  MemoryTranslatorPlugin_ports_0_cache_3_valid;
  reg [19:0] MemoryTranslatorPlugin_ports_0_cache_3_virtualAddress;
  reg [19:0] MemoryTranslatorPlugin_ports_0_cache_3_physicalAddress;
  reg  MemoryTranslatorPlugin_ports_0_cache_3_allowRead;
  reg  MemoryTranslatorPlugin_ports_0_cache_3_allowWrite;
  reg  MemoryTranslatorPlugin_ports_0_cache_3_allowExecute;
  reg  MemoryTranslatorPlugin_ports_0_cache_3_allowUser;
  wire  MemoryTranslatorPlugin_ports_0_cacheHits_0;
  wire  MemoryTranslatorPlugin_ports_0_cacheHits_1;
  wire  MemoryTranslatorPlugin_ports_0_cacheHits_2;
  wire  MemoryTranslatorPlugin_ports_0_cacheHits_3;
  wire  MemoryTranslatorPlugin_ports_0_cacheHit;
  wire  _zz_169_;
  wire  _zz_170_;
  wire [1:0] _zz_171_;
  wire  MemoryTranslatorPlugin_ports_0_cacheLine_valid;
  wire [19:0] MemoryTranslatorPlugin_ports_0_cacheLine_virtualAddress;
  wire [19:0] MemoryTranslatorPlugin_ports_0_cacheLine_physicalAddress;
  wire  MemoryTranslatorPlugin_ports_0_cacheLine_allowRead;
  wire  MemoryTranslatorPlugin_ports_0_cacheLine_allowWrite;
  wire  MemoryTranslatorPlugin_ports_0_cacheLine_allowExecute;
  wire  MemoryTranslatorPlugin_ports_0_cacheLine_allowUser;
  wire  MemoryTranslatorPlugin_ports_0_isInMmuRange;
  wire  MemoryTranslatorPlugin_ports_0_isInKernelRange;
  reg  MemoryTranslatorPlugin_ports_0_sharedMiss;
  reg [8:0] MemoryTranslatorPlugin_ports_0_sharedIterator;
  reg [1:0] MemoryTranslatorPlugin_ports_0_sharedAccessed;
  reg  MemoryTranslatorPlugin_ports_0_entryToReplace_willIncrement;
  wire  MemoryTranslatorPlugin_ports_0_entryToReplace_willClear;
  reg [1:0] MemoryTranslatorPlugin_ports_0_entryToReplace_valueNext;
  reg [1:0] MemoryTranslatorPlugin_ports_0_entryToReplace_value;
  wire  MemoryTranslatorPlugin_ports_0_entryToReplace_willOverflowIfInc;
  wire  MemoryTranslatorPlugin_ports_0_entryToReplace_willOverflow;
  reg  MemoryTranslatorPlugin_ports_0_sharedAccessAsked;
  wire  MemoryTranslatorPlugin_ports_0_sharedAccessGranted;
  wire [3:0] _zz_172_;
  wire  _zz_173_;
  wire  _zz_174_;
  wire  _zz_175_;
  wire  _zz_176_;
  reg  MemoryTranslatorPlugin_ports_1_cache_0_valid;
  reg [19:0] MemoryTranslatorPlugin_ports_1_cache_0_virtualAddress;
  reg [19:0] MemoryTranslatorPlugin_ports_1_cache_0_physicalAddress;
  reg  MemoryTranslatorPlugin_ports_1_cache_0_allowRead;
  reg  MemoryTranslatorPlugin_ports_1_cache_0_allowWrite;
  reg  MemoryTranslatorPlugin_ports_1_cache_0_allowExecute;
  reg  MemoryTranslatorPlugin_ports_1_cache_0_allowUser;
  reg  MemoryTranslatorPlugin_ports_1_cache_1_valid;
  reg [19:0] MemoryTranslatorPlugin_ports_1_cache_1_virtualAddress;
  reg [19:0] MemoryTranslatorPlugin_ports_1_cache_1_physicalAddress;
  reg  MemoryTranslatorPlugin_ports_1_cache_1_allowRead;
  reg  MemoryTranslatorPlugin_ports_1_cache_1_allowWrite;
  reg  MemoryTranslatorPlugin_ports_1_cache_1_allowExecute;
  reg  MemoryTranslatorPlugin_ports_1_cache_1_allowUser;
  reg  MemoryTranslatorPlugin_ports_1_cache_2_valid;
  reg [19:0] MemoryTranslatorPlugin_ports_1_cache_2_virtualAddress;
  reg [19:0] MemoryTranslatorPlugin_ports_1_cache_2_physicalAddress;
  reg  MemoryTranslatorPlugin_ports_1_cache_2_allowRead;
  reg  MemoryTranslatorPlugin_ports_1_cache_2_allowWrite;
  reg  MemoryTranslatorPlugin_ports_1_cache_2_allowExecute;
  reg  MemoryTranslatorPlugin_ports_1_cache_2_allowUser;
  reg  MemoryTranslatorPlugin_ports_1_cache_3_valid;
  reg [19:0] MemoryTranslatorPlugin_ports_1_cache_3_virtualAddress;
  reg [19:0] MemoryTranslatorPlugin_ports_1_cache_3_physicalAddress;
  reg  MemoryTranslatorPlugin_ports_1_cache_3_allowRead;
  reg  MemoryTranslatorPlugin_ports_1_cache_3_allowWrite;
  reg  MemoryTranslatorPlugin_ports_1_cache_3_allowExecute;
  reg  MemoryTranslatorPlugin_ports_1_cache_3_allowUser;
  wire  MemoryTranslatorPlugin_ports_1_cacheHits_0;
  wire  MemoryTranslatorPlugin_ports_1_cacheHits_1;
  wire  MemoryTranslatorPlugin_ports_1_cacheHits_2;
  wire  MemoryTranslatorPlugin_ports_1_cacheHits_3;
  wire  MemoryTranslatorPlugin_ports_1_cacheHit;
  wire  _zz_177_;
  wire  _zz_178_;
  wire [1:0] _zz_179_;
  wire  MemoryTranslatorPlugin_ports_1_cacheLine_valid;
  wire [19:0] MemoryTranslatorPlugin_ports_1_cacheLine_virtualAddress;
  wire [19:0] MemoryTranslatorPlugin_ports_1_cacheLine_physicalAddress;
  wire  MemoryTranslatorPlugin_ports_1_cacheLine_allowRead;
  wire  MemoryTranslatorPlugin_ports_1_cacheLine_allowWrite;
  wire  MemoryTranslatorPlugin_ports_1_cacheLine_allowExecute;
  wire  MemoryTranslatorPlugin_ports_1_cacheLine_allowUser;
  wire  MemoryTranslatorPlugin_ports_1_isInMmuRange;
  wire  MemoryTranslatorPlugin_ports_1_isInKernelRange;
  reg  MemoryTranslatorPlugin_ports_1_sharedMiss;
  reg [8:0] MemoryTranslatorPlugin_ports_1_sharedIterator;
  reg [1:0] MemoryTranslatorPlugin_ports_1_sharedAccessed;
  reg  MemoryTranslatorPlugin_ports_1_entryToReplace_willIncrement;
  wire  MemoryTranslatorPlugin_ports_1_entryToReplace_willClear;
  reg [1:0] MemoryTranslatorPlugin_ports_1_entryToReplace_valueNext;
  reg [1:0] MemoryTranslatorPlugin_ports_1_entryToReplace_value;
  wire  MemoryTranslatorPlugin_ports_1_entryToReplace_willOverflowIfInc;
  wire  MemoryTranslatorPlugin_ports_1_entryToReplace_willOverflow;
  reg  MemoryTranslatorPlugin_ports_1_sharedAccessAsked;
  wire  MemoryTranslatorPlugin_ports_1_sharedAccessGranted;
  wire [3:0] _zz_180_;
  wire  _zz_181_;
  wire  _zz_182_;
  wire  _zz_183_;
  wire  _zz_184_;
  reg [19:0] execute_MemoryTranslatorPlugin_tlbWriteBuffer;
  wire [33:0] _zz_185_;
  wire  _zz_186_;
  wire  _zz_187_;
  wire  _zz_188_;
  wire  _zz_189_;
  wire  _zz_190_;
  wire  _zz_191_;
  wire  _zz_192_;
  wire  _zz_193_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_194_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_195_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_196_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_197_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_198_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_199_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_200_;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  reg  writeBack_RegFilePlugin_regFileWrite_valid /* verilator public */ ;
  wire [4:0] writeBack_RegFilePlugin_regFileWrite_payload_address /* verilator public */ ;
  wire [31:0] writeBack_RegFilePlugin_regFileWrite_payload_data /* verilator public */ ;
  reg  _zz_201_;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_202_;
  reg [31:0] _zz_203_;
  wire  _zz_204_;
  reg [19:0] _zz_205_;
  wire  _zz_206_;
  reg [19:0] _zz_207_;
  reg [31:0] _zz_208_;
  wire [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  wire [4:0] execute_FullBarrelShifterPlugin_amplitude;
  reg [31:0] _zz_209_;
  wire [31:0] execute_FullBarrelShifterPlugin_reversed;
  reg [31:0] _zz_210_;
  reg  execute_MulPlugin_aSigned;
  reg  execute_MulPlugin_bSigned;
  wire [31:0] execute_MulPlugin_a;
  wire [31:0] execute_MulPlugin_b;
  wire [15:0] execute_MulPlugin_aULow;
  wire [15:0] execute_MulPlugin_bULow;
  wire [16:0] execute_MulPlugin_aSLow;
  wire [16:0] execute_MulPlugin_bSLow;
  wire [16:0] execute_MulPlugin_aHigh;
  wire [16:0] execute_MulPlugin_bHigh;
  wire [65:0] writeBack_MulPlugin_result;
  reg [32:0] memory_DivPlugin_rs1;
  reg [31:0] memory_DivPlugin_rs2;
  reg [64:0] memory_DivPlugin_accumulator;
  reg  memory_DivPlugin_div_needRevert;
  reg  memory_DivPlugin_div_counter_willIncrement;
  reg  memory_DivPlugin_div_counter_willClear;
  reg [5:0] memory_DivPlugin_div_counter_valueNext;
  reg [5:0] memory_DivPlugin_div_counter_value;
  wire  memory_DivPlugin_div_willOverflowIfInc;
  wire  memory_DivPlugin_div_counter_willOverflow;
  reg [31:0] memory_DivPlugin_div_result;
  wire [31:0] _zz_211_;
  wire [32:0] _zz_212_;
  wire [32:0] _zz_213_;
  wire [31:0] _zz_214_;
  wire  _zz_215_;
  wire  _zz_216_;
  reg [32:0] _zz_217_;
  reg  _zz_218_;
  reg  _zz_219_;
  wire  _zz_220_;
  reg  _zz_221_;
  reg [4:0] _zz_222_;
  reg [31:0] _zz_223_;
  wire  _zz_224_;
  wire  _zz_225_;
  wire  _zz_226_;
  wire  _zz_227_;
  wire  _zz_228_;
  wire  _zz_229_;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_230_;
  reg  _zz_231_;
  reg  _zz_232_;
  wire  _zz_233_;
  reg [19:0] _zz_234_;
  wire  _zz_235_;
  reg [10:0] _zz_236_;
  wire  _zz_237_;
  reg [18:0] _zz_238_;
  reg  _zz_239_;
  wire  execute_BranchPlugin_missAlignedTarget;
  reg [31:0] execute_BranchPlugin_branch_src1;
  reg [31:0] execute_BranchPlugin_branch_src2;
  wire  _zz_240_;
  reg [19:0] _zz_241_;
  wire  _zz_242_;
  reg [10:0] _zz_243_;
  wire  _zz_244_;
  reg [18:0] _zz_245_;
  wire [31:0] execute_BranchPlugin_branchAdder;
  wire [1:0] CsrPlugin_misa_base;
  wire [25:0] CsrPlugin_misa_extensions;
  reg [31:0] CsrPlugin_mtvec;
  reg [31:0] CsrPlugin_mepc;
  reg  CsrPlugin_mstatus_MIE;
  reg  CsrPlugin_mstatus_MPIE;
  reg [1:0] CsrPlugin_mstatus_MPP;
  reg  CsrPlugin_mip_MEIP;
  reg  CsrPlugin_mip_MTIP;
  reg  CsrPlugin_mip_MSIP;
  reg  CsrPlugin_mie_MEIE;
  reg  CsrPlugin_mie_MTIE;
  reg  CsrPlugin_mie_MSIE;
  reg [31:0] CsrPlugin_mscratch;
  reg  CsrPlugin_mcause_interrupt;
  reg [3:0] CsrPlugin_mcause_exceptionCode;
  reg [31:0] CsrPlugin_mtval;
  reg [63:0] CsrPlugin_mcycle = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  reg [63:0] CsrPlugin_minstret = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  reg [31:0] CsrPlugin_medeleg;
  reg [31:0] CsrPlugin_mideleg;
  reg  CsrPlugin_sstatus_SIE;
  reg  CsrPlugin_sstatus_SPIE;
  reg [0:0] CsrPlugin_sstatus_SPP;
  reg  CsrPlugin_sip_SEIP;
  reg  CsrPlugin_sip_STIP;
  reg  CsrPlugin_sip_SSIP;
  reg  CsrPlugin_sie_SEIE;
  reg  CsrPlugin_sie_STIE;
  reg  CsrPlugin_sie_SSIE;
  reg [31:0] CsrPlugin_stvec;
  reg [31:0] CsrPlugin_sscratch;
  reg  CsrPlugin_scause_interrupt;
  reg [3:0] CsrPlugin_scause_exceptionCode;
  reg [31:0] CsrPlugin_stval;
  reg [31:0] CsrPlugin_sepc;
  reg [21:0] CsrPlugin_satp_PPN;
  reg [8:0] CsrPlugin_satp_ASID;
  reg [0:0] CsrPlugin_satp_MODE;
  wire  _zz_246_;
  wire  _zz_247_;
  wire  _zz_248_;
  wire  _zz_249_;
  wire  _zz_250_;
  wire  _zz_251_;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg [3:0] CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg [31:0] CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  reg [1:0] CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
  wire  decode_exception_agregat_valid;
  wire [3:0] decode_exception_agregat_payload_code;
  wire [31:0] decode_exception_agregat_payload_badAddr;
  wire [1:0] _zz_252_;
  wire  _zz_253_;
  reg  CsrPlugin_interrupt;
  reg [3:0] CsrPlugin_interruptCode /* verilator public */ ;
  reg [1:0] CsrPlugin_interruptTargetPrivilege;
  reg [1:0] _zz_254_;
  reg [1:0] _zz_255_;
  reg [1:0] _zz_256_;
  wire  CsrPlugin_exception;
  reg  CsrPlugin_writeBackWasWfi;
  reg  CsrPlugin_pipelineLiberator_done;
  wire  CsrPlugin_interruptJump /* verilator public */ ;
  reg  CsrPlugin_hadException;
  reg [1:0] CsrPlugin_targetPrivilege;
  reg [3:0] CsrPlugin_trapCause;
  wire  execute_CsrPlugin_blockedBySideEffects;
  reg  execute_CsrPlugin_illegalAccess;
  reg  execute_CsrPlugin_illegalInstruction;
  reg [31:0] execute_CsrPlugin_readData;
  reg [31:0] execute_CsrPlugin_writeData;
  wire  execute_CsrPlugin_writeInstruction;
  wire  execute_CsrPlugin_readInstruction;
  wire  execute_CsrPlugin_writeEnable;
  wire  execute_CsrPlugin_readEnable;
  wire [11:0] execute_CsrPlugin_csrAddress;
  reg [31:0] _zz_257_;
  reg [31:0] externalInterruptArray_regNext;
  wire [31:0] _zz_258_;
  reg  DebugPlugin_firstCycle;
  reg  DebugPlugin_secondCycle;
  reg  DebugPlugin_resetIt;
  reg  DebugPlugin_haltIt;
  reg  DebugPlugin_stepIt;
  reg  DebugPlugin_isPipActive;
  reg  DebugPlugin_isPipActive_regNext;
  wire  DebugPlugin_isPipBusy;
  reg  DebugPlugin_haltedByBreak;
  reg [31:0] DebugPlugin_busReadDataReg;
  reg  _zz_259_;
  reg  DebugPlugin_resetIt_regNext;
  reg [31:0] decode_to_execute_INSTRUCTION;
  reg [31:0] execute_to_memory_INSTRUCTION;
  reg [31:0] memory_to_writeBack_INSTRUCTION;
  reg  decode_to_execute_SRC_LESS_UNSIGNED;
  reg [31:0] execute_to_memory_BRANCH_CALC;
  reg  decode_to_execute_MEMORY_MANAGMENT;
  reg  decode_to_execute_IS_RS2_SIGNED;
  reg `AluBitwiseCtrlEnum_defaultEncoding_type decode_to_execute_ALU_BITWISE_CTRL;
  reg  decode_to_execute_CSR_WRITE_OPCODE;
  reg  decode_to_execute_IS_RS1_SIGNED;
  reg [31:0] execute_to_memory_REGFILE_WRITE_DATA;
  reg [31:0] memory_to_writeBack_REGFILE_WRITE_DATA;
  reg [31:0] execute_to_memory_MUL_LL;
  reg [51:0] memory_to_writeBack_MUL_LOW;
  reg [31:0] decode_to_execute_RS2;
  reg  decode_to_execute_FLUSH_ALL;
  reg  execute_to_memory_FLUSH_ALL;
  reg [33:0] execute_to_memory_MUL_LH;
  reg [33:0] execute_to_memory_MUL_HH;
  reg [33:0] memory_to_writeBack_MUL_HH;
  reg  decode_to_execute_SRC_USE_SUB_LESS;
  reg  decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  reg  decode_to_execute_IS_MUL;
  reg  execute_to_memory_IS_MUL;
  reg  memory_to_writeBack_IS_MUL;
  reg  decode_to_execute_REGFILE_WRITE_VALID;
  reg  execute_to_memory_REGFILE_WRITE_VALID;
  reg  memory_to_writeBack_REGFILE_WRITE_VALID;
  reg  execute_to_memory_BRANCH_DO;
  reg [1:0] execute_to_memory_MEMORY_ADDRESS_LOW;
  reg [1:0] memory_to_writeBack_MEMORY_ADDRESS_LOW;
  reg  decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  reg  execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  reg `ShiftCtrlEnum_defaultEncoding_type decode_to_execute_SHIFT_CTRL;
  reg `ShiftCtrlEnum_defaultEncoding_type execute_to_memory_SHIFT_CTRL;
  reg  decode_to_execute_DO_EBREAK;
  reg  decode_to_execute_IS_CSR;
  reg [31:0] execute_to_memory_SHIFT_RIGHT;
  reg  decode_to_execute_IS_FENCEI;
  reg [33:0] execute_to_memory_MUL_HL;
  reg  decode_to_execute_PREDICTION_HAD_BRANCHED2;
  reg  decode_to_execute_CSR_READ_OPCODE;
  reg `Src2CtrlEnum_defaultEncoding_type decode_to_execute_SRC2_CTRL;
  reg  decode_to_execute_IS_DIV;
  reg  execute_to_memory_IS_DIV;
  reg [31:0] decode_to_execute_FORMAL_PC_NEXT;
  reg [31:0] execute_to_memory_FORMAL_PC_NEXT;
  reg [31:0] memory_to_writeBack_FORMAL_PC_NEXT;
  reg `BranchCtrlEnum_defaultEncoding_type decode_to_execute_BRANCH_CTRL;
  reg `EnvCtrlEnum_defaultEncoding_type decode_to_execute_ENV_CTRL;
  reg `EnvCtrlEnum_defaultEncoding_type execute_to_memory_ENV_CTRL;
  reg `EnvCtrlEnum_defaultEncoding_type memory_to_writeBack_ENV_CTRL;
  reg `AluCtrlEnum_defaultEncoding_type decode_to_execute_ALU_CTRL;
  reg [31:0] decode_to_execute_RS1;
  reg  decode_to_execute_MEMORY_WR;
  reg  execute_to_memory_MEMORY_WR;
  reg  memory_to_writeBack_MEMORY_WR;
  reg [31:0] decode_to_execute_PC;
  reg [31:0] execute_to_memory_PC;
  reg [31:0] memory_to_writeBack_PC;
  reg  decode_to_execute_IS_TLB;
  reg `Src1CtrlEnum_defaultEncoding_type decode_to_execute_SRC1_CTRL;
  reg  decode_to_execute_MEMORY_ENABLE;
  reg  execute_to_memory_MEMORY_ENABLE;
  reg  memory_to_writeBack_MEMORY_ENABLE;
  reg [2:0] _zz_260_;
  reg [31:0] _zz_261_;
  reg [2:0] _zz_262_;
  reg  _zz_263_;
  reg [31:0] iBusWishbone_DAT_MISO_regNext;
  reg [2:0] _zz_264_;
  wire  _zz_265_;
  wire  _zz_266_;
  wire  _zz_267_;
  wire  _zz_268_;
  wire  _zz_269_;
  reg  _zz_270_;
  reg [31:0] dBusWishbone_DAT_MISO_regNext;
  reg  _zz_271_;
  reg [44:0] MemoryTranslatorPlugin_shared_cache [0:255];
  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign _zz_358_ = (memory_arbitration_isValid && memory_IS_DIV);
  assign _zz_359_ = (! memory_DivPlugin_div_willOverflowIfInc);
  assign _zz_360_ = (execute_arbitration_isFiring && execute_IS_TLB);
  assign _zz_361_ = execute_INSTRUCTION[26 : 25];
  assign _zz_362_ = (execute_arbitration_isValid && execute_DO_EBREAK);
  assign _zz_363_ = ((memory_arbitration_isValid || writeBack_arbitration_isValid) == 1'b0);
  assign _zz_364_ = (DebugPlugin_stepIt && _zz_106_);
  assign _zz_365_ = (CsrPlugin_hadException || (CsrPlugin_interruptJump && (! CsrPlugin_exception)));
  assign _zz_366_ = (writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET));
  assign _zz_367_ = writeBack_INSTRUCTION[29 : 28];
  assign _zz_368_ = (IBusCachedPlugin_fetchPc_preOutput_valid && IBusCachedPlugin_fetchPc_preOutput_ready);
  assign _zz_369_ = MemoryTranslatorPlugin_ports_0_sharedAccessed[1];
  assign _zz_370_ = (MemoryTranslatorPlugin_shared_readData_virtualAddress == _zz_124_[31 : 12]);
  assign _zz_371_ = MemoryTranslatorPlugin_ports_1_sharedAccessed[1];
  assign _zz_372_ = (MemoryTranslatorPlugin_shared_readData_virtualAddress == _zz_114_[31 : 12]);
  assign _zz_373_ = (! memory_arbitration_isStuck);
  assign _zz_374_ = debug_bus_cmd_payload_address[7 : 2];
  assign _zz_375_ = (iBus_cmd_valid || (_zz_262_ != (3'b000)));
  assign _zz_376_ = writeBack_INSTRUCTION[13 : 12];
  assign _zz_377_ = execute_INSTRUCTION[13 : 12];
  assign _zz_378_ = writeBack_INSTRUCTION[13 : 12];
  assign _zz_379_ = execute_INSTRUCTION[13];
  assign _zz_380_ = (_zz_141_ - (4'b0001));
  assign _zz_381_ = {IBusCachedPlugin_fetchPc_inc,(2'b00)};
  assign _zz_382_ = {29'd0, _zz_381_};
  assign _zz_383_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_384_ = {{_zz_158_,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_385_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz_386_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_387_ = (writeBack_MEMORY_WR ? (3'b111) : (3'b101));
  assign _zz_388_ = (writeBack_MEMORY_WR ? (3'b110) : (3'b100));
  assign _zz_389_ = _zz_168_[0 : 0];
  assign _zz_390_ = _zz_168_[41 : 41];
  assign _zz_391_ = _zz_168_[42 : 42];
  assign _zz_392_ = _zz_168_[43 : 43];
  assign _zz_393_ = _zz_168_[44 : 44];
  assign _zz_394_ = MemoryTranslatorPlugin_ports_0_entryToReplace_willIncrement;
  assign _zz_395_ = {1'd0, _zz_394_};
  assign _zz_396_ = {MemoryTranslatorPlugin_ports_0_sharedAccessed,MemoryTranslatorPlugin_ports_0_sharedAccessGranted};
  assign _zz_397_ = MemoryTranslatorPlugin_ports_1_entryToReplace_willIncrement;
  assign _zz_398_ = {1'd0, _zz_397_};
  assign _zz_399_ = {MemoryTranslatorPlugin_ports_1_sharedAccessed,MemoryTranslatorPlugin_ports_1_sharedAccessGranted};
  assign _zz_400_ = execute_SRC1;
  assign _zz_401_ = _zz_185_[0 : 0];
  assign _zz_402_ = _zz_185_[1 : 1];
  assign _zz_403_ = _zz_185_[2 : 2];
  assign _zz_404_ = _zz_185_[3 : 3];
  assign _zz_405_ = _zz_185_[4 : 4];
  assign _zz_406_ = _zz_185_[5 : 5];
  assign _zz_407_ = _zz_185_[6 : 6];
  assign _zz_408_ = _zz_185_[8 : 8];
  assign _zz_409_ = _zz_185_[11 : 11];
  assign _zz_410_ = _zz_185_[12 : 12];
  assign _zz_411_ = _zz_185_[13 : 13];
  assign _zz_412_ = _zz_185_[14 : 14];
  assign _zz_413_ = _zz_185_[15 : 15];
  assign _zz_414_ = _zz_185_[16 : 16];
  assign _zz_415_ = _zz_185_[21 : 21];
  assign _zz_416_ = _zz_185_[22 : 22];
  assign _zz_417_ = _zz_185_[23 : 23];
  assign _zz_418_ = _zz_185_[24 : 24];
  assign _zz_419_ = _zz_185_[31 : 31];
  assign _zz_420_ = execute_SRC_LESS;
  assign _zz_421_ = (3'b100);
  assign _zz_422_ = execute_INSTRUCTION[19 : 15];
  assign _zz_423_ = execute_INSTRUCTION[31 : 20];
  assign _zz_424_ = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_425_ = ($signed(_zz_426_) + $signed(_zz_430_));
  assign _zz_426_ = ($signed(_zz_427_) + $signed(_zz_428_));
  assign _zz_427_ = execute_SRC1;
  assign _zz_428_ = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_429_ = (execute_SRC_USE_SUB_LESS ? _zz_431_ : _zz_432_);
  assign _zz_430_ = {{30{_zz_429_[1]}}, _zz_429_};
  assign _zz_431_ = (2'b01);
  assign _zz_432_ = (2'b00);
  assign _zz_433_ = ($signed(_zz_435_) >>> execute_FullBarrelShifterPlugin_amplitude);
  assign _zz_434_ = _zz_433_[31 : 0];
  assign _zz_435_ = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_defaultEncoding_SRA_1) && execute_FullBarrelShifterPlugin_reversed[31]),execute_FullBarrelShifterPlugin_reversed};
  assign _zz_436_ = ($signed(_zz_437_) + $signed(_zz_442_));
  assign _zz_437_ = ($signed(_zz_438_) + $signed(_zz_440_));
  assign _zz_438_ = (52'b0000000000000000000000000000000000000000000000000000);
  assign _zz_439_ = {1'b0,memory_MUL_LL};
  assign _zz_440_ = {{19{_zz_439_[32]}}, _zz_439_};
  assign _zz_441_ = ({16'd0,memory_MUL_LH} <<< 16);
  assign _zz_442_ = {{2{_zz_441_[49]}}, _zz_441_};
  assign _zz_443_ = ({16'd0,memory_MUL_HL} <<< 16);
  assign _zz_444_ = {{2{_zz_443_[49]}}, _zz_443_};
  assign _zz_445_ = {{14{writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
  assign _zz_446_ = ({32'd0,writeBack_MUL_HH} <<< 32);
  assign _zz_447_ = writeBack_MUL_LOW[31 : 0];
  assign _zz_448_ = writeBack_MulPlugin_result[63 : 32];
  assign _zz_449_ = memory_DivPlugin_div_counter_willIncrement;
  assign _zz_450_ = {5'd0, _zz_449_};
  assign _zz_451_ = {1'd0, memory_DivPlugin_rs2};
  assign _zz_452_ = {_zz_211_,(! _zz_213_[32])};
  assign _zz_453_ = _zz_213_[31:0];
  assign _zz_454_ = _zz_212_[31:0];
  assign _zz_455_ = _zz_456_;
  assign _zz_456_ = _zz_457_;
  assign _zz_457_ = ({1'b0,(memory_DivPlugin_div_needRevert ? (~ _zz_214_) : _zz_214_)} + _zz_459_);
  assign _zz_458_ = memory_DivPlugin_div_needRevert;
  assign _zz_459_ = {32'd0, _zz_458_};
  assign _zz_460_ = _zz_216_;
  assign _zz_461_ = {32'd0, _zz_460_};
  assign _zz_462_ = _zz_215_;
  assign _zz_463_ = {31'd0, _zz_462_};
  assign _zz_464_ = execute_INSTRUCTION[31 : 20];
  assign _zz_465_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_466_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_467_ = {_zz_234_,execute_INSTRUCTION[31 : 20]};
  assign _zz_468_ = {{_zz_236_,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
  assign _zz_469_ = {{_zz_238_,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_470_ = execute_INSTRUCTION[31 : 20];
  assign _zz_471_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_472_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_473_ = (3'b100);
  assign _zz_474_ = (_zz_252_ & (~ _zz_475_));
  assign _zz_475_ = (_zz_252_ - (2'b01));
  assign _zz_476_ = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_477_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_478_ = execute_CsrPlugin_writeData[31 : 31];
  assign _zz_479_ = execute_CsrPlugin_writeData[5 : 5];
  assign _zz_480_ = execute_CsrPlugin_writeData[1 : 1];
  assign _zz_481_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_482_ = execute_CsrPlugin_writeData[1 : 1];
  assign _zz_483_ = execute_CsrPlugin_writeData[11 : 11];
  assign _zz_484_ = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_485_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_486_ = execute_CsrPlugin_writeData[31 : 31];
  assign _zz_487_ = execute_CsrPlugin_writeData[9 : 9];
  assign _zz_488_ = execute_CsrPlugin_writeData[5 : 5];
  assign _zz_489_ = execute_CsrPlugin_writeData[1 : 1];
  assign _zz_490_ = (iBus_cmd_payload_address >>> 5);
  assign _zz_491_ = 1'b1;
  assign _zz_492_ = execute_SRC1[7 : 0];
  assign _zz_493_ = {execute_RS2[27],{execute_RS2[30],{execute_RS2[29],{execute_RS2[28],{execute_RS2[19 : 0],{execute_MemoryTranslatorPlugin_tlbWriteBuffer,execute_RS2[31]}}}}}};
  assign _zz_494_ = 1'b1;
  assign _zz_495_ = 1'b1;
  assign _zz_496_ = {_zz_145_,_zz_144_};
  assign _zz_497_ = decode_INSTRUCTION[31];
  assign _zz_498_ = decode_INSTRUCTION[19 : 12];
  assign _zz_499_ = decode_INSTRUCTION[20];
  assign _zz_500_ = decode_INSTRUCTION[31];
  assign _zz_501_ = decode_INSTRUCTION[7];
  assign _zz_502_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001110000)) == (32'b00000000000000000000000000100000));
  assign _zz_503_ = ((decode_INSTRUCTION & _zz_511_) == (32'b00000000000000000000000000000100));
  assign _zz_504_ = _zz_186_;
  assign _zz_505_ = ((decode_INSTRUCTION & (32'b00000000000000000101000001001000)) == (32'b00000000000000000001000000001000));
  assign _zz_506_ = {(_zz_512_ == _zz_513_),{_zz_193_,_zz_191_}};
  assign _zz_507_ = (3'b000);
  assign _zz_508_ = ({_zz_193_,{_zz_514_,_zz_515_}} != (3'b000));
  assign _zz_509_ = ({_zz_516_,_zz_517_} != (3'b000));
  assign _zz_510_ = {(_zz_518_ != _zz_519_),{_zz_520_,{_zz_521_,_zz_522_}}};
  assign _zz_511_ = (32'b00000000000000000100000000000100);
  assign _zz_512_ = (decode_INSTRUCTION & (32'b00000000000000000001000000000000));
  assign _zz_513_ = (32'b00000000000000000001000000000000);
  assign _zz_514_ = _zz_191_;
  assign _zz_515_ = ((decode_INSTRUCTION & _zz_523_) == (32'b00000000000000000010000000000000));
  assign _zz_516_ = _zz_190_;
  assign _zz_517_ = {(_zz_524_ == _zz_525_),(_zz_526_ == _zz_527_)};
  assign _zz_518_ = ((decode_INSTRUCTION & _zz_528_) == (32'b00000000000000000010000000010000));
  assign _zz_519_ = (1'b0);
  assign _zz_520_ = ({_zz_188_,{_zz_529_,_zz_530_}} != (3'b000));
  assign _zz_521_ = (_zz_531_ != (1'b0));
  assign _zz_522_ = {(_zz_532_ != _zz_533_),{_zz_534_,{_zz_535_,_zz_536_}}};
  assign _zz_523_ = (32'b00000000000000000011000000000000);
  assign _zz_524_ = (decode_INSTRUCTION & (32'b00000000000000000000000001100100));
  assign _zz_525_ = (32'b00000000000000000000000000100100);
  assign _zz_526_ = (decode_INSTRUCTION & (32'b00000000000000000100000000010100));
  assign _zz_527_ = (32'b00000000000000000100000000010000);
  assign _zz_528_ = (32'b00000000000000000110000001010100);
  assign _zz_529_ = ((decode_INSTRUCTION & _zz_537_) == (32'b00000000000000000001000000001000));
  assign _zz_530_ = ((decode_INSTRUCTION & _zz_538_) == (32'b00000000000000000000000000000100));
  assign _zz_531_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001011000)) == (32'b00000000000000000000000001000000));
  assign _zz_532_ = {(_zz_539_ == _zz_540_),{_zz_541_,{_zz_542_,_zz_543_}}};
  assign _zz_533_ = (5'b00000);
  assign _zz_534_ = ({_zz_544_,_zz_545_} != (2'b00));
  assign _zz_535_ = (_zz_546_ != (1'b0));
  assign _zz_536_ = {(_zz_547_ != _zz_548_),{_zz_549_,{_zz_550_,_zz_551_}}};
  assign _zz_537_ = (32'b00000000000000000101000000001000);
  assign _zz_538_ = (32'b00000000000000000000000000011100);
  assign _zz_539_ = (decode_INSTRUCTION & (32'b00000000000000000000000000110100));
  assign _zz_540_ = (32'b00000000000000000000000000100000);
  assign _zz_541_ = ((decode_INSTRUCTION & _zz_552_) == (32'b00000000000000000000000000100000));
  assign _zz_542_ = (_zz_553_ == _zz_554_);
  assign _zz_543_ = {_zz_555_,_zz_556_};
  assign _zz_544_ = ((decode_INSTRUCTION & _zz_557_) == (32'b00000000000000000010000000000000));
  assign _zz_545_ = ((decode_INSTRUCTION & _zz_558_) == (32'b00000000000000000001000000000000));
  assign _zz_546_ = ((decode_INSTRUCTION & _zz_559_) == (32'b00000000000100000000000001010000));
  assign _zz_547_ = (_zz_560_ == _zz_561_);
  assign _zz_548_ = (1'b0);
  assign _zz_549_ = ({_zz_562_,_zz_563_} != (3'b000));
  assign _zz_550_ = (_zz_564_ != _zz_565_);
  assign _zz_551_ = {_zz_566_,{_zz_567_,_zz_568_}};
  assign _zz_552_ = (32'b00000000000000000000000001100100);
  assign _zz_553_ = (decode_INSTRUCTION & (32'b00000010000000000011000001010000));
  assign _zz_554_ = (32'b00000010000000000011000000000000);
  assign _zz_555_ = ((decode_INSTRUCTION & (32'b00000000000000000111000001001000)) == (32'b00000000000000000101000000001000));
  assign _zz_556_ = ((decode_INSTRUCTION & (32'b00000100000000000011000001010000)) == (32'b00000100000000000011000000000000));
  assign _zz_557_ = (32'b00000000000000000010000000010000);
  assign _zz_558_ = (32'b00000000000000000101000000000000);
  assign _zz_559_ = (32'b00010000000100000011000001010000);
  assign _zz_560_ = (decode_INSTRUCTION & (32'b00000010000000000100000001110100));
  assign _zz_561_ = (32'b00000010000000000000000000110000);
  assign _zz_562_ = _zz_188_;
  assign _zz_563_ = {_zz_192_,(_zz_569_ == _zz_570_)};
  assign _zz_564_ = {_zz_192_,(_zz_571_ == _zz_572_)};
  assign _zz_565_ = (2'b00);
  assign _zz_566_ = ({_zz_573_,_zz_574_} != (2'b00));
  assign _zz_567_ = ({_zz_575_,_zz_576_} != (3'b000));
  assign _zz_568_ = {(_zz_577_ != _zz_578_),{_zz_579_,{_zz_580_,_zz_581_}}};
  assign _zz_569_ = (decode_INSTRUCTION & (32'b00000000000000000100000000010100));
  assign _zz_570_ = (32'b00000000000000000000000000000100);
  assign _zz_571_ = (decode_INSTRUCTION & (32'b00000000000000000000000001001100));
  assign _zz_572_ = (32'b00000000000000000000000000000100);
  assign _zz_573_ = ((decode_INSTRUCTION & (32'b00000000000000000111000000110100)) == (32'b00000000000000000101000000010000));
  assign _zz_574_ = ((decode_INSTRUCTION & (32'b00000010000000000111000001100100)) == (32'b00000000000000000101000000100000));
  assign _zz_575_ = ((decode_INSTRUCTION & _zz_582_) == (32'b01000000000000000001000000010000));
  assign _zz_576_ = {(_zz_583_ == _zz_584_),(_zz_585_ == _zz_586_)};
  assign _zz_577_ = ((decode_INSTRUCTION & _zz_587_) == (32'b00000000000000000000000000100000));
  assign _zz_578_ = (1'b0);
  assign _zz_579_ = ((_zz_588_ == _zz_589_) != (1'b0));
  assign _zz_580_ = ({_zz_590_,_zz_591_} != (5'b00000));
  assign _zz_581_ = {(_zz_592_ != _zz_593_),{_zz_594_,{_zz_595_,_zz_596_}}};
  assign _zz_582_ = (32'b01000000000000000011000001010100);
  assign _zz_583_ = (decode_INSTRUCTION & (32'b00000000000000000111000000110100));
  assign _zz_584_ = (32'b00000000000000000001000000010000);
  assign _zz_585_ = (decode_INSTRUCTION & (32'b00000010000000000111000001010100));
  assign _zz_586_ = (32'b00000000000000000001000000010000);
  assign _zz_587_ = (32'b00000000000000000000000000100000);
  assign _zz_588_ = (decode_INSTRUCTION & (32'b00000010000000000100000001100100));
  assign _zz_589_ = (32'b00000010000000000100000000100000);
  assign _zz_590_ = _zz_191_;
  assign _zz_591_ = {(_zz_597_ == _zz_598_),{_zz_599_,{_zz_600_,_zz_601_}}};
  assign _zz_592_ = _zz_189_;
  assign _zz_593_ = (1'b0);
  assign _zz_594_ = ({_zz_191_,{_zz_602_,_zz_603_}} != (4'b0000));
  assign _zz_595_ = (_zz_604_ != (1'b0));
  assign _zz_596_ = {(_zz_605_ != _zz_606_),{_zz_607_,{_zz_608_,_zz_609_}}};
  assign _zz_597_ = (decode_INSTRUCTION & (32'b00000000000000000010000000110000));
  assign _zz_598_ = (32'b00000000000000000010000000010000);
  assign _zz_599_ = ((decode_INSTRUCTION & _zz_610_) == (32'b00000000000000000010000000100000));
  assign _zz_600_ = (_zz_611_ == _zz_612_);
  assign _zz_601_ = (_zz_613_ == _zz_614_);
  assign _zz_602_ = (_zz_615_ == _zz_616_);
  assign _zz_603_ = {_zz_617_,_zz_618_};
  assign _zz_604_ = ((decode_INSTRUCTION & _zz_619_) == (32'b00000000000000000011000000000000));
  assign _zz_605_ = {_zz_620_,_zz_621_};
  assign _zz_606_ = (2'b00);
  assign _zz_607_ = (_zz_622_ != (1'b0));
  assign _zz_608_ = (_zz_623_ != _zz_624_);
  assign _zz_609_ = {_zz_625_,{_zz_626_,_zz_627_}};
  assign _zz_610_ = (32'b00000010000000000010000000100000);
  assign _zz_611_ = (decode_INSTRUCTION & (32'b00000010000000000001000000100000));
  assign _zz_612_ = (32'b00000000000000000000000000100000);
  assign _zz_613_ = (decode_INSTRUCTION & (32'b00000000000000000001000000110000));
  assign _zz_614_ = (32'b00000000000000000000000000010000);
  assign _zz_615_ = (decode_INSTRUCTION & (32'b00000000000000000100000000100000));
  assign _zz_616_ = (32'b00000000000000000100000000100000);
  assign _zz_617_ = ((decode_INSTRUCTION & _zz_628_) == (32'b00000000000000000000000000010000));
  assign _zz_618_ = ((decode_INSTRUCTION & _zz_629_) == (32'b00000000000000000000000000100000));
  assign _zz_619_ = (32'b00000000000000000011000001010000);
  assign _zz_620_ = ((decode_INSTRUCTION & _zz_630_) == (32'b00010000000000000000000001010000));
  assign _zz_621_ = ((decode_INSTRUCTION & _zz_631_) == (32'b00000000000000000000000001010000));
  assign _zz_622_ = ((decode_INSTRUCTION & _zz_632_) == (32'b00000000000000000000000001010000));
  assign _zz_623_ = (_zz_633_ == _zz_634_);
  assign _zz_624_ = (1'b0);
  assign _zz_625_ = ({_zz_635_,_zz_636_} != (6'b000000));
  assign _zz_626_ = (_zz_637_ != _zz_638_);
  assign _zz_627_ = {_zz_639_,{_zz_640_,_zz_641_}};
  assign _zz_628_ = (32'b00000000000000000000000000110000);
  assign _zz_629_ = (32'b00000010000000000000000000100000);
  assign _zz_630_ = (32'b00010000001000000011000001010000);
  assign _zz_631_ = (32'b00010000000100000011000001010000);
  assign _zz_632_ = (32'b00000000000100000011000001010000);
  assign _zz_633_ = (decode_INSTRUCTION & (32'b00000000000000000101000001001000));
  assign _zz_634_ = (32'b00000000000000000100000000001000);
  assign _zz_635_ = ((decode_INSTRUCTION & _zz_642_) == (32'b00000000000000000010000001000000));
  assign _zz_636_ = {(_zz_643_ == _zz_644_),{_zz_645_,{_zz_646_,_zz_647_}}};
  assign _zz_637_ = {(_zz_648_ == _zz_649_),(_zz_650_ == _zz_651_)};
  assign _zz_638_ = (2'b00);
  assign _zz_639_ = ({_zz_190_,{_zz_652_,_zz_653_}} != (3'b000));
  assign _zz_640_ = (_zz_189_ != (1'b0));
  assign _zz_641_ = {(_zz_654_ != _zz_655_),{_zz_656_,{_zz_657_,_zz_658_}}};
  assign _zz_642_ = (32'b00000000000000000010000001000000);
  assign _zz_643_ = (decode_INSTRUCTION & (32'b00000000000000000001000001000000));
  assign _zz_644_ = (32'b00000000000000000001000001000000);
  assign _zz_645_ = ((decode_INSTRUCTION & _zz_659_) == (32'b00000000000000000000000001000000));
  assign _zz_646_ = (_zz_660_ == _zz_661_);
  assign _zz_647_ = {_zz_662_,_zz_663_};
  assign _zz_648_ = (decode_INSTRUCTION & (32'b00000000000000000001000001010000));
  assign _zz_649_ = (32'b00000000000000000001000001010000);
  assign _zz_650_ = (decode_INSTRUCTION & (32'b00000000000000000010000001010000));
  assign _zz_651_ = (32'b00000000000000000010000001010000);
  assign _zz_652_ = (_zz_664_ == _zz_665_);
  assign _zz_653_ = (_zz_666_ == _zz_667_);
  assign _zz_654_ = {_zz_188_,{_zz_668_,_zz_669_}};
  assign _zz_655_ = (6'b000000);
  assign _zz_656_ = (_zz_670_ != (1'b0));
  assign _zz_657_ = (_zz_671_ != _zz_672_);
  assign _zz_658_ = (_zz_673_ != _zz_674_);
  assign _zz_659_ = (32'b00000000000100000000000001000000);
  assign _zz_660_ = (decode_INSTRUCTION & (32'b00000000000000000000000001010000));
  assign _zz_661_ = (32'b00000000000000000000000001000000);
  assign _zz_662_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000111000)) == (32'b00000000000000000000000000000000));
  assign _zz_663_ = ((decode_INSTRUCTION & (32'b00000000000000000101000000110000)) == (32'b00000000000000000001000000000000));
  assign _zz_664_ = (decode_INSTRUCTION & (32'b01000000000000000000000000110000));
  assign _zz_665_ = (32'b01000000000000000000000000110000);
  assign _zz_666_ = (decode_INSTRUCTION & (32'b00000000000000000010000000010100));
  assign _zz_667_ = (32'b00000000000000000010000000010000);
  assign _zz_668_ = ((decode_INSTRUCTION & _zz_675_) == (32'b00000000000000000001000000010000));
  assign _zz_669_ = {(_zz_676_ == _zz_677_),{_zz_678_,{_zz_679_,_zz_680_}}};
  assign _zz_670_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000001000)) == (32'b00000000000000000000000000001000));
  assign _zz_671_ = {(_zz_681_ == _zz_682_),(_zz_683_ == _zz_684_)};
  assign _zz_672_ = (2'b00);
  assign _zz_673_ = {(_zz_685_ == _zz_686_),{_zz_687_,{_zz_688_,_zz_689_}}};
  assign _zz_674_ = (5'b00000);
  assign _zz_675_ = (32'b00000000000000000001000000010000);
  assign _zz_676_ = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_677_ = (32'b00000000000000000010000000010000);
  assign _zz_678_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000000010000));
  assign _zz_679_ = _zz_187_;
  assign _zz_680_ = _zz_186_;
  assign _zz_681_ = (decode_INSTRUCTION & (32'b00000000000000000000000001011000));
  assign _zz_682_ = (32'b00000000000000000000000000000000);
  assign _zz_683_ = (decode_INSTRUCTION & (32'b00000000000000000111000001010000));
  assign _zz_684_ = (32'b00000000000000000101000000000000);
  assign _zz_685_ = (decode_INSTRUCTION & (32'b00000000000000000000000001000100));
  assign _zz_686_ = (32'b00000000000000000000000000000000);
  assign _zz_687_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000011000)) == (32'b00000000000000000000000000000000));
  assign _zz_688_ = ((decode_INSTRUCTION & (32'b00000000000000000110000000000100)) == (32'b00000000000000000010000000000000));
  assign _zz_689_ = {((decode_INSTRUCTION & (32'b00000000000000000101000000000100)) == (32'b00000000000000000001000000000000)),((decode_INSTRUCTION & (32'b00000000000000000101000001010000)) == (32'b00000000000000000101000000000000))};
  assign _zz_690_ = (32'b00000000000000000001000001111111);
  assign _zz_691_ = (decode_INSTRUCTION & (32'b00000000000000000010000001111111));
  assign _zz_692_ = (32'b00000000000000000010000001110011);
  assign _zz_693_ = ((decode_INSTRUCTION & (32'b00000000000000000100000001111111)) == (32'b00000000000000000100000001100011));
  assign _zz_694_ = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000010000000010011));
  assign _zz_695_ = {((decode_INSTRUCTION & (32'b00000000000000000110000000111111)) == (32'b00000000000000000000000000100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_696_) == (32'b00000000000000000000000000000011)),{(_zz_697_ == _zz_698_),{_zz_699_,{_zz_700_,_zz_701_}}}}}};
  assign _zz_696_ = (32'b00000000000000000101000001011111);
  assign _zz_697_ = (decode_INSTRUCTION & (32'b00000000000000000111000001111011));
  assign _zz_698_ = (32'b00000000000000000000000001100011);
  assign _zz_699_ = ((decode_INSTRUCTION & (32'b00000000000000000011000001111111)) == (32'b00000000000000000000000000001111));
  assign _zz_700_ = ((decode_INSTRUCTION & (32'b11111100000000000000000001111111)) == (32'b00000000000000000000000000110011));
  assign _zz_701_ = {((decode_INSTRUCTION & (32'b00000001111100000111000001111111)) == (32'b00000000000000000101000000001111)),{((decode_INSTRUCTION & (32'b10111100000000000111000001111111)) == (32'b00000000000000000101000000010011)),{((decode_INSTRUCTION & _zz_702_) == (32'b00000000000000000001000000010011)),{(_zz_703_ == _zz_704_),{_zz_705_,{_zz_706_,_zz_707_}}}}}};
  assign _zz_702_ = (32'b11111100000000000011000001111111);
  assign _zz_703_ = (decode_INSTRUCTION & (32'b11111100000000000111000001111111));
  assign _zz_704_ = (32'b00000000000000000111000000001111);
  assign _zz_705_ = ((decode_INSTRUCTION & (32'b11111010000000000111000001111111)) == (32'b00000000000000000111000000001111));
  assign _zz_706_ = ((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000101000000110011));
  assign _zz_707_ = {((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000000000000110011)),{((decode_INSTRUCTION & (32'b11011111111111111111111111111111)) == (32'b00010000001000000000000001110011)),{((decode_INSTRUCTION & _zz_708_) == (32'b00000000000000000000000001110011)),{(_zz_709_ == _zz_710_),(_zz_711_ == _zz_712_)}}}};
  assign _zz_708_ = (32'b11111111111011111111111111111111);
  assign _zz_709_ = (decode_INSTRUCTION & (32'b11111111111111111111111111111111));
  assign _zz_710_ = (32'b00010000010100000000000001110011);
  assign _zz_711_ = (decode_INSTRUCTION & (32'b11111111111111111111111111111111));
  assign _zz_712_ = (32'b00000000000000000001000000001111);
  assign _zz_713_ = execute_INSTRUCTION[31];
  assign _zz_714_ = execute_INSTRUCTION[31];
  assign _zz_715_ = execute_INSTRUCTION[7];
  always @ (posedge clk) begin
    if(_zz_92_) begin
      MemoryTranslatorPlugin_shared_cache[_zz_492_] <= _zz_493_;
    end
  end

  always @ (posedge clk) begin
    if(_zz_491_) begin
      _zz_289_ <= MemoryTranslatorPlugin_shared_cache[MemoryTranslatorPlugin_shared_readAddr];
    end
  end

  always @ (posedge clk) begin
    if(_zz_62_) begin
      RegFilePlugin_regFile[writeBack_RegFilePlugin_regFileWrite_payload_address] <= writeBack_RegFilePlugin_regFileWrite_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_494_) begin
      _zz_290_ <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clk) begin
    if(_zz_495_) begin
      _zz_291_ <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  InstructionCache IBusCachedPlugin_cache ( 
    .io_flush_cmd_valid(_zz_272_),
    .io_flush_cmd_ready(_zz_307_),
    .io_flush_rsp(_zz_308_),
    .io_cpu_prefetch_isValid(IBusCachedPlugin_iBusRsp_stages_0_input_valid),
    .io_cpu_prefetch_haltIt(_zz_309_),
    .io_cpu_prefetch_pc(IBusCachedPlugin_iBusRsp_stages_0_input_payload),
    .io_cpu_fetch_isValid(IBusCachedPlugin_iBusRsp_stages_1_input_valid),
    .io_cpu_fetch_isStuck(_zz_273_),
    .io_cpu_fetch_isRemoved(_zz_274_),
    .io_cpu_fetch_pc(IBusCachedPlugin_iBusRsp_stages_1_input_payload),
    .io_cpu_fetch_data(_zz_310_),
    .io_cpu_fetch_mmuBus_cmd_isValid(_zz_312_),
    .io_cpu_fetch_mmuBus_cmd_virtualAddress(_zz_313_),
    .io_cpu_fetch_mmuBus_cmd_bypassTranslation(_zz_314_),
    .io_cpu_fetch_mmuBus_rsp_physicalAddress(_zz_116_),
    .io_cpu_fetch_mmuBus_rsp_isIoAccess(_zz_275_),
    .io_cpu_fetch_mmuBus_rsp_allowRead(_zz_117_),
    .io_cpu_fetch_mmuBus_rsp_allowWrite(_zz_118_),
    .io_cpu_fetch_mmuBus_rsp_allowExecute(_zz_119_),
    .io_cpu_fetch_mmuBus_rsp_allowUser(_zz_120_),
    .io_cpu_fetch_mmuBus_rsp_miss(_zz_121_),
    .io_cpu_fetch_mmuBus_rsp_hit(_zz_122_),
    .io_cpu_fetch_mmuBus_end(_zz_315_),
    .io_cpu_fetch_physicalAddress(_zz_311_),
    .io_cpu_decode_isValid(IBusCachedPlugin_stages_2_input_valid),
    .io_cpu_decode_isStuck(_zz_276_),
    .io_cpu_decode_pc(IBusCachedPlugin_stages_2_input_payload),
    .io_cpu_decode_physicalAddress(_zz_321_),
    .io_cpu_decode_data(_zz_319_),
    .io_cpu_decode_cacheMiss(_zz_320_),
    .io_cpu_decode_error(_zz_316_),
    .io_cpu_decode_mmuMiss(_zz_317_),
    .io_cpu_decode_illegalAccess(_zz_318_),
    .io_cpu_decode_isUser(_zz_277_),
    .io_cpu_fill_valid(IBusCachedPlugin_redoFetch),
    .io_cpu_fill_payload(_zz_321_),
    .io_mem_cmd_valid(_zz_322_),
    .io_mem_cmd_ready(iBus_cmd_ready),
    .io_mem_cmd_payload_address(_zz_323_),
    .io_mem_cmd_payload_size(_zz_324_),
    .io_mem_rsp_valid(iBus_rsp_valid),
    .io_mem_rsp_payload_data(iBus_rsp_payload_data),
    .io_mem_rsp_payload_error(iBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  DataCache dataCache_1_ ( 
    .io_cpu_execute_isValid(_zz_278_),
    .io_cpu_execute_isStuck(execute_arbitration_isStuck),
    .io_cpu_execute_args_kind(_zz_279_),
    .io_cpu_execute_args_wr(execute_MEMORY_WR),
    .io_cpu_execute_args_address(_zz_280_),
    .io_cpu_execute_args_data(_zz_163_),
    .io_cpu_execute_args_size(execute_DBusCachedPlugin_size),
    .io_cpu_execute_args_forceUncachedAccess(_zz_281_),
    .io_cpu_execute_args_clean(_zz_282_),
    .io_cpu_execute_args_invalidate(_zz_283_),
    .io_cpu_execute_args_way(_zz_284_),
    .io_cpu_memory_isValid(_zz_285_),
    .io_cpu_memory_isStuck(memory_arbitration_isStuck),
    .io_cpu_memory_isRemoved(memory_arbitration_removeIt),
    .io_cpu_memory_haltIt(_zz_325_),
    .io_cpu_memory_mmuBus_cmd_isValid(_zz_326_),
    .io_cpu_memory_mmuBus_cmd_virtualAddress(_zz_327_),
    .io_cpu_memory_mmuBus_cmd_bypassTranslation(_zz_328_),
    .io_cpu_memory_mmuBus_rsp_physicalAddress(_zz_126_),
    .io_cpu_memory_mmuBus_rsp_isIoAccess(_zz_286_),
    .io_cpu_memory_mmuBus_rsp_allowRead(_zz_127_),
    .io_cpu_memory_mmuBus_rsp_allowWrite(_zz_128_),
    .io_cpu_memory_mmuBus_rsp_allowExecute(_zz_129_),
    .io_cpu_memory_mmuBus_rsp_allowUser(_zz_130_),
    .io_cpu_memory_mmuBus_rsp_miss(_zz_131_),
    .io_cpu_memory_mmuBus_rsp_hit(_zz_132_),
    .io_cpu_memory_mmuBus_end(_zz_329_),
    .io_cpu_writeBack_isValid(_zz_287_),
    .io_cpu_writeBack_isStuck(writeBack_arbitration_isStuck),
    .io_cpu_writeBack_isUser(_zz_288_),
    .io_cpu_writeBack_haltIt(_zz_330_),
    .io_cpu_writeBack_data(_zz_331_),
    .io_cpu_writeBack_mmuMiss(_zz_332_),
    .io_cpu_writeBack_illegalAccess(_zz_333_),
    .io_cpu_writeBack_unalignedAccess(_zz_334_),
    .io_cpu_writeBack_accessError(_zz_335_),
    .io_cpu_writeBack_badAddr(_zz_336_),
    .io_mem_cmd_valid(_zz_337_),
    .io_mem_cmd_ready(dBus_cmd_ready),
    .io_mem_cmd_payload_wr(_zz_338_),
    .io_mem_cmd_payload_address(_zz_339_),
    .io_mem_cmd_payload_data(_zz_340_),
    .io_mem_cmd_payload_mask(_zz_341_),
    .io_mem_cmd_payload_length(_zz_342_),
    .io_mem_cmd_payload_last(_zz_343_),
    .io_mem_rsp_valid(dBus_rsp_valid),
    .io_mem_rsp_payload_data(dBus_rsp_payload_data),
    .io_mem_rsp_payload_error(dBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  JtagBridge jtagBridge_1_ ( 
    .io_jtag_tms(jtag_tms),
    .io_jtag_tdi(jtag_tdi),
    .io_jtag_tdo(_zz_344_),
    .io_jtag_tck(jtag_tck),
    .io_remote_cmd_valid(_zz_345_),
    .io_remote_cmd_ready(_zz_349_),
    .io_remote_cmd_payload_last(_zz_346_),
    .io_remote_cmd_payload_fragment(_zz_347_),
    .io_remote_rsp_valid(_zz_350_),
    .io_remote_rsp_ready(_zz_348_),
    .io_remote_rsp_payload_error(_zz_351_),
    .io_remote_rsp_payload_data(_zz_352_),
    .clk(clk),
    .reset(reset) 
  );
  SystemDebugger systemDebugger_1_ ( 
    .io_remote_cmd_valid(_zz_345_),
    .io_remote_cmd_ready(_zz_349_),
    .io_remote_cmd_payload_last(_zz_346_),
    .io_remote_cmd_payload_fragment(_zz_347_),
    .io_remote_rsp_valid(_zz_350_),
    .io_remote_rsp_ready(_zz_348_),
    .io_remote_rsp_payload_error(_zz_351_),
    .io_remote_rsp_payload_data(_zz_352_),
    .io_mem_cmd_valid(_zz_353_),
    .io_mem_cmd_ready(debug_bus_cmd_ready),
    .io_mem_cmd_payload_address(_zz_354_),
    .io_mem_cmd_payload_data(_zz_355_),
    .io_mem_cmd_payload_wr(_zz_356_),
    .io_mem_cmd_payload_size(_zz_357_),
    .io_mem_rsp_valid(_zz_271_),
    .io_mem_rsp_payload(debug_bus_rsp_data),
    .clk(clk),
    .reset(reset) 
  );
  always @(*) begin
    case(_zz_496_)
      2'b00 : begin
        _zz_292_ = _zz_136_;
      end
      2'b01 : begin
        _zz_292_ = _zz_134_;
      end
      2'b10 : begin
        _zz_292_ = _zz_111_;
      end
      default : begin
        _zz_292_ = _zz_108_;
      end
    endcase
  end

  always @(*) begin
    case(_zz_171_)
      2'b00 : begin
        _zz_293_ = MemoryTranslatorPlugin_ports_0_cache_0_valid;
        _zz_294_ = MemoryTranslatorPlugin_ports_0_cache_0_virtualAddress;
        _zz_295_ = MemoryTranslatorPlugin_ports_0_cache_0_physicalAddress;
        _zz_296_ = MemoryTranslatorPlugin_ports_0_cache_0_allowRead;
        _zz_297_ = MemoryTranslatorPlugin_ports_0_cache_0_allowWrite;
        _zz_298_ = MemoryTranslatorPlugin_ports_0_cache_0_allowExecute;
        _zz_299_ = MemoryTranslatorPlugin_ports_0_cache_0_allowUser;
      end
      2'b01 : begin
        _zz_293_ = MemoryTranslatorPlugin_ports_0_cache_1_valid;
        _zz_294_ = MemoryTranslatorPlugin_ports_0_cache_1_virtualAddress;
        _zz_295_ = MemoryTranslatorPlugin_ports_0_cache_1_physicalAddress;
        _zz_296_ = MemoryTranslatorPlugin_ports_0_cache_1_allowRead;
        _zz_297_ = MemoryTranslatorPlugin_ports_0_cache_1_allowWrite;
        _zz_298_ = MemoryTranslatorPlugin_ports_0_cache_1_allowExecute;
        _zz_299_ = MemoryTranslatorPlugin_ports_0_cache_1_allowUser;
      end
      2'b10 : begin
        _zz_293_ = MemoryTranslatorPlugin_ports_0_cache_2_valid;
        _zz_294_ = MemoryTranslatorPlugin_ports_0_cache_2_virtualAddress;
        _zz_295_ = MemoryTranslatorPlugin_ports_0_cache_2_physicalAddress;
        _zz_296_ = MemoryTranslatorPlugin_ports_0_cache_2_allowRead;
        _zz_297_ = MemoryTranslatorPlugin_ports_0_cache_2_allowWrite;
        _zz_298_ = MemoryTranslatorPlugin_ports_0_cache_2_allowExecute;
        _zz_299_ = MemoryTranslatorPlugin_ports_0_cache_2_allowUser;
      end
      default : begin
        _zz_293_ = MemoryTranslatorPlugin_ports_0_cache_3_valid;
        _zz_294_ = MemoryTranslatorPlugin_ports_0_cache_3_virtualAddress;
        _zz_295_ = MemoryTranslatorPlugin_ports_0_cache_3_physicalAddress;
        _zz_296_ = MemoryTranslatorPlugin_ports_0_cache_3_allowRead;
        _zz_297_ = MemoryTranslatorPlugin_ports_0_cache_3_allowWrite;
        _zz_298_ = MemoryTranslatorPlugin_ports_0_cache_3_allowExecute;
        _zz_299_ = MemoryTranslatorPlugin_ports_0_cache_3_allowUser;
      end
    endcase
  end

  always @(*) begin
    case(_zz_179_)
      2'b00 : begin
        _zz_300_ = MemoryTranslatorPlugin_ports_1_cache_0_valid;
        _zz_301_ = MemoryTranslatorPlugin_ports_1_cache_0_virtualAddress;
        _zz_302_ = MemoryTranslatorPlugin_ports_1_cache_0_physicalAddress;
        _zz_303_ = MemoryTranslatorPlugin_ports_1_cache_0_allowRead;
        _zz_304_ = MemoryTranslatorPlugin_ports_1_cache_0_allowWrite;
        _zz_305_ = MemoryTranslatorPlugin_ports_1_cache_0_allowExecute;
        _zz_306_ = MemoryTranslatorPlugin_ports_1_cache_0_allowUser;
      end
      2'b01 : begin
        _zz_300_ = MemoryTranslatorPlugin_ports_1_cache_1_valid;
        _zz_301_ = MemoryTranslatorPlugin_ports_1_cache_1_virtualAddress;
        _zz_302_ = MemoryTranslatorPlugin_ports_1_cache_1_physicalAddress;
        _zz_303_ = MemoryTranslatorPlugin_ports_1_cache_1_allowRead;
        _zz_304_ = MemoryTranslatorPlugin_ports_1_cache_1_allowWrite;
        _zz_305_ = MemoryTranslatorPlugin_ports_1_cache_1_allowExecute;
        _zz_306_ = MemoryTranslatorPlugin_ports_1_cache_1_allowUser;
      end
      2'b10 : begin
        _zz_300_ = MemoryTranslatorPlugin_ports_1_cache_2_valid;
        _zz_301_ = MemoryTranslatorPlugin_ports_1_cache_2_virtualAddress;
        _zz_302_ = MemoryTranslatorPlugin_ports_1_cache_2_physicalAddress;
        _zz_303_ = MemoryTranslatorPlugin_ports_1_cache_2_allowRead;
        _zz_304_ = MemoryTranslatorPlugin_ports_1_cache_2_allowWrite;
        _zz_305_ = MemoryTranslatorPlugin_ports_1_cache_2_allowExecute;
        _zz_306_ = MemoryTranslatorPlugin_ports_1_cache_2_allowUser;
      end
      default : begin
        _zz_300_ = MemoryTranslatorPlugin_ports_1_cache_3_valid;
        _zz_301_ = MemoryTranslatorPlugin_ports_1_cache_3_virtualAddress;
        _zz_302_ = MemoryTranslatorPlugin_ports_1_cache_3_physicalAddress;
        _zz_303_ = MemoryTranslatorPlugin_ports_1_cache_3_allowRead;
        _zz_304_ = MemoryTranslatorPlugin_ports_1_cache_3_allowWrite;
        _zz_305_ = MemoryTranslatorPlugin_ports_1_cache_3_allowExecute;
        _zz_306_ = MemoryTranslatorPlugin_ports_1_cache_3_allowUser;
      end
    endcase
  end

  assign decode_MEMORY_ENABLE = _zz_89_;
  assign decode_SRC1_CTRL = _zz_1_;
  assign _zz_2_ = _zz_3_;
  assign decode_IS_TLB = _zz_81_;
  assign memory_PC = execute_to_memory_PC;
  assign memory_MEMORY_WR = execute_to_memory_MEMORY_WR;
  assign decode_MEMORY_WR = _zz_76_;
  assign decode_ALU_CTRL = _zz_4_;
  assign _zz_5_ = _zz_6_;
  assign _zz_7_ = _zz_8_;
  assign _zz_9_ = _zz_10_;
  assign decode_ENV_CTRL = _zz_11_;
  assign _zz_12_ = _zz_13_;
  assign _zz_14_ = _zz_15_;
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = _zz_101_;
  assign decode_IS_DIV = _zz_77_;
  assign decode_SRC2_CTRL = _zz_16_;
  assign _zz_17_ = _zz_18_;
  assign decode_CSR_READ_OPCODE = _zz_30_;
  assign decode_PREDICTION_HAD_BRANCHED2 = _zz_38_;
  assign execute_MUL_HL = _zz_42_;
  assign execute_SHIFT_RIGHT = _zz_47_;
  assign decode_IS_CSR = _zz_84_;
  assign decode_DO_EBREAK = _zz_27_;
  assign _zz_19_ = _zz_20_;
  assign decode_SHIFT_CTRL = _zz_21_;
  assign _zz_22_ = _zz_23_;
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_80_;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = _zz_95_;
  assign execute_BRANCH_DO = _zz_35_;
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign decode_IS_MUL = _zz_73_;
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_78_;
  assign decode_SRC_USE_SUB_LESS = _zz_85_;
  assign memory_MUL_HH = execute_to_memory_MUL_HH;
  assign execute_MUL_HH = _zz_41_;
  assign execute_MUL_LH = _zz_43_;
  assign execute_FLUSH_ALL = decode_to_execute_FLUSH_ALL;
  assign decode_FLUSH_ALL = _zz_83_;
  assign memory_MUL_LOW = _zz_40_;
  assign execute_MUL_LL = _zz_44_;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign decode_IS_RS1_SIGNED = _zz_79_;
  assign decode_CSR_WRITE_OPCODE = _zz_31_;
  assign decode_ALU_BITWISE_CTRL = _zz_24_;
  assign _zz_25_ = _zz_26_;
  assign decode_IS_RS2_SIGNED = _zz_86_;
  assign decode_MEMORY_MANAGMENT = _zz_88_;
  assign execute_BRANCH_CALC = _zz_34_;
  assign decode_SRC_LESS_UNSIGNED = _zz_71_;
  assign execute_DO_EBREAK = decode_to_execute_DO_EBREAK;
  assign decode_IS_EBREAK = _zz_72_;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_REGFILE_WRITE_DATA = _zz_58_;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign memory_ENV_CTRL = _zz_28_;
  assign execute_ENV_CTRL = _zz_29_;
  assign writeBack_ENV_CTRL = _zz_32_;
  assign execute_IS_FENCEI = decode_to_execute_IS_FENCEI;
  always @ (*) begin
    _zz_33_ = decode_INSTRUCTION;
    if(decode_IS_FENCEI)begin
      _zz_33_[12] = 1'b0;
      _zz_33_[22] = 1'b1;
    end
  end

  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_PREDICTION_HAD_BRANCHED2 = decode_to_execute_PREDICTION_HAD_BRANCHED2;
  assign execute_BRANCH_COND_RESULT = _zz_37_;
  assign execute_BRANCH_CTRL = _zz_36_;
  assign decode_IS_FENCEI = _zz_66_;
  assign decode_RS2_USE = _zz_70_;
  assign decode_RS1_USE = _zz_90_;
  always @ (*) begin
    _zz_39_ = execute_REGFILE_WRITE_DATA;
    execute_arbitration_haltItself = 1'b0;
    if((execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_WFI)))begin
      if((! CsrPlugin_interrupt))begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
    if((execute_arbitration_isValid && execute_IS_CSR))begin
      _zz_39_ = execute_CsrPlugin_readData;
      if(execute_CsrPlugin_blockedBySideEffects)begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
  end

  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    decode_RS2 = _zz_63_;
    decode_RS1 = _zz_64_;
    if(_zz_221_)begin
      if((_zz_222_ == decode_INSTRUCTION[19 : 15]))begin
        decode_RS1 = _zz_223_;
      end
      if((_zz_222_ == decode_INSTRUCTION[24 : 20]))begin
        decode_RS2 = _zz_223_;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if(1'b1)begin
        if(_zz_224_)begin
          decode_RS1 = _zz_94_;
        end
        if(_zz_225_)begin
          decode_RS2 = _zz_94_;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if(memory_BYPASSABLE_MEMORY_STAGE)begin
        if(_zz_226_)begin
          decode_RS1 = _zz_45_;
        end
        if(_zz_227_)begin
          decode_RS2 = _zz_45_;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if(execute_BYPASSABLE_EXECUTE_STAGE)begin
        if(_zz_228_)begin
          decode_RS1 = _zz_39_;
        end
        if(_zz_229_)begin
          decode_RS2 = _zz_39_;
        end
      end
    end
  end

  assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_IS_DIV = decode_to_execute_IS_DIV;
  assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_IS_DIV = execute_to_memory_IS_DIV;
  assign writeBack_IS_MUL = memory_to_writeBack_IS_MUL;
  assign writeBack_MUL_HH = memory_to_writeBack_MUL_HH;
  assign writeBack_MUL_LOW = memory_to_writeBack_MUL_LOW;
  assign memory_MUL_HL = execute_to_memory_MUL_HL;
  assign memory_MUL_LH = execute_to_memory_MUL_LH;
  assign memory_MUL_LL = execute_to_memory_MUL_LL;
  assign memory_SHIFT_RIGHT = execute_to_memory_SHIFT_RIGHT;
  always @ (*) begin
    _zz_45_ = memory_REGFILE_WRITE_DATA;
    decode_arbitration_flushAll = 1'b0;
    memory_arbitration_haltItself = 1'b0;
    _zz_272_ = 1'b0;
    if((memory_arbitration_isValid && memory_FLUSH_ALL))begin
      _zz_272_ = 1'b1;
      decode_arbitration_flushAll = 1'b1;
      if((! _zz_307_))begin
        memory_arbitration_haltItself = 1'b1;
      end
    end
    if(_zz_325_)begin
      memory_arbitration_haltItself = 1'b1;
    end
    if(((_zz_123_ && (! _zz_132_)) && (! _zz_131_)))begin
      memory_arbitration_haltItself = 1'b1;
    end
    case(memory_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : begin
        _zz_45_ = _zz_210_;
      end
      `ShiftCtrlEnum_defaultEncoding_SRL_1, `ShiftCtrlEnum_defaultEncoding_SRA_1 : begin
        _zz_45_ = memory_SHIFT_RIGHT;
      end
      default : begin
      end
    endcase
    memory_DivPlugin_div_counter_willIncrement = 1'b0;
    if(_zz_358_)begin
      if(_zz_359_)begin
        memory_arbitration_haltItself = 1'b1;
        memory_DivPlugin_div_counter_willIncrement = 1'b1;
      end
      _zz_45_ = memory_DivPlugin_div_result;
    end
  end

  assign memory_SHIFT_CTRL = _zz_46_;
  assign execute_SHIFT_CTRL = _zz_48_;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_52_ = execute_PC;
  assign execute_SRC2_CTRL = _zz_53_;
  assign execute_SRC1_CTRL = _zz_55_;
  assign execute_SRC_ADD_SUB = _zz_51_;
  assign execute_SRC_LESS = _zz_49_;
  assign execute_ALU_CTRL = _zz_57_;
  assign execute_SRC2 = _zz_54_;
  assign execute_ALU_BITWISE_CTRL = _zz_59_;
  assign _zz_60_ = writeBack_INSTRUCTION;
  assign _zz_61_ = writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_62_ = 1'b0;
    if(writeBack_RegFilePlugin_regFileWrite_valid)begin
      _zz_62_ = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = _zz_97_;
  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_87_;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = _zz_91_;
  assign decode_INSTRUCTION_READY = 1'b1;
  always @ (*) begin
    _zz_92_ = 1'b0;
    if(_zz_360_)begin
      case(_zz_361_)
        2'b00 : begin
        end
        2'b01 : begin
          _zz_92_ = 1'b1;
        end
        2'b10 : begin
        end
        default : begin
        end
      endcase
    end
  end

  assign execute_SRC1 = _zz_56_;
  assign execute_IS_TLB = decode_to_execute_IS_TLB;
  always @ (*) begin
    MemoryTranslatorPlugin_shared_free = _zz_93_;
    if(MemoryTranslatorPlugin_ports_1_sharedAccessAsked)begin
      MemoryTranslatorPlugin_shared_free = 1'b0;
    end
  end

  always @ (*) begin
    _zz_93_ = 1'b1;
    if(MemoryTranslatorPlugin_ports_0_sharedAccessAsked)begin
      _zz_93_ = 1'b0;
    end
  end

  always @ (*) begin
    _zz_94_ = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_94_ = writeBack_DBusCachedPlugin_rspFormated;
    end
    if((writeBack_arbitration_isValid && writeBack_IS_MUL))begin
      case(_zz_378_)
        2'b00 : begin
          _zz_94_ = _zz_447_;
        end
        default : begin
          _zz_94_ = _zz_448_;
        end
      endcase
    end
  end

  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_WR = memory_to_writeBack_MEMORY_WR;
  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_MEMORY_MANAGMENT = decode_to_execute_MEMORY_MANAGMENT;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_SRC_ADD = _zz_50_;
  assign execute_MEMORY_WR = decode_to_execute_MEMORY_WR;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign memory_FLUSH_ALL = execute_to_memory_FLUSH_ALL;
  always @ (*) begin
    IBusCachedPlugin_issueDetected = _zz_96_;
    _zz_112_ = 1'b0;
    if(((IBusCachedPlugin_stages_2_input_valid && ((_zz_316_ || _zz_317_) || _zz_318_)) && (! _zz_96_)))begin
      IBusCachedPlugin_issueDetected = 1'b1;
      _zz_112_ = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  always @ (*) begin
    _zz_96_ = 1'b0;
    IBusCachedPlugin_redoFetch = 1'b0;
    if(((IBusCachedPlugin_stages_2_input_valid && _zz_320_) && (! 1'b0)))begin
      _zz_96_ = 1'b1;
      IBusCachedPlugin_redoFetch = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  assign decode_BRANCH_CTRL = _zz_98_;
  always @ (*) begin
    _zz_99_ = memory_FORMAL_PC_NEXT;
    if(_zz_133_)begin
      _zz_99_ = _zz_134_;
    end
  end

  always @ (*) begin
    _zz_100_ = decode_FORMAL_PC_NEXT;
    if(_zz_107_)begin
      _zz_100_ = _zz_108_;
    end
    if(_zz_110_)begin
      _zz_100_ = _zz_111_;
    end
  end

  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  assign decode_PC = _zz_103_;
  always @ (*) begin
    decode_INSTRUCTION = _zz_102_;
    if((_zz_260_ != (3'b000)))begin
      decode_INSTRUCTION = _zz_261_;
    end
  end

  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    decode_arbitration_isValid = (IBusCachedPlugin_iBusRsp_decodeInput_valid && (! IBusCachedPlugin_injector_decodeRemoved));
    if((decode_arbitration_isValid && (_zz_218_ || _zz_219_)))begin
      decode_arbitration_haltItself = 1'b1;
    end
    _zz_140_ = 1'b0;
    case(_zz_260_)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
        decode_arbitration_isValid = 1'b1;
        decode_arbitration_haltItself = 1'b1;
      end
      3'b011 : begin
        decode_arbitration_isValid = 1'b1;
      end
      3'b100 : begin
        _zz_140_ = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    decode_arbitration_haltByOther = 1'b0;
    if((CsrPlugin_interrupt && decode_arbitration_isValid))begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(((execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)) || (memory_arbitration_isValid && (memory_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET))))begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @ (*) begin
    decode_arbitration_removeIt = 1'b0;
    if(decode_exception_agregat_valid)begin
      decode_arbitration_removeIt = 1'b1;
    end
    if(decode_arbitration_isFlushed)begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_redoIt = 1'b0;
  always @ (*) begin
    execute_arbitration_haltByOther = 1'b0;
    _zz_104_ = 1'b0;
    _zz_105_ = 1'b0;
    if(((execute_arbitration_isValid && execute_IS_FENCEI) && (memory_arbitration_isValid || writeBack_arbitration_isValid)))begin
      execute_arbitration_haltByOther = 1'b1;
    end
    if((((CsrPlugin_exceptionPortCtrl_exceptionValids_decode || CsrPlugin_exceptionPortCtrl_exceptionValids_execute) || CsrPlugin_exceptionPortCtrl_exceptionValids_memory) || CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack))begin
      _zz_104_ = 1'b1;
      _zz_105_ = 1'b1;
    end
    if(_zz_362_)begin
      execute_arbitration_haltByOther = 1'b1;
      if(_zz_363_)begin
        _zz_105_ = 1'b1;
        _zz_104_ = 1'b1;
      end
    end
    if(DebugPlugin_haltIt)begin
      _zz_104_ = 1'b1;
    end
    if(_zz_364_)begin
      _zz_104_ = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_removeIt = 1'b0;
    if(execute_arbitration_isFlushed)begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_flushAll = 1'b0;
    if(_zz_133_)begin
      execute_arbitration_flushAll = 1'b1;
    end
    if(memory_exception_agregat_valid)begin
      execute_arbitration_flushAll = 1'b1;
    end
    if(_zz_362_)begin
      if(_zz_363_)begin
        execute_arbitration_flushAll = 1'b1;
      end
    end
  end

  assign execute_arbitration_redoIt = 1'b0;
  assign memory_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    memory_arbitration_removeIt = 1'b0;
    if(memory_exception_agregat_valid)begin
      memory_arbitration_removeIt = 1'b1;
    end
    if(memory_arbitration_isFlushed)begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    memory_arbitration_flushAll = 1'b0;
    writeBack_arbitration_removeIt = 1'b0;
    _zz_135_ = 1'b0;
    _zz_136_ = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
    if(writeBack_exception_agregat_valid)begin
      memory_arbitration_flushAll = 1'b1;
      writeBack_arbitration_removeIt = 1'b1;
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b1;
    end
    if(_zz_365_)begin
      _zz_135_ = 1'b1;
      memory_arbitration_flushAll = 1'b1;
      case(CsrPlugin_targetPrivilege)
        2'b01 : begin
          _zz_136_ = CsrPlugin_stvec;
        end
        2'b11 : begin
          _zz_136_ = CsrPlugin_mtvec;
        end
        default : begin
        end
      endcase
    end
    if(_zz_366_)begin
      _zz_135_ = 1'b1;
      memory_arbitration_flushAll = 1'b1;
      case(_zz_367_)
        2'b11 : begin
          _zz_136_ = CsrPlugin_mepc;
        end
        2'b01 : begin
          _zz_136_ = CsrPlugin_sepc;
        end
        default : begin
        end
      endcase
    end
    if(writeBack_arbitration_isFlushed)begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_redoIt = 1'b0;
  always @ (*) begin
    writeBack_arbitration_haltItself = 1'b0;
    if(_zz_330_)begin
      writeBack_arbitration_haltItself = 1'b1;
    end
  end

  assign writeBack_arbitration_haltByOther = 1'b0;
  assign writeBack_arbitration_flushAll = 1'b0;
  assign writeBack_arbitration_redoIt = 1'b0;
  always @ (*) begin
    _zz_106_ = 1'b0;
    if((IBusCachedPlugin_iBusRsp_stages_1_input_valid || IBusCachedPlugin_stages_2_input_valid))begin
      _zz_106_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_137_ = 1'b1;
    if((DebugPlugin_haltIt || DebugPlugin_stepIt))begin
      _zz_137_ = 1'b0;
    end
  end

  always @ (*) begin
    _zz_138_ = 1'b1;
    if(DebugPlugin_haltIt)begin
      _zz_138_ = 1'b0;
    end
  end

  assign IBusCachedPlugin_jump_pcLoad_valid = (((_zz_107_ || _zz_110_) || _zz_133_) || _zz_135_);
  assign _zz_141_ = {_zz_107_,{_zz_110_,{_zz_133_,_zz_135_}}};
  assign _zz_142_ = (_zz_141_ & (~ _zz_380_));
  assign _zz_143_ = _zz_142_[3];
  assign _zz_144_ = (_zz_142_[1] || _zz_143_);
  assign _zz_145_ = (_zz_142_[2] || _zz_143_);
  assign IBusCachedPlugin_jump_pcLoad_payload = _zz_292_;
  assign _zz_146_ = (! _zz_104_);
  assign IBusCachedPlugin_fetchPc_output_valid = (IBusCachedPlugin_fetchPc_preOutput_valid && _zz_146_);
  assign IBusCachedPlugin_fetchPc_preOutput_ready = (IBusCachedPlugin_fetchPc_output_ready && _zz_146_);
  assign IBusCachedPlugin_fetchPc_output_payload = IBusCachedPlugin_fetchPc_preOutput_payload;
  always @ (*) begin
    IBusCachedPlugin_fetchPc_propagatePc = 1'b0;
    if((IBusCachedPlugin_iBusRsp_stages_1_input_valid && IBusCachedPlugin_iBusRsp_stages_1_input_ready))begin
      IBusCachedPlugin_fetchPc_propagatePc = 1'b1;
    end
  end

  always @ (*) begin
    IBusCachedPlugin_fetchPc_pc = (IBusCachedPlugin_fetchPc_pcReg + _zz_382_);
    IBusCachedPlugin_fetchPc_samplePcNext = 1'b0;
    if(IBusCachedPlugin_fetchPc_propagatePc)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
    end
    if(IBusCachedPlugin_jump_pcLoad_valid)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_jump_pcLoad_payload;
    end
    if(_zz_368_)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
    end
    IBusCachedPlugin_fetchPc_pc[0] = 1'b0;
    IBusCachedPlugin_fetchPc_pc[1] = 1'b0;
  end

  assign IBusCachedPlugin_fetchPc_preOutput_valid = _zz_147_;
  assign IBusCachedPlugin_fetchPc_preOutput_payload = IBusCachedPlugin_fetchPc_pc;
  assign IBusCachedPlugin_iBusRsp_stages_0_input_valid = IBusCachedPlugin_fetchPc_output_valid;
  assign IBusCachedPlugin_fetchPc_output_ready = IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  assign IBusCachedPlugin_iBusRsp_stages_0_input_payload = IBusCachedPlugin_fetchPc_output_payload;
  assign IBusCachedPlugin_iBusRsp_stages_0_inputSample = 1'b1;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b0;
    if(_zz_309_)begin
      IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b1;
    end
  end

  assign _zz_148_ = (! IBusCachedPlugin_iBusRsp_stages_0_halt);
  assign IBusCachedPlugin_iBusRsp_stages_0_input_ready = (IBusCachedPlugin_iBusRsp_stages_0_output_ready && _zz_148_);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_valid = (IBusCachedPlugin_iBusRsp_stages_0_input_valid && _zz_148_);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_payload = IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b0;
    if(((_zz_113_ && (! _zz_122_)) && (! _zz_121_)))begin
      IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b1;
    end
  end

  assign _zz_149_ = (! IBusCachedPlugin_iBusRsp_stages_1_halt);
  assign IBusCachedPlugin_iBusRsp_stages_1_input_ready = (IBusCachedPlugin_iBusRsp_stages_1_output_ready && _zz_149_);
  assign IBusCachedPlugin_iBusRsp_stages_1_output_valid = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && _zz_149_);
  assign IBusCachedPlugin_iBusRsp_stages_1_output_payload = IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  always @ (*) begin
    IBusCachedPlugin_stages_2_halt = 1'b0;
    if((IBusCachedPlugin_issueDetected || IBusCachedPlugin_iBusRspOutputHalt))begin
      IBusCachedPlugin_stages_2_halt = 1'b1;
    end
  end

  assign _zz_150_ = (! IBusCachedPlugin_stages_2_halt);
  assign IBusCachedPlugin_stages_2_input_ready = (IBusCachedPlugin_stages_2_output_ready && _zz_150_);
  assign IBusCachedPlugin_stages_2_output_valid = (IBusCachedPlugin_stages_2_input_valid && _zz_150_);
  assign IBusCachedPlugin_stages_2_output_payload = IBusCachedPlugin_stages_2_input_payload;
  assign IBusCachedPlugin_iBusRsp_stages_0_output_ready = _zz_151_;
  assign _zz_151_ = ((1'b0 && (! _zz_152_)) || IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign _zz_152_ = _zz_153_;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_valid = _zz_152_;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_payload = IBusCachedPlugin_fetchPc_pcReg;
  assign IBusCachedPlugin_iBusRsp_stages_1_output_ready = ((1'b0 && (! _zz_154_)) || IBusCachedPlugin_stages_2_input_ready);
  assign _zz_154_ = _zz_155_;
  assign IBusCachedPlugin_stages_2_input_valid = _zz_154_;
  assign IBusCachedPlugin_stages_2_input_payload = _zz_156_;
  assign IBusCachedPlugin_iBusRsp_readyForError = 1'b1;
  assign IBusCachedPlugin_iBusRsp_decodeInput_ready = (! decode_arbitration_isStuck);
  assign _zz_103_ = IBusCachedPlugin_iBusRsp_decodeInput_payload_pc;
  assign _zz_102_ = IBusCachedPlugin_iBusRsp_decodeInput_payload_rsp_rawInDecode;
  assign _zz_101_ = (decode_PC + (32'b00000000000000000000000000000100));
  assign _zz_157_ = _zz_383_[11];
  always @ (*) begin
    _zz_158_[18] = _zz_157_;
    _zz_158_[17] = _zz_157_;
    _zz_158_[16] = _zz_157_;
    _zz_158_[15] = _zz_157_;
    _zz_158_[14] = _zz_157_;
    _zz_158_[13] = _zz_157_;
    _zz_158_[12] = _zz_157_;
    _zz_158_[11] = _zz_157_;
    _zz_158_[10] = _zz_157_;
    _zz_158_[9] = _zz_157_;
    _zz_158_[8] = _zz_157_;
    _zz_158_[7] = _zz_157_;
    _zz_158_[6] = _zz_157_;
    _zz_158_[5] = _zz_157_;
    _zz_158_[4] = _zz_157_;
    _zz_158_[3] = _zz_157_;
    _zz_158_[2] = _zz_157_;
    _zz_158_[1] = _zz_157_;
    _zz_158_[0] = _zz_157_;
  end

  assign _zz_109_ = ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) || ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_B) && _zz_384_[31]));
  assign _zz_107_ = (_zz_109_ && decode_arbitration_isFiring);
  assign _zz_159_ = _zz_385_[19];
  always @ (*) begin
    _zz_160_[10] = _zz_159_;
    _zz_160_[9] = _zz_159_;
    _zz_160_[8] = _zz_159_;
    _zz_160_[7] = _zz_159_;
    _zz_160_[6] = _zz_159_;
    _zz_160_[5] = _zz_159_;
    _zz_160_[4] = _zz_159_;
    _zz_160_[3] = _zz_159_;
    _zz_160_[2] = _zz_159_;
    _zz_160_[1] = _zz_159_;
    _zz_160_[0] = _zz_159_;
  end

  assign _zz_161_ = _zz_386_[11];
  always @ (*) begin
    _zz_162_[18] = _zz_161_;
    _zz_162_[17] = _zz_161_;
    _zz_162_[16] = _zz_161_;
    _zz_162_[15] = _zz_161_;
    _zz_162_[14] = _zz_161_;
    _zz_162_[13] = _zz_161_;
    _zz_162_[12] = _zz_161_;
    _zz_162_[11] = _zz_161_;
    _zz_162_[10] = _zz_161_;
    _zz_162_[9] = _zz_161_;
    _zz_162_[8] = _zz_161_;
    _zz_162_[7] = _zz_161_;
    _zz_162_[6] = _zz_161_;
    _zz_162_[5] = _zz_161_;
    _zz_162_[4] = _zz_161_;
    _zz_162_[3] = _zz_161_;
    _zz_162_[2] = _zz_161_;
    _zz_162_[1] = _zz_161_;
    _zz_162_[0] = _zz_161_;
  end

  assign _zz_108_ = (decode_PC + ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) ? {{_zz_160_,{{{_zz_497_,_zz_498_},_zz_499_},decode_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_162_,{{{_zz_500_,_zz_501_},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0}));
  assign iBus_cmd_valid = _zz_322_;
  always @ (*) begin
    iBus_cmd_payload_address = _zz_323_;
    iBus_cmd_payload_address = _zz_323_;
  end

  assign iBus_cmd_payload_size = _zz_324_;
  assign _zz_274_ = (IBusCachedPlugin_jump_pcLoad_valid || _zz_105_);
  assign IBusCachedPlugin_iBusRspOutputHalt = 1'b0;
  assign _zz_113_ = _zz_312_;
  assign _zz_114_ = _zz_313_;
  assign _zz_115_ = _zz_314_;
  assign _zz_275_ = 1'b1;
  assign _zz_273_ = (! IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign _zz_276_ = (! IBusCachedPlugin_stages_2_input_ready);
  assign _zz_277_ = (CsrPlugin_privilege == (2'b00));
  assign _zz_97_ = (decode_arbitration_isStuck ? decode_INSTRUCTION : _zz_310_);
  assign _zz_110_ = IBusCachedPlugin_redoFetch;
  assign _zz_111_ = IBusCachedPlugin_stages_2_input_payload;
  assign IBusCachedPlugin_iBusRsp_decodeInput_valid = IBusCachedPlugin_stages_2_output_valid;
  assign IBusCachedPlugin_stages_2_output_ready = IBusCachedPlugin_iBusRsp_decodeInput_ready;
  assign IBusCachedPlugin_iBusRsp_decodeInput_payload_rsp_rawInDecode = _zz_319_;
  assign IBusCachedPlugin_iBusRsp_decodeInput_payload_pc = IBusCachedPlugin_stages_2_output_payload;
  assign dBus_cmd_valid = _zz_337_;
  assign dBus_cmd_payload_wr = _zz_338_;
  assign dBus_cmd_payload_address = _zz_339_;
  assign dBus_cmd_payload_data = _zz_340_;
  assign dBus_cmd_payload_mask = _zz_341_;
  assign dBus_cmd_payload_length = _zz_342_;
  assign dBus_cmd_payload_last = _zz_343_;
  assign execute_DBusCachedPlugin_size = execute_INSTRUCTION[13 : 12];
  assign _zz_278_ = (execute_arbitration_isValid && execute_MEMORY_ENABLE);
  assign _zz_280_ = execute_SRC_ADD;
  always @ (*) begin
    case(execute_DBusCachedPlugin_size)
      2'b00 : begin
        _zz_163_ = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_163_ = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_163_ = execute_RS2[31 : 0];
      end
    endcase
  end

  assign _zz_281_ = 1'b0;
  assign _zz_279_ = (execute_MEMORY_MANAGMENT ? `DataCacheCpuCmdKind_defaultEncoding_MANAGMENT : `DataCacheCpuCmdKind_defaultEncoding_MEMORY);
  assign _zz_282_ = execute_INSTRUCTION[28];
  assign _zz_283_ = execute_INSTRUCTION[29];
  assign _zz_284_ = (execute_MEMORY_MANAGMENT ? execute_INSTRUCTION[30] : 1'b0);
  assign _zz_95_ = _zz_280_[1 : 0];
  assign _zz_285_ = (memory_arbitration_isValid && memory_MEMORY_ENABLE);
  assign _zz_123_ = _zz_326_;
  assign _zz_124_ = _zz_327_;
  assign _zz_125_ = _zz_328_;
  assign _zz_286_ = 1'b1;
  assign _zz_287_ = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  assign _zz_288_ = (CsrPlugin_privilege == (2'b00));
  assign writeBack_exception_agregat_valid = (((_zz_332_ || _zz_335_) || _zz_333_) || _zz_334_);
  assign writeBack_exception_agregat_payload_badAddr = _zz_336_;
  always @ (*) begin
    writeBack_exception_agregat_payload_code = (4'bxxxx);
    if((_zz_333_ || _zz_335_))begin
      writeBack_exception_agregat_payload_code = {1'd0, _zz_387_};
    end
    if(_zz_334_)begin
      writeBack_exception_agregat_payload_code = {1'd0, _zz_388_};
    end
    if(_zz_332_)begin
      writeBack_exception_agregat_payload_code = (writeBack_MEMORY_WR ? (4'b1111) : (4'b1101));
    end
  end

  always @ (*) begin
    writeBack_DBusCachedPlugin_rspShifted = _zz_331_;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspShifted[7 : 0] = _zz_331_[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusCachedPlugin_rspShifted[15 : 0] = _zz_331_[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusCachedPlugin_rspShifted[7 : 0] = _zz_331_[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign _zz_164_ = (writeBack_DBusCachedPlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_165_[31] = _zz_164_;
    _zz_165_[30] = _zz_164_;
    _zz_165_[29] = _zz_164_;
    _zz_165_[28] = _zz_164_;
    _zz_165_[27] = _zz_164_;
    _zz_165_[26] = _zz_164_;
    _zz_165_[25] = _zz_164_;
    _zz_165_[24] = _zz_164_;
    _zz_165_[23] = _zz_164_;
    _zz_165_[22] = _zz_164_;
    _zz_165_[21] = _zz_164_;
    _zz_165_[20] = _zz_164_;
    _zz_165_[19] = _zz_164_;
    _zz_165_[18] = _zz_164_;
    _zz_165_[17] = _zz_164_;
    _zz_165_[16] = _zz_164_;
    _zz_165_[15] = _zz_164_;
    _zz_165_[14] = _zz_164_;
    _zz_165_[13] = _zz_164_;
    _zz_165_[12] = _zz_164_;
    _zz_165_[11] = _zz_164_;
    _zz_165_[10] = _zz_164_;
    _zz_165_[9] = _zz_164_;
    _zz_165_[8] = _zz_164_;
    _zz_165_[7 : 0] = writeBack_DBusCachedPlugin_rspShifted[7 : 0];
  end

  assign _zz_166_ = (writeBack_DBusCachedPlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_167_[31] = _zz_166_;
    _zz_167_[30] = _zz_166_;
    _zz_167_[29] = _zz_166_;
    _zz_167_[28] = _zz_166_;
    _zz_167_[27] = _zz_166_;
    _zz_167_[26] = _zz_166_;
    _zz_167_[25] = _zz_166_;
    _zz_167_[24] = _zz_166_;
    _zz_167_[23] = _zz_166_;
    _zz_167_[22] = _zz_166_;
    _zz_167_[21] = _zz_166_;
    _zz_167_[20] = _zz_166_;
    _zz_167_[19] = _zz_166_;
    _zz_167_[18] = _zz_166_;
    _zz_167_[17] = _zz_166_;
    _zz_167_[16] = _zz_166_;
    _zz_167_[15 : 0] = writeBack_DBusCachedPlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_376_)
      2'b00 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_165_;
      end
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_167_;
      end
      default : begin
        writeBack_DBusCachedPlugin_rspFormated = writeBack_DBusCachedPlugin_rspShifted;
      end
    endcase
  end

  always @ (*) begin
    MemoryTranslatorPlugin_shared_readAddr = (8'bxxxxxxxx);
    if(MemoryTranslatorPlugin_ports_0_sharedAccessGranted)begin
      MemoryTranslatorPlugin_shared_readAddr = MemoryTranslatorPlugin_ports_0_sharedIterator[7:0];
    end
    if(MemoryTranslatorPlugin_ports_1_sharedAccessGranted)begin
      MemoryTranslatorPlugin_shared_readAddr = MemoryTranslatorPlugin_ports_1_sharedIterator[7:0];
    end
  end

  assign _zz_168_ = _zz_289_;
  assign MemoryTranslatorPlugin_ports_0_cacheHits_0 = (MemoryTranslatorPlugin_ports_0_cache_0_valid && (MemoryTranslatorPlugin_ports_0_cache_0_virtualAddress == _zz_124_[31 : 12]));
  assign MemoryTranslatorPlugin_ports_0_cacheHits_1 = (MemoryTranslatorPlugin_ports_0_cache_1_valid && (MemoryTranslatorPlugin_ports_0_cache_1_virtualAddress == _zz_124_[31 : 12]));
  assign MemoryTranslatorPlugin_ports_0_cacheHits_2 = (MemoryTranslatorPlugin_ports_0_cache_2_valid && (MemoryTranslatorPlugin_ports_0_cache_2_virtualAddress == _zz_124_[31 : 12]));
  assign MemoryTranslatorPlugin_ports_0_cacheHits_3 = (MemoryTranslatorPlugin_ports_0_cache_3_valid && (MemoryTranslatorPlugin_ports_0_cache_3_virtualAddress == _zz_124_[31 : 12]));
  assign MemoryTranslatorPlugin_ports_0_cacheHit = ({MemoryTranslatorPlugin_ports_0_cacheHits_3,{MemoryTranslatorPlugin_ports_0_cacheHits_2,{MemoryTranslatorPlugin_ports_0_cacheHits_1,MemoryTranslatorPlugin_ports_0_cacheHits_0}}} != (4'b0000));
  assign _zz_169_ = (MemoryTranslatorPlugin_ports_0_cacheHits_1 || MemoryTranslatorPlugin_ports_0_cacheHits_3);
  assign _zz_170_ = (MemoryTranslatorPlugin_ports_0_cacheHits_2 || MemoryTranslatorPlugin_ports_0_cacheHits_3);
  assign _zz_171_ = {_zz_170_,_zz_169_};
  assign MemoryTranslatorPlugin_ports_0_cacheLine_valid = _zz_293_;
  assign MemoryTranslatorPlugin_ports_0_cacheLine_virtualAddress = _zz_294_;
  assign MemoryTranslatorPlugin_ports_0_cacheLine_physicalAddress = _zz_295_;
  assign MemoryTranslatorPlugin_ports_0_cacheLine_allowRead = _zz_296_;
  assign MemoryTranslatorPlugin_ports_0_cacheLine_allowWrite = _zz_297_;
  assign MemoryTranslatorPlugin_ports_0_cacheLine_allowExecute = _zz_298_;
  assign MemoryTranslatorPlugin_ports_0_cacheLine_allowUser = _zz_299_;
  assign MemoryTranslatorPlugin_ports_0_isInMmuRange = ((((4'b0000) <= _zz_124_[31 : 28]) && (_zz_124_[31 : 28] <= (4'b1011))) && (! _zz_125_));
  assign MemoryTranslatorPlugin_ports_0_isInKernelRange = ((_zz_124_[31 : 28] == (4'b1100)) && (! _zz_125_));
  always @ (*) begin
    MemoryTranslatorPlugin_ports_0_entryToReplace_willIncrement = 1'b0;
    if(_zz_369_)begin
      if(_zz_370_)begin
        MemoryTranslatorPlugin_ports_0_entryToReplace_willIncrement = 1'b1;
      end
    end
  end

  assign MemoryTranslatorPlugin_ports_0_entryToReplace_willClear = 1'b0;
  assign MemoryTranslatorPlugin_ports_0_entryToReplace_willOverflowIfInc = (MemoryTranslatorPlugin_ports_0_entryToReplace_value == (2'b11));
  assign MemoryTranslatorPlugin_ports_0_entryToReplace_willOverflow = (MemoryTranslatorPlugin_ports_0_entryToReplace_willOverflowIfInc && MemoryTranslatorPlugin_ports_0_entryToReplace_willIncrement);
  always @ (*) begin
    MemoryTranslatorPlugin_ports_0_entryToReplace_valueNext = (MemoryTranslatorPlugin_ports_0_entryToReplace_value + _zz_395_);
    if(MemoryTranslatorPlugin_ports_0_entryToReplace_willClear)begin
      MemoryTranslatorPlugin_ports_0_entryToReplace_valueNext = (2'b00);
    end
  end

  assign MemoryTranslatorPlugin_ports_0_sharedAccessGranted = (MemoryTranslatorPlugin_ports_0_sharedAccessAsked && 1'b1);
  assign _zz_172_ = ({3'd0,(1'b1)} <<< MemoryTranslatorPlugin_ports_0_entryToReplace_value);
  assign _zz_173_ = _zz_172_[0];
  assign _zz_174_ = _zz_172_[1];
  assign _zz_175_ = _zz_172_[2];
  assign _zz_176_ = _zz_172_[3];
  always @ (*) begin
    if(MemoryTranslatorPlugin_ports_0_isInKernelRange)begin
      _zz_126_[31 : 28] = (4'b0100);
      _zz_126_[27 : 0] = _zz_124_[27 : 0];
      _zz_127_ = 1'b1;
      _zz_128_ = 1'b1;
      _zz_129_ = 1'b1;
      _zz_130_ = 1'b0;
      _zz_132_ = 1'b1;
    end else begin
      if((MemoryTranslatorPlugin_ports_0_isInMmuRange && MemoryTranslatorPlugin_mmuEnabled))begin
        _zz_126_ = {MemoryTranslatorPlugin_ports_0_cacheLine_physicalAddress,_zz_124_[11 : 0]};
        _zz_127_ = MemoryTranslatorPlugin_ports_0_cacheLine_allowRead;
        _zz_128_ = MemoryTranslatorPlugin_ports_0_cacheLine_allowWrite;
        _zz_129_ = MemoryTranslatorPlugin_ports_0_cacheLine_allowExecute;
        _zz_130_ = MemoryTranslatorPlugin_ports_0_cacheLine_allowUser;
        _zz_132_ = MemoryTranslatorPlugin_ports_0_cacheHit;
      end else begin
        _zz_126_ = _zz_124_;
        _zz_127_ = 1'b1;
        _zz_128_ = 1'b1;
        _zz_129_ = 1'b1;
        _zz_130_ = 1'b1;
        _zz_132_ = 1'b1;
      end
    end
  end

  assign _zz_131_ = MemoryTranslatorPlugin_ports_0_sharedMiss;
  assign MemoryTranslatorPlugin_ports_1_cacheHits_0 = (MemoryTranslatorPlugin_ports_1_cache_0_valid && (MemoryTranslatorPlugin_ports_1_cache_0_virtualAddress == _zz_114_[31 : 12]));
  assign MemoryTranslatorPlugin_ports_1_cacheHits_1 = (MemoryTranslatorPlugin_ports_1_cache_1_valid && (MemoryTranslatorPlugin_ports_1_cache_1_virtualAddress == _zz_114_[31 : 12]));
  assign MemoryTranslatorPlugin_ports_1_cacheHits_2 = (MemoryTranslatorPlugin_ports_1_cache_2_valid && (MemoryTranslatorPlugin_ports_1_cache_2_virtualAddress == _zz_114_[31 : 12]));
  assign MemoryTranslatorPlugin_ports_1_cacheHits_3 = (MemoryTranslatorPlugin_ports_1_cache_3_valid && (MemoryTranslatorPlugin_ports_1_cache_3_virtualAddress == _zz_114_[31 : 12]));
  assign MemoryTranslatorPlugin_ports_1_cacheHit = ({MemoryTranslatorPlugin_ports_1_cacheHits_3,{MemoryTranslatorPlugin_ports_1_cacheHits_2,{MemoryTranslatorPlugin_ports_1_cacheHits_1,MemoryTranslatorPlugin_ports_1_cacheHits_0}}} != (4'b0000));
  assign _zz_177_ = (MemoryTranslatorPlugin_ports_1_cacheHits_1 || MemoryTranslatorPlugin_ports_1_cacheHits_3);
  assign _zz_178_ = (MemoryTranslatorPlugin_ports_1_cacheHits_2 || MemoryTranslatorPlugin_ports_1_cacheHits_3);
  assign _zz_179_ = {_zz_178_,_zz_177_};
  assign MemoryTranslatorPlugin_ports_1_cacheLine_valid = _zz_300_;
  assign MemoryTranslatorPlugin_ports_1_cacheLine_virtualAddress = _zz_301_;
  assign MemoryTranslatorPlugin_ports_1_cacheLine_physicalAddress = _zz_302_;
  assign MemoryTranslatorPlugin_ports_1_cacheLine_allowRead = _zz_303_;
  assign MemoryTranslatorPlugin_ports_1_cacheLine_allowWrite = _zz_304_;
  assign MemoryTranslatorPlugin_ports_1_cacheLine_allowExecute = _zz_305_;
  assign MemoryTranslatorPlugin_ports_1_cacheLine_allowUser = _zz_306_;
  assign MemoryTranslatorPlugin_ports_1_isInMmuRange = ((((4'b0000) <= _zz_114_[31 : 28]) && (_zz_114_[31 : 28] <= (4'b1011))) && (! _zz_115_));
  assign MemoryTranslatorPlugin_ports_1_isInKernelRange = ((_zz_114_[31 : 28] == (4'b1100)) && (! _zz_115_));
  always @ (*) begin
    MemoryTranslatorPlugin_ports_1_entryToReplace_willIncrement = 1'b0;
    if(_zz_371_)begin
      if(_zz_372_)begin
        MemoryTranslatorPlugin_ports_1_entryToReplace_willIncrement = 1'b1;
      end
    end
  end

  assign MemoryTranslatorPlugin_ports_1_entryToReplace_willClear = 1'b0;
  assign MemoryTranslatorPlugin_ports_1_entryToReplace_willOverflowIfInc = (MemoryTranslatorPlugin_ports_1_entryToReplace_value == (2'b11));
  assign MemoryTranslatorPlugin_ports_1_entryToReplace_willOverflow = (MemoryTranslatorPlugin_ports_1_entryToReplace_willOverflowIfInc && MemoryTranslatorPlugin_ports_1_entryToReplace_willIncrement);
  always @ (*) begin
    MemoryTranslatorPlugin_ports_1_entryToReplace_valueNext = (MemoryTranslatorPlugin_ports_1_entryToReplace_value + _zz_398_);
    if(MemoryTranslatorPlugin_ports_1_entryToReplace_willClear)begin
      MemoryTranslatorPlugin_ports_1_entryToReplace_valueNext = (2'b00);
    end
  end

  assign MemoryTranslatorPlugin_ports_1_sharedAccessGranted = (MemoryTranslatorPlugin_ports_1_sharedAccessAsked && _zz_93_);
  assign _zz_180_ = ({3'd0,(1'b1)} <<< MemoryTranslatorPlugin_ports_1_entryToReplace_value);
  assign _zz_181_ = _zz_180_[0];
  assign _zz_182_ = _zz_180_[1];
  assign _zz_183_ = _zz_180_[2];
  assign _zz_184_ = _zz_180_[3];
  always @ (*) begin
    if(MemoryTranslatorPlugin_ports_1_isInKernelRange)begin
      _zz_116_[31 : 28] = (4'b0100);
      _zz_116_[27 : 0] = _zz_114_[27 : 0];
      _zz_117_ = 1'b1;
      _zz_118_ = 1'b1;
      _zz_119_ = 1'b1;
      _zz_120_ = 1'b0;
      _zz_122_ = 1'b1;
    end else begin
      if((MemoryTranslatorPlugin_ports_1_isInMmuRange && MemoryTranslatorPlugin_mmuEnabled))begin
        _zz_116_ = {MemoryTranslatorPlugin_ports_1_cacheLine_physicalAddress,_zz_114_[11 : 0]};
        _zz_117_ = MemoryTranslatorPlugin_ports_1_cacheLine_allowRead;
        _zz_118_ = MemoryTranslatorPlugin_ports_1_cacheLine_allowWrite;
        _zz_119_ = MemoryTranslatorPlugin_ports_1_cacheLine_allowExecute;
        _zz_120_ = MemoryTranslatorPlugin_ports_1_cacheLine_allowUser;
        _zz_122_ = MemoryTranslatorPlugin_ports_1_cacheHit;
      end else begin
        _zz_116_ = _zz_114_;
        _zz_117_ = 1'b1;
        _zz_118_ = 1'b1;
        _zz_119_ = 1'b1;
        _zz_120_ = 1'b1;
        _zz_122_ = 1'b1;
      end
    end
  end

  assign _zz_121_ = MemoryTranslatorPlugin_ports_1_sharedMiss;
  assign _zz_186_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000101000)) == (32'b00000000000000000000000000000000));
  assign _zz_187_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000001100)) == (32'b00000000000000000000000000000100));
  assign _zz_188_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001001000));
  assign _zz_189_ = ((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000000000000000000));
  assign _zz_190_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000001000000));
  assign _zz_191_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_192_ = ((decode_INSTRUCTION & (32'b00000000000000000100000001010000)) == (32'b00000000000000000100000001010000));
  assign _zz_193_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001000000)) == (32'b00000000000000000000000001000000));
  assign _zz_185_ = {({_zz_188_,{_zz_187_,_zz_502_}} != (3'b000)),{({_zz_188_,{_zz_503_,_zz_504_}} != (3'b000)),{(_zz_505_ != (1'b0)),{(_zz_506_ != _zz_507_),{_zz_508_,{_zz_509_,_zz_510_}}}}}};
  assign _zz_91_ = ({((decode_INSTRUCTION & (32'b00000000000000000000000001011111)) == (32'b00000000000000000000000000010111)),{((decode_INSTRUCTION & (32'b00000000000000000000000001111111)) == (32'b00000000000000000000000001101111)),{((decode_INSTRUCTION & (32'b00000000000000000001000001101111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_690_) == (32'b00000000000000000001000001110011)),{(_zz_691_ == _zz_692_),{_zz_693_,{_zz_694_,_zz_695_}}}}}}} != (24'b000000000000000000000000));
  assign _zz_90_ = _zz_401_[0];
  assign _zz_89_ = _zz_402_[0];
  assign _zz_88_ = _zz_403_[0];
  assign _zz_87_ = _zz_404_[0];
  assign _zz_86_ = _zz_405_[0];
  assign _zz_85_ = _zz_406_[0];
  assign _zz_84_ = _zz_407_[0];
  assign _zz_83_ = _zz_408_[0];
  assign _zz_194_ = _zz_185_[10 : 9];
  assign _zz_82_ = _zz_194_;
  assign _zz_81_ = _zz_409_[0];
  assign _zz_80_ = _zz_410_[0];
  assign _zz_79_ = _zz_411_[0];
  assign _zz_78_ = _zz_412_[0];
  assign _zz_77_ = _zz_413_[0];
  assign _zz_76_ = _zz_414_[0];
  assign _zz_195_ = _zz_185_[18 : 17];
  assign _zz_75_ = _zz_195_;
  assign _zz_196_ = _zz_185_[20 : 19];
  assign _zz_74_ = _zz_196_;
  assign _zz_73_ = _zz_415_[0];
  assign _zz_72_ = _zz_416_[0];
  assign _zz_71_ = _zz_417_[0];
  assign _zz_70_ = _zz_418_[0];
  assign _zz_197_ = _zz_185_[26 : 25];
  assign _zz_69_ = _zz_197_;
  assign _zz_198_ = _zz_185_[28 : 27];
  assign _zz_68_ = _zz_198_;
  assign _zz_199_ = _zz_185_[30 : 29];
  assign _zz_67_ = _zz_199_;
  assign _zz_66_ = _zz_419_[0];
  assign _zz_200_ = _zz_185_[33 : 32];
  assign _zz_65_ = _zz_200_;
  always @ (*) begin
    if((decode_INSTRUCTION == (32'b00000000000000000000000001110011)))begin
      decodeExceptionPort_valid = (decode_arbitration_isValid && decode_INSTRUCTION_READY);
      decodeExceptionPort_1_code = (4'b1011);
      decodeExceptionPort_1_badAddr = decode_PC;
    end else begin
      decodeExceptionPort_valid = ((decode_arbitration_isValid && decode_INSTRUCTION_READY) && (! decode_LEGAL_INSTRUCTION));
      decodeExceptionPort_1_code = (4'b0010);
      decodeExceptionPort_1_badAddr = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    end
  end

  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign decode_RegFilePlugin_rs1Data = _zz_290_;
  assign decode_RegFilePlugin_rs2Data = _zz_291_;
  assign _zz_64_ = decode_RegFilePlugin_rs1Data;
  assign _zz_63_ = decode_RegFilePlugin_rs2Data;
  always @ (*) begin
    writeBack_RegFilePlugin_regFileWrite_valid = (_zz_61_ && writeBack_arbitration_isFiring);
    if(_zz_201_)begin
      writeBack_RegFilePlugin_regFileWrite_valid = 1'b1;
    end
  end

  assign writeBack_RegFilePlugin_regFileWrite_payload_address = _zz_60_[11 : 7];
  assign writeBack_RegFilePlugin_regFileWrite_payload_data = _zz_94_;
  always @ (*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = execute_SRC1;
      end
    endcase
  end

  always @ (*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_BITWISE : begin
        _zz_202_ = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : begin
        _zz_202_ = {31'd0, _zz_420_};
      end
      default : begin
        _zz_202_ = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_58_ = _zz_202_;
  always @ (*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : begin
        _zz_203_ = execute_RS1;
      end
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : begin
        _zz_203_ = {29'd0, _zz_421_};
      end
      `Src1CtrlEnum_defaultEncoding_IMU : begin
        _zz_203_ = {execute_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
      default : begin
        _zz_203_ = {27'd0, _zz_422_};
      end
    endcase
  end

  assign _zz_56_ = _zz_203_;
  assign _zz_204_ = _zz_423_[11];
  always @ (*) begin
    _zz_205_[19] = _zz_204_;
    _zz_205_[18] = _zz_204_;
    _zz_205_[17] = _zz_204_;
    _zz_205_[16] = _zz_204_;
    _zz_205_[15] = _zz_204_;
    _zz_205_[14] = _zz_204_;
    _zz_205_[13] = _zz_204_;
    _zz_205_[12] = _zz_204_;
    _zz_205_[11] = _zz_204_;
    _zz_205_[10] = _zz_204_;
    _zz_205_[9] = _zz_204_;
    _zz_205_[8] = _zz_204_;
    _zz_205_[7] = _zz_204_;
    _zz_205_[6] = _zz_204_;
    _zz_205_[5] = _zz_204_;
    _zz_205_[4] = _zz_204_;
    _zz_205_[3] = _zz_204_;
    _zz_205_[2] = _zz_204_;
    _zz_205_[1] = _zz_204_;
    _zz_205_[0] = _zz_204_;
  end

  assign _zz_206_ = _zz_424_[11];
  always @ (*) begin
    _zz_207_[19] = _zz_206_;
    _zz_207_[18] = _zz_206_;
    _zz_207_[17] = _zz_206_;
    _zz_207_[16] = _zz_206_;
    _zz_207_[15] = _zz_206_;
    _zz_207_[14] = _zz_206_;
    _zz_207_[13] = _zz_206_;
    _zz_207_[12] = _zz_206_;
    _zz_207_[11] = _zz_206_;
    _zz_207_[10] = _zz_206_;
    _zz_207_[9] = _zz_206_;
    _zz_207_[8] = _zz_206_;
    _zz_207_[7] = _zz_206_;
    _zz_207_[6] = _zz_206_;
    _zz_207_[5] = _zz_206_;
    _zz_207_[4] = _zz_206_;
    _zz_207_[3] = _zz_206_;
    _zz_207_[2] = _zz_206_;
    _zz_207_[1] = _zz_206_;
    _zz_207_[0] = _zz_206_;
  end

  always @ (*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : begin
        _zz_208_ = execute_RS2;
      end
      `Src2CtrlEnum_defaultEncoding_IMI : begin
        _zz_208_ = {_zz_205_,execute_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_defaultEncoding_IMS : begin
        _zz_208_ = {_zz_207_,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_208_ = _zz_52_;
      end
    endcase
  end

  assign _zz_54_ = _zz_208_;
  assign execute_SrcPlugin_addSub = _zz_425_;
  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign _zz_51_ = execute_SrcPlugin_addSub;
  assign _zz_50_ = execute_SrcPlugin_addSub;
  assign _zz_49_ = execute_SrcPlugin_less;
  assign execute_FullBarrelShifterPlugin_amplitude = execute_SRC2[4 : 0];
  always @ (*) begin
    _zz_209_[0] = execute_SRC1[31];
    _zz_209_[1] = execute_SRC1[30];
    _zz_209_[2] = execute_SRC1[29];
    _zz_209_[3] = execute_SRC1[28];
    _zz_209_[4] = execute_SRC1[27];
    _zz_209_[5] = execute_SRC1[26];
    _zz_209_[6] = execute_SRC1[25];
    _zz_209_[7] = execute_SRC1[24];
    _zz_209_[8] = execute_SRC1[23];
    _zz_209_[9] = execute_SRC1[22];
    _zz_209_[10] = execute_SRC1[21];
    _zz_209_[11] = execute_SRC1[20];
    _zz_209_[12] = execute_SRC1[19];
    _zz_209_[13] = execute_SRC1[18];
    _zz_209_[14] = execute_SRC1[17];
    _zz_209_[15] = execute_SRC1[16];
    _zz_209_[16] = execute_SRC1[15];
    _zz_209_[17] = execute_SRC1[14];
    _zz_209_[18] = execute_SRC1[13];
    _zz_209_[19] = execute_SRC1[12];
    _zz_209_[20] = execute_SRC1[11];
    _zz_209_[21] = execute_SRC1[10];
    _zz_209_[22] = execute_SRC1[9];
    _zz_209_[23] = execute_SRC1[8];
    _zz_209_[24] = execute_SRC1[7];
    _zz_209_[25] = execute_SRC1[6];
    _zz_209_[26] = execute_SRC1[5];
    _zz_209_[27] = execute_SRC1[4];
    _zz_209_[28] = execute_SRC1[3];
    _zz_209_[29] = execute_SRC1[2];
    _zz_209_[30] = execute_SRC1[1];
    _zz_209_[31] = execute_SRC1[0];
  end

  assign execute_FullBarrelShifterPlugin_reversed = ((execute_SHIFT_CTRL == `ShiftCtrlEnum_defaultEncoding_SLL_1) ? _zz_209_ : execute_SRC1);
  assign _zz_47_ = _zz_434_;
  always @ (*) begin
    _zz_210_[0] = memory_SHIFT_RIGHT[31];
    _zz_210_[1] = memory_SHIFT_RIGHT[30];
    _zz_210_[2] = memory_SHIFT_RIGHT[29];
    _zz_210_[3] = memory_SHIFT_RIGHT[28];
    _zz_210_[4] = memory_SHIFT_RIGHT[27];
    _zz_210_[5] = memory_SHIFT_RIGHT[26];
    _zz_210_[6] = memory_SHIFT_RIGHT[25];
    _zz_210_[7] = memory_SHIFT_RIGHT[24];
    _zz_210_[8] = memory_SHIFT_RIGHT[23];
    _zz_210_[9] = memory_SHIFT_RIGHT[22];
    _zz_210_[10] = memory_SHIFT_RIGHT[21];
    _zz_210_[11] = memory_SHIFT_RIGHT[20];
    _zz_210_[12] = memory_SHIFT_RIGHT[19];
    _zz_210_[13] = memory_SHIFT_RIGHT[18];
    _zz_210_[14] = memory_SHIFT_RIGHT[17];
    _zz_210_[15] = memory_SHIFT_RIGHT[16];
    _zz_210_[16] = memory_SHIFT_RIGHT[15];
    _zz_210_[17] = memory_SHIFT_RIGHT[14];
    _zz_210_[18] = memory_SHIFT_RIGHT[13];
    _zz_210_[19] = memory_SHIFT_RIGHT[12];
    _zz_210_[20] = memory_SHIFT_RIGHT[11];
    _zz_210_[21] = memory_SHIFT_RIGHT[10];
    _zz_210_[22] = memory_SHIFT_RIGHT[9];
    _zz_210_[23] = memory_SHIFT_RIGHT[8];
    _zz_210_[24] = memory_SHIFT_RIGHT[7];
    _zz_210_[25] = memory_SHIFT_RIGHT[6];
    _zz_210_[26] = memory_SHIFT_RIGHT[5];
    _zz_210_[27] = memory_SHIFT_RIGHT[4];
    _zz_210_[28] = memory_SHIFT_RIGHT[3];
    _zz_210_[29] = memory_SHIFT_RIGHT[2];
    _zz_210_[30] = memory_SHIFT_RIGHT[1];
    _zz_210_[31] = memory_SHIFT_RIGHT[0];
  end

  assign execute_MulPlugin_a = execute_SRC1;
  assign execute_MulPlugin_b = execute_SRC2;
  always @ (*) begin
    case(_zz_377_)
      2'b01 : begin
        execute_MulPlugin_aSigned = 1'b1;
        execute_MulPlugin_bSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_aSigned = 1'b1;
        execute_MulPlugin_bSigned = 1'b0;
      end
      default : begin
        execute_MulPlugin_aSigned = 1'b0;
        execute_MulPlugin_bSigned = 1'b0;
      end
    endcase
  end

  assign execute_MulPlugin_aULow = execute_MulPlugin_a[15 : 0];
  assign execute_MulPlugin_bULow = execute_MulPlugin_b[15 : 0];
  assign execute_MulPlugin_aSLow = {1'b0,execute_MulPlugin_a[15 : 0]};
  assign execute_MulPlugin_bSLow = {1'b0,execute_MulPlugin_b[15 : 0]};
  assign execute_MulPlugin_aHigh = {(execute_MulPlugin_aSigned && execute_MulPlugin_a[31]),execute_MulPlugin_a[31 : 16]};
  assign execute_MulPlugin_bHigh = {(execute_MulPlugin_bSigned && execute_MulPlugin_b[31]),execute_MulPlugin_b[31 : 16]};
  assign _zz_44_ = (execute_MulPlugin_aULow * execute_MulPlugin_bULow);
  assign _zz_43_ = ($signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh));
  assign _zz_42_ = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow));
  assign _zz_41_ = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh));
  assign _zz_40_ = ($signed(_zz_436_) + $signed(_zz_444_));
  assign writeBack_MulPlugin_result = ($signed(_zz_445_) + $signed(_zz_446_));
  always @ (*) begin
    memory_DivPlugin_div_counter_willClear = 1'b0;
    if(_zz_373_)begin
      memory_DivPlugin_div_counter_willClear = 1'b1;
    end
  end

  assign memory_DivPlugin_div_willOverflowIfInc = (memory_DivPlugin_div_counter_value == (6'b100001));
  assign memory_DivPlugin_div_counter_willOverflow = (memory_DivPlugin_div_willOverflowIfInc && memory_DivPlugin_div_counter_willIncrement);
  always @ (*) begin
    if(memory_DivPlugin_div_counter_willOverflow)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end else begin
      memory_DivPlugin_div_counter_valueNext = (memory_DivPlugin_div_counter_value + _zz_450_);
    end
    if(memory_DivPlugin_div_counter_willClear)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end
  end

  assign _zz_211_ = memory_DivPlugin_rs1[31 : 0];
  assign _zz_212_ = {memory_DivPlugin_accumulator[31 : 0],_zz_211_[31]};
  assign _zz_213_ = (_zz_212_ - _zz_451_);
  assign _zz_214_ = (memory_INSTRUCTION[13] ? memory_DivPlugin_accumulator[31 : 0] : memory_DivPlugin_rs1[31 : 0]);
  assign _zz_215_ = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_216_ = (1'b0 || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @ (*) begin
    _zz_217_[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_217_[31 : 0] = execute_RS1;
  end

  always @ (*) begin
    _zz_218_ = 1'b0;
    _zz_219_ = 1'b0;
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! 1'b1)))begin
        if(_zz_224_)begin
          _zz_218_ = 1'b1;
        end
        if(_zz_225_)begin
          _zz_219_ = 1'b1;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE)))begin
        if(_zz_226_)begin
          _zz_218_ = 1'b1;
        end
        if(_zz_227_)begin
          _zz_219_ = 1'b1;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE)))begin
        if(_zz_228_)begin
          _zz_218_ = 1'b1;
        end
        if(_zz_229_)begin
          _zz_219_ = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _zz_218_ = 1'b0;
    end
    if((! decode_RS2_USE))begin
      _zz_219_ = 1'b0;
    end
  end

  assign _zz_220_ = (_zz_61_ && writeBack_arbitration_isFiring);
  assign _zz_224_ = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_225_ = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_226_ = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_227_ = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_228_ = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_229_ = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_38_ = (_zz_109_ && (! decode_IS_FENCEI));
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_230_ = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_230_ == (3'b000))) begin
        _zz_231_ = execute_BranchPlugin_eq;
    end else if((_zz_230_ == (3'b001))) begin
        _zz_231_ = (! execute_BranchPlugin_eq);
    end else if((((_zz_230_ & (3'b101)) == (3'b101)))) begin
        _zz_231_ = (! execute_SRC_LESS);
    end else begin
        _zz_231_ = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : begin
        _zz_232_ = 1'b0;
      end
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_232_ = 1'b1;
      end
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_232_ = 1'b1;
      end
      default : begin
        _zz_232_ = _zz_231_;
      end
    endcase
  end

  assign _zz_37_ = _zz_232_;
  assign _zz_233_ = _zz_464_[11];
  always @ (*) begin
    _zz_234_[19] = _zz_233_;
    _zz_234_[18] = _zz_233_;
    _zz_234_[17] = _zz_233_;
    _zz_234_[16] = _zz_233_;
    _zz_234_[15] = _zz_233_;
    _zz_234_[14] = _zz_233_;
    _zz_234_[13] = _zz_233_;
    _zz_234_[12] = _zz_233_;
    _zz_234_[11] = _zz_233_;
    _zz_234_[10] = _zz_233_;
    _zz_234_[9] = _zz_233_;
    _zz_234_[8] = _zz_233_;
    _zz_234_[7] = _zz_233_;
    _zz_234_[6] = _zz_233_;
    _zz_234_[5] = _zz_233_;
    _zz_234_[4] = _zz_233_;
    _zz_234_[3] = _zz_233_;
    _zz_234_[2] = _zz_233_;
    _zz_234_[1] = _zz_233_;
    _zz_234_[0] = _zz_233_;
  end

  assign _zz_235_ = _zz_465_[19];
  always @ (*) begin
    _zz_236_[10] = _zz_235_;
    _zz_236_[9] = _zz_235_;
    _zz_236_[8] = _zz_235_;
    _zz_236_[7] = _zz_235_;
    _zz_236_[6] = _zz_235_;
    _zz_236_[5] = _zz_235_;
    _zz_236_[4] = _zz_235_;
    _zz_236_[3] = _zz_235_;
    _zz_236_[2] = _zz_235_;
    _zz_236_[1] = _zz_235_;
    _zz_236_[0] = _zz_235_;
  end

  assign _zz_237_ = _zz_466_[11];
  always @ (*) begin
    _zz_238_[18] = _zz_237_;
    _zz_238_[17] = _zz_237_;
    _zz_238_[16] = _zz_237_;
    _zz_238_[15] = _zz_237_;
    _zz_238_[14] = _zz_237_;
    _zz_238_[13] = _zz_237_;
    _zz_238_[12] = _zz_237_;
    _zz_238_[11] = _zz_237_;
    _zz_238_[10] = _zz_237_;
    _zz_238_[9] = _zz_237_;
    _zz_238_[8] = _zz_237_;
    _zz_238_[7] = _zz_237_;
    _zz_238_[6] = _zz_237_;
    _zz_238_[5] = _zz_237_;
    _zz_238_[4] = _zz_237_;
    _zz_238_[3] = _zz_237_;
    _zz_238_[2] = _zz_237_;
    _zz_238_[1] = _zz_237_;
    _zz_238_[0] = _zz_237_;
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_239_ = (_zz_467_[1] ^ execute_RS1[1]);
      end
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_239_ = _zz_468_[1];
      end
      default : begin
        _zz_239_ = _zz_469_[1];
      end
    endcase
  end

  assign execute_BranchPlugin_missAlignedTarget = (execute_BRANCH_COND_RESULT && _zz_239_);
  assign _zz_35_ = ((execute_PREDICTION_HAD_BRANCHED2 != execute_BRANCH_COND_RESULT) || execute_BranchPlugin_missAlignedTarget);
  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        execute_BranchPlugin_branch_src1 = execute_RS1;
        execute_BranchPlugin_branch_src2 = {_zz_241_,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        execute_BranchPlugin_branch_src1 = execute_PC;
        execute_BranchPlugin_branch_src2 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) ? {{_zz_243_,{{{_zz_713_,execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_245_,{{{_zz_714_,_zz_715_},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0});
        if((execute_PREDICTION_HAD_BRANCHED2 && (! execute_BranchPlugin_missAlignedTarget)))begin
          execute_BranchPlugin_branch_src2 = {29'd0, _zz_473_};
        end
      end
    endcase
  end

  assign _zz_240_ = _zz_470_[11];
  always @ (*) begin
    _zz_241_[19] = _zz_240_;
    _zz_241_[18] = _zz_240_;
    _zz_241_[17] = _zz_240_;
    _zz_241_[16] = _zz_240_;
    _zz_241_[15] = _zz_240_;
    _zz_241_[14] = _zz_240_;
    _zz_241_[13] = _zz_240_;
    _zz_241_[12] = _zz_240_;
    _zz_241_[11] = _zz_240_;
    _zz_241_[10] = _zz_240_;
    _zz_241_[9] = _zz_240_;
    _zz_241_[8] = _zz_240_;
    _zz_241_[7] = _zz_240_;
    _zz_241_[6] = _zz_240_;
    _zz_241_[5] = _zz_240_;
    _zz_241_[4] = _zz_240_;
    _zz_241_[3] = _zz_240_;
    _zz_241_[2] = _zz_240_;
    _zz_241_[1] = _zz_240_;
    _zz_241_[0] = _zz_240_;
  end

  assign _zz_242_ = _zz_471_[19];
  always @ (*) begin
    _zz_243_[10] = _zz_242_;
    _zz_243_[9] = _zz_242_;
    _zz_243_[8] = _zz_242_;
    _zz_243_[7] = _zz_242_;
    _zz_243_[6] = _zz_242_;
    _zz_243_[5] = _zz_242_;
    _zz_243_[4] = _zz_242_;
    _zz_243_[3] = _zz_242_;
    _zz_243_[2] = _zz_242_;
    _zz_243_[1] = _zz_242_;
    _zz_243_[0] = _zz_242_;
  end

  assign _zz_244_ = _zz_472_[11];
  always @ (*) begin
    _zz_245_[18] = _zz_244_;
    _zz_245_[17] = _zz_244_;
    _zz_245_[16] = _zz_244_;
    _zz_245_[15] = _zz_244_;
    _zz_245_[14] = _zz_244_;
    _zz_245_[13] = _zz_244_;
    _zz_245_[12] = _zz_244_;
    _zz_245_[11] = _zz_244_;
    _zz_245_[10] = _zz_244_;
    _zz_245_[9] = _zz_244_;
    _zz_245_[8] = _zz_244_;
    _zz_245_[7] = _zz_244_;
    _zz_245_[6] = _zz_244_;
    _zz_245_[5] = _zz_244_;
    _zz_245_[4] = _zz_244_;
    _zz_245_[3] = _zz_244_;
    _zz_245_[2] = _zz_244_;
    _zz_245_[1] = _zz_244_;
    _zz_245_[0] = _zz_244_;
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_34_ = {execute_BranchPlugin_branchAdder[31 : 1],(1'b0)};
  assign _zz_133_ = (memory_BRANCH_DO && memory_arbitration_isFiring);
  assign _zz_134_ = memory_BRANCH_CALC;
  assign memory_exception_agregat_valid = (memory_arbitration_isValid && (memory_BRANCH_DO && memory_BRANCH_CALC[1]));
  assign memory_exception_agregat_payload_code = (4'b0000);
  assign memory_exception_agregat_payload_badAddr = memory_BRANCH_CALC;
  assign CsrPlugin_misa_base = (2'b01);
  assign CsrPlugin_misa_extensions = (26'b00000000000000000001000010);
  assign _zz_246_ = (CsrPlugin_sip_STIP && CsrPlugin_sie_STIE);
  assign _zz_247_ = (CsrPlugin_sip_SSIP && CsrPlugin_sie_SSIE);
  assign _zz_248_ = (CsrPlugin_sip_SEIP && CsrPlugin_sie_SEIE);
  assign _zz_249_ = (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE);
  assign _zz_250_ = (CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE);
  assign _zz_251_ = (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE);
  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = (2'b01);
    if(((! CsrPlugin_medeleg[CsrPlugin_exceptionPortCtrl_exceptionContext_code]) || ((2'b01) < CsrPlugin_privilege)))begin
      CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = (2'b11);
    end
  end

  assign decode_exception_agregat_valid = (_zz_112_ || decodeExceptionPort_valid);
  assign _zz_252_ = {decodeExceptionPort_valid,_zz_112_};
  assign _zz_253_ = _zz_474_[0];
  assign decode_exception_agregat_payload_code = (_zz_253_ ? (_zz_317_ ? (4'b1100) : (4'b0001)) : decodeExceptionPort_1_code);
  assign decode_exception_agregat_payload_badAddr = (_zz_253_ ? IBusCachedPlugin_stages_2_input_payload : decodeExceptionPort_1_badAddr);
  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
    if(decode_exception_agregat_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b1;
    end
    if(decode_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
    if(execute_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
    if(memory_exception_agregat_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b1;
    end
    if(memory_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_interrupt = 1'b0;
    CsrPlugin_interruptCode = (4'bxxxx);
    CsrPlugin_interruptTargetPrivilege = (2'bxx);
    if(((CsrPlugin_sstatus_SIE && (CsrPlugin_privilege <= (2'b01))) || (CsrPlugin_privilege == (2'b00))))begin
      if(((_zz_246_ || _zz_247_) || _zz_248_))begin
        CsrPlugin_interrupt = 1'b1;
      end
      if(_zz_246_)begin
        CsrPlugin_interruptCode = (4'b0101);
        CsrPlugin_interruptTargetPrivilege = _zz_254_;
      end
      if(_zz_247_)begin
        CsrPlugin_interruptCode = (4'b0001);
        CsrPlugin_interruptTargetPrivilege = _zz_255_;
      end
      if(_zz_248_)begin
        CsrPlugin_interruptCode = (4'b1001);
        CsrPlugin_interruptTargetPrivilege = _zz_256_;
      end
    end
    if(CsrPlugin_mstatus_MIE)begin
      if(((_zz_249_ || _zz_250_) || _zz_251_))begin
        CsrPlugin_interrupt = 1'b1;
      end
      if(_zz_249_)begin
        CsrPlugin_interruptCode = (4'b0111);
        CsrPlugin_interruptTargetPrivilege = (2'b11);
      end
      if(_zz_250_)begin
        CsrPlugin_interruptCode = (4'b0011);
        CsrPlugin_interruptTargetPrivilege = (2'b11);
      end
      if(_zz_251_)begin
        CsrPlugin_interruptCode = (4'b1011);
        CsrPlugin_interruptTargetPrivilege = (2'b11);
      end
    end
    if((! _zz_137_))begin
      CsrPlugin_interrupt = 1'b0;
    end
  end

  always @ (*) begin
    _zz_254_ = (2'b01);
    if((! CsrPlugin_mideleg[5]))begin
      _zz_254_ = (2'b11);
    end
  end

  always @ (*) begin
    _zz_255_ = (2'b01);
    if((! CsrPlugin_mideleg[1]))begin
      _zz_255_ = (2'b11);
    end
  end

  always @ (*) begin
    _zz_256_ = (2'b01);
    if((! CsrPlugin_mideleg[9]))begin
      _zz_256_ = (2'b11);
    end
  end

  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && _zz_138_);
  always @ (*) begin
    CsrPlugin_pipelineLiberator_done = ((! ((execute_arbitration_isValid || memory_arbitration_isValid) || writeBack_arbitration_isValid)) && IBusCachedPlugin_injector_nextPcCalc_3);
    if(((CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory) || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack))begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign CsrPlugin_interruptJump = (CsrPlugin_interrupt && CsrPlugin_pipelineLiberator_done);
  always @ (*) begin
    CsrPlugin_targetPrivilege = CsrPlugin_interruptTargetPrivilege;
    if(CsrPlugin_hadException)begin
      if((CsrPlugin_exceptionPortCtrl_exceptionContext_code == (4'b1011)))begin
        CsrPlugin_targetPrivilege = (2'b01);
      end else begin
        CsrPlugin_targetPrivilege = CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
      end
    end
  end

  always @ (*) begin
    CsrPlugin_trapCause = CsrPlugin_interruptCode;
    if((CsrPlugin_hadException && (! CsrPlugin_interrupt)))begin
      if((CsrPlugin_exceptionPortCtrl_exceptionContext_code == (4'b1011)))begin
        case(CsrPlugin_privilege)
          2'b00 : begin
            CsrPlugin_trapCause = (4'b1000);
          end
          2'b01 : begin
            CsrPlugin_trapCause = (4'b1001);
          end
          default : begin
            CsrPlugin_trapCause = (4'b1011);
          end
        endcase
      end else begin
        CsrPlugin_trapCause = CsrPlugin_exceptionPortCtrl_exceptionContext_code;
      end
    end
  end

  assign contextSwitching = _zz_135_;
  assign _zz_31_ = (! (((decode_INSTRUCTION[14 : 13] == (2'b01)) && (decode_INSTRUCTION[19 : 15] == (5'b00000))) || ((decode_INSTRUCTION[14 : 13] == (2'b11)) && (decode_INSTRUCTION[19 : 15] == (5'b00000)))));
  assign _zz_30_ = (decode_INSTRUCTION[13 : 7] != (7'b0100000));
  assign execute_CsrPlugin_blockedBySideEffects = (memory_arbitration_isValid || writeBack_arbitration_isValid);
  always @ (*) begin
    execute_CsrPlugin_illegalAccess = (execute_arbitration_isValid && execute_IS_CSR);
    execute_CsrPlugin_readData = (32'b00000000000000000000000000000000);
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = _zz_257_;
      end
      12'b001100000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[12 : 11] = CsrPlugin_mstatus_MPP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mstatus_MPIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mstatus_MIE;
      end
      12'b001100000011 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mideleg;
      end
      12'b000101000010 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 31] = CsrPlugin_scause_interrupt;
        execute_CsrPlugin_readData[3 : 0] = CsrPlugin_scause_exceptionCode;
      end
      12'b000100000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[8 : 8] = CsrPlugin_sstatus_SPP;
        execute_CsrPlugin_readData[5 : 5] = CsrPlugin_sstatus_SPIE;
        execute_CsrPlugin_readData[1 : 1] = CsrPlugin_sstatus_SIE;
      end
      12'b001100000010 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_medeleg;
      end
      12'b001101000001 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mepc;
      end
      12'b101100000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mcycle[31 : 0];
      end
      12'b101110000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mcycle[63 : 32];
      end
      12'b001101000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mip_MEIP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mip_MTIP;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mip_MSIP;
      end
      12'b001100000101 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mtvec;
      end
      12'b000110000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 31] = CsrPlugin_satp_MODE;
        execute_CsrPlugin_readData[30 : 22] = CsrPlugin_satp_ASID;
        execute_CsrPlugin_readData[21 : 0] = CsrPlugin_satp_PPN;
      end
      12'b110011000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[12 : 0] = (13'b1000000000000);
        execute_CsrPlugin_readData[25 : 20] = (6'b100000);
      end
      12'b000101000001 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_sepc;
      end
      12'b000101000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[9 : 9] = CsrPlugin_sip_SEIP;
        execute_CsrPlugin_readData[5 : 5] = CsrPlugin_sip_STIP;
        execute_CsrPlugin_readData[1 : 1] = CsrPlugin_sip_SSIP;
      end
      12'b001101000011 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mtval;
      end
      12'b000100000101 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_stvec;
      end
      12'b111111000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = _zz_258_;
      end
      12'b110000000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mcycle[31 : 0];
      end
      12'b001101000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mscratch;
      end
      12'b001100000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mie_MEIE;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mie_MTIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mie_MSIE;
      end
      12'b000101000011 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_stval;
      end
      12'b000101000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_sscratch;
      end
      12'b110010000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mcycle[63 : 32];
      end
      12'b001101000010 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 31] = CsrPlugin_mcause_interrupt;
        execute_CsrPlugin_readData[3 : 0] = CsrPlugin_mcause_exceptionCode;
      end
      12'b000100000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[9 : 9] = CsrPlugin_sie_SEIE;
        execute_CsrPlugin_readData[5 : 5] = CsrPlugin_sie_STIE;
        execute_CsrPlugin_readData[1 : 1] = CsrPlugin_sie_SSIE;
      end
      default : begin
      end
    endcase
    if((CsrPlugin_privilege < execute_CsrPlugin_csrAddress[9 : 8]))begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
  end

  always @ (*) begin
    execute_CsrPlugin_illegalInstruction = 1'b0;
    if((execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)))begin
      if((execute_INSTRUCTION[29 : 28] != CsrPlugin_privilege))begin
        execute_CsrPlugin_illegalInstruction = 1'b1;
      end
    end
  end

  always @ (*) begin
    case(_zz_379_)
      1'b0 : begin
        execute_CsrPlugin_writeData = execute_REGFILE_WRITE_DATA;
      end
      default : begin
        execute_CsrPlugin_writeData = (execute_INSTRUCTION[12] ? (execute_CsrPlugin_readData & (~ execute_REGFILE_WRITE_DATA)) : (execute_CsrPlugin_readData | execute_REGFILE_WRITE_DATA));
      end
    endcase
  end

  assign execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE);
  assign execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE);
  assign execute_CsrPlugin_writeEnable = (execute_CsrPlugin_writeInstruction && (! execute_arbitration_isStuck));
  assign execute_CsrPlugin_readEnable = (execute_CsrPlugin_readInstruction && (! execute_arbitration_isStuck));
  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20];
  assign _zz_258_ = (_zz_257_ & externalInterruptArray_regNext);
  assign externalInterruptS = (_zz_258_ != (32'b00000000000000000000000000000000));
  assign DebugPlugin_isPipBusy = (DebugPlugin_isPipActive || DebugPlugin_isPipActive_regNext);
  always @ (*) begin
    debug_bus_cmd_ready = 1'b1;
    _zz_139_ = 1'b0;
    if(debug_bus_cmd_valid)begin
      case(_zz_374_)
        6'b000000 : begin
        end
        6'b000001 : begin
          if(debug_bus_cmd_payload_wr)begin
            _zz_139_ = 1'b1;
            debug_bus_cmd_ready = _zz_140_;
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @ (*) begin
    debug_bus_rsp_data = DebugPlugin_busReadDataReg;
    if((! _zz_259_))begin
      debug_bus_rsp_data[0] = DebugPlugin_resetIt;
      debug_bus_rsp_data[1] = DebugPlugin_haltIt;
      debug_bus_rsp_data[2] = DebugPlugin_isPipBusy;
      debug_bus_rsp_data[3] = DebugPlugin_haltedByBreak;
      debug_bus_rsp_data[4] = DebugPlugin_stepIt;
    end
  end

  assign _zz_27_ = ((! DebugPlugin_haltIt) && (decode_IS_EBREAK || 1'b0));
  assign debug_resetOut = DebugPlugin_resetIt_regNext;
  assign _zz_26_ = decode_ALU_BITWISE_CTRL;
  assign _zz_24_ = _zz_67_;
  assign _zz_59_ = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_23_ = decode_SHIFT_CTRL;
  assign _zz_20_ = execute_SHIFT_CTRL;
  assign _zz_21_ = _zz_75_;
  assign _zz_48_ = decode_to_execute_SHIFT_CTRL;
  assign _zz_46_ = execute_to_memory_SHIFT_CTRL;
  assign _zz_18_ = decode_SRC2_CTRL;
  assign _zz_16_ = _zz_65_;
  assign _zz_53_ = decode_to_execute_SRC2_CTRL;
  assign _zz_15_ = decode_BRANCH_CTRL;
  assign _zz_98_ = _zz_69_;
  assign _zz_36_ = decode_to_execute_BRANCH_CTRL;
  assign _zz_13_ = decode_ENV_CTRL;
  assign _zz_10_ = execute_ENV_CTRL;
  assign _zz_8_ = memory_ENV_CTRL;
  assign _zz_11_ = _zz_82_;
  assign _zz_29_ = decode_to_execute_ENV_CTRL;
  assign _zz_28_ = execute_to_memory_ENV_CTRL;
  assign _zz_32_ = memory_to_writeBack_ENV_CTRL;
  assign _zz_6_ = decode_ALU_CTRL;
  assign _zz_4_ = _zz_68_;
  assign _zz_57_ = decode_to_execute_ALU_CTRL;
  assign _zz_3_ = decode_SRC1_CTRL;
  assign _zz_1_ = _zz_74_;
  assign _zz_55_ = decode_to_execute_SRC1_CTRL;
  assign decode_arbitration_isFlushed = (((decode_arbitration_flushAll || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign execute_arbitration_isFlushed = ((execute_arbitration_flushAll || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign memory_arbitration_isFlushed = (memory_arbitration_flushAll || writeBack_arbitration_flushAll);
  assign writeBack_arbitration_isFlushed = writeBack_arbitration_flushAll;
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign iBusWishbone_ADR = {_zz_490_,_zz_262_};
  assign iBusWishbone_CTI = ((_zz_262_ == (3'b111)) ? (3'b111) : (3'b010));
  assign iBusWishbone_BTE = (2'b00);
  assign iBusWishbone_SEL = (4'b1111);
  assign iBusWishbone_WE = 1'b0;
  assign iBusWishbone_DAT_MOSI = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  always @ (*) begin
    iBusWishbone_CYC = 1'b0;
    iBusWishbone_STB = 1'b0;
    if(_zz_375_)begin
      iBusWishbone_CYC = 1'b1;
      iBusWishbone_STB = 1'b1;
    end
  end

  assign iBus_cmd_ready = (iBus_cmd_valid && iBusWishbone_ACK);
  assign iBus_rsp_valid = _zz_263_;
  assign iBus_rsp_payload_data = iBusWishbone_DAT_MISO_regNext;
  assign iBus_rsp_payload_error = 1'b0;
  assign _zz_269_ = (dBus_cmd_payload_length != (3'b000));
  assign _zz_265_ = dBus_cmd_valid;
  assign _zz_267_ = dBus_cmd_payload_wr;
  assign _zz_268_ = (_zz_264_ == dBus_cmd_payload_length);
  assign dBus_cmd_ready = (_zz_266_ && (_zz_267_ || _zz_268_));
  assign dBusWishbone_ADR = ((_zz_269_ ? {{dBus_cmd_payload_address[31 : 5],_zz_264_},(2'b00)} : {dBus_cmd_payload_address[31 : 2],(2'b00)}) >>> 2);
  assign dBusWishbone_CTI = (_zz_269_ ? (_zz_268_ ? (3'b111) : (3'b010)) : (3'b000));
  assign dBusWishbone_BTE = (2'b00);
  assign dBusWishbone_SEL = (_zz_267_ ? dBus_cmd_payload_mask : (4'b1111));
  assign dBusWishbone_WE = _zz_267_;
  assign dBusWishbone_DAT_MOSI = dBus_cmd_payload_data;
  assign _zz_266_ = (_zz_265_ && dBusWishbone_ACK);
  assign dBusWishbone_CYC = _zz_265_;
  assign dBusWishbone_STB = _zz_265_;
  assign dBus_rsp_valid = _zz_270_;
  assign dBus_rsp_payload_data = dBusWishbone_DAT_MISO_regNext;
  assign dBus_rsp_payload_error = 1'b0;
  assign debug_bus_cmd_valid = _zz_353_;
  assign debug_bus_cmd_payload_wr = _zz_356_;
  assign debug_bus_cmd_payload_address = _zz_354_[7:0];
  assign debug_bus_cmd_payload_data = _zz_355_;
  assign jtag_tdo = _zz_344_;
  always @ (posedge clk) begin
    if(reset) begin
      CsrPlugin_privilege <= (2'b11);
      IBusCachedPlugin_fetchPc_pcReg <= externalResetVector;
      IBusCachedPlugin_fetchPc_inc <= 1'b0;
      _zz_147_ <= 1'b0;
      _zz_153_ <= 1'b0;
      _zz_155_ <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_0 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_1 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_2 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_3 <= 1'b0;
      IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      MemoryTranslatorPlugin_mmuEnabled <= 1'b0;
      MemoryTranslatorPlugin_ports_0_cache_0_valid <= 1'b0;
      MemoryTranslatorPlugin_ports_0_cache_1_valid <= 1'b0;
      MemoryTranslatorPlugin_ports_0_cache_2_valid <= 1'b0;
      MemoryTranslatorPlugin_ports_0_cache_3_valid <= 1'b0;
      MemoryTranslatorPlugin_ports_0_sharedMiss <= 1'b0;
      MemoryTranslatorPlugin_ports_0_sharedAccessed <= (2'b00);
      MemoryTranslatorPlugin_ports_0_entryToReplace_value <= (2'b00);
      MemoryTranslatorPlugin_ports_1_cache_0_valid <= 1'b0;
      MemoryTranslatorPlugin_ports_1_cache_1_valid <= 1'b0;
      MemoryTranslatorPlugin_ports_1_cache_2_valid <= 1'b0;
      MemoryTranslatorPlugin_ports_1_cache_3_valid <= 1'b0;
      MemoryTranslatorPlugin_ports_1_sharedMiss <= 1'b0;
      MemoryTranslatorPlugin_ports_1_sharedAccessed <= (2'b00);
      MemoryTranslatorPlugin_ports_1_entryToReplace_value <= (2'b00);
      _zz_201_ <= 1'b1;
      memory_DivPlugin_div_counter_value <= (6'b000000);
      _zz_221_ <= 1'b0;
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= (2'b11);
      CsrPlugin_mip_MEIP <= 1'b0;
      CsrPlugin_mip_MTIP <= 1'b0;
      CsrPlugin_mip_MSIP <= 1'b0;
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_medeleg <= (32'b00000000000000000000000000000000);
      CsrPlugin_mideleg <= (32'b00000000000000000000000000000000);
      CsrPlugin_sstatus_SIE <= 1'b0;
      CsrPlugin_sstatus_SPIE <= 1'b0;
      CsrPlugin_sstatus_SPP <= (1'b1);
      CsrPlugin_sip_SEIP <= 1'b0;
      CsrPlugin_sip_STIP <= 1'b0;
      CsrPlugin_sip_SSIP <= 1'b0;
      CsrPlugin_sie_SEIE <= 1'b0;
      CsrPlugin_sie_STIE <= 1'b0;
      CsrPlugin_sie_SSIE <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      CsrPlugin_writeBackWasWfi <= 1'b0;
      CsrPlugin_hadException <= 1'b0;
      _zz_257_ <= (32'b00000000000000000000000000000000);
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      _zz_260_ <= (3'b000);
      memory_to_writeBack_REGFILE_WRITE_DATA <= (32'b00000000000000000000000000000000);
      memory_to_writeBack_INSTRUCTION <= (32'b00000000000000000000000000000000);
      _zz_262_ <= (3'b000);
      _zz_263_ <= 1'b0;
      _zz_264_ <= (3'b000);
      _zz_270_ <= 1'b0;
      _zz_271_ <= 1'b0;
    end else begin
      if(IBusCachedPlugin_fetchPc_propagatePc)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(IBusCachedPlugin_jump_pcLoad_valid)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(_zz_368_)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b1;
      end
      if(IBusCachedPlugin_fetchPc_samplePcNext)begin
        IBusCachedPlugin_fetchPc_pcReg <= IBusCachedPlugin_fetchPc_pc;
      end
      _zz_147_ <= 1'b1;
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_105_))begin
        _zz_153_ <= 1'b0;
      end
      if(_zz_151_)begin
        _zz_153_ <= IBusCachedPlugin_iBusRsp_stages_0_output_valid;
      end
      if(IBusCachedPlugin_iBusRsp_stages_1_output_ready)begin
        _zz_155_ <= IBusCachedPlugin_iBusRsp_stages_1_output_valid;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_105_))begin
        _zz_155_ <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_105_))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_iBusRsp_stages_1_input_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_105_))begin
        IBusCachedPlugin_injector_nextPcCalc_0 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_stages_2_input_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_0 <= IBusCachedPlugin_injector_nextPcCalc_valids_0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_105_))begin
        IBusCachedPlugin_injector_nextPcCalc_0 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_105_))begin
        IBusCachedPlugin_injector_nextPcCalc_1 <= 1'b0;
      end
      if((! execute_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_1 <= IBusCachedPlugin_injector_nextPcCalc_0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_105_))begin
        IBusCachedPlugin_injector_nextPcCalc_1 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_105_))begin
        IBusCachedPlugin_injector_nextPcCalc_2 <= 1'b0;
      end
      if((! memory_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_2 <= IBusCachedPlugin_injector_nextPcCalc_1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_105_))begin
        IBusCachedPlugin_injector_nextPcCalc_2 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_105_))begin
        IBusCachedPlugin_injector_nextPcCalc_3 <= 1'b0;
      end
      if((! writeBack_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_3 <= IBusCachedPlugin_injector_nextPcCalc_2;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_105_))begin
        IBusCachedPlugin_injector_nextPcCalc_3 <= 1'b0;
      end
      if(decode_arbitration_removeIt)begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_105_))begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      end
      MemoryTranslatorPlugin_ports_0_entryToReplace_value <= MemoryTranslatorPlugin_ports_0_entryToReplace_valueNext;
      MemoryTranslatorPlugin_ports_0_sharedAccessed <= _zz_396_[1:0];
      if(_zz_369_)begin
        if(_zz_370_)begin
          if(_zz_173_)begin
            MemoryTranslatorPlugin_ports_0_cache_0_valid <= MemoryTranslatorPlugin_shared_readData_valid;
          end
          if(_zz_174_)begin
            MemoryTranslatorPlugin_ports_0_cache_1_valid <= MemoryTranslatorPlugin_shared_readData_valid;
          end
          if(_zz_175_)begin
            MemoryTranslatorPlugin_ports_0_cache_2_valid <= MemoryTranslatorPlugin_shared_readData_valid;
          end
          if(_zz_176_)begin
            MemoryTranslatorPlugin_ports_0_cache_3_valid <= MemoryTranslatorPlugin_shared_readData_valid;
          end
        end
      end
      if((((9'b100000000) <= MemoryTranslatorPlugin_ports_0_sharedIterator) && (MemoryTranslatorPlugin_ports_0_sharedAccessed == (2'b00))))begin
        MemoryTranslatorPlugin_ports_0_sharedMiss <= 1'b1;
      end
      if(_zz_329_)begin
        MemoryTranslatorPlugin_ports_0_sharedMiss <= 1'b0;
        MemoryTranslatorPlugin_ports_0_sharedAccessed <= (2'b00);
      end
      MemoryTranslatorPlugin_ports_1_entryToReplace_value <= MemoryTranslatorPlugin_ports_1_entryToReplace_valueNext;
      MemoryTranslatorPlugin_ports_1_sharedAccessed <= _zz_399_[1:0];
      if(_zz_371_)begin
        if(_zz_372_)begin
          if(_zz_181_)begin
            MemoryTranslatorPlugin_ports_1_cache_0_valid <= MemoryTranslatorPlugin_shared_readData_valid;
          end
          if(_zz_182_)begin
            MemoryTranslatorPlugin_ports_1_cache_1_valid <= MemoryTranslatorPlugin_shared_readData_valid;
          end
          if(_zz_183_)begin
            MemoryTranslatorPlugin_ports_1_cache_2_valid <= MemoryTranslatorPlugin_shared_readData_valid;
          end
          if(_zz_184_)begin
            MemoryTranslatorPlugin_ports_1_cache_3_valid <= MemoryTranslatorPlugin_shared_readData_valid;
          end
        end
      end
      if((((9'b100000000) <= MemoryTranslatorPlugin_ports_1_sharedIterator) && (MemoryTranslatorPlugin_ports_1_sharedAccessed == (2'b00))))begin
        MemoryTranslatorPlugin_ports_1_sharedMiss <= 1'b1;
      end
      if(_zz_315_)begin
        MemoryTranslatorPlugin_ports_1_sharedMiss <= 1'b0;
        MemoryTranslatorPlugin_ports_1_sharedAccessed <= (2'b00);
      end
      if(_zz_360_)begin
        case(_zz_361_)
          2'b00 : begin
          end
          2'b01 : begin
            MemoryTranslatorPlugin_ports_0_cache_0_valid <= 1'b0;
            MemoryTranslatorPlugin_ports_0_cache_1_valid <= 1'b0;
            MemoryTranslatorPlugin_ports_0_cache_2_valid <= 1'b0;
            MemoryTranslatorPlugin_ports_0_cache_3_valid <= 1'b0;
            MemoryTranslatorPlugin_ports_1_cache_0_valid <= 1'b0;
            MemoryTranslatorPlugin_ports_1_cache_1_valid <= 1'b0;
            MemoryTranslatorPlugin_ports_1_cache_2_valid <= 1'b0;
            MemoryTranslatorPlugin_ports_1_cache_3_valid <= 1'b0;
          end
          2'b10 : begin
            MemoryTranslatorPlugin_mmuEnabled <= execute_RS2[0];
          end
          default : begin
          end
        endcase
      end
      _zz_201_ <= 1'b0;
      memory_DivPlugin_div_counter_value <= memory_DivPlugin_div_counter_valueNext;
      _zz_221_ <= _zz_220_;
      CsrPlugin_mip_MEIP <= externalInterrupt;
      CsrPlugin_mip_MTIP <= timerInterrupt;
      CsrPlugin_sip_SEIP <= externalInterruptS;
      CsrPlugin_sip_STIP <= timerInterruptS;
      if((! decode_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
      end
      if((! execute_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= (CsrPlugin_exceptionPortCtrl_exceptionValids_decode && (! decode_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
      end
      if((! memory_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= (CsrPlugin_exceptionPortCtrl_exceptionValids_execute && (! execute_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
      end
      if((! writeBack_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= (CsrPlugin_exceptionPortCtrl_exceptionValids_memory && (! memory_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      end
      CsrPlugin_writeBackWasWfi <= (writeBack_arbitration_isFiring && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_WFI));
      CsrPlugin_hadException <= CsrPlugin_exception;
      if(_zz_365_)begin
        CsrPlugin_privilege <= CsrPlugin_targetPrivilege;
        case(CsrPlugin_targetPrivilege)
          2'b01 : begin
            CsrPlugin_sstatus_SIE <= 1'b0;
            CsrPlugin_sstatus_SPIE <= CsrPlugin_sstatus_SIE;
            CsrPlugin_sstatus_SPP <= CsrPlugin_privilege[0 : 0];
          end
          2'b11 : begin
            CsrPlugin_mstatus_MIE <= 1'b0;
            CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
            CsrPlugin_mstatus_MPP <= CsrPlugin_privilege;
          end
          default : begin
          end
        endcase
      end
      if(_zz_366_)begin
        case(_zz_367_)
          2'b11 : begin
            CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
            CsrPlugin_mstatus_MPP <= (2'b00);
            CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
            CsrPlugin_privilege <= CsrPlugin_mstatus_MPP;
          end
          2'b01 : begin
            CsrPlugin_sstatus_SIE <= CsrPlugin_sstatus_SPIE;
            CsrPlugin_sstatus_SPP <= (1'b0);
            CsrPlugin_sstatus_SPIE <= 1'b1;
            CsrPlugin_privilege <= {(1'b0),CsrPlugin_sstatus_SPP};
          end
          default : begin
          end
        endcase
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_45_;
      end
      if(((! execute_arbitration_isStuck) || execute_arbitration_removeIt))begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt)))begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(((! memory_arbitration_isStuck) || memory_arbitration_removeIt))begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt)))begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt))begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt)))begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
      case(_zz_260_)
        3'b000 : begin
          if(_zz_139_)begin
            _zz_260_ <= (3'b001);
          end
        end
        3'b001 : begin
          _zz_260_ <= (3'b010);
        end
        3'b010 : begin
          _zz_260_ <= (3'b011);
        end
        3'b011 : begin
          if((! decode_arbitration_isStuck))begin
            _zz_260_ <= (3'b100);
          end
        end
        3'b100 : begin
          _zz_260_ <= (3'b000);
        end
        default : begin
        end
      endcase
      case(execute_CsrPlugin_csrAddress)
        12'b101111000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            _zz_257_ <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b001100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mstatus_MPP <= execute_CsrPlugin_writeData[12 : 11];
            CsrPlugin_mstatus_MPIE <= _zz_476_[0];
            CsrPlugin_mstatus_MIE <= _zz_477_[0];
          end
        end
        12'b001100000011 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mideleg <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b000101000010 : begin
        end
        12'b000100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_sstatus_SPP <= execute_CsrPlugin_writeData[8 : 8];
            CsrPlugin_sstatus_SPIE <= _zz_479_[0];
            CsrPlugin_sstatus_SIE <= _zz_480_[0];
          end
        end
        12'b001100000010 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_medeleg <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b001101000001 : begin
        end
        12'b101100000000 : begin
        end
        12'b101110000000 : begin
        end
        12'b001101000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mip_MSIP <= _zz_481_[0];
          end
        end
        12'b001100000101 : begin
        end
        12'b000110000000 : begin
        end
        12'b110011000000 : begin
        end
        12'b000101000001 : begin
        end
        12'b000101000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_sip_SSIP <= _zz_482_[0];
          end
        end
        12'b001101000011 : begin
        end
        12'b000100000101 : begin
        end
        12'b111111000000 : begin
        end
        12'b110000000000 : begin
        end
        12'b001101000000 : begin
        end
        12'b001100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mie_MEIE <= _zz_483_[0];
            CsrPlugin_mie_MTIE <= _zz_484_[0];
            CsrPlugin_mie_MSIE <= _zz_485_[0];
          end
        end
        12'b000101000011 : begin
        end
        12'b000101000000 : begin
        end
        12'b110010000000 : begin
        end
        12'b001101000010 : begin
        end
        12'b000100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_sie_SEIE <= _zz_487_[0];
            CsrPlugin_sie_STIE <= _zz_488_[0];
            CsrPlugin_sie_SSIE <= _zz_489_[0];
          end
        end
        default : begin
        end
      endcase
      if(_zz_375_)begin
        if(iBusWishbone_ACK)begin
          _zz_262_ <= (_zz_262_ + (3'b001));
        end
      end
      _zz_263_ <= (iBusWishbone_CYC && iBusWishbone_ACK);
      if((_zz_265_ && _zz_266_))begin
        _zz_264_ <= (_zz_264_ + (3'b001));
        if(_zz_268_)begin
          _zz_264_ <= (3'b000);
        end
      end
      _zz_270_ <= ((_zz_265_ && (! dBusWishbone_WE)) && dBusWishbone_ACK);
      _zz_271_ <= (debug_bus_cmd_valid && debug_bus_cmd_ready);
    end
  end

  always @ (posedge clk) begin
    if(IBusCachedPlugin_iBusRsp_stages_1_output_ready)begin
      _zz_156_ <= IBusCachedPlugin_iBusRsp_stages_1_output_payload;
    end
    MemoryTranslatorPlugin_shared_readData_valid <= _zz_389_[0];
    MemoryTranslatorPlugin_shared_readData_virtualAddress <= _zz_168_[20 : 1];
    MemoryTranslatorPlugin_shared_readData_physicalAddress <= _zz_168_[40 : 21];
    MemoryTranslatorPlugin_shared_readData_allowRead <= _zz_390_[0];
    MemoryTranslatorPlugin_shared_readData_allowWrite <= _zz_391_[0];
    MemoryTranslatorPlugin_shared_readData_allowExecute <= _zz_392_[0];
    MemoryTranslatorPlugin_shared_readData_allowUser <= _zz_393_[0];
    MemoryTranslatorPlugin_ports_0_sharedAccessAsked <= (((_zz_123_ && (! MemoryTranslatorPlugin_ports_0_cacheHit)) && (MemoryTranslatorPlugin_ports_0_sharedIterator < (9'b100000000))) && MemoryTranslatorPlugin_ports_0_isInMmuRange);
    if(MemoryTranslatorPlugin_ports_0_sharedAccessGranted)begin
      MemoryTranslatorPlugin_ports_0_sharedIterator <= (MemoryTranslatorPlugin_ports_0_sharedIterator + (9'b000000001));
    end
    if(_zz_369_)begin
      if(_zz_370_)begin
        if(_zz_173_)begin
          MemoryTranslatorPlugin_ports_0_cache_0_virtualAddress <= MemoryTranslatorPlugin_shared_readData_virtualAddress;
        end
        if(_zz_174_)begin
          MemoryTranslatorPlugin_ports_0_cache_1_virtualAddress <= MemoryTranslatorPlugin_shared_readData_virtualAddress;
        end
        if(_zz_175_)begin
          MemoryTranslatorPlugin_ports_0_cache_2_virtualAddress <= MemoryTranslatorPlugin_shared_readData_virtualAddress;
        end
        if(_zz_176_)begin
          MemoryTranslatorPlugin_ports_0_cache_3_virtualAddress <= MemoryTranslatorPlugin_shared_readData_virtualAddress;
        end
        if(_zz_173_)begin
          MemoryTranslatorPlugin_ports_0_cache_0_physicalAddress <= MemoryTranslatorPlugin_shared_readData_physicalAddress;
        end
        if(_zz_174_)begin
          MemoryTranslatorPlugin_ports_0_cache_1_physicalAddress <= MemoryTranslatorPlugin_shared_readData_physicalAddress;
        end
        if(_zz_175_)begin
          MemoryTranslatorPlugin_ports_0_cache_2_physicalAddress <= MemoryTranslatorPlugin_shared_readData_physicalAddress;
        end
        if(_zz_176_)begin
          MemoryTranslatorPlugin_ports_0_cache_3_physicalAddress <= MemoryTranslatorPlugin_shared_readData_physicalAddress;
        end
        if(_zz_173_)begin
          MemoryTranslatorPlugin_ports_0_cache_0_allowRead <= MemoryTranslatorPlugin_shared_readData_allowRead;
        end
        if(_zz_174_)begin
          MemoryTranslatorPlugin_ports_0_cache_1_allowRead <= MemoryTranslatorPlugin_shared_readData_allowRead;
        end
        if(_zz_175_)begin
          MemoryTranslatorPlugin_ports_0_cache_2_allowRead <= MemoryTranslatorPlugin_shared_readData_allowRead;
        end
        if(_zz_176_)begin
          MemoryTranslatorPlugin_ports_0_cache_3_allowRead <= MemoryTranslatorPlugin_shared_readData_allowRead;
        end
        if(_zz_173_)begin
          MemoryTranslatorPlugin_ports_0_cache_0_allowWrite <= MemoryTranslatorPlugin_shared_readData_allowWrite;
        end
        if(_zz_174_)begin
          MemoryTranslatorPlugin_ports_0_cache_1_allowWrite <= MemoryTranslatorPlugin_shared_readData_allowWrite;
        end
        if(_zz_175_)begin
          MemoryTranslatorPlugin_ports_0_cache_2_allowWrite <= MemoryTranslatorPlugin_shared_readData_allowWrite;
        end
        if(_zz_176_)begin
          MemoryTranslatorPlugin_ports_0_cache_3_allowWrite <= MemoryTranslatorPlugin_shared_readData_allowWrite;
        end
        if(_zz_173_)begin
          MemoryTranslatorPlugin_ports_0_cache_0_allowExecute <= MemoryTranslatorPlugin_shared_readData_allowExecute;
        end
        if(_zz_174_)begin
          MemoryTranslatorPlugin_ports_0_cache_1_allowExecute <= MemoryTranslatorPlugin_shared_readData_allowExecute;
        end
        if(_zz_175_)begin
          MemoryTranslatorPlugin_ports_0_cache_2_allowExecute <= MemoryTranslatorPlugin_shared_readData_allowExecute;
        end
        if(_zz_176_)begin
          MemoryTranslatorPlugin_ports_0_cache_3_allowExecute <= MemoryTranslatorPlugin_shared_readData_allowExecute;
        end
        if(_zz_173_)begin
          MemoryTranslatorPlugin_ports_0_cache_0_allowUser <= MemoryTranslatorPlugin_shared_readData_allowUser;
        end
        if(_zz_174_)begin
          MemoryTranslatorPlugin_ports_0_cache_1_allowUser <= MemoryTranslatorPlugin_shared_readData_allowUser;
        end
        if(_zz_175_)begin
          MemoryTranslatorPlugin_ports_0_cache_2_allowUser <= MemoryTranslatorPlugin_shared_readData_allowUser;
        end
        if(_zz_176_)begin
          MemoryTranslatorPlugin_ports_0_cache_3_allowUser <= MemoryTranslatorPlugin_shared_readData_allowUser;
        end
      end
    end
    if(_zz_329_)begin
      MemoryTranslatorPlugin_ports_0_sharedIterator <= (9'b000000000);
      MemoryTranslatorPlugin_ports_0_sharedAccessAsked <= 1'b0;
    end
    MemoryTranslatorPlugin_ports_1_sharedAccessAsked <= (((_zz_113_ && (! MemoryTranslatorPlugin_ports_1_cacheHit)) && (MemoryTranslatorPlugin_ports_1_sharedIterator < (9'b100000000))) && MemoryTranslatorPlugin_ports_1_isInMmuRange);
    if(MemoryTranslatorPlugin_ports_1_sharedAccessGranted)begin
      MemoryTranslatorPlugin_ports_1_sharedIterator <= (MemoryTranslatorPlugin_ports_1_sharedIterator + (9'b000000001));
    end
    if(_zz_371_)begin
      if(_zz_372_)begin
        if(_zz_181_)begin
          MemoryTranslatorPlugin_ports_1_cache_0_virtualAddress <= MemoryTranslatorPlugin_shared_readData_virtualAddress;
        end
        if(_zz_182_)begin
          MemoryTranslatorPlugin_ports_1_cache_1_virtualAddress <= MemoryTranslatorPlugin_shared_readData_virtualAddress;
        end
        if(_zz_183_)begin
          MemoryTranslatorPlugin_ports_1_cache_2_virtualAddress <= MemoryTranslatorPlugin_shared_readData_virtualAddress;
        end
        if(_zz_184_)begin
          MemoryTranslatorPlugin_ports_1_cache_3_virtualAddress <= MemoryTranslatorPlugin_shared_readData_virtualAddress;
        end
        if(_zz_181_)begin
          MemoryTranslatorPlugin_ports_1_cache_0_physicalAddress <= MemoryTranslatorPlugin_shared_readData_physicalAddress;
        end
        if(_zz_182_)begin
          MemoryTranslatorPlugin_ports_1_cache_1_physicalAddress <= MemoryTranslatorPlugin_shared_readData_physicalAddress;
        end
        if(_zz_183_)begin
          MemoryTranslatorPlugin_ports_1_cache_2_physicalAddress <= MemoryTranslatorPlugin_shared_readData_physicalAddress;
        end
        if(_zz_184_)begin
          MemoryTranslatorPlugin_ports_1_cache_3_physicalAddress <= MemoryTranslatorPlugin_shared_readData_physicalAddress;
        end
        if(_zz_181_)begin
          MemoryTranslatorPlugin_ports_1_cache_0_allowRead <= MemoryTranslatorPlugin_shared_readData_allowRead;
        end
        if(_zz_182_)begin
          MemoryTranslatorPlugin_ports_1_cache_1_allowRead <= MemoryTranslatorPlugin_shared_readData_allowRead;
        end
        if(_zz_183_)begin
          MemoryTranslatorPlugin_ports_1_cache_2_allowRead <= MemoryTranslatorPlugin_shared_readData_allowRead;
        end
        if(_zz_184_)begin
          MemoryTranslatorPlugin_ports_1_cache_3_allowRead <= MemoryTranslatorPlugin_shared_readData_allowRead;
        end
        if(_zz_181_)begin
          MemoryTranslatorPlugin_ports_1_cache_0_allowWrite <= MemoryTranslatorPlugin_shared_readData_allowWrite;
        end
        if(_zz_182_)begin
          MemoryTranslatorPlugin_ports_1_cache_1_allowWrite <= MemoryTranslatorPlugin_shared_readData_allowWrite;
        end
        if(_zz_183_)begin
          MemoryTranslatorPlugin_ports_1_cache_2_allowWrite <= MemoryTranslatorPlugin_shared_readData_allowWrite;
        end
        if(_zz_184_)begin
          MemoryTranslatorPlugin_ports_1_cache_3_allowWrite <= MemoryTranslatorPlugin_shared_readData_allowWrite;
        end
        if(_zz_181_)begin
          MemoryTranslatorPlugin_ports_1_cache_0_allowExecute <= MemoryTranslatorPlugin_shared_readData_allowExecute;
        end
        if(_zz_182_)begin
          MemoryTranslatorPlugin_ports_1_cache_1_allowExecute <= MemoryTranslatorPlugin_shared_readData_allowExecute;
        end
        if(_zz_183_)begin
          MemoryTranslatorPlugin_ports_1_cache_2_allowExecute <= MemoryTranslatorPlugin_shared_readData_allowExecute;
        end
        if(_zz_184_)begin
          MemoryTranslatorPlugin_ports_1_cache_3_allowExecute <= MemoryTranslatorPlugin_shared_readData_allowExecute;
        end
        if(_zz_181_)begin
          MemoryTranslatorPlugin_ports_1_cache_0_allowUser <= MemoryTranslatorPlugin_shared_readData_allowUser;
        end
        if(_zz_182_)begin
          MemoryTranslatorPlugin_ports_1_cache_1_allowUser <= MemoryTranslatorPlugin_shared_readData_allowUser;
        end
        if(_zz_183_)begin
          MemoryTranslatorPlugin_ports_1_cache_2_allowUser <= MemoryTranslatorPlugin_shared_readData_allowUser;
        end
        if(_zz_184_)begin
          MemoryTranslatorPlugin_ports_1_cache_3_allowUser <= MemoryTranslatorPlugin_shared_readData_allowUser;
        end
      end
    end
    if(_zz_315_)begin
      MemoryTranslatorPlugin_ports_1_sharedIterator <= (9'b000000000);
      MemoryTranslatorPlugin_ports_1_sharedAccessAsked <= 1'b0;
    end
    if(_zz_360_)begin
      case(_zz_361_)
        2'b00 : begin
          execute_MemoryTranslatorPlugin_tlbWriteBuffer <= _zz_400_[19:0];
        end
        2'b01 : begin
        end
        2'b10 : begin
        end
        default : begin
        end
      endcase
    end
    if(_zz_358_)begin
      if(_zz_359_)begin
        memory_DivPlugin_rs1[31 : 0] <= _zz_452_[31:0];
        memory_DivPlugin_accumulator[31 : 0] <= ((! _zz_213_[32]) ? _zz_453_ : _zz_454_);
        if((memory_DivPlugin_div_counter_value == (6'b100000)))begin
          memory_DivPlugin_div_result <= _zz_455_[31:0];
        end
      end
    end
    if(_zz_373_)begin
      memory_DivPlugin_accumulator <= (65'b00000000000000000000000000000000000000000000000000000000000000000);
      memory_DivPlugin_rs1 <= ((_zz_216_ ? (~ _zz_217_) : _zz_217_) + _zz_461_);
      memory_DivPlugin_rs2 <= ((_zz_215_ ? (~ execute_RS2) : execute_RS2) + _zz_463_);
      memory_DivPlugin_div_needRevert <= ((_zz_216_ ^ (_zz_215_ && (! execute_INSTRUCTION[13]))) && (! (((execute_RS2 == (32'b00000000000000000000000000000000)) && execute_IS_RS2_SIGNED) && (! execute_INSTRUCTION[13]))));
    end
    if(_zz_220_)begin
      _zz_222_ <= _zz_60_[11 : 7];
      _zz_223_ <= _zz_94_;
    end
    CsrPlugin_mcycle <= (CsrPlugin_mcycle + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    if(writeBack_arbitration_isFiring)begin
      CsrPlugin_minstret <= (CsrPlugin_minstret + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    end
    if(decode_exception_agregat_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= decode_exception_agregat_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= decode_exception_agregat_payload_badAddr;
    end
    if(memory_exception_agregat_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= memory_exception_agregat_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= memory_exception_agregat_payload_badAddr;
    end
    if(writeBack_exception_agregat_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= writeBack_exception_agregat_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= writeBack_exception_agregat_payload_badAddr;
    end
    if((CsrPlugin_exception || CsrPlugin_interruptJump))begin
      case(CsrPlugin_targetPrivilege)
        2'b01 : begin
          CsrPlugin_sepc <= writeBack_PC;
        end
        2'b11 : begin
          CsrPlugin_mepc <= writeBack_PC;
        end
        default : begin
        end
      endcase
    end
    if(_zz_365_)begin
      case(CsrPlugin_targetPrivilege)
        2'b01 : begin
          CsrPlugin_scause_interrupt <= CsrPlugin_interrupt;
          CsrPlugin_scause_exceptionCode <= CsrPlugin_trapCause;
          CsrPlugin_stval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
        end
        2'b11 : begin
          CsrPlugin_mcause_interrupt <= CsrPlugin_interrupt;
          CsrPlugin_mcause_exceptionCode <= CsrPlugin_trapCause;
          CsrPlugin_mtval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
        end
        default : begin
        end
      endcase
    end
    externalInterruptArray_regNext <= externalInterruptArray;
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_INSTRUCTION <= _zz_33_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_MANAGMENT <= decode_MEMORY_MANAGMENT;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_25_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_39_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LL <= execute_MUL_LL;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS2 <= decode_RS2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FLUSH_ALL <= decode_FLUSH_ALL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FLUSH_ALL <= execute_FLUSH_ALL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LH <= execute_MUL_LH;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HH <= execute_MUL_HH;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_HH <= memory_MUL_HH;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_MUL <= decode_IS_MUL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_MUL <= execute_IS_MUL;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_IS_MUL <= memory_IS_MUL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SHIFT_CTRL <= _zz_22_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_SHIFT_CTRL <= _zz_19_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_DO_EBREAK <= decode_DO_EBREAK;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_SHIFT_RIGHT <= execute_SHIFT_RIGHT;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_FENCEI <= decode_IS_FENCEI;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HL <= execute_MUL_HL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PREDICTION_HAD_BRANCHED2 <= decode_PREDICTION_HAD_BRANCHED2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_CTRL <= _zz_17_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_DIV <= decode_IS_DIV;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_DIV <= execute_IS_DIV;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FORMAL_PC_NEXT <= _zz_100_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_99_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BRANCH_CTRL <= _zz_14_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ENV_CTRL <= _zz_12_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_ENV_CTRL <= _zz_9_;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_ENV_CTRL <= _zz_7_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_CTRL <= _zz_5_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS1 <= decode_RS1;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_WR <= decode_MEMORY_WR;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_WR <= execute_MEMORY_WR;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_WR <= memory_MEMORY_WR;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PC <= decode_PC;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_PC <= _zz_52_;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_TLB <= decode_IS_TLB;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC1_CTRL <= _zz_2_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
      end
      12'b001100000000 : begin
      end
      12'b001100000011 : begin
      end
      12'b000101000010 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_scause_interrupt <= _zz_478_[0];
          CsrPlugin_scause_exceptionCode <= execute_CsrPlugin_writeData[3 : 0];
        end
      end
      12'b000100000000 : begin
      end
      12'b001100000010 : begin
      end
      12'b001101000001 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mepc <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b101100000000 : begin
      end
      12'b101110000000 : begin
      end
      12'b001101000100 : begin
      end
      12'b001100000101 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mtvec <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b000110000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_satp_MODE <= execute_CsrPlugin_writeData[31 : 31];
          CsrPlugin_satp_ASID <= execute_CsrPlugin_writeData[30 : 22];
          CsrPlugin_satp_PPN <= execute_CsrPlugin_writeData[21 : 0];
        end
      end
      12'b110011000000 : begin
      end
      12'b000101000001 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_sepc <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b000101000100 : begin
      end
      12'b001101000011 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mtval <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b000100000101 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_stvec <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b111111000000 : begin
      end
      12'b110000000000 : begin
      end
      12'b001101000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mscratch <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b001100000100 : begin
      end
      12'b000101000011 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_stval <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b000101000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_sscratch <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b110010000000 : begin
      end
      12'b001101000010 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mcause_interrupt <= _zz_486_[0];
          CsrPlugin_mcause_exceptionCode <= execute_CsrPlugin_writeData[3 : 0];
        end
      end
      12'b000100000100 : begin
      end
      default : begin
      end
    endcase
    iBusWishbone_DAT_MISO_regNext <= iBusWishbone_DAT_MISO;
    dBusWishbone_DAT_MISO_regNext <= dBusWishbone_DAT_MISO;
  end

  always @ (posedge clk) begin
    DebugPlugin_firstCycle <= 1'b0;
    if(debug_bus_cmd_ready)begin
      DebugPlugin_firstCycle <= 1'b1;
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle;
    DebugPlugin_isPipActive <= (((decode_arbitration_isValid || execute_arbitration_isValid) || memory_arbitration_isValid) || writeBack_arbitration_isValid);
    DebugPlugin_isPipActive_regNext <= DebugPlugin_isPipActive;
    if(writeBack_arbitration_isValid)begin
      DebugPlugin_busReadDataReg <= _zz_94_;
    end
    _zz_259_ <= debug_bus_cmd_payload_address[2];
    if(_zz_362_)begin
      DebugPlugin_busReadDataReg <= execute_PC;
    end
    DebugPlugin_resetIt_regNext <= DebugPlugin_resetIt;
  end

  always @ (posedge clk) begin
    if(debugReset) begin
      DebugPlugin_resetIt <= 1'b0;
      DebugPlugin_haltIt <= 1'b0;
      DebugPlugin_stepIt <= 1'b0;
      DebugPlugin_haltedByBreak <= 1'b0;
    end else begin
      if(debug_bus_cmd_valid)begin
        case(_zz_374_)
          6'b000000 : begin
            if(debug_bus_cmd_payload_wr)begin
              DebugPlugin_stepIt <= debug_bus_cmd_payload_data[4];
              if(debug_bus_cmd_payload_data[16])begin
                DebugPlugin_resetIt <= 1'b1;
              end
              if(debug_bus_cmd_payload_data[24])begin
                DebugPlugin_resetIt <= 1'b0;
              end
              if(debug_bus_cmd_payload_data[17])begin
                DebugPlugin_haltIt <= 1'b1;
              end
              if(debug_bus_cmd_payload_data[25])begin
                DebugPlugin_haltIt <= 1'b0;
              end
              if(debug_bus_cmd_payload_data[25])begin
                DebugPlugin_haltedByBreak <= 1'b0;
              end
            end
          end
          6'b000001 : begin
          end
          default : begin
          end
        endcase
      end
      if(_zz_362_)begin
        if(_zz_363_)begin
          DebugPlugin_haltIt <= 1'b1;
          DebugPlugin_haltedByBreak <= 1'b1;
        end
      end
      if(_zz_364_)begin
        if(decode_arbitration_isValid)begin
          DebugPlugin_haltIt <= 1'b1;
        end
      end
      if((DebugPlugin_stepIt && ({writeBack_arbitration_redoIt,{memory_arbitration_redoIt,{execute_arbitration_redoIt,decode_arbitration_redoIt}}} != (4'b0000))))begin
        DebugPlugin_haltIt <= 1'b0;
      end
    end
  end

  always @ (posedge clk) begin
    _zz_261_ <= debug_bus_cmd_payload_data;
  end

endmodule

