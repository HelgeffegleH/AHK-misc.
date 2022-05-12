#pragma once
#include <random>
using namespace std;

union param
{
	__int64 i;
	double d;
};

enum num_type
{
	INT_64,
	DOUBLE
};

#define __DECL __declspec(dllexport)

extern "C" __DECL void gen(param min, param max, num_type nt, void* out, unsigned __int64* seed);

