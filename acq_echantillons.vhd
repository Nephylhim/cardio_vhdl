--Bloc : acq_echantillons
--Auteur : Joseph Caillet
--Description : communique avec l'adc pour recuperer les informations numerisees, et avertit les blocs consernes lorsque la conversion est faite.

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
	signal s_echantillon : std_logic_vector(11 downto 0);
	signal s_sel : std_logic;
	signal s_enable : std_logic;
	
	begin
	
	SEQ : process(clk, rst)
	begin
		if(rst = '0') then
			EP <= W;
			s_cpt <= 0;
			s_sel <= '0';
		elsif rising_edge(clk) then
			if modop = '0' then
				EP <= W;
			else
				case EP is
					when W =>
						if(ena2ms = '1') then
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
						if s_cpt = 11 then
							s_cpt <= 0;
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
					when WF_u =>
						if s_cpt = 2 then
							s_cpt <= 0;
							if s_sel = '0' then
								s_sel <= '1';
								EP <= S_d;
							else
								s_sel <= '0';
								EP <= W;
							end if;
						else
							EP <= S_d;
						end if;
					when WF_d =>
						s_cpt <= s_cpt + 1;
					when others =>
						s_cpt <= 0;
						EP <= W;
				end case;
			end if;
		end if;
	end process SEQ;
	
	COMB : process(EP)
	begin
		case EP is
			when W =>
				cs_adc <= '1';
				clk_adc <= '0';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when S_d =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= '1';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when S_u =>
				cs_adc <= '0';
				clk_adc <= '1';
				din_adc <= '1';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when A2_d =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= s_sel;
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when A2_u =>
				cs_adc <= '0';
				clk_adc <= '1';
				din_adc <= s_sel;
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when A1_d =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when A1_u =>
				cs_adc <= '0';
				clk_adc <= '1';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when A0_d =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= '1';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when A0_u =>
				cs_adc <= '0';
				clk_adc <= '1';
				din_adc <= '1';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when Mode_d =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when Mode_u =>
				cs_adc <= '0';
				clk_adc <= '1';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when SGL_d =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= '1';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when SGL_u =>
				cs_adc <= '0';
				clk_adc <= '1';
				din_adc <= '1';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when PD1_d =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= '1';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when PD1_u =>
				cs_adc <= '0';
				clk_adc <= '1';
				din_adc <= '1';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when PD0_d =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= '1';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when PD0_u =>
				cs_adc <= '0';
				clk_adc <= '1';
				din_adc <= '1';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when WC_d =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when WC_u =>
				cs_adc <= '0';
				clk_adc <= '1';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when A_u =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= '0';
				s_enable <= '1';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when A_d =>
				cs_adc <= '0';
				clk_adc <= '1';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when Rac =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '1';
				echDC_acq <= '0';
			when Rdc =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '1';
			when WF_u =>
				cs_adc <= '0';
				clk_adc <= '1';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when WF_d =>
				cs_adc <= '0';
				clk_adc <= '0';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
			when others =>
				cs_adc <= '1';
				clk_adc <= '0';
				din_adc <= '0';
				s_enable <= '0';
				echAC_acq <= '0';
				echDC_acq <= '0';
		end case;
	end process COMB;

	REGISTRE : process(clk, rst)
		begin
		if(rst = '0') then
			s_echantillon <= (others => '0');
		elsif rising_edge(clk) then
			if s_enable = '1' then
				s_echantillon <= s_echantillon(10 downto 0) & dout_adc;
			end if;
		end if;
		echantillon <= s_echantillon;
	end process REGISTRE;
end beh;