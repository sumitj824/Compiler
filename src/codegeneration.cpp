#include "codegeneration.h"

using namespace std;

string curr_Func;

vector <quad> parameters;

void generate_code(){
    for(int i = 0;i < emitted_code.size();i++){
        string instruction = emitted_code[i].op_code.first;
        if(instruction == "CALL_FUNC"){
            // find the func_size
            // move the stack_pointer to func_size + space_required_for_registers
            // now push parameters on the stack
            // decrease the stack pointer
        }
        if(instruction == "FUNC_START"){
            curr_Func = emitted_code[i].op_1.first; // changed the func_name
            // save t0-t9
            // save s0-s7, fp, ra
            // increase the stack pointer by func_size + space_required_for_registers
        }
        if(instruction == "param"){
            // write param 3ac code.
            parameters.push_back(emitted_code[i]);
        }
    }
}