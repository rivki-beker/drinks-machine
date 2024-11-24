# Drinks Machine

## Project Overview

This project involves the verification of a digital **Drinks Machine** design. The primary goal is to ensure that the machine processes payments correctly, delivers the requested drink, and reports errors accurately.

## Project Files

- **Design files (RTL)**:
  - `design.sv`: RTL implementation of the `drink` module.

- **Testbench files**:
  - `dr_seq_item.sv`: Defines the format of sequence items used in tests.
  - `dr_sequence.sv`: Contains predefined test scenarios.
  - `dr_sequencer.sv`: Manages communication between sequences and the driver.
  - `dr_driver.sv`: Simulates input signals to the DUT.
  - `dr_monitor.sv`: Captures outputs from the DUT.
  - `dr_scoreboard.sv`: Compares actual and expected outputs.
  - `dr_agent.sv`: Manages all UVM components.
  - `dr_env.sv`: Defines the UVM environment.
  - `dr_base_test.sv`: Serves as a base class for creating custom tests.
  - `dr_random_test.sv`: Implements randomized test scenarios.

- **Interface**:  
  `dr_interface.sv`: Connects the testbench with the RTL design.

## Design Under Test (DUT)

The DUT simulates the operation of a drinks vending machine with the following features:
- **Inputs**:
  - `clk`: Clock signal.
  - `rst`: Reset signal (1 bit).
  - `valid`: Valid signal (1 bit).
  - `pay_in`: Payment data (10 bits).
  - `code`: Drink code (3 bits).

- **Outputs**:
  - `drink`: Delivered drink (3 bits).
  - `error`: Error flag (1 bit).

### Functionality
1. The machine begins a transaction when `valid` is set high at the positive edge of the clock.
2. The machine:
   - Receives payment (`pay_in`) and drink code (`code`).
   - Processes the inputs to determine whether the payment is correct and the code is valid.
   - Outputs the requested drink if the transaction is valid.
   - Transmits an error flag if the payment or code is invalid.

### Constraints
- Payment is calculated by counting consecutive `1`s in the `pay_in` signal.
- Each drink has a specific code and price:
  - **Water**: `C1`, 5 ILS.
  - **Apple Water**: `C2`, 8 ILS.
  - **Peach Water**: `C3`, 10 ILS.
  - **Soda**: `D4`, 15 ILS.
  - **Cola**: `D5`, 18 ILS.
  - **Orange Lime**: `B6`, 20 ILS.
  - **Drink X**: `B7`, 25 ILS.

### Bonus Features
- The verification ensures that the DUT processes only accurate transactions.
- A scoreboard validates correct operations and discards invalid transactions.
- Testbench includes corner cases to challenge the DUT under extreme conditions.

## Project Setup

This project was developed in **EDA Playground**, an online platform for digital design and verification.

### Tools Used
- **SystemVerilog**: For designing and verifying the DUT.
- **UVM (Universal Verification Methodology)**: For building the testbench and the verification environment.

## Getting Started

1. **Open EDA Playground**: Use [EDA Playground](https://edaplayground.com/x/RXpX) to simulate and test the design.
2. **Run Simulations**: Verify the outputs under various test cases, including corner cases. See the waves in the simulation.

## How It Works

1. The DUT calculates the payment by counting the number of consecutive `1`s in the `pay_in` signal.
   - Example: `1011111` = 5, `000111` = 3.
2. If the payment matches the drink's price and the code is valid, the drink is delivered.
3. If any input is invalid, an error flag is raised.