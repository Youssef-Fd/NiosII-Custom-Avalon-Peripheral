library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Tp_periph is
    port (
      reset, Clock   : in std_logic;
      chipselect   : in std_logic;
      address      : in std_logic_vector (1 downto 0);
      write        : in std_logic;
      read         : in std_logic;
      writeData    : in std_logic_vector (31 downto 0);
      readData     : out std_logic_vector (31 downto 0)
    );
	 
end Tp_periph;

architecture periph of Tp_periph is

signal resultat  : std_logic_vector (31 downto 0);
signal data_in0  : std_logic_vector (31 downto 0);
signal data_in1  : std_logic_vector (31 downto 0);
signal data_in2  : std_logic_vector (31 downto 0);
signal data_in3  : std_logic_vector (31 downto 0);

begin


PROCESS (reset, Clock)
    BEGIN
        IF (reset = '1') THEN
            data_in0 <= (others => '0'); 
            data_in1 <= (others => '0');
            data_in2 <= (others => '0'); 
            data_in3 <= (others => '0');
        ELSIF Clock'EVENT AND Clock = '1' THEN
            IF (chipselect = '1' AND write = '1') THEN
                CASE address IS
                    WHEN "00" => data_in0 <= writeData;
                    WHEN "01" => data_in1 <= writeData;
                    WHEN "10" => data_in2 <= writeData;
                    WHEN "11" => data_in3 <= writeData;
                    WHEN OTHERS => NULL;
                END CASE;
            END IF;
        END IF;
    END PROCESS;

resultat <= data_in0 + data_in1 + data_in2 + data_in3;

PROCESS (reset, Clock)
    BEGIN
        IF (reset = '1') THEN
            readdata <= (others => '0');
        ELSIF Clock'EVENT AND Clock = '1' THEN
            IF (chipselect = '1' AND read = '1') THEN
                IF (address = "00") THEN
                    readdata <= (31 downto 30 => resultat(31) ) & resultat(31 downto 2);
                ELSE
                    readdata <= (others => '0');
                END IF;
            END IF;
        END IF;
    END PROCESS;

end periph;