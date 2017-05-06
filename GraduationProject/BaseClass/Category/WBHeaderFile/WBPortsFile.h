//
//  WBPortsFile.h
//  BXYJWB
//
//  Created by MS on 17/1/10.
//  Copyright © 2017年 yxkjios. All rights reserved.
//

#ifndef WBPortsFile_h
#define WBPortsFile_h

#define NSLogError      NSLog(@"错误消息%@",error.localizedDescription)

#if 1
//接口文件
#define IDCard_KEY      @"33670dd65192452b34a49b1c336259b1"
//身份证查询接口
#define IDCard_Search   @"https://apis.juhe.cn/idcard/index?"
/*请求示例
 http://apis.juhe.cn/idcard/index?key=您申请的KEY&cardno=330326198903081211
 */

//手机号码查询接口
#define PhoneNum_Key    @"a9e81d76452620002411ddd862bf40a4"
#define PhoneNum_Search @"https://apis.juhe.cn/mobile/get?"
/*
 示例:http://apis.juhe.cn/mobile/get?phone=13429667914&key=您申请的KEY
 */

//油价查询
#define OIL_Key         @"780efce3986cf2ebcef357f457661b76"
#define Oil_Query       @"https://apis.juhe.cn/cnoil/oil_city?"

//电视节目表
#define TVShow_Key             @"f2bde37ef5eb38ea2ba9e568ca162a18"
#define TVCategory_Url         @"https://japi.juhe.cn/tv/getCategory?"
#define TVShowChannel_Url      @"https://japi.juhe.cn/tv/getChannel?"
#define TVShowList_Url         @"https://japi.juhe.cn/tv/getProgram?"
/*
 http://japi.juhe.cn/tv/getCategory?key=您申请的KEY
 http://japi.juhe.cn/tv/getChannel?pId=1&key=您申请的KEY
 http://japi.juhe.cn/tv/getProgram?code=cctv5&date=&key=您申请的KEY
 */

//手机话费充值
#define PhoneRecharge_key       @"afafc27339cc8b700ad5e84f0b068ad6"
#define PhoneNumTest_Url        @"https://op.juhe.cn/ofpay/mobile/telcheck"
#define SearchProduct_Url       @"https://op.juhe.cn/ofpay/mobile/telquery"
/*
 以下是手机快速充值接口参数的含义
 phoneno	string	是	手机号码
 cardnum	string	是	充值金额,目前可选：10、20、30、50、100、300
 orderid	string	是	商家订单号，8-32位字母数字组合，由您自己生成
 key	string	是	应用APPKEY(应用详细页查询)
 sign	string	是	校验值，md5(OpenID+key+phoneno+cardnum+orderid)，OpenID在个人中心查询
 */
#define PhoneChargeFee_Url      @"https://op.juhe.cn/ofpay/mobile/onlineorder"
#define PhoneCharge_OpenID      @"JH182059bb0bfee0d54ef142c71e65f772"
/*
 订单查询的接口参数含义
 orderid	string	是	商家订单号，8-32位字母数字组合，请填写已经成功提交的订单号
 key	string	是	应用APPKEY(应用详细页查询)
 */
#define PhoneChargeOrderQuery_Url   @"https ://op.juhe.cn/ofpay/mobile/ordersta"
/*
 http://op.juhe.cn/ofpay/mobile/telcheck?cardnum=100&phoneno=13429667914&key=您申请的KEY
 http://op.juhe.cn/ofpay/mobile/telquery?cardnum=30&phoneno=18913515635&key=您申请的KEY
 http://op.juhe.cn/ofpay/mobile/onlineorder?key=KEY&phoneno=18913513535&cardnum=100&orderid=2014111111113&sign=fb1ed32a9540c24b03cc0c06aabbb642
 */

//手机流量充值
#define PhoneFlowCharge_Key     @"d62f8f9ab82c65e2910cdd8aac87fc2b"
/*
 以下是手机充值流量接口参数的含义
 phone	string	是	需要充值流量的手机号码
 pid	string	是	流量套餐ID
 orderid	string	是	自定义订单号，8-32字母数字组合
 key	string	是	应用APPKEY(应用详细页查询)
 sign	string	是	校验值，md5(OpenID+key+phone+pid+orderid)，结果转为小写
 */
#define PhoneFlowCharge_Url     @"https://v.juhe.cn/flow/recharge"
//查询订单信息
/*
 以下是手机流量充值订单查询接口参数的含义
 page	int	否	当前页数，默认1
 pagesize	int	否	每页显示条数，默认50，最大100
 starttime	time	是	格式：2016-03-01 00:00:00，开始和结束时间不能跨月
 endtime	time	是	格式：2016-03-10 23:59:59
 key	string	是	应用APPKEY(应用详细页查询)
 */
