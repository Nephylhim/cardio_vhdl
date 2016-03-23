--Bloc : cmd_ledpouls
--Auteur : Joseph Caillet
--Description : bloc de commande de la led du pouls

library ieee;
use ieee.std_logic_1164.all;


entity cmd_ledpouls is
	port(
		clk, rst : in std_logic;
		top_alum : in std_logic;
		led_pou : out std_logic
	);
end cmd_ledpouls;

architecture beh of cmd_ledpouls is
	constant CPT_MAX : integer := 11999;
	signal s_cpt : natural range 0 to CPT_MAX;
	signal s_led_pou : std_logic;
	
	begin
	
	P1 : process(clk, rst)
	begin
		if rst = '0' then
			s_cpt <= 0;
			s_led_pou <= '0';
		elsif rising_edge(clk) then
			if s_led_pou = '1' then
				if s_cpt = CPT_MAX then
					s_led_pou <= '0';
				else
					s_cpt <= s_cpt + 1;
				end if;
			elsif top_alum = '1' then
				s_led_pou <= '1';
				s_cpt <= 0;
			end if;
		end if;
	end process P1;
	
	led_pou <= s_led_pou;
end beh;