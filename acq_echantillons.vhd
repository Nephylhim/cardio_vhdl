--Bloc : acq_echantillons
--Auteur : Joseph Caillet
--Description : communique avec l'acd pour recuperer les informations numerisees, et avertit les blocs consernes lorsque la conversion est faite.

library ieee;
use ieee.std_logic_1164.all;

entity acq_echantillons is
	port(
		clk, rst, modop, ena2ms, dout_adc : in std_logic;
		clk_adc, cs_adc, din_adc, echAC_acq, echDC_acq : out std_logic;
		echantillon : out std_logic_vector(11 downto 0)
	);
end acq_echantillons;

architecture beh of acq_echantillons is
	type etat is(
		W,
		S_d, S_u, A2_d, A2_u, A1_d, A1_u, A0_d, A0_u,
		Mode_d, Mode_u, SGL_d, SGL_u, PD1_d, PD1_u, PD0_d, PD0_u,
		WC_d, WC_u, A_u, A_d, Rac, Rdc, WF_u, WF_d
	);
	signal EP : etat;
	signal s_cpt : natural range 0 to 12;
	signal s_sel : std_logic;
	
	begin
	
	SEQ : process (clk, rst)
	begin
		if(rst = '0') then
			EP <= W;
			s_cpt <= 0;
			s_sel <= '0';
		elsif rising_edge(clk) then
			if modop = '0'
				EP <= W;
			else
				case EP is
					when W =>
						if(ena2ms = '1' and modop = '1')
							EP <= S_d;
						end if;
					when S_d =>
						EP <= S_u;
					when S_u =>
						EP <= A2_d;
					when A2_d =>
						EP <= A2_u;
					when A2_u =>
						EP <= A1_d;
					when A1_d =>
						EP <= A1_u;
					when A1_u =>
						EP <= A0_d;
					when A0_d =>
						EP <= A0_u;
					when A0_u =>
						EP <= Mode_d;
					when Mode_d =>
						EP <= Mode_u;
					when Mode_u =>
						EP <= SGL_d;
					when SGL_d =>
						EP <= SGL_u;
					when SGL_u =>
						EP <= PD1_d;
					when PD1_d =>
						EP <= PD1_u;
					when PD1_u =>
						EP <= PD0_d;
					when PD0_d =>
						EP <= PD0_u;
					when PD0_u =>
						EP <= WC_d;
					when WC_d =>
						EP <= WC_u;
					when WC_u =>
						EP <= A_u;
					when A_u =>
						if c_cpt = 11 then
							s_cpt = 0;
							if s_sel = '0' then
								EP <= Rac;
							else
								EP <= Rdc;
							end if;
						else
							EP <= A_d;
						end if;
					when A_d =>
						s_cpt <= s_cpt +1;
						EP <= A_u;
					when Rac =>
						EP <= WF_u;
					when Rdc =>
						EP <= WF_u;
					when WF_u =>N
						if s_cpt = 2 then
						s_cpt = 0;
							if s_sel = '0' then
								s_sel = '1';
								EP <= S_d;
							else
								s_sel = '0';
								EP <= W;
							end if;
						else
							EP <= S_do;
						end if
					when WF_d =>
						s_cpt = s_cpt + 1;
					when others =>
						s_cpt <= 0;
						EP <= W;
				end case;
			end if;
		end if;
	end process SEQ;
	
	
	
	
--case EP is
--	when W =>
--	when S_d =>
--	when S_u =>
--	when A2_d =>
--	when A2_u =>
--	when A1_d =>
--	when A1_u =>
--	when A0_d =>
--	when A0_u =>
--	when Mode_d =>
--	when Mode_u =>
--	when SGL_d =>
--	when SGL_u =>
--	when PD1_d =>
--	when PD1_u =>
--	when PD0_d =>
--	when PD0_u =>
--	when WC_d =>
--	when WC_u =>
--	when A_u =>
--	when A_d =>
--	when Rac =>
--	when Rdc =>
--	when WF_u =>
--	when WF_d =>					
--	when others =>
--		s_cpt1 <=0;
--		s_cpt2 <=0;
--		EP <= PV_SR;
--end case;

end beh;