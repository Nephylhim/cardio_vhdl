-------------------------------------------------------------------------------
-- Title      : adc.vhd
-- Project    : 
-------------------------------------------------------------------------------
-- File       : adc.vhd
-- Author     : isen  <isen@localhost.localdomain>
-- Company    : 
-- Last update: 2010/03/16
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: simulateur du convertisseur ADC
-- 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2010/03/13  1.0      isen	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ADC is
  
  port (
    DCLK     : in  std_logic;           -- horloge de synchro
    rst      : in std_logic;            --reset asynchrone
    CS_ADC   : in  std_logic;           -- chip select 
    DIN_ADC  : in  std_logic;           -- entree mot de controle adc
    DOUT_ADC : out std_logic);          -- data synchrone serie

end ADC;


architecture beh of ADC is


  
type etat is (compt,decompt);
signal e_p_ac,e_p_dc : etat;
signal load_mot_AC,load_mot_dc,done_AC,done_DC,decal_AC,decal_DC : std_logic;
signal ena_compt_ac,ena_compt_dc : std_logic;
signal compt_pulse : integer range 0 to 58;
signal mot_AC : integer range 0 to 4095;
signal mot_DC : integer range 0 to 4095;
signal temp_reg : std_logic_vector(14 downto 0);

constant amplitude_max_ac :integer := 3298;
constant amplitude_min_ac :integer := 798;
constant amplitude_max_dc :integer := 4000;
constant amplitude_min_dc :integer := 100;
constant pas_ac : integer := 10;
constant pas_dc : integer := 10;

begin  -- beh

load_mot_AC <= '1' when compt_pulse=9 else '0';
load_mot_dc <= '1' when compt_pulse=33 else '0';
done_AC <= '1' when compt_pulse=24 else '0';
done_DC <= '1' when compt_pulse=47 else '0';
decal_AC <= '1' when (compt_pulse>9 and  compt_pulse<24) else '0';
decal_DC <= '1' when ( compt_pulse>33 and compt_pulse<48) else '0';


-----------------------------------------------constant amplitude_ac : integer range 0 to  4095:= 0;--------------------------------
  -- detection compteur de pulse
  -----------------------------------------------------------------------------
  p1: process (DCLK, rst)
  begin  -- process
    if rst = '0' then                   -- asynchronous reset (active low)
      compt_pulse <= 0;
    elsif DCLK'event and DCLK = '1' then  -- rising clock edge
      if CS_ADC='0' then
        
    
        if compt_pulse=47 then
          compt_pulse <= 0;
        else
          compt_pulse <= compt_pulse + 1;
         end if;

      
       end if;
    end if;
  end process;


   -----------------------------------------------------------------------------
  -- production des mots de la voie ac
  -----------------------------------------------------------------------------
  --machine de Moore
  -- process sequentiel de changement d'etat
  PSEQVAC: process (DCLK, rst)
  begin  -- process P2
    if rst = '0' then                   -- asynchronous reset (active low)
      e_p_ac <= compt;
    elsif DCLK'event and DCLK = '1' then  -- rising clock edge
      case e_p_ac is
       
        when compt => 
          if mot_AC=amplitude_max_ac then
            e_p_ac <= decompt;
          else
            e_p_ac <= compt;
          end if;
        when decompt =>
          if mot_AC=amplitude_min_ac then
            e_p_ac <= compt;
          else
            e_p_ac <= decompt;
          end if;
            
        when others => null;
      end case;
    end if;
  end process PSEQVAC;

 --process combinatoire d'elaboration de la sortie en focntion de l'etat present
  PCOMBVAC: process (e_p_ac	)
begin  -- process P3
  case e_p_ac is
    when compt =>
      ena_compt_ac <= '1';
    when decompt =>
      ena_compt_ac <= '0';
    when others => null;
  end case;
end process PCOMBVAC;

--process sequentiel de chgt de valeur de l'echantillon voie AC
PCHGTMAC: process (DCLK, rst)
begin  -- process P4
  if rst = '0' then                     -- asynchronous reset (active low)
    mot_AC <= amplitude_min_ac;
  elsif DCLK'event and DCLK = '1' then    -- rising clock edge
    if done_AC='1' then
      if ena_compt_ac='1' then    mot_AC <= mot_AC + pas_ac;
        elsif ena_compt_ac='0' then   mot_AC <= mot_AC - pas_ac;
      end if;
    end if;
  end if;
end process PCHGTMAC;

   -----------------------------------------------------------------------------
  -- production des mots de la voie dc
  -----------------------------------------------------------------------------
 -- machine de Moore
  -- process sequentiel de changement d'etat
  PSEQVDC: process (DCLK, rst)
  begin  -- process P4
    if rst = '0' then                   -- asynchronous reset (active low)
      e_p_dc <= compt;
    elsif DCLK'event and DCLK = '1' then  -- rising clock edge
      case e_p_dc is
       
        when compt => 
          if mot_DC=amplitude_max_dc then
            e_p_dc <= decompt;
          else
            e_p_dc <= compt;
          end if;
        when decompt =>
          if mot_DC=amplitude_min_dc then
            e_p_dc <= compt;
          else
            e_p_dc <= decompt;
          end if;
            
        when others => null;
      end case;
    end if;
  end process PSEQVDC;

  --process combinatoire d'elaboration de la sortie en fonction de l'etat present
  PCOMBVDC: process (e_p_dc)
begin  -- process P3
  case e_p_dc is
    when compt =>
      ena_compt_dc <= '1';
    when decompt =>
      ena_compt_dc <= '0';
    when others => null;
  end case;
end process PCOMBVDC;




--process sequentiel de chgt de valeur de l'echantillon voie DC
PCHGTMDC: process (DCLK, rst)
begin  
  if rst = '0' then                     -- asynchronous reset (active low)
    mot_DC <=amplitude_min_dc ;
  elsif DCLK'event and DCLK = '1' then    -- rising clock edge
    if done_DC='1' then
      if ena_compt_dc='1' then mot_DC <= mot_DC + pas_dc;
        elsif ena_compt_dc='0' then mot_DC <= mot_DC - pas_dc;
      end if;
    end if;
  end if;
end process PCHGTMDC;

-------------------------------------------------------------------------------
-- reg  a decalage entree parallele sortie serie sur DOUT_ADC
-------------------------------------------------------------------------------
  PREG: process (DCLK, rst)
  begin  -- process p1
    if rst = '0' then                   -- asynchronous reset (active low)
      temp_reg <= (others => '0');
    
    elsif DCLK'event and DCLK = '0' then  -- rising clock edge
       if load_mot_ac='1' then
          temp_reg <=  conv_std_logic_vector(mot_AC,12) & "000" ;
       elsif load_mot_dc='1' then
           temp_reg <=  conv_std_logic_vector(mot_DC,12) & "000" ; 
       elsif  decal_AC='1' or decal_dc='1' then
       
            temp_reg <= temp_reg(13 downto 0) & '0';
       end if;
    end if;
  end process PREG;

  DOUT_ADC <= temp_reg(14);
end beh;