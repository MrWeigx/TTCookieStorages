# TTCookieStorages
ios Cookies.binarycookies decode

	/**
	* 解析当前沙盒下Cookies.binarycookies文件
	*
	* @return 返回解析后的cookie数据.
	*/
	-(NSArray<TTCookieItem*>*) tt_decode;



	/**
	* 解析Cookies.binarycookies文件
	*
	* @param path 绝对路径
	*
	* @param complete 完成时回调， error==nil时成功。
	*
	* @return 返回解析后的cookie数据.
	*/
	-(NSArray<TTCookieItem*>*) tt_decodeWithPath:(NSString*)path complete:(void (^)(NSError* error))complete;


	/**
	* 解析Cookies.binarycookies文件
	*
	* @param data Cookies.binarycookies源数据
	*
	* @param complete 完成时回调， error==nil时成功。
	*
	* @return 返回解析后的cookie数据.
	*/
	-(NSArray<TTCookieItem*>*) tt_decodeWithData:(NSData*)data complete:(void (^)(NSError* error))complete;