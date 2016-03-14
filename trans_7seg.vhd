--------------------------------------------------
-- fichier : trans_hexa_7seg.vhd                --
-- auteur : Thomas C.                           --
-- desc : transfre un code hexa en 7 seg        --
--------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity trans_7seg is
	port(
		code_e : in std_logic_vector(3 downto 0);
		code_s : out std_logic_vector(6 downto 0)
	);
end trans_7seg;

architecture beh of trans_7seg is
	constant zero : std_logic_vector(6 downto 0) := "1000000";
	constant un : std_logic_vector(6 downto 0) := "1111001";
	constant deux : std_logic_vector(6 downto 0) := "0100100";
	constant trois : std_logic_vector(6 downto 0) := "0110000";
	constant quatre : std_logic_vector(6 downto 0) := "0011001";
	constant cinq : std_logic_vector(6 downto 0) := "0010010";
	constant six : std_logic_vector(6 downto 0) := "0000010";
	constant sept : std_logic_vector(6 downto 0) := "1111000";
	constant huit : std_logic_vector(6 downto 0) := "0000000";
	constant neuf : std_logic_vector(6 downto 0) := "0010000";
	constant CA : std_logic_vector(6 downto 0) := "0001000";
	constant CB : std_logic_vector(6 downto 0) := "0000011";
	constant CC : std_logic_vector(6 downto 0) := "0100111";
	constant CD : std_logic_vector(6 downto 0) := "0100001";
	constant CE : std_logic_vector(6 downto 0) := "0000110";
	constant CF : std_logic_vector(6 downto 0) := "0001110";
	constant ETEINT : std_logic_vector(6 downto 0) := "1111111";

	begin
		with code_e select
			code_s <= 	zero when "0000",
							un when "0001",
							deux when "0010",
							trois when "0011",
							quatre when "0100",
							cinq when "0101",
							six when "0110",
							sept when "0111",
							huit when "1000",
							neuf when "1001",
							CA when "1010",
							CB when "1011",
							CC when "1100",
							CD when "1101",
							CE when "1110",
							CF when "1111",
							ETEINT when others;
end beh;