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
	constant WAIT_TIME : integer := 300000000;
	constant DC_BAS : integer := x"A00";
	constant DC_HAUT : integer := x"B00";
	signal s_cpt : natural range 0 to CPT_MAX;
	signal s_bascule : natural range 0 to CPT_MAX;
	
	begin
	
	SEQ : process(clk, rst)
	begin
		if(rst = '0') then
			s_cpt <= 0;
			s_bascule <= CPT_MAX * 0.75;
			pwm_ledcap <= '0';
		elsif rising_edge(clk) then
			if(modop = '1' and reg_auto = '1'
		end if;
	end process SEQ;
	
end beh;