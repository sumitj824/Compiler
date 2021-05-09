#include "codegeneration.h"

using namespace std;

string curr_Func;

vector <quad> parameters;

void generate_code(){
    for(int i = 0;i < emitted_code.size();i++){
        string instruction = emitted_code[i].op_code.first;
        if(instruction == "CALL_FUNC"){
            string call_func = emitted_code[i].op_1.first;
            int size = funcSize[call_func];
            save_all_registers();
            push_line("move $s0, $sp");
            // copy the previous stack pointer to s0
            push_line("li $t1, " + to_string(80));
            push_line("add $t1, $t1, " + to_string(size));
            push_line("sub $sp, $sp, $t1");
            // move the stack_pointer to func_size + space_required_for_registers
            // TODO : test whether value of pointer is copied or not in case of a parameter.
            int temp_off = 0;
            for(int i = 0;i < parameters.size();i++){
                s_entry * temp = parameters[i].op_1.second;
                string type = temp -> type;
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
            push_line("jal " + call_func);
        }
        if(instruction == "FUNC_START"){
            curr_Func = emitted_code[i].op_1.first; // changed the func_name
        }
        if(instruction == "param"){
            parameters.push_back(emitted_code[i]);
        }


        if(instruction == "arr_element"){
            // load temporary
            push_line("arr_element lw $t0, " + to_string(emitted_code[i].op_1.second -> size) + "($sp)");// t0 has value of temp
            push_line("lw $t1, " + to_string(emitted_code[i].op_2.second -> offset) + "($sp)"); // t1 has value of expression
            push_line("li $t2, " + emitted_code[i].result.first); //  has the offset to be added
            push_line("mul $t3, $t1 , $t2"); // multiply 
            push_line("add $t0, $t3, $t0");
            push_line("sw $t0, " + to_string(emitted_code[i].op_1.second -> size) + "($sp)");
        }

        // handle the return case for functions

        // if(instruction == "="){
        //     comp op1 = emitted_code[i].op_1;
        //     comp op2 = emitted_code[i].op_2;
        //     comp res = emitted_code[i].result;
        //     if(is_array_element(op1)){  
        //         load_array_element0(op1);
        //     }
        //     else{
        //         load_normal_element0(op1);
        //     }
        //     if(is_array_element(res)){
        //         load_array_element2(res);
        //     }
        //     else{
        //         load_normal_element2(op1);
        //     }
        //     push_line("lw $t3, 0($t0)");
        //     push_line("sw $t3, 0($t2)");
        // }
        if(instruction == "+int"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("add $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
    }
}