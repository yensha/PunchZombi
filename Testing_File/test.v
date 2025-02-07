library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity button_reader is
    Port (
        btn0, btn1, btn2: in std_logic; -- 三個按鈕的輸入信號
        btn_state: out std_logic_vector(2 downto 0) -- 按鈕狀態的輸出信號
    );
end button_reader;

architecture Behavioral of button_reader is
begin
    process(btn0, btn1, btn2)
    begin
        -- 檢查按鈕狀態
        if (btn0 = '1') then
            btn_state <= "001"; -- 按鈕0被按下
        elsif (btn1 = '1') then
            btn_state <= "010"; -- 按鈕1被按下
        elsif (btn2 = '1') then
            btn_state <= "100"; -- 按鈕2被按下
        else
            btn_state <= "000"; -- 沒有按鈕被按下
        end if;
    end process;
end Behavioral;