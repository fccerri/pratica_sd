library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity part4 is
	port(
		clk: in STD_LOGIC;
		w: in STD_LOGIC;
		Key0: in STD_LOGIC;
		waddress: in STD_LOGIC_VECTOR (4 downto 0);
		raddress: in STD_LOGIC_VECTOR (4 downto 0);
		DataIn: in STD_LOGIC_VECTOR (3 downto 0);
		hex0: out STD_LOGIC_VECTOR (6 downto 0);
		hex1: out STD_LOGIC_VECTOR (6 downto 0);
		hex2: out STD_LOGIC_VECTOR (6 downto 0);
		hex3: out STD_LOGIC_VECTOR (6 downto 0);
		hex4: out STD_LOGIC_VECTOR (6 downto 0);
		hex5: out STD_LOGIC_VECTOR (6 downto 0)
	);
end entity;

architecture Behaviour of part4 is

	component ram32x4 is
		port(
			clock: in STD_LOGIC  := '1';
			data: in STD_LOGIC_VECTOR (3 downto 0);
			rdaddress: in STD_LOGIC_VECTOR (4 downto 0);
			wraddress: in STD_LOGIC_VECTOR (4 downto 0);
			wren: in STD_LOGIC  := '0';
			q: out STD_LOGIC_VECTOR (3 downto 0)
		);
	end component;
	
	component contador is
		generic(n: natural:=5; k: STD_LOGIC_VECTOR:="11111"; c: natural:=50000000);
		port (
			clk: in STD_LOGIC;
			reset: in STD_LOGIC;
			enable: in STD_LOGIC;
			output: out STD_LOGIC_VECTOR (n-1 downto 0);
			rollover: out STD_LOGIC :='0'
		);
	end component;
	
	component display7seg is
		port(
			in_disp: in STD_LOGIC_VECTOR (3 downto 0);
			out_disp: out STD_LOGIC_VECTOR (6 downto 0)
	);
	end component;
	
	signal display0: STD_LOGIC_VECTOR (3 downto 0);
	signal display2_3: STD_LOGIC_VECTOR (4 downto 0);

begin

	c: contador
	generic map(
		n => 5,
		k => "11111",
		c => 50000000
	)
	port map(
		clk => clk,
		reset => not Key0,
		enable => '1',
		output => display2_3,
		rollover => open
	);

	ram: ram32x4
	port map(
		clock => clk,
		data => DataIn,
		rdaddress => display2_3,
		wraddress => waddress,
		wren => w,
		q => display0
	);
	
	d0: display7seg
	port map(
		in_disp => display0,
		out_disp => hex0
	);
	
	d1: display7seg
	port map(
		in_disp => DataIn,
		out_disp => hex1
	);
	
	d2: display7seg
	port map(
		in_disp => display2_3 (3 downto 0),
		out_disp => hex2
	);
	
	d3: display7seg
	port map(
		in_disp => "000" & display2_3(4),
		out_disp => hex3
	);
	
	d4: display7seg
	port map(
		in_disp => waddress (3 downto 0),
		out_disp => hex4
	);
	
	d5: display7seg
	port map(
		in_disp => "000" & waddress(4),
		out_disp => hex5
	);
	
end architecture Behaviour;