/* 
 * File:   main.cpp
 * Author: Daniel-PC
 *
 * Created on September 13, 2016, 9:58 PM
 */

#include <cstdlib>
#include <iostream>

using namespace std;

/*
 * 
 */
int main(int argc, char** argv) {

    //holds all the characters from 0-9 and A-Z
    string digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    string result = ""; //this is where the the conversion will output to
    
    int number; //user will enter in
    int base;   //will be used to get user picked base
    
    cout << "Please enter a number (it will be in base 10)" << endl;
    cin >> number;
    
    cout << "Please enter the base you would like to convert to" << endl;
    cin >> base;
    
    int div = number; //div will hold the number variable value
    int rem;          //remainder for what gets left after division
    
    do{
        int temp = div/base;    //temp variable to hold the value of div/base
        
        rem = div-temp*base;
        
        div = temp;             //div becomes temp to continue loop
        
        result = digits[rem]+result;    
        
    }while(div>base);
    
    result = digits[div]+result;
    
    cout << number << " base 10 is " << result << " base " << base << endl;
    return 0;
}

