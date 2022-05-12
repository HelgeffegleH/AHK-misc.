#include "pch.h"
#include "rnd.h"

__DECL void gen(param min, param max, num_type nt, void* out, unsigned __int64* seed)
{
    static mt19937_64 mt64(random_device{}());
    if (seed)
    {
        mt64 = mt19937_64(*seed);
        return;
    }
    if (nt == num_type::INT_64)
    {
        uniform_int_distribution<__int64> dist(min.i, max.i);
        *(__int64*)out = dist(mt64);
        
    }
    else if (nt == num_type::DOUBLE)
    {
        uniform_real_distribution<double> dist(min.d, max.d);
        *(double*)out = dist(mt64);
    }
    return;
}