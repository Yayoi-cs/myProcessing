#include<stdio.h>
int main(void){
    char cipherText[]="HlWleoodl r!";
    int len=sizeof(cipherText)/sizeof(char)-1;
    char result[len+1];
    result[len]='\0';
    int line=3;
    for(int i=0;i<line;i++){
        int width=len/line;
        for(int j=width*i;j<width*(i+1);j++){
            result[line*(j%width)+i]=cipherText[j];
        }
    }
    printf("%s\n",result);
}