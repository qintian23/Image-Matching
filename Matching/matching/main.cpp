#include "match.h"

using namespace std;
using namespace cv;

const char* img1[] = {
	// chinese 12
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
	 // bird 24
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
	"../figure/bird/bird_booby_1.jpg",//
	// fish 36
	"../figure/fisher/acanthopagrus_latus_1.png", 
	"../figure/fisher/acanthopagrus_latus_4.png",
	"../figure/fisher/alectis_ciliaris_2.png",
	"../figure/fisher/alectis_ciliaris_3.png",
	"../figure/fisher/amanses_scopas_11.png",
	"../figure/fisher/amanses_scopas_12.png",
	"../figure/fisher/anampses_lennardi_5.png",
	"../figure/fisher/anampses_lennardi_6.png",
	"../figure/fisher/aphareus_furca_12.png",
	"../figure/fisher/aphareus_furca_14.png",
	"../figure/fisher/CUNWCB-Y_4.png",
	"../figure/fisher/CUNWCB-Y_6.png",
	// flower 48
	"../figure/flower/flower_b.jpg",
	"../figure/flower/flower_bh.jpg",
	"../figure/flower/flower_bh_1.jpg",
	"../figure/flower/flower_b_1.jpg",
	"../figure/flower/flower_h.jpg",
	"../figure/flower/flower_h_1.jpg",
	"../figure/flower/flower_j.jpg",
	"../figure/flower/flower_jh.jpg",
	"../figure/flower/flower_jh_1.jpg",
	"../figure/flower/flower_j_1.jpg",
	"../figure/flower/flower_q.jpg",
	"../figure/flower/flower_q_1.jpg"
};

const char* img2[] = { 
	"../figure/chinese/all.png",
	"../figure/bird/all.png", 
	"../figure/fisher/all.png", 
	"../figure/flower/all.png"
};

int main(int argc, char** argv)
{
	//cout << img1[0] << endl;
	//orb_match(img1[0], img2[1], img1[0] + 18 );
	//cout << img1[12] + 15 << endl;
	//cout << img1[24] + 17 << endl;
	//cout << img1[36] + 17 << endl;
	//for (int i = 0; i < 12; i++) // Chinese
	//{
	//	// cout << img1[i]+18 << endl;
	//	//orb_match(img1[i], img2[0], img1[i] + 18);
	//	//sift_match(img1[i], img2[0], img1[i] + 18);
	//	//suft_match(img1[i], img2[0], img1[i] + 18);
	//	//vfc_match(img1[i], img2[0], img1[i] + 18);
	//}
	//for (int i = 12; i < 24; i++) // bird
	//{
	//	 //cout << img1[i]+15 << endl;
	//	//orb_match(img1[i], img2[1], img1[i] + 15);
	//	//sift_match(img1[i], img2[1], img1[i] + 15);
	//	//suft_match(img1[i], img2[1], img1[i] + 15);
	//	//vfc_match(img1[i], img2[1], img1[i] + 15);
	//}
	for (int i = 24; i < 36; i++) // fish
	{
		//cout << img1[i]+15 << endl;
	   orb_match(img1[i], img2[2], img1[i] + 17);
	   //sift_match(img1[i], img2[2], img1[i] + 17);
	   //suft_match(img1[i], img2[2], img1[i] + 17);
		//vfc_match(img1[i], img2[2], img1[i] + 17);
	}
	//for (int i = 36; i < 48; i++) // flower
	//{
	//	//cout << img1[i]+15 << endl;
	//   //orb_match(img1[i], img2[3], img1[i] + 17);
	//   //sift_match(img1[i], img2[3], img1[i] + 17);
	//   //suft_match(img1[i], img2[3], img1[i] + 17);
	//	//vfc_match(img1[i], img2[3], img1[i] + 17);
	//}
	return 0;
}