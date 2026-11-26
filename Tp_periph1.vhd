library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Tp_periph1 is
port (

    CLOCK_50            : in std_logic;
    CLOCK_27            : in std_logic;
    KEY                 : in std_logic_vector (3 downto 0);
    SW                  : in std_logic_vector (9 downto 0);

    UART_RXD            : in std_logic;

    AUD_ADCDAT          : in std_logic;

    GPIO_0              : inout std_logic_vector (35 downto 0);
    GPIO_1              : inout std_logic_vector (35 downto 0);

    SRAM_DQ             : inout std_logic_vector (15 downto 0);
    
    DRAM_DQ             : inout std_logic_vector (15 downto 0);

    PS2_CLK             : inout std_logic;
    PS2_DAT             : inout std_logic;
    
    AUD_BCLK            : inout std_logic;
    AUD_ADCLRCK         : inout std_logic;
    AUD_DACLRCK         : inout std_logic;

    I2C_SDAT            : inout std_logic;
    
    TD_RESET            : out std_logic;

    LEDG                : out std_logic_vector (7 downto 0);
    LEDR                : out std_logic_vector (9 downto 0);
    HEX0                : out std_logic_vector (6 downto 0);
    HEX1                : out std_logic_vector (6 downto 0);
    HEX2                : out std_logic_vector (6 downto 0);
    HEX3                : out std_logic_vector (6 downto 0);

    SRAM_ADDR           : out std_logic_vector (17 downto 0);
    SRAM_CE_N           : out std_logic;
    SRAM_WE_N           : out std_logic;
    SRAM_OE_N           : out std_logic;
    SRAM_UB_N           : out std_logic;
    SRAM_LB_N           : out std_logic;

    UART_TXD            : out std_logic;
    
    DRAM_ADDR           : out std_logic_vector (11 downto 0);
    DRAM_BA_1           : buffer std_logic;
    DRAM_BA_0           : buffer std_logic;
    DRAM_CAS_N          : out std_logic;
    DRAM_RAS_N          : out std_logic;
    DRAM_CLK            : out std_logic;
    DRAM_CKE            : out std_logic;
    DRAM_CS_N           : out std_logic;
    DRAM_WE_N           : out std_logic;
    DRAM_UDQM           : buffer std_logic;
    DRAM_LDQM           : buffer std_logic;

    AUD_XCK             : out std_logic;
    AUD_DACDAT          : out std_logic;
    
    VGA_CLK             : out std_logic;
    VGA_HS              : out std_logic;
    VGA_VS              : out std_logic;
    VGA_R               : out std_logic_vector (3 downto 0);
    VGA_G               : out std_logic_vector (3 downto 0);
    VGA_B               : out std_logic_vector (3 downto 0);
    
    I2C_SCLK            : out std_logic
    );
end Tp_periph1;

architecture sys of Tp_periph1 is

   component qsys is
        port (
            clk_clk       : in std_logic := 'X'; -- clk
            reset_reset_n : in std_logic := 'X'  -- reset_n
        );
    end component qsys;

signal             BA  : STD_LOGIC_VECTOR(1 DOWNTO 0);
signal             DQM : STD_LOGIC_VECTOR(1 DOWNTO 0);


begin

UART_TXD <= '0';

AUD_XCK     <= '0';
AUD_DACDAT  <= '0';
    
I2C_SCLK        <= '0';

PS2_CLK     <= 'Z';
PS2_DAT     <= 'Z';
    
AUD_BCLK        <= 'Z';
AUD_ADCLRCK <= 'Z';
AUD_DACLRCK <= 'Z';

I2C_SDAT        <= 'Z';

TD_RESET    <= '1';

GPIO_1 <= (others => 'Z');
GPIO_0 <= (others => 'Z');

DRAM_BA_1  <= BA(1);
DRAM_BA_0  <= BA(0);
DRAM_UDQM  <= DQM(1);
DRAM_LDQM  <= DQM(0);



 u0 : component qsys
        port map (
            clk_clk       => CLOCK_50,       --   clk.clk
            reset_reset_n => KEY(0)  -- reset.reset_n
        );

end sys;