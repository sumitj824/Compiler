#include "codegeneration.h"

using namespace std;

string curr_Func = "__global";

set<string> global_variables_completed;

vector <quad> parameters;

vector <quad> initializer_list_vec;

vector <quad> local_string_char_vec;

void generate_code(){
    // curr_Func = ".data";
    // for(auto i : *GST){
    //     if(funcMap.count(i.first)){
    //         continue;
    //     }
    //     push_line(i.first + " :");
    // }
    library_function_implementation();
    formBasicBlocks();
    for(int i = 0;i < emitted_code.size();i++){
        if(basicBlock.find(i)!=basicBlock.end()){
            push_line("Label"+to_string(i)+" :");
        }
        string instruction = emitted_code[i].op_code.first;
        push_line("");
        push_line("# "+ emitted_code[i].op_code.first+ " "+emitted_code[i].op_1.first +" "+ emitted_code[i].op_2.first+" "+emitted_code[i].result.first);
       // cout<<("# "+ emitted_code[i].op_code.first+ " "+emitted_code[i].op_1.first +" "+ emitted_code[i].op_2.first+" "+emitted_code[i].result.first)<<endl;;
        
        if(instruction == "initializer_list"){
           if(emitted_code[i].op_1.second!=NULL) initializer_list_vec.push_back(emitted_code[i]);
        }

        if(instruction == "array_initialized"){
            int curr_temp_off = 0; 
        
            for(int j = 0; j < initializer_list_vec.size(); j++){
                
                load_normal_element0(initializer_list_vec[j].op_1);  //value to be passed is in $t0
                // load_normal_element2((emitted_code[i].op_1));  //value to be passed is in $t0
                push_line("add $t2, $sp, " + to_string(((emitted_code[i].op_1).second) -> offset));
                push_line("lw $t3, 0($t0)");
                push_line("sw $t3, "+ to_string(curr_temp_off)+"($t2)");
                curr_temp_off += 4;
            }
            initializer_list_vec.clear();
        }
        if(instruction=="global_array_intialized_int"){
            initializer_list_vec.clear();
            curr_Func = ".data";
            push_line(emitted_code[i].result.first + " : .word " + emitted_code[i].op_1.first);
            global_variables_completed.insert(emitted_code[i].result.first);
            curr_Func = "__global";
        }

        if(instruction=="global_array_intialized_float"){
            initializer_list_vec.clear();
            curr_Func = ".data";
            push_line(emitted_code[i].result.first + " : .float " + emitted_code[i].op_1.first);
            global_variables_completed.insert(emitted_code[i].result.first);
            curr_Func = "__global";
        }

        if(instruction == "store_in_global_variable_int"){
            curr_Func = ".data";
            if(!is_array_element(emitted_code[i].result.first)){
                push_line(emitted_code[i].result.first + " : .word " + emitted_code[i].op_1.first);
                global_variables_completed.insert(emitted_code[i].result.first);
            }
            curr_Func = "__global";
        }

        if(instruction == "store_in_global_variable_float"){
            curr_Func = ".data";
            if(!is_array_element(emitted_code[i].result.first)){
                push_line(emitted_code[i].result.first + " : .float " + emitted_code[i].op_1.first);
                global_variables_completed.insert(emitted_code[i].result.first);
            }
            curr_Func = "__global";
        }

        if(instruction == "global_string"){
            local_string_char_vec.clear();
            curr_Func = ".data";
            push_line(emitted_code[i].result.first + " : .asciiz \"" + emitted_code[i].op_1.first + "\"");
            global_variables_completed.insert(emitted_code[i].result.first);
            curr_Func = "__global";
        }

        if(instruction == "string_literal_local_char"){
            if(emitted_code[i].op_1.second!=NULL) local_string_char_vec.push_back(emitted_code[i]);
        }

        if(instruction == "initializing_local_string"){
            int curr_temp_off = 0; 
        
            for(int j = 0; j < local_string_char_vec.size(); j++){
                
                load_normal_element0(local_string_char_vec[j].op_1);  //value to be passed is in $t0
                // load_normal_element2((emitted_code[i].op_1));  //value to be passed is in $t0
                push_line("add $t2, $sp, " + to_string(((emitted_code[i].op_1).second) -> offset));
                push_line("lw $t3, 0($t0)");
                push_line("sw $t3, "+ to_string(curr_temp_off)+"($t2)");
                curr_temp_off += 4;
            }
            local_string_char_vec.clear();
        }

        if(instruction == "struct_pointer_case"){
            comp op1 = emitted_code[i].op_1;
            comp res = emitted_code[i].result;
            push_line("li $t0, " + res.first);
            push_line("lw $t1, " + to_string(op1.second -> size) + "($sp)");
            push_line("add $t1, $t1, $t0");
            push_line("sw $t1, " + to_string(op1.second -> size) + "($sp)");
        }

        if(instruction == "string_literal_handle"){
            local_string_char_vec.clear();
            string temp_func =curr_Func;
            curr_Func = ".data";
            push_line(emitted_code[i].result.first + " : .asciiz " + emitted_code[i].op_1.first);
            global_variables_completed.insert(emitted_code[i].result.first);
            curr_Func = temp_func;
        }
        
        if(instruction == "CALL_FUNC"){
            string call_func2 = emitted_code[i].op_1.first;
            
            if(call_func2 == "prints"){
                argument_label = parameters[0].op_1.first;
                prints_implementation();
                parameters.clear();
            }
            else{
                string call_func = emitted_code[i].op_1.first;
                int size = funcSize[call_func];
                // copy the previous stack pointer to s0
                push_line("li $t1, " + to_string(80));
                push_line("add $t1, $t1, " + to_string(size));
                push_line("sub $s0, $sp, $t1");
                // move the stack_pointer to func_size + space_required_for_registers
                
                // TODO : test whether value of pointer is copied or not in case of a parameter.
                
            
                int temp_off = 0;

                for(int i = 0;i < parameters.size();i++){
                    s_entry * temp = parameters[i].op_1.second;
                    string type = temp -> type;
                    if(type.back() == '*'){
                        if(is_parameter(parameters[i].op_1.first)){
                            push_line("li $t0, " + to_string(temp -> offset));
                            push_line("add $t0, $sp, $t0");
                            push_line("lw $t1, 0($t0)");
                            push_line("sw $t1, " + to_string(temp_off) + "($s0)");
                        
                        }
                        else{
                            load_normal_element1(parameters[i].op_1);
                            push_line("sw $t1, " + to_string(temp_off) + "($s0)");
                        }
                        temp_off += get_size(type);
                    }
                    else{
                        comp op1 = parameters[i].op_1;
                        if(is_array_element(op1.first)){
                            load_array_element0(op1);
                        }
                        else{
                            load_normal_element0(op1);
                        }
                        string type = (op1.second) -> type;
                        if(is_struct(type)){
                            symTable *temp = id_to_struct[type];
                            push_line("add $t0, $s0, " + to_string(temp_off));
                            push_line("add $t1, $sp, " + to_string((op1.second) -> offset));
                            for(auto i : (*temp)){
                                s_entry * t = i.second;
                                push_line("lw $t2, " + to_string(t -> offset) + "($t1)");
                                push_line("sw $t2, " + to_string(t -> offset) + "($t0)");
                            }
                        }
                        else{
                            push_line("lw $t1, 0($t0)");
                            push_line("sw $t1, " + to_string(temp_off) + "($s0)");
                        }
                        temp_off += get_size(type);
                    }
                }
                push_line("move $sp, $s0");
                // jump to function called.
                push_line("jal " + call_func);
                comp res = emitted_code[i].result;
                if(is_array_element(res.first)){
                    load_array_element2(res);
                }
                else{
                    load_normal_element2(res);
                }
                parameters.clear();
                string type = (res.second) -> type;
                if(is_struct(type)){
                    symTable *temp = id_to_struct[type];
                    for(auto i : (*temp)){
                        s_entry * t = i.second;
                        push_line("add $t3, $t2, " + to_string(t -> offset));
                        push_line("add $t4, $v0, " + to_string(t -> offset));
                        push_line("lw $t5, 0($t4)");
                        push_line("sw $t5, 0($t3)");
                    }
                }
                else{
                    push_line("sw $v0, 0($t2)");
                }
            }
        }

        if(instruction == "FUNC_START"){
            curr_Func = emitted_code[i].op_1.first; // changed the func_name
            int size = funcSize[curr_Func];
            push_line("li $t1, " + to_string(80));
            push_line("add $t1, $t1, " + to_string(size));
            push_line("add $sp, $sp, $t1");
            save_all_registers();
            push_line("sub $sp, $sp, $t1");
            if(curr_Func == "main"){
                curr_Func = ".data";
                for(auto i : *GST){
                    if(funcMap.count(i.first)){
                        continue;
                    }
                    if(!global_variables_completed.count(i.first)){
                        if(array_symTable_entry.count(i.second)){
                            vector <int> dim = array_symTable_entry[i.second];
                            int pro = 1;
                            for(auto i : dim){
                                pro *= i;
                            }
                            push_line(i.first + " : .space " + to_string(pro));
                        }
                        else{
                            if(((i.second) -> type).find("float") != string::npos || ((i.second) -> type).find("double") != string::npos){
                                push_line(i.first + " : .float 0.0");
                            }
                            else if(((i.second) -> type).find("int") != string::npos || ((i.second) -> type).find("long") != string::npos){
                                push_line(i.first + " : .word 0");
                            }
                            else push_line(i.first + " : .space " + to_string(i.second -> size));
                        }
                    }
                }
                curr_Func = "main";
            }
        }
        if(instruction == "param"){
            parameters.push_back(emitted_code[i]);
        }


        if(instruction == "arr_element"){
            // load temporary
            push_line("lw $t0, " + to_string(emitted_code[i].op_1.second -> size) + "($sp)");// t0 has value of temp
            push_line("lw $t1, " + to_string(emitted_code[i].op_2.second -> offset) + "($sp)"); // t1 has value of expression
            push_line("li $t2, " + emitted_code[i].result.first); //  has the offset to be added
            push_line("mul $t3, $t1 , $t2"); // multiply 
            push_line("add $t0, $t3, $t0");
            push_line("sw $t0, " + to_string(emitted_code[i].op_1.second -> size) + "($sp)");
        }

        // handle the return case for functions

        if(instruction == "RETURN"){
            if(curr_Func == "main"){
                push_line("li $a0, 0");
                push_line("li $v0, 10");
                push_line("syscall");
            }
            else{
                comp op1 = emitted_code[i].op_1;
                if(op1.second == NULL){
                    push_line("li $v0, 0");
                }
                else{
                    string type = (op1.second) -> type;
                    if(type.back() == '*'){
                        if(is_parameter(op1.first)){
                            load_normal_element2(op1);
                            push_line("lw $v0, 0($t0)");
                        }
                        else{
                            load_normal_element2(op1);
                            push_line("move $v0, $t0");
                        }
                    }
                    else if(is_struct(type)){
                        if(is_array_element(op1.first)){
                            load_array_element2(op1);
                            push_line("move $v0, $t2");
                        }
                        else{
                            load_normal_element2(op1);
                            push_line("move $v0, $t2");
                        }
                    }
                    else{
                        if(is_array_element(op1.first)){
                            load_array_element2(op1);
                            push_line("lw $v0, 0($t2)");
                        }
                        else{
                            load_normal_element2(op1);
                            push_line("lw $v0, 0($t2)");
                        }
                    }
                }
                int size = funcSize[curr_Func];
                push_line("add $sp, $sp, " + to_string(size));
                push_line("b func_end");
                load_prev_registers();
            }
        }

        if(instruction == "FUNC_END" && curr_Func!="main"){
            int size = funcSize[curr_Func];
            push_line("add $sp, $sp, " + to_string(size));
            push_line("b func_end");
            load_prev_registers();
        }

        if(instruction == "="){
            comp op1 = emitted_code[i].op_1;
            comp res = emitted_code[i].result; 
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            string type = (op1.second) -> type;
            if(is_struct(type)){
                symTable *temp = id_to_struct[type];
                for(auto i : (*temp)){
                    s_entry * t = i.second;
                    push_line("add $t3, $t2, " + to_string(t -> offset));
                    push_line("add $t4, $t0, " + to_string(t -> offset));
                    push_line("lw $t5, 0($t4)");
                    push_line("sw $t5, 0($t3)");
                }
            }
            else{
                push_line("lw $t3, 0($t0)");
                push_line("sw $t3, 0($t2)");
            }
        }
        if(instruction == "float_="){
            comp op1 = emitted_code[i].op_1;
            comp res = emitted_code[i].result; 
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            //string type = (op1.second) -> type;

            
                push_line("lwc1 $f0, 0($t0)");
                push_line("swc1 $f0, 0($t2)");
            
        }
        if(instruction == "+int"){            
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
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

        if(instruction == "store_int"){
            comp op1 = emitted_code[i].op_1;
            comp res = emitted_code[i].result;
            push_line("li $t0, " + op1.first);
            push_line("add $t1, $sp, " + to_string(res.second -> offset));
            push_line("sw $t0, 0($t1)");
        }

        if(instruction == "store_float"){
            comp op1 = emitted_code[i].op_1;
            comp res = emitted_code[i].result;
            push_line("li.s $f0, " + op1.first);
            push_line("add $t1, $sp, " + to_string(res.second -> offset));
            push_line("swc1 $f0, 0($t1)");
            // instructinos to store float in temp
        }

        if(instruction == "+float"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lwc1 $f0, 0($t0)");
            push_line("lwc1 $f1, 0($t1)");
            push_line("add.s $f2, $f0, $f1");
            push_line("swc1 $f2, 0($t2)");
        }

        if(instruction == "*float"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lwc1 $f0, 0($t0)");
            push_line("lwc1 $f1, 0($t1)");
            push_line("mul.s $f2, $f0, $f1");
            push_line("swc1 $f2, 0($t2)");
        }
        if(instruction == "/float"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lwc1 $f0, 0($t0)");
            push_line("lwc1 $f1, 0($t1)");
            push_line("div.s $f2, $f0, $f1");
            push_line("swc1 $f2, 0($t2)");
        }



        if(instruction == "string_literal"){
            // instructions to store string_literal in temp.
        }

        if(instruction == "struct_array"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            push_line("li $t0, " + op2.first);
            push_line("lw $t1, " + to_string(op1.second -> size) + "($sp)");
            push_line("add $t1, $t1, $t0");
            push_line("sw $t1, " + to_string(op1.second -> size) + "($sp)");
        }

        if(instruction == "*int"){  
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("mul $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "/int"){            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("div $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "-int"){            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("neg $t6, $t4");
            push_line("add $t5, $t3, $t6");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == ">"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("sgt $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "<"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("slt $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "inttoreal"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("mtc1 $t3, $f0 ");
            push_line("cvt.s.w $f1, $f0");
            push_line("swc1 $f1, 0($t2)");
            //push_line("lwc1.s $f1, 0($t2)");

        }
        if(instruction == "realtoint"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lwc1 $f0, 0($t0)");
            push_line("cvt.w.s $f1, $f0");
            push_line("mfc1 $t3, $f1 ");
            
            push_line("sw $t3, 0($t2)");
            //push_line("lwc1.s $f1, 0($t2)");

        }
        if(instruction == "float_<"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lwc1 $f0, 0($t0)");
            push_line("lwc1 $f1, 0($t1)");
            push_line("c.lt.s $f0, $f1");
            push_line("cfc1 $t5,$25");
            push_line("andi $t5, 1");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "float_>"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lwc1 $f0, 0($t0)");
            push_line("lwc1 $f1, 0($t1)");
            push_line("c.lt.s $f1, $f0");
            push_line("cfc1 $t5,$25");
            push_line("andi $t5, 1");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "float_<="){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lwc1 $f0, 0($t0)"); 
            push_line("lwc1 $f1, 0($t1)");
            push_line("c.le.s $f0, $f1");
            push_line("cfc1 $t5,$25");
            push_line("andi $t5, 1");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "float_>="){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lwc1 $f0, 0($t0)");
            push_line("lwc1 $f1, 0($t1)");
            push_line("c.le.s $f1, $f0");
            push_line("cfc1 $t5,$25");
            push_line("andi $t5, 1");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "float_=="){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lwc1 $f0, 0($t0)");
            push_line("lwc1 $f1, 0($t1)");
            push_line("c.eq.s $f0, $f1");
            push_line("cfc1 $t5,$25");
            push_line("andi $t5, 1");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "float_!="){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lwc1 $f0, 0($t0)");
            push_line("lwc1 $f1, 0($t1)");
            push_line("c.ne.s $f0, $f1");
            push_line("cfc1 $t5,$25");
            push_line("andi $t5, 1");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "float_unary+"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lwc1 $f0, 0($t0)");
            push_line("swc1 $f0, 0($t2)");
        }
        if(instruction == "float_unary-"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lwc1 $f0, 0($t0)");
            push_line("neg.s $f1, $f0");
            push_line("swc1 $f1, 0($t2)");
        }
        
        if(instruction == "%"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("rem $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "<="){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("sle $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == ">="){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("sge $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "=="){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("seq $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)"); 
        }
        if(instruction == "!="){
             comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("neq $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "~"){
             comp op1 = emitted_code[i].op_1;
            //comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            //if(is_array_element(op2.first)){
            //    load_array_element1(op2);
            //}
            //else{
            //    load_normal_element1(op2);
            //}
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("not $t4, $t3");
            push_line("sw $t4, 0($t2)");
        }
        if(instruction == "|"){
             comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("or $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "&"){
             comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("and $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "^"){
              comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("xor $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }

        if(instruction == "unary*"){
            //todo for left hand side
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t3)");
            push_line("sw $t4, 0($t2)");
        }
        if(instruction == "unary-"){
             comp op1 = emitted_code[i].op_1;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }

            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            //push_line("lw $t4, 0($t1)");
            //push_line("neq $t5, $t3, $t4");
            
            //load("$t0",(emitted_code[i].op_1.second)->offset);
            push_line("neg $t4, $t3");
            push_line("sw $t4, 0($t2)");
            //store("$t1", (emitted_code[i].op_2.second)->offset);
        }
        if(instruction == "unary&"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("sw $t0, 0($t2)");
        }
        if(instruction == "unary+"){
            comp op1 = emitted_code[i].op_1;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }

            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("sw $t3, 0($t2)");
        }

        if(instruction == "goto"){
            int num = stoi(emitted_code[i].result.first);
            int addr = findNext(num);
            push_line("j Label"+to_string(addr));
        }
        if(instruction == "if_goto"){
            int num = stoi(emitted_code[i].result.first);
            int addr = findNext(num);
            comp op1 = emitted_code[i].op_1;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            push_line("lw $t1 0($t0)");
            //load("$t0",(emitted_code[i].op_1.second)->offset);
            push_line("bnez $t1, Label" + to_string(addr));  
        }
        if(instruction == ">>"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("srl $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
        if(instruction == "<<"){
            comp op1 = emitted_code[i].op_1;
            comp op2 = emitted_code[i].op_2;
            comp res = emitted_code[i].result;
            if(is_array_element(op1.first)){  
                load_array_element0(op1);
            }
            else{
                load_normal_element0(op1);
            }
            if(is_array_element(op2.first)){
                load_array_element1(op2);
            }
            else{
                load_normal_element1(op2);
            }
            if(is_array_element(res.first)){
                load_array_element2(res);
            }
            else{
                load_normal_element2(res);
            }
            push_line("lw $t3, 0($t0)");
            push_line("lw $t4, 0($t1)");
            push_line("sll $t5, $t3, $t4");
            push_line("sw $t5, 0($t2)");
        }
    }

}