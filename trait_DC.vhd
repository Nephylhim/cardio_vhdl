--Bloc : trait_DC
--Auteur : Joseph Caillet
--Description : effectue la moyenne des 8 dernieres valeurs recues

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trait_DC is
	port(
		clk, rst, echDC_acq : in std_logic;
		echDC : std_logic_vector(11 downto 0);
		DC_moy : std_logic_vector(11 downto 0)
	);
end trait_DC;

architecture beh of trait_DC is
	signal s_reg1 : std_logic_vector(11 downto 0);
	signal s_reg2 : std_logic_vector(11 downto 0);
	signal s_reg3 : std_logic_vector(11 downto 0);
	signal s_reg4 : std_logic_vector(11 downto 0);
	signal s_reg5 : std_logic_vector(11 downto 0);
	signal s_reg6 : std_logic_vector(11 downto 0);
	signal s_reg7 : std_logic_vector(11 downto 0);
	signal s_reg8 : std_logic_vector(11 downto 0);
	
	signal s_cpt : natural range 1 to 8;
	signal s_somme : std_logic_vector(14 downto 0);
	
	begin

	--Memoriqation Dc ds un des 8 registres
	Memo : process(clk,rst)
	begin
		if rst = '0' then
			s_reg1 <= "100000000000";
			s_reg2 <= "100000000000";
			s_reg3 <= "100000000000";
			s_reg4 <= "100000000000";
			s_reg5 <= "100000000000";
			s_reg6 <= "100000000000";
			s_reg7 <= "100000000000";
			s_reg8 <= "100000000000";
			s_cpt <= 1;
		elsif (rising_edge(clk) and echDC_acq = '1') then
			if s_cpt = 1 then
				s_reg1 <= echDC;
				s_cpt <= s_cpt + 1;
			elsif s_cpt = 2 then
				s_reg5 <= echDC;
				s_cpt <= s_cpt + 1;
			elsif s_cpt = 3 then
				s_reg3 <= echDC;
				s_cpt <= s_cpt + 1;
			elsif s_cpt = 4 then
				s_reg4 <= echDC;
				s_cpt <= s_cpt + 1;
			elsif s_cpt = 5 then
				s_reg5 <= echDC;
				s_cpt <= s_cpt + 1;
			elsif s_cpt = 6 then
				s_reg6 <= echDC;
				s_cpt <= s_cpt + 1;
			elsif s_cpt = 7 then
				s_reg7 <= echDC;
				s_cpt <= s_cpt + 1;
			elsif s_cpt = 8 then
				s_reg8 <= echDC;
				s_cpt <= 1;
			end if;			
		end if;
	end process Memo;
	
	--Somme des registres
	s_somme <= std_logic_vector(
		unsigned("000" & s_reg1) +
		unsigned("000" & s_reg2) +
		unsigned("000" & s_reg3) +
		unsigned("000" & s_reg4) +
		unsigned("000" & s_reg5) +
		unsigned("000" & s_reg6) +
		unsigned("000" & s_reg7) +
		unsigned("000" & s_reg8)
	);
	
	--Moyenne de la somme
	
end beh;