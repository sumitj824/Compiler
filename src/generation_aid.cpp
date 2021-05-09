#include "generation_aid.h"

map <string, vector <string>> assembly_code;

void push_line(string s){
    assembly_code[curr_Func].push_back(s);
    cout << s << endl;
}

bool is_array_element(comp q){
    if((q.first).back() == ']'){
        return true;
    }
    else{
        return false;
    }
}

bool is_parameter(string name){
    for(auto i : parameters){
        if(i.op_1.first == name){
            return true;
        }
    }
    return false;
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

void load_array_element0(comp q){ // to load array_element in $t1
    string name = get_array_name(q.first);
    if(is_parameter(name)){
        push_line("add $t0, $sp, " + to_string(q.second -> offset));
        push_line("lw $t1, $t0");
        push_line("add $t1, $t1, " + to_string(q.second -> size));
        push_line("lw $t0, $t1");
    }
    else{
        push_line("add $t0, $sp, " + to_string(q.second -> offset));
        push_line("lw $t1, " + to_string(q.second -> size) + "($sp)");
        push_line("add $t1, $t1, $t0");
        push_line("lw $t0, $t1");
    }
}

void load_array_element1(comp q){ // to load array_element in $t1
    string name = get_array_name(q.first);
    if(is_parameter(name)){
        push_line("add $t1, $sp, " + to_string(q.second -> offset));
        push_line("lw $t2, $t1");
        push_line("add $t2, $t2, " + to_string(q.second -> size));
        push_line("lw $t1, $t2");
    }
    else{
        push_line("add $t1, $sp, " + to_string(q.second -> offset));
        push_line("lw $t2, " + to_string(q.second -> size) + "($sp)");
        push_line("add $t2, $t2, $t1");
        push_line("lw $t1, $t2");
    }
}

void load_array_element2(comp q){ // to load array_element in $t2
    string name = get_array_name(q.first);
    if(is_parameter(name)){
        push_line("add $t2, $sp, " + to_string(q.second -> offset));
        push_line("lw $t3, $t2");
        push_line("add $t2, $t2, " + to_string(q.second -> size));
        push_line("lw $t2, $t3");
    }
    else{
        push_line("add $t2, $sp, " + to_string(q.second -> offset));
        push_line("lw $t3, " + to_string(q.second -> size) + "($sp)");
        push_line("add $t3, $t3, $t2");
        push_line("lw $t2, $t3");
    }
}

void load_normal_element0(comp q){
    push_line("add $t0, $sp, " + to_string(q.second -> offset));
} 

void load_normal_element1(comp q){
    push_line("add $t1, $sp, " + to_string(q.second -> offset));
} 

void load_normal_element2(comp q){
    push_line("add $t2, $sp, " + to_string(q.second -> offset));
} 

void save_all_registers(){
    push_line("sub $sp, $sp, 80");
    push_line("sw $ra, 0($sp)");
    push_line("sw $fp, 4($sp)");
    push_line("la $fp, 72($sp)");
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