--Bloc : gestion_alarme
--Auteur : Joseph Caillet
--Description : verifie si bpm et en dehors des seuil permis, et permet rglage de ces seuils.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gestion_alarme is
	port(
		clk, rst, bp_reg : in std_logic;
		SW : in std_logic_vector(1 downto 0);
		BPM : in std_logic_vector(9 downto 0);
		led_al : out std_logic;
		SALH : out std_logic_vector(9 downto 0);
		SALB : out std_logic_vector(9 downto 0)
	);
end gestion_alarme;

architecture beh of gestion_alarme is
	type etat is(
		OP_OK,
		REG_SH, SH_DEC, SH_W,
		REG_SB, SB_INC, SB_W
	);
	
	constant PAS_AL_H : integer := 2;
	constant PAS_AL_B : integer := 10;
	
	signal EP : etat;
	signal s_salH : natural range 40 to 60;
	signal s_salB : natural range 100 to 240;
	
	begin
	
	SEQ : process(clk, rst)
	begin
		if(rst = '0') then
			EP <= OP_OK;
			s_salH <= 240;
			s_salB <= 40;
		elsif rising_edge(clk) then
			if SW(1) = '1' then
				EP <= OP_OK;
			else
				case EP is
					when OP_OK =>
						if SW(0) = '0' then
							EP <= REG_SB;
						else
							EP <= REG_SH;
						end if;
					when REG_SH =>
						if SW(0) = '0' then
							EP <= REG_SB;
						else
							if BP_REG = '0' then
								EP <= SH_DEC;
							end if;
						end if;
					when SH_DEC =>
						s_salH <= s_salH - PAS_AL_H;
						if s_salH < 100 then
							s_salH <= 240;
						end if;
						EP <= SH_W;
					when SH_W =>
						if BP_REG = '1' then
							EP <= REG_SH;
						end if;
					when REG_SB =>
						if SW(0) = '1' then
							EP <= REG_SH;
						else
							if BP_REG = '0' then
								EP <= SB_INC;
							end if;
						end if;
					when SB_INC =>
						s_salB <= s_salB + PAS_AL_B;
						if s_salB > 60 then
							s_salB <= 40;
						end if;
						EP <= SB_W;
					when SB_W =>
						if BP_REG = '1' then
							EP <= REG_SB;
						end if;
					when others =>
						EP <= OP_OK;
				end case;
			end if;
		end if;
	end process SEQ;
	
	led_al <= '1' when to_integer(unsigned(BPM)) > s_salH or to_integer(unsigned(BPM)) < s_salB else '0';
	SALH <= std_logic_vector(to_unsigned(s_salH, 10));
	SALB <= std_logic_vector(to_unsigned(s_salB, 10));
	
end beh;