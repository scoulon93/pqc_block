--------------------------------------------------------------------------------------------------------------------------
--  Project : pqc_block
--  File    : signed_shift_dynamic.vhd
--  Author  : Sam Coulon
--  Purpose : The purpose of this file is to...
--            1) Accept a_vector & a_sel values
--            2) Invert element of a_vector at a_sel index
--            3) Move last element to index 0
--            4) Shift all other elements over by 1
--------------------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity signed_shift_dynamic is
    port(
        inv_sel : in    std_logic_vector(COUNTER_SIZE_A_SEL-1 downto 0);
        A_in    : in    a_vector;

        A_out   : out   a_vector
    );
end entity;

architecture rtl of signed_shift_dynamic is

    signal a_not    : a_vector;
    signal a_shift  : a_vector;
    signal a_inv    : a_vector;

begin

    -- Invert value at index inv_sel
    INV_GEN : for i in 0 to N_SIZE-1 generate
        a_not(i) <= NOT(A_in(i)) + "01";

        a_inv(i) <= a_not(i) when unsigned(inv_sel) = i else A_in(i);
    end generate INV_GEN;

    -- Shift last value to top
    a_shift(0) <= a_inv(N_SIZE-1);
    SHIFT_GEN : for i in 1 to N_SIZE-1 generate
        a_shift(i) <= a_inv(i-1);
    end generate SHIFT_GEN;

    A_out <= a_shift;

end rtl;