#include<iostream>
using namespace std;

void maxHeapify(int * arr,int n){

	for(int i=1;i<n;i++){
		int parent=(i-1)/2;
		int child=i;
		while(parent>=0 && arr[parent]<arr[child]){
			int temp=arr[parent];
			arr[parent]=arr[child];
			arr[child]=temp;
			child=parent;
			parent=(chil-1)/2;
		}
	}
	print(arr,n);
}
void print(int * arr,int n){
	for(int i=0;i<n;i++)
		cout<<arr[i]<<" ";
	cout<<endl;
}
int main(){
int  arr[]={4, 10, 3, 5, 1};
maxHeapify(arr,5);
print(arr,5);
}