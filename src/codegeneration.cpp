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


        if(instruction == "arr_element"){
            // load temporary
            push_line("arr_element lw $t0, " + to_string(emitted_code[i].op_1.second -> size) + "($sp)");// t0 has value of temp
            push_line("lw $t1, " + to_string(emitted_code[i].op_2.second -> offset) + "($sp)"); // t1 has value of expression
            push_line("li $t2, " + emitted_code[i].result.first); //  has the offset to be added
            push_line("mul $t3, $t1 , $t2"); // multiply 
            push_line("add $t0, $t3, $t0");
            push_line("sw $t0, " + to_string(emitted_code[i].op_1.second -> size) + "($sp)");
        }
        if(instruction == "="){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1)){  // int  x = a[i][j][k] + z; int a[M][N][O];
                                        // add a[i] z x 
                                        // a[i] -> 3AC -> {"arr_element",{"a",sym_entry_a},$3 -> place,{"N*O",NULL}};
                                        
                                        // {"a[i]",base_a -> offset,offset} a[i][j] offset -> j*O
                                        // {"a[i][j]",base_a,offset};
                                        // a[i][j][k] -> {"a[i][j][k]",{"int",base_a -> offset,offset_temporaray_variable}} original array -> a lookup through parameter
                                        // global_array -> handle
                                        // local_array -> handle
                load_array_element0(op1);
            }
            else{
                // normal variable to be loaded
            }
            // if(is_array_element(op2)){
            //     load_array_element(op2);
            // }
            // else{

            // }
            if(is_array_element(res)){
                load_array_element2(res);
            }
            else{
                
            }
        }
        if(instruction == "+int"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            // if(is_array_element(op1)){  // int  x = a[i][j][k] + z; int a[M][N][O];
            //                             // add a[i] z x 
            //                             // a[i] -> 3AC -> {"arr_element",{"a",sym_entry_a},$3 -> place,{"N*O",NULL}};
                                        
            //                             // {"a[i]",base_a -> offset,offset} a[i][j] offset -> j*O
            //                             // {"a[i][j]",base_a,offset};
            //                             // a[i][j][k] -> {"a[i][j][k]",{"int",base_a -> offset,offset_temporaray_variable}} original array -> a lookup through parameter
            //                             // global_array -> handle
            //                             // local_array -> handle
            //     load_array_element(op1);
            // }
            // else{
            //     // normal variable to be loaded
            // }
            // if(is_array_element(op2)){
            //     load_array_element(op2);
            // }
            // else{

            // }
            // if(is_array_element(res)){
            //     load_array_element(res);
            // }
        }
    }
}