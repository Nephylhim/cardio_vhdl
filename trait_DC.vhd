--Bloc : trait_DC
--Auteur : Joseph Caillet
--Description : effectue la moyenne des 8 dernieres valeurs recues

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trait_DC is
	port(
		clk, rst, echDC_acq : in std_logic;
		echDC : in  std_logic_vector(11 downto 0);
		DC_moy : out std_logic_vector(11 downto 0)
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
	signal s_moyenne : std_logic_vector(11 downto 0);
	
	begin

	--Memoriqation Dc ds un des 8 registres
	Memo : process(clk, rst)
	begin
		if rst = '0' then
			s_reg1 <= (others => '0');
			s_reg2 <= (others => '0');
			s_reg3 <= (others => '0');
			s_reg4 <= (others => '0');
			s_reg5 <= (others => '0');
			s_reg6 <= (others => '0');
			s_reg7 <= (others => '0');
			s_reg8 <= (others => '0');
			s_cpt <= 1;
		elsif (rising_edge(clk) and echDC_acq = '1') then
			case s_cpt is
			when 1 =>
				s_reg1 <= echDC;
				s_cpt <= s_cpt + 1;
			when 2 =>
				s_reg2 <= echDC;
				s_cpt <= s_cpt + 1;
			when 3 =>
				s_reg3 <= echDC;
				s_cpt <= s_cpt + 1;
			when 4 =>
				s_reg4 <= echDC;
				s_cpt <= s_cpt + 1;
			when 5 =>
				s_reg5 <= echDC;
				s_cpt <= s_cpt + 1;
			when 6 =>
				s_reg6 <= echDC;
				s_cpt <= s_cpt + 1;
			when 7 =>
				s_reg7 <= echDC;
				s_cpt <= s_cpt + 1;
			when 8 =>
				s_reg8 <= echDC;
				s_cpt <= 1;
			end case;			
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
	Moyenne : process(clk, rst)
	begin
		if rst = '0' then
			DC_moy <= (others => '0');
		elsif rising_edge(clk) then
			DC_moy <= s_somme(14 downto 3);
		end if;
	end process Moyenne;
end beh;