library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity part2 is
	port(
		clk: in STD_LOGIC;
		w: in STD_LOGIC;
		Address: in STD_LOGIC_VECTOR (4 downto 0);
		DataIn: in STD_LOGIC_VECTOR (3 downto 0);
		DataOut: out STD_LOGIC_VECTOR (6 downto 0)
	);
end entity;

architecture Behaviour of part2 is

	component ram32x4 is
		port(
			address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
		);
	end component;
	
	component display7seg is
		port(
			in_disp: in STD_LOGIC_VECTOR (3 downto 0);
			out_disp: out STD_LOGIC_VECTOR (6 downto 0)
	);
	 end component;
	
	signal aux: STD_LOGIC_VECTOR (3 downto 0);

begin

	ram: ram32x4
	port map(
		address => Address,
		clock => clk,
		data => DataIn,
		wren => w,
		q => aux
	);
	
	d: display7seg
	port map(
		in_disp => aux,
		out_disp => DataOut
	);
	
end architecture Behaviour;