-- fsm.vhd: Finite State Machine
-- Author(s): 
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
-- kod1 = 2401966314 	 												  kod2 = 2602949472
--
architecture behavioral of fsm is
   type t_state is (TEST_EMPTY, TEST_ERROR, TEST_2, TEST_24, TEST_240, TEST_2401, TEST_24019, TEST_240196, TEST_2401966, TEST_24019663, TEST_240196631, TEST_2401966314, TEST_26, TEST_260, TEST_2602, TEST_26029, TEST_260294, TEST_2602949, TEST_26029494, TEST_260294947, TEST_2602949472, PRINT_ERROR, PRINT_SUCCESS, FINISH);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= TEST_EMPTY;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;
-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_EMPTY =>
      next_state <= TEST_EMPTY;
		if (KEY(2) = '1') then
			next_state <= TEST_2;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_2 =>
      next_state <= TEST_2;
		if (KEY(4) = '1') then
			next_state <= TEST_24;
		elsif (KEY(6) = '1') then
			next_state <= TEST_26;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	-- - - - - - - -   kod1  - - - - - - - - - - -
	-- - - - - - - -  2401966314 - - - - - - - - -
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_24 =>
      next_state <= TEST_24;
		if (KEY(0) = '1') then
			next_state <= TEST_240;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_240 =>
      next_state <= TEST_240;
		if (KEY(1) = '1') then
			next_state <= TEST_2401;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;	
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_2401 =>
      next_state <= TEST_2401;
		if (KEY(9) = '1') then
			next_state <= TEST_24019;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;	
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_24019 =>
      next_state <= TEST_24019;
		if (KEY(6) = '1') then
			next_state <= TEST_240196;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_240196 =>
      next_state <= TEST_240196;
		if (KEY(6) = '1') then
			next_state <= TEST_2401966;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_2401966 =>
      next_state <= TEST_2401966;
		if (KEY(3) = '1') then
			next_state <= TEST_24019663;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_24019663 =>
      next_state <= TEST_24019663;
		if (KEY(1) = '1') then
			next_state <= TEST_240196631;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_240196631 =>
      next_state <= TEST_240196631;
		if (KEY(4) = '1') then
			next_state <= TEST_2401966314;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_2401966314 =>
      next_state <= TEST_2401966314;
      if (KEY(15) = '1') then
         next_state <= PRINT_SUCCESS; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	-- - - - - - -	- -   kod2  - - - - - - - - - -
	-- - - - - - - -  2602949472   - - - - - - - -
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_26 =>
      next_state <= TEST_26;
		if (KEY(0) = '1') then
			next_state <= TEST_260;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_260 =>
      next_state <= TEST_260;
		if (KEY(2) = '1') then
			next_state <= TEST_2602;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_2602 =>
      next_state <= TEST_2602;
		if (KEY(9) = '1') then
			next_state <= TEST_26029;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_26029 =>
      next_state <= TEST_26029;
		if (KEY(4) = '1') then
			next_state <= TEST_260294;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_260294 =>
      next_state <= TEST_260294;
		if (KEY(9) = '1') then
			next_state <= TEST_2602949;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_2602949 =>
      next_state <= TEST_2602949;
		if (KEY(4) = '1') then
			next_state <= TEST_26029494;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_26029494 =>
      next_state <= TEST_26029494;
		if (KEY(7) = '1') then
			next_state <= TEST_260294947;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_260294947 =>
      next_state <= TEST_260294947;
		if (KEY(2) = '1') then
			next_state <= TEST_2602949472;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_2602949472 =>
      next_state <= TEST_2602949472;
      if (KEY(15) = '1') then
         next_state <= PRINT_SUCCESS; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	-- - - - - - -	spatna klavesa  - - - - - - - -
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_ERROR =>
      next_state <= TEST_ERROR;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR;
      end if;	
	-- - - - - - - - - - - - - - - - - - - - - - -
	-- - - - - - - - ostatni - - - - - - - - - - -
	-- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_ERROR =>
      next_state <= PRINT_ERROR;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;	
	-- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_SUCCESS =>
      next_state <= PRINT_SUCCESS;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= TEST_EMPTY; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= TEST_EMPTY;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_EMPTY | TEST_ERROR | TEST_2 | TEST_24 | TEST_240 | TEST_2401 | TEST_24019 | TEST_240196 | TEST_2401966 | TEST_24019663 | TEST_240196631 | TEST_2401966314 | TEST_26 | TEST_260 | TEST_2602 | TEST_26029 | TEST_260294 | TEST_2602949 | TEST_26029494 | TEST_260294947 | TEST_2602949472 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_ERROR =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
	-- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_SUCCESS =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
		FSM_MX_MEM		<= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
   end case;
end process output_logic;

end architecture behavioral;

