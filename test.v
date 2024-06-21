library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity button_reader is
    Port (
        btn0, btn1, btn2: in std_logic; -- �T�ӫ��s����J�H��
        btn_state: out std_logic_vector(2 downto 0) -- ���s���A����X�H��
    );
end button_reader;

architecture Behavioral of button_reader is
begin
    process(btn0, btn1, btn2)
    begin
        -- �ˬd���s���A
        if (btn0 = '1') then
            btn_state <= "001"; -- ���s0�Q���U
        elsif (btn1 = '1') then
            btn_state <= "010"; -- ���s1�Q���U
        elsif (btn2 = '1') then
            btn_state <= "100"; -- ���s2�Q���U
        else
            btn_state <= "000"; -- �S�����s�Q���U
        end if;
    end process;
end Behavioral;