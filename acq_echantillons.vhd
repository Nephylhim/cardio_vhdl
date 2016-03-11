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
			s_sel <= 0;
		elsif rising_edge(clk) then
			case EP is
				when PV_SR =>
					
				when others =>
					s_cpt1 <=0;
					s_cpt2 <=0;
					EP <= PV_SR;
			end case;
		end if;
	end process SEQ;
end beh;