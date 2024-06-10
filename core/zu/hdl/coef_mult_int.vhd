-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2018.3
-- Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity coef_mult_int is
port (
    ap_ready : OUT STD_LOGIC;
    a_0_read : IN STD_LOGIC_VECTOR (7 downto 0);
    a_1_read : IN STD_LOGIC_VECTOR (7 downto 0);
    a_2_read : IN STD_LOGIC_VECTOR (7 downto 0);
    a_3_read : IN STD_LOGIC_VECTOR (7 downto 0);
    ap_return_0 : OUT STD_LOGIC_VECTOR (7 downto 0);
    ap_return_1 : OUT STD_LOGIC_VECTOR (7 downto 0);
    ap_return_2 : OUT STD_LOGIC_VECTOR (7 downto 0);
    ap_return_3 : OUT STD_LOGIC_VECTOR (7 downto 0) );
end;


architecture behav of coef_mult_int is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv5_E : STD_LOGIC_VECTOR (4 downto 0) := "01110";
    constant ap_const_lv5_9 : STD_LOGIC_VECTOR (4 downto 0) := "01001";
    constant ap_const_lv5_D : STD_LOGIC_VECTOR (4 downto 0) := "01101";
    constant ap_const_lv5_B : STD_LOGIC_VECTOR (4 downto 0) := "01011";
    constant ap_const_logic_0 : STD_LOGIC := '0';

    signal tmp_Multiply_fu_46_ap_ready : STD_LOGIC;
    signal tmp_Multiply_fu_46_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_s_Multiply_fu_54_ap_ready : STD_LOGIC;
    signal tmp_s_Multiply_fu_54_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_13_Multiply_fu_62_ap_ready : STD_LOGIC;
    signal tmp_13_Multiply_fu_62_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_14_Multiply_fu_70_ap_ready : STD_LOGIC;
    signal tmp_14_Multiply_fu_70_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_15_Multiply_fu_78_ap_ready : STD_LOGIC;
    signal tmp_15_Multiply_fu_78_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_16_Multiply_fu_86_ap_ready : STD_LOGIC;
    signal tmp_16_Multiply_fu_86_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_17_Multiply_fu_94_ap_ready : STD_LOGIC;
    signal tmp_17_Multiply_fu_94_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_18_Multiply_fu_102_ap_ready : STD_LOGIC;
    signal tmp_18_Multiply_fu_102_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_19_Multiply_fu_110_ap_ready : STD_LOGIC;
    signal tmp_19_Multiply_fu_110_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_20_Multiply_fu_118_ap_ready : STD_LOGIC;
    signal tmp_20_Multiply_fu_118_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_21_Multiply_fu_126_ap_ready : STD_LOGIC;
    signal tmp_21_Multiply_fu_126_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_22_Multiply_fu_134_ap_ready : STD_LOGIC;
    signal tmp_22_Multiply_fu_134_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_23_Multiply_fu_142_ap_ready : STD_LOGIC;
    signal tmp_23_Multiply_fu_142_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_24_Multiply_fu_150_ap_ready : STD_LOGIC;
    signal tmp_24_Multiply_fu_150_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_25_Multiply_fu_158_ap_ready : STD_LOGIC;
    signal tmp_25_Multiply_fu_158_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_26_Multiply_fu_166_ap_ready : STD_LOGIC;
    signal tmp_26_Multiply_fu_166_ap_return : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp2_fu_180_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp1_fu_174_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp4_fu_198_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp3_fu_192_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp6_fu_216_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp5_fu_210_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp8_fu_234_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp7_fu_228_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal d_0_write_assign_fu_186_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal d_1_write_assign_fu_204_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal d_2_write_assign_fu_222_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal d_3_write_assign_fu_240_p2 : STD_LOGIC_VECTOR (7 downto 0);

    component Multiply IS
    port (
        ap_ready : OUT STD_LOGIC;
        x : IN STD_LOGIC_VECTOR (7 downto 0);
        y : IN STD_LOGIC_VECTOR (4 downto 0);
        ap_return : OUT STD_LOGIC_VECTOR (7 downto 0) );
    end component;



