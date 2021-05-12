#include "generation_aid.h"

map <string, vector <string>> assembly_code;
map<int, string> basicBlock;

void push_line(string s){
    assembly_code[curr_Func].push_back(s);
}

void print_assembly_code(){
    for(auto a : assembly_code){
        if(a.first == "__global") continue;
        cout << a.first;
        if(a.first != ".data"){
            cout << " : " << endl; 
        }
        else{
            cout << endl;
        }
        cout << endl;
        for(auto i : a.second){
            cout << "       " << i << endl;
        }
        cout << endl;
        cout << endl;
        if(a.first == ".data"){
            cout << ".text" << endl;
            cout << endl;
        }
    }
}

bool is_array_element(string q){
    if(q.back() == ']'){
        return true;
    }
    else{
        return false;
    }
}

bool is_parameter(string name){
    string params = funcParams[curr_Func];
    int i = 0;
    string temp = "";
    while(i < params.size()){
        if(params[i] == ','){
            if(name == temp){
                return true;
            }
            temp = "";
        }
        else{
            temp += params[i];
        }
        i++;
    }
    return (temp == name);
}

string get_array_name(string s){
    int i = 0;
    string temp = "";
    while(i < s.size()){
        if(s[i] == '['){
            break;
        }
        else{
            temp += s[i];
        }
        i++;
    }
    return temp;
}

void load_array_element0(comp q){ // to load array_element in $t0
    string name = get_array_name(q.first);
    if(is_parameter(name)){
        push_line("add $t0, $sp, " + to_string(q.second -> offset));
        push_line("lw $t1, ($t0)");
        push_line("lw $t0, " + to_string(q.second -> size) + "($sp)");
        push_line("add $t1, $t1, $t0");
        push_line("move $t0, $t1");
    }
    else{
        if(temp_global_set.count(q.second)){
            push_line("lw $t1, " + to_string(q.second -> size) + "($sp)");
            push_line("add $t1, $gp, " + name);
            push_line("move $t0, $t1");
        }
        else{
            push_line("add $t0, $sp, " + to_string(q.second -> offset));
            push_line("lw $t1, " + to_string(q.second -> size) + "($sp)");
            push_line("add $t1, $t1, $t0");
            push_line("move $t0, $t1");
        }
    }
}

void load_array_element1(comp q){ // to load array_element in $t1
    string name = get_array_name(q.first);
    if(is_parameter(name)){
        push_line("add $t1, $sp, " + to_string(q.second -> offset));
        push_line("lw $t2, ($t1)");
        push_line("lw $t1, " + to_string(q.second -> size) + "($sp)");
        push_line("add $t2, $t2, $t1");
        push_line("move $t1, $t2");
    }
    else{
        if(temp_global_set.count(q.second)){
            push_line("lw $t2, " + to_string(q.second -> size) + "($sp)");
            push_line("add $t2, $gp, " + name);
            push_line("move $t1, $t2");
        }
        else{
            push_line("add $t1, $sp, " + to_string(q.second -> offset)); // t1 -> base_address of a
            push_line("lw $t2, " + to_string(q.second -> size) + "($sp)");
            push_line("add $t2, $t2, $t1");
            push_line("move $t1, $t2");
        }
    }
}

void load_array_element2(comp q){ // to load array_element in $t2
    string name = get_array_name(q.first);
    if(is_parameter(name)){
        push_line("add $t2, $sp, " + to_string(q.second -> offset));
        push_line("lw $t3, ($t2)");
        push_line("lw $t2, " + to_string(q.second -> size) + "($sp)");
        push_line("add $t3, $t3, $t2");
        push_line("move $t2, $t3");
    }
    else{
        if(temp_global_set.count(q.second)){
            push_line("lw $t3, " + to_string(q.second -> size) + "($sp)");
            push_line("add $t3,$gp, " + name);
            push_line("move $t2, $t3");
        }
        else{
            push_line("add $t2, $sp, " + to_string(q.second -> offset));
            push_line("lw $t3, " + to_string(q.second -> size) + "($sp)");
            push_line("add $t3, $t3, $t2");
            push_line("move $t2, $t3");
        }
    }
}

