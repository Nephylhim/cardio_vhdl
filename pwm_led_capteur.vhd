--Bloc : pwm_led_capteur
--Auteur : Joseph Caillet et Thomas Coussot
--Description : evite les rebonds du bouton poussoir

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_led_capteur is
	port(
		clk, rst, modop, reg_auto : in std_logic;
		dc_moy : in std_logic_vector(11 downto 0);
		pwm_ledcap : out std_logic
	);
end pwm_led_capteur;

architecture beh of pwm_led_capteur is
	constant CPT_MAX : integer := 199;
	constant PAS : integer := 10;
	constant WAIT_TIME : integer := 300000000 - 1;
	constant DC_BAS : std_logic_vector(11 downto 0) := x"A00";
	constant DC_HAUT : std_logic_vector(11 downto 0) := x"B00";
	signal s_cpt : natural range 0 to CPT_MAX;
	signal s_bascule : natural range 0 to CPT_MAX;
	signal s_attente_filtre : natural range 0 to WAIT_TIME;
	signal s_led : std_logic ;
	
	begin
	
	SEQ : process(clk, rst)
	begin
		if(rst = '0') then
			s_cpt <= 0;
			s_bascule <= CPT_MAX * 3 / 4;
			s_attente_filtre <= 0;
			s_led <= '0';
		elsif rising_edge(clk) then
			if(modop = '1' and reg_auto = '0') then
				--maj rapport cyclique si temps necessaire ecoule
				if s_attente_filtre = WAIT_TIME then
					if dc_moy < DC_BAS then 
						s_bascule <= s_bascule + PAS;
					elsif dc_moy > DC_HAUT then
						s_bascule <= s_bascule - PAS;
					end if;
					s_attente_filtre <= 0;
				else
					s_attente_filtre <= s_attente_filtre + 1;
				end if;
				--inversion led si besoin
				if s_cpt = s_bascule then
					s_led <= '0';
				elsif s_cpt = CPT_MAX then
					s_led <= '1';
				end if;
			else
				s_cpt <= 0;
				s_bascule <= CPT_MAX * 3 / 4;
				s_attente_filtre <= 0;
				s_led <= '0';
			end if;
		end if;
	end process SEQ;
	
	pwm_ledcap <= s_led;
	
end beh;