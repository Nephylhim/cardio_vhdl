--Bloc : gestion_alarme
--Auteur : Joseph Caillet
--Description : verifie si bpm et en dehors des seuil permis, et permet le reglage de ces seuils.

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
	
	signal EP : etat;
	
	signal s_shc : natural range 1 to 2;
	signal s_shd, s_sbu : natural range 0 to 9;
	signal s_sbd : natural range 4 to 6;
	signal s_sh, s_sb : std_logic_vector(9 downto 0);
	
	begin
	
	SEQ : process(clk, rst)
	begin
		if(rst = '0') then
			EP <= OP_OK;
			s_shc <= 2;
			s_shd <= 4;
			s_sbd <= 4;
			s_sbu <= 0;
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
						if(s_shc = 1) then
							if(s_shd = 0) then
								s_shc <= 2;
								s_shd <= 4;
							else
								s_shd <= s_shd - 1;
							end if;
						else
							if(s_shd = 0) then
								s_shc <= 1;
								s_shd <= 9;
							else
								s_shd <= s_shd - 1;
							end if;
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
						if(s_sbd = 6) then
							s_sbd <= 4;
						elsif(s_sbd = 5) then
							if(s_sbu = 8) then
								s_sbd <= 6;
								s_sbu <= 0;
							else
								s_sbu <= s_sbu + 2;
							end if;
						else
							if(s_sbu = 8) then
								s_sbd <= 5;
								s_sbu <= 0;
							else
								s_sbu <= s_sbu + 2;
							end if;
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
	
	COMB : process(EP, s_salH, s_salB, BPM)
		begin
		s_sh <= std_logic_vector(to_unsigned(s_shc, 2)) & std_logic_vector(tu_unsigned(s_shd, 4)) & "0000";
		s_sb <=  "00" & std_logic_vector(to_unsigned(s_sbd, 4)) & std_logic_vector(tu_unsigned(s_sbu, 4));
		SALH <= s_sh;
		SALB <= s_sb;
		if(BPM > s_sh or BPM < s_sb) then
			led_al <= '1';
		else
			led_al <= '0';
		end if;
	end process COMB;
	
end beh;