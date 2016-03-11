--Bloc : div_freq
--Auteur : Joseph Caillet
--Description : diviseur de frquence de 20 MHz -> 100 KHz

library ieee;
use ieee.std_logic_1164.all;

entity div_freq is
	port(
		clk, rst : in std_logic;
		clk100K : out std_logic
	);
end div_freq;

architecture beh of div_freq is
	constant CPT_MAX : integer := 99;
	signal s_cpt : natural range 0 to CPT_MAX;
	signal s_clk : std_logic;
	
	begin
	
	P1 : process(clk, rst)
	begin
		if rst = '0' then
			s_cpt <= 0;
			s_clk <= '0';
		elsif rising_edge(clk) then
			if s_cpt = CPT_MAX then
				s_cpt <= 0;
				s_clk <= not s_clk;
			else
				s_cpt <= s_cpt + 1;
			end if;
		end if;
	end process P1;
	
	clk100K <= s_clk;
end beh;