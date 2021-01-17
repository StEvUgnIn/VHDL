----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2018 09:59:30
-- Design Name: 
-- Module Name: decodeur - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodeur is
    Port ( bus_addr  : in STD_LOGIC_VECTOR (15 downto 0);
           CS_RAM    : out STD_LOGIC;
           CS_FLASH  : out STD_LOGIC;
           CS_EEPROM : out STD_LOGIC);
end decodeur;

architecture Behavioral of decodeur is
    -- secteur RAM
    signal addr_0000 : std_logic_vector (15 downto 0) := "0000000000000000";
    signal addr_3fff : std_logic_vector (15 downto 0) := "0011111111111111";
    -- secteur FLASH
    signal addr_4000 : std_logic_vector (15 downto 0) := "0100000000000000";
    signal addr_cfff : std_logic_vector (15 downto 0) := "1100111111111111";
    -- secteur EEPROM
    signal addr_e800 : std_logic_vector (15 downto 0) := "1110100000000000";
    signal addr_ebff : std_logic_vector (15 downto 0) := "1110101111111111";
begin
p1: process(bus_addr) begin
    if bus_addr >= addr_0000 and addr_3fff <= bus_addr then
    CS_RAM <= '0';
    elsif bus_addr >= addr_4000 and addr_cfff <= bus_addr then
    CS_FLASH <= '0';
    elsif bus_addr >= addr_e800  and addr_ebff <= bus_addr then
    CS_EEPROM <= '0';
    end if;
    end process;
end Behavioral;
