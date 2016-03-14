--Bloc : test bench pour acq_echantillons
--Auteur : Joseph Caillet
--Description : test bench du bloc acq_echantillon avec adc fourni.

library ieee;
use ieee.std_logic_1164.all;

entity acq_ech_tb is

end acq_ech_tb;

architecture test of acq_ech_tb is
	
	--adc fourni
	component ADC is
		port (
		DCLK     : in  std_logic;           -- horloge de synchro
		rst      : in std_logic;            -- reset asynchrone
		CS_ADC   : in  std_logic;           -- chip select 
		DIN_ADC  : in  std_logic;           -- entree mot de controle adc
		DOUT_ADC : out std_logic);          -- data synchrone serie
	end component;
	
	--bloc acq_echantillons a tester
	component acq_echantillons is
		port(
			clk, rst, modop, ena2ms, dout_adc : in std_logic;
			clk_adc, cs_adc, din_adc, echAC_acq, echDC_acq : out std_logic;
			echantillon : out std_logic_vector(11 downto 0)
		);
	end component;
	
	--signeaux internes
	signal s_dout_adc, s_din_adc, s_cs_adc, s_clk_adc : std_logic;
	--entrees
	signal clk_i, rst_i, modop_i, ena2ms_i : std_logic;
	--sorties
	signal echDC_acq_s, echAC_acq_s : std_logic;
	signal echantillon_s : std_logic_vector(11 downto 0);
	
	begin
	
	adc1 : ADC
	port map(
		dclk => s_clk_adc,
		rst => rst_i,
		cs_adc => s_cs_adc,
		din_adc => s_din_adc,
		dout_adc =>s_dout_adc
	);
	
	acq_ech1 : acq_echantillons
	port map(
		clk => clk_i,
		rst => rst_i,
		modop => modop_i,
		ena2ms => ena2ms_i,
		dout_adc => s_dout_adc,
		
		clk_adc => s_clk_adc,
		cs_adc => s_cs_adc,
		din_adc => s_din_adc,
		echAC_acq => echAC_acq_s,
		echDC_acq => echDC_acq_s,
		echantillon => echantillon_s
	);
	
	rst_i <= '0', '1' after 20us;
	modop_i <= '0', '1' after 40us;
	ena2ms_i <= '0', '1' after 60us, '0' after 80us;
	
end test;