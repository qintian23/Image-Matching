#include "match.h"

using namespace std;
using namespace cv;

const char* img1[] = {
	// chinese
	"../figure/chinese/cheng.png",  //
	"../figure/chinese/cheng1.png", //
	"../figure/chinese/dong.png", //
	 "../figure/chinese/dong1.png",  //
	 "../figure/chinese/lin.png", //
	 "../figure/chinese/lin1.png", // 
	 "../figure/chinese/wan.png",//
	 "../figure/chinese/wan1.png",//
	 "../figure/chinese/xi.png",//
	 "../figure/chinese/xi1.png",//
	 "../figure/chinese/zhang.png",//
	 "../figure/chinese/zhang1.png",//
	 // bird
	"../figure/bird/bird_acc.jpg",  //
	"../figure/bird/bird_acc_1.jpg", //
	"../figure/bird/bird_anianiau.jpg", //
	"../figure/bird/bird_anianiau_1.jpg",  //
	"../figure/bird/bird_aoc.jpg", //
	"../figure/bird/bird_aoc_1.jpg", //
	"../figure/bird/bird_ap.jpg",//
	"../figure/bird/bird_ap_1.jpg",//
	"../figure/bird/bird_apapane.jpg",//
	"../figure/bird/bird_apapane_1.jpg",//
	"../figure/bird/bird_booby.jpg",//
	"../figure/bird/bird_booby_1.jpg"//
};

const char* img2[] = { "../figure/bird/all.png", "../figure/chinese/all.png" };

int main(int argc, char** argv)
{
	//cout << img1[0] << endl;
	//orb_match(img1[0], img2[1], img1[0] + 18 );
	for (int i = 0; i < 12; i++)
	{
		// cout << img1[i]+18 << endl;
		orb_match(img1[i], img2[1], img1[i] + 18);
	}
	return 0;
}