LIBRARY ieee;
USE  ieee.std_logic_1164.ALL;

ENTITY FullAdder IS 
    PORT(a, b, cin: IN std_logic;
         s, cout:   OUT std_logic);
END FullAdder;

ARCHITECTURE FA OF FullAdder IS 
BEGIN 
    s <= a XOR b XOR cin;
    cout <= (a AND b) OR (a AND cin) OR (b AND cin);
END FA;

LIBRARY ieee;
USE  ieee.std_logic_1164.ALL;

ENTITY ArrayMultiplier IS 
    Generic (data_width: integer := 32);
    PORT (X, Y: IN std_logic_vector(data_width - 1 DOWNTO 0);
          P:    OUT std_logic_vector(2 * data_width - 1 DOWNTO 0));
END ArrayMultiplier;

ARCHITECTURE concurrent OF ArrayMultiplier IS
    
    type vector_2d is array (0 to data_width - 1) of std_logic_vector(0 TO data_width - 1);
    type ports_2d is array (0 to data_width - 1) of std_logic_vector(0 TO data_width - 2);
    
    SIGNAL and_results: vector_2d;
    SIGNAL as: ports_2d;
    SIGNAL bs: ports_2d;
    SIGNAL cins: ports_2d;
    SIGNAL couts: ports_2d;
    SIGNAL sums: ports_2d;
    
    COMPONENT FullAdder IS 
        PORT(a, b, cin: IN std_logic;
             s, cout: OUT std_logic);
    END COMPONENT;
BEGIN 
    AndResults1: FOR i IN 0 TO data_width - 1 GENERATE
        AndResults2: FOR j IN 0 TO data_width - 1 GENERATE
            and_results(i)(j) <= X(i) AND Y(j);
        END GENERATE AndResults2;
    END GENERATE AndResults1;

    FirstRow: For i IN 0 TO data_width - 2 GENERATE
        as(0)(i) <= and_results(i + 1)(0);
        bs(0)(i) <= and_results(i)(1);
        cins(0)(i) <= '0';
    END GENERATE FirstRow;

    MiddleRows1: FOR i IN 1 TO data_Width - 2 GENERATE
        MiddleRows2: FOR j IN 0 TO data_width - 3 GENERATE
            as(i)(j) <= sums(i - 1)(j + 1);
            bs(i)(j) <= and_results(j)(i + 1);
            cins(i)(j) <= couts(i-1)(j);
        END GENERATE MiddleRows2;
        as(i)(data_width - 2) <= and_results(data_width - 1)(i);
        bs(i)(data_width - 2) <= and_results(data_width - 2)(i + 1);
        cins(i)(data_width - 2) <= couts(i - 1)(data_width - 2);
    END GENERATE MiddleRows1;

    -- last row, first one.
    as(data_width - 1)(0) <= sums(data_width - 2)(1);
    bs(data_width - 1)(0) <= '0';
    cins(data_width - 1)(0) <= couts(data_width - 2)(0);

    LastRow: FOR i IN 1 TO data_width - 3 GENERATE
        as(data_width - 1)(i) <= sums(data_width - 2)(i + 1);
        bs(data_width - 1)(i) <= couts(data_width - 1)(i - 1);
        cins(data_width - 1)(i) <= couts(data_width - 2)(i);
    END GENERATE LastRow;

    -- last row last one.
    as(data_width - 1)(data_width - 2) <= and_results(data_width - 1)(data_width - 1);
    bs(data_width - 1)(data_width - 2) <= couts(data_width - 1)(data_width - 3);
    cins(data_width - 1)(data_width - 2) <= couts(data_width - 2)(data_width - 2);

    MakeComp1: FOR i IN 0 TO data_width - 1 GENERATE
        MakeComp2: FOR j IN 0 TO data_width - 2 GENERATE
            full_adder: FullAdder
                PORT MAP(
                    a => as(i)(j),
                    b => bs(i)(j),
                    cin => cins(i)(j),
                    cout => couts(i)(j),
                    s => sums(i)(j)
                );
        END GENERATE MakeComp2;
    END GENERATE MakeComp1;
    
    P(0) <= and_results(0)(0);
    
    Output1: FOR i IN 0 TO data_width - 1 GENERATE
        P(i + 1) <= sums(i)(0);
    END GENERATE Output1;

    Output2: FOR i IN 0 TO data_width - 2 GENERATE
        P(i + data_width) <= sums(data_width - 1)(i);
    END GENERATE Output2;

    P(2 * data_width - 1) <= couts(data_width - 1)(data_width - 2);
END concurrent;

ENTITY ArrayMultiplierTb IS END ArrayMultiplierTb;

LIBRARY ieee;
USE  ieee.std_logic_1164.all;

ARCHITECTURE concurrent_tb OF ArrayMultiplierTb IS 
    CONSTANT data_w: integer := 32;
    COMPONENT ArrayMultiplier IS 
        Generic (data_width: integer := 32);
        PORT (X,Y: IN std_logic_vector(data_width - 1 DOWNTO 0);
              P: OUT std_logic_vector(2 * data_width - 1 DOWNTO 0));
    END COMPONENT;
    SIGNAL x_t: std_logic_vector(data_w - 1 DOWNTO 0);
    SIGNAL y_t: std_logic_vector(data_w - 1 DOWNTO 0);
    SIGNAL p_t: std_logic_vector(2 * data_w - 1 DOWNTO 0);
BEGIN 
    U1: ArrayMultiplier 
        -- GENERIC MAP(data_width => data_w) 
        PORT MAP(
            X => x_t, 
            Y => y_t, 
            P => p_t);
    x_t <= B"00000000000000000000000000000000" , B"00000000000000000000000000001110" AFTER 15ns, 
    B"00000000000000000000000000001101" AFTER 30ns, B"01011111000000001111010100110111" AFTER 45ns;
    y_t <= B"00000000000000000000000000000000" , B"00000000000000000000000000010110" AFTER 15ns,
    B"00000000000000000000000000010101" AFTER 30ns, B"11010111110011110001100101010011" AFTER 45ns;
END concurrent_tb;
