----------------------------------------------------------------
-- fichier : trait_ac.vhd                                     --
-- auteur : Thomas COUSSOT                                    --
-- desc : determine quand une periode de battement recommence --
--        et compte le nombre de cycle d'horloge entre deux   --
--        periodes                                            --
----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trait_ac is
	port(
		clk, rst, modop, echAC_acq : in std_logic;
		echAC : in std_logic_vector(11 downto 0);
		debord_cpt, top_alum : out std_logic;
		cptperiode_moy : out std_logic_vector(9 downto 0)
	);
end trait_ac;

architecture beh of trait_ac is
	constant SH : std_logic_vector(11 downto 0) := "100001100100";
	constant SB : std_logic_vector(11 downto 0) := "011110011100";
	constant MAX : natural range 0 to 1000 := 1000;
	signal s_cpt, s_reg0, s_reg1, s_reg2, s_reg3, s_reg4, s_reg5, s_reg6, s_reg7 : natural range 0 to MAX;
	signal s_acq_max : natural range 0 to MAX := 478;
	signal s_acq_min : natural range 0 to MAX := 372;
	signal s_cpt_filtre : natural range 0 to MAX := 425;
	signal s_sel : natural range 0 to 7;
	signal s_SH_depasse : std_logic;
	signal s_somme_n : natural range 0 to 8*MAX;
	signal s_somme_l : std_logic_vector(12 downto 0);
	signal s_debord, s_prems : std_logic;
	
	begin
		
		filtre_cpt : process(s_cpt, s_acq_min, s_acq_max)
			begin
				if(s_cpt < s_acq_min) then
					s_cpt_filtre <= s_acq_min;
				elsif(s_cpt > s_acq_max) then
					s_cpt_filtre <= s_acq_max;
				else
					s_cpt_filtre <= s_cpt;
				end if;
		end process;
		
		maj_min_max : process(s_cpt_filtre, modop, echAC_acq, echAC, s_SH_depasse, s_debord, s_prems)
			begin
				if(s_prems = '1') then
					s_acq_max <= MAX;
					s_acq_min <= 0;
				elsif(modop = '1' and echAC < SB and s_SH_depasse = '1' and s_debord = '0') then
					if(s_cpt_filtre + (s_cpt_filtre / 8) <= MAX) then
						s_acq_max <= s_cpt_filtre + (s_cpt_filtre / 8);
					else
						s_acq_max <= MAX;
					end if;
					s_acq_min <= s_cpt_filtre - (s_cpt_filtre / 8);
				end if;
		end process;
		
		Memo : process(clk, rst)
			begin
				if(rst = '0') then
					s_cpt <= 1000;
					s_reg0 <= 425;
					s_reg1 <= 425;
					s_reg2 <= 425;
					s_reg3 <= 425;
					s_reg4 <= 425;
					s_reg5 <= 425;
					s_reg6 <= 425;
					s_reg7 <= 425;
					s_sel <= 0;
					s_debord <= '1';
					debord_cpt <= '0';
					top_alum <= '0';
					s_SH_depasse <= '0';
					s_prems <= '1';
					
				elsif(rising_edge(clk)) then
					if(modop = '1' and echAC_acq = '1') then
						top_alum <= '0';
						
						-- Incrmentation du compteur --
						if(s_cpt < 1000) then
							s_debord <= '0';
							s_cpt <= s_cpt+1;
						else
							s_debord <= '1';
							s_prems <= '1';
						end if;
						
						-- Maj du registre si nouvelle periode --
						if(echAC > SH) then
							s_SH_depasse <= '1';
						elsif(echAC < SB and s_SH_depasse = '1') then
							if(s_debord = '0') then
								
--								if(s_cpt_filtre + (s_cpt_filtre / 8) <= MAX) then
--									s_acq_max <= s_cpt_filtre + (s_cpt_filtre / 8);
--								else
--									s_acq_max <= MAX;
--								end if;
--								s_acq_min <= s_cpt_filtre - (s_cpt_filtre / 8);
								
								case s_sel is
									when 1 => s_reg1 <= s_cpt_filtre;
									when 2 => s_reg2 <= s_cpt_filtre;
									when 3 => s_reg3 <= s_cpt_filtre;
									when 4 => s_reg4 <= s_cpt_filtre;
									when 5 => s_reg5 <= s_cpt_filtre;
									when 6 => s_reg6 <= s_cpt_filtre;
									when 7 => s_reg7 <= s_cpt_filtre;
									when others => s_reg0 <= s_cpt_filtre;
														s_sel <= 0;
								end case;
							
								if(s_sel < 7) then
									s_sel <= s_sel+1;
								else
									s_sel <= 0;
								end if;
							end if;
							
							s_prems <= '0';
							s_cpt <= 0;
							s_SH_depasse <= '0';
							top_alum <= '1';
						end if;
						
						debord_cpt <= s_debord;
					end if;
				end if;
		end process Memo;
		
		-- Somme des registres --
		s_somme_n <= s_reg0 + s_reg1 + s_reg2 + s_reg3 + s_reg4 + s_reg5 + s_reg6 + s_reg7;
		s_somme_l <= std_logic_vector(to_unsigned(s_somme_n, 13));
		
		-- Registre a decalage (diviseur par 8) --
		Div8 : process(clk, rst)
			begin
				if(rst = '0') then
					cptperiode_moy <= "0000000000";
				elsif(rising_edge(clk)) then
					cptperiode_moy <= s_somme_l(12 downto 3);
				end if;
		end process Div8;
end beh;