library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram256x8 is
	port(
		address: in STD_LOGIC_VECTOR (7 downto 0) := "00000000";
		clock: in STD_LOGIC  := '1';
		data: in STD_LOGIC_VECTOR (7 downto 0);
		wren: in STD_LOGIC ;
		q: out STD_LOGIC_VECTOR (7 downto 0)
	);
end entity;

architecture Behaviour of ram256x8 is

	type mem is ARRAY (0 to 255) of STD_LOGIC_VECTOR (7 downto 0);
	signal memory_array : mem;

begin

	process(clock)
	begin
		if rising_edge(clock) then
			if wren = '1' then
				memory_array(to_integer(unsigned(address))) <= data;
			end if;
		end if;
	end process;
	q <= memory_array(to_integer(unsigned(address)));
	
end architecture;