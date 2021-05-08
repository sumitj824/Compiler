#include "codegeneration.h"

using namespace std;

string curr_Func;

vector <quad> parameters;

void generate_code(){
    for(int i = 0;i < emitted_code.size();i++){
        string instruction = emitted_code[i].op_code.first;
        if(instruction == "CALL_FUNC"){
            // find the func_size
            // copy the previous stack pointer to s0
            // move the stack_pointer to func_size + space_required_for_registers
            // now push parameters on the stack
            // test for pointers

            int temp_off = 0;
            // cout << "inside call_func" << endl;
            for(int i = 0;i < parameters.size();i++){
                s_entry * temp = parameters[i].op_1.second;
                string type = temp -> type;
                // cout << type << endl;
                if(type.back() == '*'){
                    push_line("li $t0, " + to_string(temp -> offset));
                    push_line("add $t0, $s0, $t0");
                    push_line("sw $t0, " + to_string(temp_off)+ "($sp)");
                    temp_off += get_size(type);
                }
                else{
                    push_line("lw $t0, " + to_string(temp -> offset) + "($s0)");
                    push_line("sw $t0, " + to_string(temp_off)+ "($sp)");
                    temp_off += get_size(type);
                }
            }
            // jump to function called.
        }
        if(instruction == "FUNC_START"){
            curr_Func = emitted_code[i].op_1.first; // changed the func_name
            // save t0-t9
            // save s0-s7, fp, ra
            // increase the stack pointer by func_size + space_required_for_registers
        }
        if(instruction == "param"){
        //     write param 3ac code.
            parameters.push_back(emitted_code[i]);
        }
    }
}