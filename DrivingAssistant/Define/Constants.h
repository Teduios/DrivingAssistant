//
//  Constants.h
//  DrivingAssistant
//
//  Created by ji on 16/4/19.
//  Copyright © 2016年 ji. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define kJKAPPKEY            @"e6645f84db06bf9c220cb11a7d135766"
#define kJKBASE_URL          @"http://api2.juheapi.com/jztk/query"
#define equalTo(...)                     mas_equalTo(__VA_ARGS__)


#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


//“天气”宏定义
#define HOME_HEADER_VIEW_WIDTH  SCREEN_WIDTH/2
#define HOME_HEADER_VIEW_HEIGHT HOME_HEADER_VIEW_WIDTH

#define HOME_HEADER_VIEW_X HOME_HEADER_VIEW_WIDTH/2
#define HOME_HEADER_VIEW_Y 120

//collectionViewCell宏定义
#define COLLECTION_CELL_WIDTH SCREEN_WIDTH/5
#define COLLECTION_CELL_HEIGHT 150
#define COLLECTION_CELL_INSET  80

//life视图宏定义
#define LIFE_HEADER_VIEW_HEIGHT 200
#define LIFE_SECTION_VIEW_HEIGHT 40

//申请key
#define REQUEST_KEY @"5cd72cbbc1f84d9cbda0c1c0968b0812"

//刷新button

#define REFRESH_BOTTON_Y  40
#define REFRESH_BOTTON_WIDTH  60
#define REFRESH_BOTTON_HEIGHT 40

#endif /* Constants_h */
