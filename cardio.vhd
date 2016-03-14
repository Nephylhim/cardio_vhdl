-------------------------------------------------------------
-- fichier : cardio.vhd                                    --
-- auteur : Thomas COUSSOT                                 --
-- desc : recoit un signal cardiaque et le traite afin     --
--        d'afficher BPM, intensit lumineuses, alarme,     --
--        nouvelle periode et seuils d'alarmes             --
-------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity cardio is
	port(
		clk, rst, BP_REG, DOUT_ADC : in std_logic;
		SW : in std_logic_vector(1 downto 0);
		DIN_ADC, CS_ADC, CLK_ADC, LED_POU, LED_AL, LED_BF : out std_logic;
		AFFU, AFFD, AFFC : out std_logic_vector(6 downto 0)
	);
end cardio;

architecture struct of cardio is
	signal s_clk_100K : std_logic;
	signal s_ena2ms : std_logic;
	signal s_ech_ACacq, s_ech_DCacq, s_debord, s_top_alum : std_logic;
	signal s_ech, s_DC_moy : std_logic_vector(11 downto 0);
	signal s_cptperiode_moy : std_logic_vector(9 downto 0);

	component div_freq is
		port(
			clk, rst : in std_logic;
			clk_100K : out std_logic
		);
	end component;
	
	component acq_echantillons is
		port(
			clk, rst, modop, ena2ms, dout_adc : in std_logic;
			clk_adc, cs_adc, din_adc, echAC_acq, echDC_acq : out std_logic;
			echantillon : out std_logic_vector(11 downto 0)
		);
	end component;
	
	component pulse2ms is
		port(
			clk, rst : in std_logic;
			ena2ms : out std_logic
		);
	end component;
	
	component trait_DC is
		port(
			clk, rst, echDC_acq : in std_logic;
			echDC : in  std_logic_vector(11 downto 0);
			DC_moy : out std_logic_vector(11 downto 0)
		);
	end component;
	
	component trait_ac is
		port(
			clk, rst, modop, echAC_acq : in std_logic;
			ech_AC : in std_logic_vector(11 downto 0);
			debord_cpt, top_alum : out std_logic;
			cptperiode_moy : out std_logic_vector(9 downto 0)
		);
	end component;
	
	component rom1BPM is
		port(
			address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			q		: OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
		);
	end component;
	
	component choix_aff is
		port(
			bp_reg : in std_logic;
			SW : in std_logic_vector(1 downto 0);
			SALB, SALH, BPM : in std_logic_vector(9 downto 0);
			moy_DC : in std_logic_vector(11 downto 0);
			aff : out std_logic_vector(11 downto 0)
		);
	end component;
	
	component trans_7seg is
		port(
			code_e : in std_logic_vector(3 downto 0);
			code_s : out std_logic_vector(6 downto 0)
		);
	end component;
	
	component gestion_alarme is
		port(
			BP_REG, clk, rst : in std_logic;
			SW : in std_logic_vector(1 downto 0);
			BPM : in std_logic_vector(9 downto 0);
			led_al : out std_logic;
			SALH, SALB : out std_logic_vector(9 downto 0)
		);
	end component;
	
	component cmd_ledpouls is
		port(
			clk, rst, top_alum : in std_logic;
			led_pou : out std_logic
		);
	end component;
	
	begin
		clk100 : div_freq port map(
			clk => clk,
			rst => rst,
			clk_100K => s_clk_100K
		);
		
		pulse : pulse2ms port map(
			clk => s_clk_100K,
			rst => rst,
			ena2ms => s_ena2ms
		);
		
		acq_ech : acq_echantillons port map(
			clk => s_clk_100K,
			rst => rst,
			dout_adc => dout_adc,
			ena2ms => s_ena2ms,
			modop => sw(1),
			clk_adc => clk_adc,
			cs_adc => cs_adc,
			din_adc => din_adc,
			ech_ACacq => s_ech_ACacq,
			ech_DCacq => s_ech_DCacq,
			echantillon => s_ech
		);
		
		tdc : trait_DC port map(
			clk => s_clk_100K,
			rst => rst,
			ech_DCacq => s_ech_DCacq,
			echDC => s_ech,
			DC_moy => s_DC_moy
		);
		
		tac : trait_AC port map(
			clk => s_clk_100K,
			rst => rst,
			ech_ACacq => s_ech_ACacq,
			echAC => s_ech,
			debord_cpt => s_debord,
			top_alum => s_top_alum,
			cptperiode_moy => s_cptperiode_moy
		);
		
		rom : rom1BPM port map(
			
		);

end struct;