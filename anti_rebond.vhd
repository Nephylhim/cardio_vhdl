--Bloc : anti_rebond
--Auteur : Joseph Caillet et Thomas Coussot
--Description : evite les rebonds du bouton poussoir

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity anti_rebond is
	port(
		clk, rst, bouton_poussoir : in std_logic;
		bp_reg : out std_logic
	);
end anti_rebond;

architecture beh of anti_rebond is
	constant CPT_MAX : integer := 9999;
	signal s_cpt : natural range 0 to CPT_MAX;
	
	begin
	
	SEQ : process(clk, rst)
	begin
		if(rst = '0') then
			s_cpt <= 0;
		elsif rising_edge(clk) then
			if s_cpt > 0 then
				if s_cpt = CPT_MAX then
					s_cpt <= 0;
				else
					s_cpt <= s_cpt + 1;
				end if;
			elsif bouton_poussoir = '0' then
				s_cpt <= 1;
			end if;
		end if;
	end process SEQ;
	
	bp_reg <= '0' when s_cpt = 1 else '1';
	
end beh;