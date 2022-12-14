--------------------------------------------------------------------------------------------------------------------------
--  Project : pqc_block
--  File    : multiplier.vhd
--  Author  : Sam Coulon
--  Purpose : The purpose of this file is to...
--            1) Accept a_section (ROWS-number 2-bit elements) and B value
--            2) Multiply A(i)(0)xB to produce C(i)
--            3) If A(i)(1) = '1' (i.e. A(i) = -1), perform 2's compliment on C(i) 
--------------------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity multiplier is
    port(
        A   : in    a_section;
        B   : in    std_logic_vector(7 downto 0);

        C   : out   c_section
    );
end entity;

architecture rtl of multiplier is

    signal c_hold   : c_section;
    signal c_inv    : c_section;

begin

    LOOP_ROWS : for i in 0 to ROWS-1 generate
        LOOP_8BITS : for j in 0 to 7 generate
            C_hold(i)(j) <= A(i)(0) AND B(j);
        end generate LOOP_8BITS;
        c_inv(i) <= NOT(c_hold(i)) + "00000001" when (A(i)(1)) = '1' else c_hold(i);
    end generate LOOP_ROWS;

    C <= c_inv;

end rtl;