# custom_mdc_processor
custom mdc processor for two 8bits input.

The following project was created using the RTL method, first starting by a C-Level code for a mdc function:

![image](https://user-images.githubusercontent.com/43892745/131693403-8cf2038a-62e0-4e7c-9f99-399dd055de6c.png)

The algorithm describes the behavior of the mdc function with control signals and variables to be created. Starting from the C code, we could implement our fist view of a High-Level state machine in order to organize what will happen in each state for the mdc algorithm.

![image](https://user-images.githubusercontent.com/43892745/131693992-e3a9450b-b850-4eba-b5a7-702c5ac586dd.png)

With the High-Level state machine, we can now create our first view of the datapath, creating the necessary blocks to perform the desired calculations as seen in the High-Level state machine.

![image](https://user-images.githubusercontent.com/43892745/131694888-8c8ded06-b382-4be1-970b-b67b115aad4f.png)






