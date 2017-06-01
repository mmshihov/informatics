//фильтр хороших операндов для ускорения второго порядка
//чтобы получалось восем триад...

#include "stdafx.h"
#include <iostream>

static const int FOUR_SIZE = 4;

bool IsCoverTestOk(int i, int j) {
	int vector		= 0;
	const int MASK	= 0x7 << (FOUR_SIZE * 2 - 1); //11 10 00 00 00 (0x380)

	if ((i & MASK) >> (FOUR_SIZE * 2 - 1) != 1)
		return false;

	if ((j & MASK) >> (FOUR_SIZE * 2 - 1) != 1)
		return false;

	for (int k = 0; k < (FOUR_SIZE + 1); ++k) {
		vector |= (1 << ((i & MASK) >> 7));
		vector |= (1 << ((j & MASK) >> 7));

		i <<= 2;
		j <<= 2;
	}

	return vector == 0xFF;
}

int _tmain(int argc, _TCHAR* argv[])
{
	for (int i = 0; i < (1 << FOUR_SIZE * 2); ++i) {
		for (int j = 0; j <= i; ++j) {
			if (IsCoverTestOk(i, j)) {
				std::cout << i << " " << j << "\n";
			}
		}
	}

	std::cin.get();

	return 0;
}