begin
    tmp_Multiply_fu_46 : component Multiply
    port map (
        ap_ready => tmp_Multiply_fu_46_ap_ready,
        x => a_0_read,
        y => ap_const_lv5_E,
        ap_return => tmp_Multiply_fu_46_ap_return);

    tmp_s_Multiply_fu_54 : component Multiply
    port map (
        ap_ready => tmp_s_Multiply_fu_54_ap_ready,
        x => a_3_read,
        y => ap_const_lv5_9,
        ap_return => tmp_s_Multiply_fu_54_ap_return);

    tmp_13_Multiply_fu_62 : component Multiply
    port map (
        ap_ready => tmp_13_Multiply_fu_62_ap_ready,
        x => a_2_read,
        y => ap_const_lv5_D,
        ap_return => tmp_13_Multiply_fu_62_ap_return);

    tmp_14_Multiply_fu_70 : component Multiply
    port map (
        ap_ready => tmp_14_Multiply_fu_70_ap_ready,
        x => a_1_read,
        y => ap_const_lv5_B,
        ap_return => tmp_14_Multiply_fu_70_ap_return);

    tmp_15_Multiply_fu_78 : component Multiply
    port map (
        ap_ready => tmp_15_Multiply_fu_78_ap_ready,
        x => a_1_read,
        y => ap_const_lv5_E,
        ap_return => tmp_15_Multiply_fu_78_ap_return);

    tmp_16_Multiply_fu_86 : component Multiply
    port map (
        ap_ready => tmp_16_Multiply_fu_86_ap_ready,
        x => a_0_read,
        y => ap_const_lv5_9,
        ap_return => tmp_16_Multiply_fu_86_ap_return);

    tmp_17_Multiply_fu_94 : component Multiply
    port map (
        ap_ready => tmp_17_Multiply_fu_94_ap_ready,
        x => a_3_read,
        y => ap_const_lv5_D,
        ap_return => tmp_17_Multiply_fu_94_ap_return);

    tmp_18_Multiply_fu_102 : component Multiply
    port map (
        ap_ready => tmp_18_Multiply_fu_102_ap_ready,
        x => a_2_read,
        y => ap_const_lv5_B,
        ap_return => tmp_18_Multiply_fu_102_ap_return);

    tmp_19_Multiply_fu_110 : component Multiply
    port map (
        ap_ready => tmp_19_Multiply_fu_110_ap_ready,
        x => a_2_read,
        y => ap_const_lv5_E,
        ap_return => tmp_19_Multiply_fu_110_ap_return);

    tmp_20_Multiply_fu_118 : component Multiply
    port map (
        ap_ready => tmp_20_Multiply_fu_118_ap_ready,
        x => a_1_read,
        y => ap_const_lv5_9,
        ap_return => tmp_20_Multiply_fu_118_ap_return);

    tmp_21_Multiply_fu_126 : component Multiply
    port map (
        ap_ready => tmp_21_Multiply_fu_126_ap_ready,
        x => a_0_read,
        y => ap_const_lv5_D,
        ap_return => tmp_21_Multiply_fu_126_ap_return);

    tmp_22_Multiply_fu_134 : component Multiply
    port map (
        ap_ready => tmp_22_Multiply_fu_134_ap_ready,
        x => a_3_read,
        y => ap_const_lv5_B,
        ap_return => tmp_22_Multiply_fu_134_ap_return);

    tmp_23_Multiply_fu_142 : component Multiply
    port map (
        ap_ready => tmp_23_Multiply_fu_142_ap_ready,
        x => a_3_read,
        y => ap_const_lv5_E,
        ap_return => tmp_23_Multiply_fu_142_ap_return);

    tmp_24_Multiply_fu_150 : component Multiply
    port map (
        ap_ready => tmp_24_Multiply_fu_150_ap_ready,
        x => a_2_read,
        y => ap_const_lv5_9,
        ap_return => tmp_24_Multiply_fu_150_ap_return);

    tmp_25_Multiply_fu_158 : component Multiply
    port map (
        ap_ready => tmp_25_Multiply_fu_158_ap_ready,
        x => a_1_read,
        y => ap_const_lv5_D,
        ap_return => tmp_25_Multiply_fu_158_ap_return);

    tmp_26_Multiply_fu_166 : component Multiply
    port map (
        ap_ready => tmp_26_Multiply_fu_166_ap_ready,
        x => a_0_read,
        y => ap_const_lv5_B,
        ap_return => tmp_26_Multiply_fu_166_ap_return);




    ap_ready <= ap_const_logic_1;
    ap_return_0 <= d_0_write_assign_fu_186_p2;
    ap_return_1 <= d_1_write_assign_fu_204_p2;
    ap_return_2 <= d_2_write_assign_fu_222_p2;
    ap_return_3 <= d_3_write_assign_fu_240_p2;
    d_0_write_assign_fu_186_p2 <= (tmp2_fu_180_p2 xor tmp1_fu_174_p2);
    d_1_write_assign_fu_204_p2 <= (tmp4_fu_198_p2 xor tmp3_fu_192_p2);
    d_2_write_assign_fu_222_p2 <= (tmp6_fu_216_p2 xor tmp5_fu_210_p2);
    d_3_write_assign_fu_240_p2 <= (tmp8_fu_234_p2 xor tmp7_fu_228_p2);
    tmp1_fu_174_p2 <= (tmp_s_Multiply_fu_54_ap_return xor tmp_Multiply_fu_46_ap_return);
    tmp2_fu_180_p2 <= (tmp_14_Multiply_fu_70_ap_return xor tmp_13_Multiply_fu_62_ap_return);
    tmp3_fu_192_p2 <= (tmp_16_Multiply_fu_86_ap_return xor tmp_15_Multiply_fu_78_ap_return);
    tmp4_fu_198_p2 <= (tmp_18_Multiply_fu_102_ap_return xor tmp_17_Multiply_fu_94_ap_return);
    tmp5_fu_210_p2 <= (tmp_20_Multiply_fu_118_ap_return xor tmp_19_Multiply_fu_110_ap_return);
    tmp6_fu_216_p2 <= (tmp_22_Multiply_fu_134_ap_return xor tmp_21_Multiply_fu_126_ap_return);
    tmp7_fu_228_p2 <= (tmp_24_Multiply_fu_150_ap_return xor tmp_23_Multiply_fu_142_ap_return);
    tmp8_fu_234_p2 <= (tmp_26_Multiply_fu_166_ap_return xor tmp_25_Multiply_fu_158_ap_return);
end behav;