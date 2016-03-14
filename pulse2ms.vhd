-------------------------------------------------------------
-- fichier : pulse2ms.vhd                                  --
-- auteur : Thomas COUSSOT                                 --
-- desc : envoi une impulsion d'un cycle d'horloge toutes  --
--        les 2ms (avec une horloge de base de 100kHz      --
-------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity pulse2ms is
	port(
		clk, rst : in std_logic;
		ena2ms : out std_logic
	);
end pulse2ms;

architecture beh of pulse2ms is
	constant MAX : natural range 0 to 199 := 199;
	signal s_cpt : natural range 0 to MAX;
	
	begin
		Pulse : process(clk, rst)
			begin
				if(rst = '0') then
					s_cpt <= 0;
					ena2ms <= '0';
				elsif rising_edge(clk) then
					if(s_cpt = MAX) then
						s_cpt <= 0;
						ena2ms <= '1';
					else
						ena2ms <= '0';
						s_cpt <= s_cpt+1;
					end if;
				end if;
		end process Pulse;
end beh;