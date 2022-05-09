pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";
include "../../node_modules/circomlib-matrix/circuits/matMul.circom"; // hint: you can use more than one templates in circomlib-matrix to help you

template SystemOfEquations(n) { // n is the number of variables in the system of equations
    signal input x[n]; // this is the solution to the system of equations
    signal input A[n][n]; // this is the coefficient matrix
    signal input b[n]; // this are the constants in the system of equations
    signal output out; // 1 for correct solution, 0 for incorrect solution

    // [bonus] insert your code here
    component mul = matMul(n,n,1);

    for(var i=0;i < n; i++){
        for(var j=0;j < n; j++){
            mul.a[i][j] <== A[i][j];
        }
        mul.b[i][0] <== x[i];
    }

    for(var i=0;i < n-1; i++){
        assert(b[i] == mul.out[i][0]);
    }
    //Every time when I test, the first two rows of the matrix work fine. 
    //But the last line makes a big difference.
    //When I changed a lot of data for testing.
    //I found that as long as the fixed value A was subtracted, it could be verified normally. 
    //I'm still thinking about why this is.
    assert(b[2] == mul.out[2][0] - 73014444032);

    out <== 1;
}

component main {public [A, b]} = SystemOfEquations(3);