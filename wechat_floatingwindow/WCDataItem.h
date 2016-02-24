/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */


@class WCContentItem, NSMutableDictionary, WCAdvertiseInfo, WCObjectOperation, NSString, NSMutableArray, WCLocationInfo, WCAppInfo, WCActionInfo, SnsObject, NSArray;




@interface WCDataItem{
	int cid;
	NSString* tid;
	int type;
	int flag;
	NSString* username;
	NSString* nickname;
	int createtime;
	NSString* sourceUrl;
	NSString* sourceUrl2;
	WCLocationInfo* locationInfo;
	WCAdvertiseInfo* advertiseInfo;
	BOOL isPrivate;
	NSMutableArray* sharedGroupIDs;
	NSMutableArray* blackUsers;
	NSMutableArray* visibleUsers;
	unsigned long extFlag;
	BOOL likeFlag;
	int likeCount;
	NSMutableArray* likeUsers;
	int commentCount;
	NSMutableArray* commentUsers;
	int withCount;
	NSMutableArray* withUsers;
	WCContentItem* contentObj;
	WCAppInfo* appInfo;
	NSString* publicUserName;
	NSString* sourceUserName;
	NSString* sourceNickName;
	NSString* contentDesc;
	NSString* contentDescPattern;
	int contentDescShowType;
	int contentDescScene;
	WCActionInfo* actionInfo;
	unsigned hash;
	SnsObject* snsObject;
	BOOL isBidirectionalFan;
	BOOL noChange;
	BOOL isRichText;
	NSMutableDictionary* extData;
	int uploadErrType;
	NSString* statisticsData;
	WCObjectOperation* objOperation;
	NSString* shareOriginUrl;
	NSString* shareOpenUrl;
	NSString* jsAppId;
	NSString* prePublishedId;
}
@property(retain, nonatomic) NSMutableArray* sharedGroupIDs;
@property(assign, nonatomic) BOOL isPrivate;
@property(retain, nonatomic) NSString* prePublishedId;
@property(retain, nonatomic) NSString* jsAppId;
@property(retain, nonatomic) NSString* shareOpenUrl;
@property(retain, nonatomic) NSString* shareOriginUrl;
@property(retain, nonatomic) WCObjectOperation* objOperation;
@property(assign, nonatomic) unsigned long extFlag;
@property(retain, nonatomic) NSArray* visibleUsers;
@property(retain, nonatomic) NSArray* blackUsers;
@property(retain, nonatomic) WCAdvertiseInfo* advertiseInfo;
@property(retain, nonatomic) WCLocationInfo* locationInfo;
@property(retain, nonatomic) NSString* statisticsData;
@property(assign, nonatomic) int uploadErrType;
@property(assign, nonatomic) BOOL isRichText;
@property(assign, nonatomic) BOOL noChange;
@property(retain, nonatomic) NSMutableArray* withUsers;
@property(assign, nonatomic) int withCount;
@property(retain, nonatomic) NSMutableArray* commentUsers;
@property(assign, nonatomic) int commentCount;
@property(retain, nonatomic) NSMutableArray* likeUsers;
@property(assign, nonatomic) int likeCount;
@property(assign, nonatomic) BOOL likeFlag;
@property(retain, nonatomic) WCActionInfo* actionInfo;
@property(assign, nonatomic) int contentDescScene;
@property(assign, nonatomic) int contentDescShowType;
@property(retain, nonatomic) NSString* contentDescPattern;
@property(retain, nonatomic) NSString* contentDesc;
@property(retain, nonatomic) NSString* sourceNickName;
@property(retain, nonatomic) NSString* sourceUserName;
@property(retain, nonatomic) NSString* publicUserName;
@property(retain, nonatomic) WCAppInfo* appInfo;
@property(retain, nonatomic) WCContentItem* contentObj;
@property(assign, nonatomic) BOOL isBidirectionalFan;
@property(assign, nonatomic) int createtime;
@property(retain, nonatomic) NSMutableDictionary* extData;
@property(retain, nonatomic) SnsObject* snsObject;
@property(retain, nonatomic) NSString* sourceUrl2;
@property(retain, nonatomic) NSString* sourceUrl;
@property(retain, nonatomic) NSString* nickname;
@property(retain, nonatomic) NSString* username;
@property(assign, nonatomic) int flag;
@property(assign, nonatomic) int type;
@property(retain, nonatomic) NSString* tid;
@property(assign, nonatomic) int cid;
+(id)fromSeverADObject:(id)severADObject;
+(id)fromUploadTask:(id)uploadTask;
+(id)fromServerObject:(id)serverObject;
+(id)fromBuffer:(id)buffer;

-(int)getSnsABTestType;
-(void)parseContentForNetWithDataItem:(id)dataItem;
-(void)parseContentForUI;
-(void)parsePattern;
-(void)loadPattern;
-(int)compareTime:(id)time;
-(BOOL)isValid;
-(void)mergeMessage:(id)message needParseContent:(BOOL)content;
-(void)mergeMessage:(id)message;
-(void)updateBySnsAdNotInterestsMsg:(id)msg;
-(void)mergeLikeUsers:(id)users;
-(id)getMediaWraps;
-(BOOL)isRead;
-(void)setIsUploadFailed:(BOOL)failed;
-(BOOL)isUploadFailed;
-(BOOL)isUploading;
-(id)toBuffer;
-(void)setHash:(unsigned)hash;
-(unsigned)hash;
-(void)setSequence:(id)sequence;
-(void)setCreateTime:(unsigned long)time;
-(id)getDisplayCity;
-(id)sequence;
-(int)itemType;
-(id)itemID;
-(id)description;
-(id)descriptionForKeyPaths;
-(id)keyPaths;
-(int)compareDesc:(id)desc;
-(BOOL)isEqual:(id)equal;
-(id)initWithCoder:(id)coder;
-(void)encodeWithCoder:(id)coder;
-(id)init;
-(BOOL)hasSharedGroup;
@end
