library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ff is
	port(
		clk : in STD_LOGIC;
		data : in STD_LOGIC;
		q : out STD_LOGIC
	);
end entity;

architecture Behaviuour of ff is
begin
	process(clk)
	begin
		if rising_edge(clk) then
			q <= data;
		end if;
	end process;
end architecture;