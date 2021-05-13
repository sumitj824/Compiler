// int a[3][2]={{-1,-2},{-3,-4},{6,7}};
// // int a=-5;



int main(){
    int a[3][2]={{-1,-2},{-3,-4},{-6,-7}};
    printf(a[0][0]);
    printf(a[0][1]);
    printf(a[1][0]);
    printf(a[1][1]);
    printf(a[2][0]);
    printf(a[2][1]);
    // printf(a);
   
    return 0;
}

/*
[0]  FUNC_START main  
[1]  store_int 3  _t1
[2]  store_int 2  _t3
[3]  store_int 1  _t5
[4]  unary- _t5  _t6
[5]  initializer_list _t6  
[6]  store_int 2  _t8
[7]  unary- _t8  _t9
[8]  initializer_list _t9  
[9]  initializer_list   
[10]  store_int 3  _t11
[11]  unary- _t11  _t12
[12]  initializer_list _t12  
[13]  store_int 4  _t14
[14]  unary- _t14  _t15
[15]  initializer_list _t15  
[16]  initializer_list   
[17]  store_int 6  _t17
[18]  unary- _t17  _t18
[19]  initializer_list _t18  
[20]  store_int 7  _t20
[21]  unary- _t20  _t21
[22]  initializer_list _t21  
[23]  initializer_list   
[24]  array_initialized a  
[25]  store_int 0  _t23
[26]  store_int 0  _t24
[27]  arr_element a[_t24] _t24 8
[28]  store_int 0  _t26
[29]  arr_element a[_t24][_t26] _t26 4
[30]  param a[_t24][_t26]  
[31]  CALL_FUNC printf  _t29
[32]  store_int 0  _t31
[33]  store_int 0  _t32
[34]  arr_element a[_t32] _t32 8
[35]  store_int 1  _t34
[36]  arr_element a[_t32][_t34] _t34 4
[37]  param a[_t32][_t34]  
[38]  CALL_FUNC printf  _t37
[39]  store_int 0  _t39
[40]  store_int 1  _t40
[41]  arr_element a[_t40] _t40 8
[42]  store_int 0  _t42
[43]  arr_element a[_t40][_t42] _t42 4
[44]  param a[_t40][_t42]  
[45]  CALL_FUNC printf  _t45
[46]  store_int 0  _t47
[47]  store_int 1  _t48
[48]  arr_element a[_t48] _t48 8
[49]  store_int 1  _t50
[50]  arr_element a[_t48][_t50] _t50 4
[51]  param a[_t48][_t50]  
[52]  CALL_FUNC printf  _t53
[53]  store_int 0  _t55
[54]  store_int 2  _t56
[55]  arr_element a[_t56] _t56 8
[56]  store_int 0  _t58
[57]  arr_element a[_t56][_t58] _t58 4
[58]  param a[_t56][_t58]  
[59]  CALL_FUNC printf  _t61
[60]  store_int 0  _t63
[61]  store_int 2  _t64
[62]  arr_element a[_t64] _t64 8
[63]  store_int 1  _t66
[64]  arr_element a[_t64][_t66] _t66 4
[65]  param a[_t64][_t66]  
[66]  CALL_FUNC printf  _t69
[67]  store_int 0  _t71
[68]  RETURN _t71  
[69]  FUNC_END main  
*/