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
		DIN_ADC, CS_ADC, CLK_ADC, LED_POU, LED_AL, LED_BF, PWM_LEDCAP : out std_logic;
		AFFU, AFFD, AFFC : out std_logic_vector(6 downto 0)
	);
end cardio;

architecture struct of cardio is
	constant tirets : std_logic_vector(6 downto 0) := "0111111";

	signal s_clk_100K, s_ena2ms : std_logic;
	signal s_echAC_acq, s_echDC_acq, s_debord, s_top_alum, s_sel, s_bp_regAR, s_pwm : std_logic;
	signal s_ech, s_DC_moy, s_aff : std_logic_vector(11 downto 0);
	signal s_cptperiode_moy, s_bpm, s_SALB, s_SALH : std_logic_vector(9 downto 0);
	signal s_affu, s_affd, s_affc : std_logic_vector(6 downto 0);

	component div_freq is
		port(
			clk, rst : in std_logic;
			clk100K : out std_logic
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
			echAC : in std_logic_vector(11 downto 0);
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
	
	component anti_rebond is
		port(
			clk, rst, bp_reg : in std_logic;
			bp_regAR : out std_logic
		);
	end component;
	
	component pwm_led_capteur is
		port(
			clk, rst, modop, reg_auto : in std_logic;
			dc_moy : in std_logic_vector(11 downto 0);
			pwm_ledcap : out std_logic
		);
	end component;
	
	begin
		clk100 : div_freq port map(
			clk => clk,
			rst => rst,
			clk100K => s_clk_100K
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
			echAC_acq => s_echAC_acq,
			echDC_acq => s_echDC_acq,
			echantillon => s_ech
		);
		
		tdc : trait_DC port map(
			clk => s_clk_100K,
			rst => rst,
			echDC_acq => s_echDC_acq,
			echDC => s_ech,
			DC_moy => s_DC_moy
		);
		
		tac : trait_AC port map(
			clk => s_clk_100K,
			rst => rst,
			echAC_acq => s_echAC_acq,
			echAC => s_ech,
			modop => SW(1),
			debord_cpt => s_debord,
			top_alum => s_top_alum,
			cptperiode_moy => s_cptperiode_moy
		);
		
		rom : rom1BPM port map(
			clock => s_clk_100K,
			address => s_cptperiode_moy,
			q => s_bpm	
		);
		
		ch_aff : choix_aff port map(
			bp_reg => bp_reg,
			sw => sw,
			SALB => s_SALB,
			SALH => s_SALH,
			BPM => s_bpm,
			moy_dc => s_DC_moy,
			aff => s_aff
		);
		
		a_r : anti_rebond port map(
			clk => s_clk_100K,
			rst => rst,
			bp_reg => bp_reg,
			bp_regAR => s_bp_regAR
		);
		
		gal : gestion_alarme port map(
			clk => s_clk_100K,
			rst => rst,
			bp_reg => s_bp_regAR,
			sw => sw,
			BPM => s_bpm,
			led_al => led_al,
			SALB => s_SALB,
			SALH => s_SALH
		);
		
		cmd_pou : cmd_ledpouls port map(
			clk => s_clk_100K,
			rst => rst,
			top_alum => s_top_alum,
			led_pou => led_pou
		);

--		led_al <= '0';
--		s_SALB <= "0001000000";
--		s_SALH <= "1001000000";
--		led_pou <= '0';
		
		pwm_led : pwm_led_capteur port map(
			clk => clk,
			rst => rst,
			modop => SW(1),
			reg_auto => SW(0),
			dc_moy => s_DC_moy,
			pwm_ledcap => s_pwm
		);
		
		trans_u : trans_7seg port map(
			code_e => s_aff(3 downto 0),
			code_s => s_affu
		);
		
		trans_d : trans_7seg port map(
			code_e => s_aff(7 downto 4),
			code_s => s_affd
		);
		
		trans_c : trans_7seg port map(
			code_e => s_aff(11 downto 8),
			code_s => s_affc
		);
		
		s_sel <= sw(1) and bp_reg and s_debord;
		
		affu 	<= tirets when s_sel = '1'
				else s_affu;
		affd 	<= tirets when s_sel = '1'
				else s_affd;
		affc 	<= tirets when s_sel = '1'
				else s_affc;
				
		led_bf <= '1';
		PWM_LEDCAP <= s_pwm;

end struct;