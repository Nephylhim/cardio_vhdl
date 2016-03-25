--Bloc : anti_rebond
--Auteur : Joseph Caillet et Thomas Coussot
--Description : evite les rebonds du bouton poussoir

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity anti_rebond is
	port(
		clk, rst, bp_reg : in std_logic;
		bp_regAR : out std_logic
	);
end anti_rebond;

architecture beh of anti_rebond is
	constant CPT_MAX : integer := 19999;
	signal s_cpt : natural range 0 to CPT_MAX;
	signal s_ena : std_logic;
	
	begin
	
	SEQ : process(clk, rst)
	begin
		if(rst = '0') then
			s_cpt <= 0;
			s_ena <= '0';
		elsif rising_edge(clk) then
			if s_ena = '1' then
				if s_cpt = CPT_MAX then
					s_ena <= '0';
					s_cpt <= 0;
				else				
					s_cpt <= s_cpt + 1;
				end if;
			elsif bp_reg = '0' then
				s_ena <= '1';
			end if;
		end if;
	end process SEQ;
	
	bp_regAR <= '0' when s_cpt = 0 and s_ena = '1' else '1';
	
end beh;