-------------------------------------------------------------
-- fichier : choix_aff.vhd                                 --
-- auteur : Thomas COUSSOT                                 --
-- desc : envoi le signal SALH, SALB, BPM ou moy_DC en     --
--        fonction de SW et bp_reg                         --
-------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity choix_aff is
	port(
		bp_reg : in std_logic;
		SW : in std_logic_vector(1 downto 0);
		SALB, SALH, BPM : in std_logic_vector(9 downto 0);
		moy_DC : in std_logic_vector(11 downto 0);
		aff : out std_logic_vector(11 downto 0)
	);
end choix_aff;

architecture beh of choix_aff is
	begin
		P1 : process(SW, bp_reg)
			begin
				if(SW(1) = '1') then
					if(bp_reg = '1') then
						aff <= "00" & BPM;
					else
						aff <= moy_DC
					end if;
				else
					if(SW(0) = '1') then
						aff <= "00" & SALH;
					else
						aff <= "00" & SALB;
					end if;
				end if;
		end process P1;
end beh;