#define PhoneFlowOrderQuery_Url @"https://v.juhe.cn/flow/ordersbydate"
/*
 http://v.juhe.cn/flow/recharge?key=您申请的KEY&phone=18913513535&pid=8&orderid=a1122111d&sign=721a3f667b0eb63f54517971181e7392
 http://v.juhe.cn/flow/ordersbydate?key=&page=1&pagesize=10&starttime=2016-03-01%2000:00:00&endtime=2016-03-16%2000:00:00
 */

//新闻头条
#define News_key            @"1556e6a8727672ced0deb4007782429c"
#define News_Url            @"https://v.juhe.cn/toutiao/index"
/*
 http://v.juhe.cn/toutiao/index?type=top&key=APPKEY
 */

//快递查询
/*
 type	string	是	快递公司 自动识别请写auto
 number	string	是	快递单号
 */
#define ExpressSearch_Key   @"a53d764bf324136a"
#define ExpressSearch_Url   @"https://api.jisuapi.com/express/query"
/*
 http://api.jisuapi.com/express/query?appkey=yourappkey&type=sfexpress&number=931658943036
 */
//天气查询
#define Weather_Key         @"225f96215adac2b66691866fbec9569b"
#define Weather_Url         @"https://v.juhe.cn/weather/geo"
/*
 http://v.juhe.cn/weather/geo?format=2&key=您申请的KEY&lon=116.39277&lat=39.933748
 */

//空气查询
#define AirQuery_Key        @"e38fef43a425659d78f736b47c2b8e7c"
#define AirQuery_Url        @"http://web.juhe.cn:8080/environment/air/cityair"
/*
 http://web.juhe.cn:8080/environment/air/cityair?city=城市名称&key=您申请的APPKEY值
 */

//团购--->美食推荐
#define GroupBuying_Key     @"d2bc772959f9cd4ed2f2e740ff99c66e"
#define GroupBuyingLocationSearch_Url  @"https://apis.juhe.cn/catering/query"
#define GroupBuyingCitySearch_Url      @"https://apis.juhe.cn/catering/querybycity"
/*
 http://apis.juhe.cn/catering/query?key=key&lng=121.538123&lat=31.677132&radius=2000
 http://apis.juhe.cn/catering/querybycity?key=&city=%E5%8C%97%E4%BA%AC&page=1
 */

//酒店查询---->接口来自好平台Api(http://www.haoservice.com/docs/50/HotelList###)-->每天50次请求，维持一个月，过期需充值5¥／月
#define Hotel_Key           @"e9f4c648d672440eb918885e3a0cc86f"
#define Hotel_GetCity_List_Url @"http://apis.haoservice.com/lifeservice/travel/cityList"
#define Hotel_Url           @"http://apis.haoservice.com/lifeservice/travel/HotelList"
#define HotelDetail_Url     @"http://apis.haoservice.com/lifeservice/travel/GetHotel"
#define SceniaArea_Url      @"http://apis.haoservice.com/lifeservice/travel/scenery"
#define ScenicAreaDetail_Url @"http://apis.haoservice.com/lifeservice/travel/GetScenery"
/*
    http://apis.haoservice.com/lifeservice/travel/cityList?key=您申请的APPKEY
    http://apis.haoservice.com/lifeservice/travel/HotelList?cityid=37&page=1&key=您申请的APPKEY
    http://apis.haoservice.com/lifeservice/travel/GetHotel?hid=17192&key=您申请的APPKEY
    http://apis.haoservice.com/lifeservice/travel/scenery?pid=2&cid=45&page=1&key=您申请的APPKEY
    http://apis.haoservice.com/lifeservice/travel/GetScenery?sid=31365&key=您申请的APPKEY
 */
//电影查询
#define Movie_Key           @"e0d288c57fbaa1f3385cf9fea0b2cb4b"
#define Movie_Search_City_Url    @"https://v.juhe.cn/movie/citys"
#define Movie_Search_Url    @"https://v.juhe.cn/movie/cinemas.search"
#define Movie_Detail_Url    @"https://v.juhe.cn/movie/cinemas.movies"
/*
 http://v.juhe.cn/movie/citys?key=您申请的key
 http://v.juhe.cn/movie/cinemas.search.php?key=您申请的key&dtype=json&cityid=2
 http://v.juhe.cn/movie/cinemas.movies?key=您申请的key&cinemaid=1188
 */
#endif

#endif /* WBPortsFile_h */
