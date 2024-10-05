library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram32x4 is
	port(
		address: in STD_LOGIC_VECTOR (4 DOWNTO 0) := "00000";
		clock: in STD_LOGIC  := '1';
		data: in STD_LOGIC_VECTOR (3 DOWNTO 0);
		wren: in STD_LOGIC ;
		q: out STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
end entity;

architecture Behaviour of ram32x4 is

	type mem is ARRAY (0 to 31) of STD_LOGIC_VECTOR (3 downto 0);
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