bool is_special_struct_case(string name){
    for(int i = 0;i < (name.size()-1);i++){
        if(name[i] == '.'){
            if(name[i - 1] == ']'){
                return true;
            }
            else{
                return false;
            }
        }
        else if(name[i] == '-' && name[i + 1] == '>'){
            return true;
        }
    }
    return false;
}

void load_normal_element0(comp q){
    if(is_special_struct_case(q.first)){
        string name = q.first;
        while(name.back() != '.'){
            name.pop_back();
        }
        q.first = name;
        load_array_element0(q);
    }
    else{
        if(global_entry_set.count(q.second)){
            push_line("la $t0, " + q.first);
        }
        else push_line("add $t0, $sp, " + to_string(q.second -> offset));
    }
} 

void load_normal_element1(comp q){
    if(is_special_struct_case(q.first)){
        string name = q.first;
        while(name.back() != '.'){
            name.pop_back();
        }
        q.first = name;
        load_array_element1(q);
    }
    else{
        if(global_entry_set.count(q.second)){
            push_line("la $t1, " + q.first);
        }
        else push_line("add $t1, $sp, " + to_string(q.second -> offset));
    }
} 

void load_normal_element2(comp q){
    if(is_special_struct_case(q.first)){
        string name = q.first;
        while(name.back() != '.'){
            name.pop_back();
        }
        q.first = name;
        load_array_element2(q);
    }
    else{
        if(global_entry_set.count(q.second)){
            push_line("la $t2, " + q.first);
        }
        else push_line("add $t2, $sp, " + to_string(q.second -> offset));
    }
} 

void save_all_registers(){
    push_line("sub $sp, $sp, 80");
    push_line("sw $ra, 0($sp)");
    push_line("sw $fp, 4($sp)");
    push_line("la $fp, 80($sp)");
    push_line("sw $t0, 12($sp)");
    push_line("sw $t1, 16($sp)");
    push_line("sw $t2, 20($sp)");
    push_line("sw $t3, 24($sp)");
    push_line("sw $t4, 28($sp)");
    push_line("sw $t5, 32($sp)");
    push_line("sw $t6, 36($sp)");
    push_line("sw $t7, 40($sp)");
    push_line("sw $t8, 44($sp)");
    push_line("sw $t9, 48($sp)");
    push_line("sw $s0, 52($sp)");
    push_line("sw $s1, 56($sp)");
    push_line("sw $s2, 60($sp)");
    push_line("sw $s3, 64($sp)");
    push_line("sw $s4, 68($sp)");
    push_line("sw $s5, 72($sp)");
    push_line("sw $s6, 76($sp)");
    push_line("add $sp, $sp, 80");
}

void load_prev_registers(){
    if(assembly_code.count("func_end")){
        return;
    }
    string temp_func = curr_Func;
    curr_Func = "func_end";
    push_line("lw $ra, 0($sp)");
    push_line("lw $fp, 4($sp)");
    push_line("lw $a0, 8($sp)");
    push_line("lw $t0, 12($sp)");
    push_line("lw $t1, 16($sp)");
    push_line("lw $t2, 20($sp)");
    push_line("lw $t3, 24($sp)");
    push_line("lw $t4, 28($sp)");
    push_line("lw $t5, 32($sp)");
    push_line("lw $t6, 36($sp)");
    push_line("lw $t7, 40($sp)");
    push_line("lw $t8, 44($sp)");
    push_line("lw $t9, 48($sp)");
    push_line("lw $s0, 52($sp)");
    push_line("lw $s1, 56($sp)");
    push_line("lw $s2, 60($sp)");
    push_line("lw $s3, 64($sp)");
    push_line("lw $s4, 68($sp)");
    push_line("lw $s5, 72($sp)");
    push_line("lw $s6, 76($sp)");
    push_line("add $sp, $sp, 80");
    push_line("jr $ra");
    curr_Func = temp_func;
}

void formBasicBlocks(){
    for(auto x:emitted_code){
        if(x.op_code.first=="goto" || x.op_code.first=="if_goto"){
            int addr = stoi(x.result.first);
            addr = findNext(addr);
            basicBlock[addr] = string("Label")+to_string(addr);
        }
    }
}

int findNext(int addr){
    while(emitted_code[addr].op_code.first=="goto"){
        addr = stoi(emitted_code[addr].result.first);
    }
    return addr;
}