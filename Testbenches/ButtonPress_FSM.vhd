library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ButtonPress_FSM is
   port (clk, rst : in std_logic;
         b : in std_logic;
         y : out std_logic);
end ButtonPress_FSM;

architecture Behavior of ButtonPress_FSM is
begin

   process(clk)
      type BP_statetype is (BP_Init, BP_Out1, BP_Out2);
      variable BP_State : BP_statetype;  
   begin
      if (rising_edge(clk)) then
         if (rst = '1') then
            -- Initial state
            BP_State := BP_Init;
         else 
            -- State transitions
            case BP_State is
               when BP_Init =>
                  if ((not b) = '1') then
                     BP_State := BP_Init;
                  elsif (b = '1') then
                     BP_State := BP_Out1;
                  end if;
                  
               when BP_Out1 =>
                  BP_State := BP_Out2;

               when BP_Out2 =>
                  BP_State := BP_Init;
               
               when others =>
                  BP_State := BP_Init;
            end case;
         end if;
         
         -- State actions
         case BP_State is
            when BP_Init =>
               y <= '0';
                  
            when BP_Out1 =>
               y <= '1';

            when BP_Out2 =>
               y <= '0';

            when others =>
               y <= '0';
         end case;
      end if;
   end process;

end Behavior;