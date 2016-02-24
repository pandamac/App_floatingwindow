//
//  wechat_floatingwindow.m
//  wechat_floatingwindow
//
//  Created by panda on 24/2/16.
//  Copyright (c) 2016年 __MyCompanyName__. All rights reserved.
//

#import "wechat_floatingwindow.h"
#import <objc/runtime.h>
#import "HookUtil.h"


#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIWindow.h>
#import <UIKit/UIKit.h>


#import "ContactsViewController.h"
#import "WCLikeButton.h"
#import "ContactsDataLogic.h"
#import "CBaseContact.h"
#import "WCUserComment.h"
#import "WCDataItem.h"

//typedef struct {
//    CLLocationDegrees latitude;
//    CLLocationDegrees longitude;
//} CLLocationCoordinate2D;

UIWindow *keywindow =nil;
UIImageView *_imageView = nil;
//悬浮窗
UIWindow *mwindow = nil;

//主窗口
UIWindow *nwindow = nil;
UILabel *location_lable;
UILabel *jingwei_lable;

UITextField *text1;
UITextField *text2;
UISwitch *location_switchButton;

int gps=0;


ContactsViewController *m_controller=nil;

//悬浮窗宽高
#define WIDTH mwindow.frame.size.width
#define HEIGHT mwindow.frame.size.height
//手机屏幕宽高
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

void gps_switchAction(id self, SEL _cmd) {
    if([location_switchButton isOn] == NO){
        gps=0;
    }
    else{
        gps=1;
    }
    
}

void passTextField_DidEndOnExit(id self,SEL _cmd,id sender) {
    [sender resignFirstResponder];
}

void locationChange(id self,SEL _cmd,UIPanGestureRecognizer *piont){
    
    CGPoint panPoint = [piont locationInView:keywindow];
    //拖动开始
    if(piont.state == UIGestureRecognizerStateBegan)
    {
        _imageView.alpha = 1;
    }
    //拖动中
    if(piont.state == UIGestureRecognizerStateChanged)
    {
        mwindow.center = CGPointMake(panPoint.x, panPoint.y);
    }
    
    //拖动结束悬浮窗停留位置
    //屏幕分为四个象限，根据到边框的距离计算停留位置
    else if(piont.state == UIGestureRecognizerStateEnded)
    {
        //  第一象限
        if(panPoint.x <= kScreenWidth/2 && panPoint.y <= kScreenHeight/2)
        {
            if(panPoint.y <= panPoint.x)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    mwindow.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else
            {
                [UIView animateWithDuration:0.2 animations:^{
                    mwindow.center = CGPointMake(WIDTH/2, panPoint.y);
                }];
            }
        }
        
        //第三象限
        else if(panPoint.x <= kScreenWidth/2 && panPoint.y > kScreenHeight/2)
        {
            if(kScreenHeight-panPoint.y <= panPoint.x)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    mwindow.center = CGPointMake(panPoint.x, kScreenHeight-HEIGHT/2);
                }];
            }
            else
            {
                [UIView animateWithDuration:0.2 animations:^{
                    mwindow.center = CGPointMake(WIDTH/2, panPoint.y);
                }];
            }
            
        }
        
        //第二象限
        else if(panPoint.x > kScreenWidth/2 && panPoint.y <= kScreenHeight/2)
        {
            if(panPoint.y <= kScreenWidth-panPoint.x)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    mwindow.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else
            {
                [UIView animateWithDuration:0.2 animations:^{
                    mwindow.center = CGPointMake(kScreenWidth-WIDTH/2, panPoint.y);
                }];
            }
            
        }
        
        //第四象限
        else if(panPoint.x > kScreenWidth/2 && panPoint.y > kScreenHeight/2)
        {
            if(kScreenHeight-panPoint.y <= kScreenWidth-panPoint.x)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    mwindow.center = CGPointMake(panPoint.x, kScreenHeight-HEIGHT/2);
                }];
            }
            else
            {
                [UIView animateWithDuration:0.2 animations:^{
                    mwindow.center = CGPointMake(kScreenWidth-WIDTH/2, panPoint.y);
                }];
            }
            
        }
    }
    
}

void showresult(id self,SEL _cmd)
{
    if(nwindow.hidden==NO){
        nwindow.hidden=YES;
    }
    else {
        nwindow.hidden=NO;
    }
}

@implementation wechat_floatingwindow
+(void)load
{
    Class NewMainFrameViewController=objc_getClass("NewMainFrameViewController");
    
    class_addMethod([NewMainFrameViewController class], @selector(m_showresult), (IMP)showresult, "v@:");
    class_addMethod([NewMainFrameViewController class], @selector(l_switchAction), (IMP)gps_switchAction, "v@:");
    class_addMethod([NewMainFrameViewController class], @selector(m_locationChange:), (IMP)locationChange, "v@:@");
    class_addMethod([NewMainFrameViewController class], @selector(m_passTextField_DidEndOnExit:), (IMP)passTextField_DidEndOnExit, "v@:@");
    
//    class_addMethod([NewMainFrameViewController class], @selector(m_switchAction), (IMP)switchAction, "v@:");
//    class_addMethod([NewMainFrameViewController class], @selector(n_switchAction), (IMP)dianzan_switchAction, "v@:");
//    class_addMethod([NewMainFrameViewController class], @selector(x_switchAction), (IMP)xiping_switchAction, "v@:");
//    class_addMethod([NewMainFrameViewController class], @selector(m_addaction), (IMP)addaction, "v@:");
//    class_addMethod([NewMainFrameViewController class], @selector(m_closeaction), (IMP)closeaction, "v@:");
//    class_addMethod([NewMainFrameViewController class], @selector(m_subaction), (IMP)subaction, "v@:");
}
@end



//@property(readonly, nonatomic) CLLocationCoordinate2D coordinate
HOOK_MESSAGE(CLLocationCoordinate2D,CLLocation,coordinate)
{
    CLLocationCoordinate2D tmp = _CLLocation_coordinate(self,sel);
    if (gps==1) {
        tmp.latitude = [text1.text floatValue];//北纬
        tmp.longitude = [text2.text floatValue];//东经
        NSLog(@"locaton fuck");
    }
    return tmp;
}

HOOK_MESSAGE(void,WCLikeButton,onLikeFriend)
{
    
//    template <typename Type_>
//    static inline Type_ &MSHookIvar(id self, const char *name) {
//        Ivar ivar(class_getInstanceVariable(object_getClass(self), name));
//        void *pointer(ivar == NULL ? NULL : reinterpret_cast<char *>(self) + ivar_getOffset(ivar));
//        return *reinterpret_cast<Type_ *>(pointer);
//    }
    if (m_controller!=nil)
    {
//        ContactsDataLogic* _m_contactsDataLogic = MSHookIvar<ContactsDataLogic*>(m_controller,"m_contactsDataLogic");
        Ivar ivar = class_getInstanceVariable(object_getClass(m_controller), "m_contactsDataLogic");
        void *pointer = (char *)(m_controller) + ivar_getOffset(ivar);
        ContactsDataLogic* _m_contactsDataLogic  = *(id*)(pointer);
        
        NSMutableArray *User = [_m_contactsDataLogic getAllContacts];//CBaseContact
        
        NSMutableArray *mutItems=[NSMutableArray arrayWithCapacity:3];
        
        for (CBaseContact *user in User)
        {
            // NSLog(@"user = %@",user);
            if ([user m_uiSex] != 0)//去掉公众
            {
                WCUserComment *comment = [[objc_getClass("WCUserComment") alloc] init];
                comment.nickname = [user m_nsNickName];
                comment.username = [user m_nsUsrName];
                [mutItems addObject:comment];
            }
        }
        
        [self m_item].likeUsers = mutItems;
        _WCLikeButton_onLikeFriend(self,sel);
        [self LikeBtnReduceEnd];
    }
    else
    {
        _WCLikeButton_onLikeFriend(self,sel);
    }
    return ;
}

HOOK_MESSAGE(void,ContactsViewController,initData)
{
     _ContactsViewController_initData(self,sel);
    
    m_controller = self;
    return ;
}


HOOK_MESSAGE(void,NewMainFrameViewController,viewDidLoad)
{
    _NewMainFrameViewController_viewDidLoad(self,sel);
    keywindow = [[UIApplication sharedApplication] keyWindow];
    
    //经纬lable
    jingwei_lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 40)];
    jingwei_lable.font = [UIFont systemFontOfSize:12];
    jingwei_lable.backgroundColor = [UIColor clearColor];
    jingwei_lable.text=@"北纬+东经";
    jingwei_lable.adjustsFontSizeToFitWidth = YES;
    
    //经纬度text
    text1=[[UITextField alloc] initWithFrame:CGRectMake(60, 10, 40, 30)];
    [text1 setBackgroundColor:[UIColor whiteColor]];
    text1.font = [UIFont systemFontOfSize:12];
    text1.text=@"25.03";
    
    [text1 addTarget:self action:@selector(m_passTextField_DidEndOnExit:)
              forControlEvents:UIControlEventEditingDidEndOnExit];
    
    text2=[[UITextField alloc] initWithFrame:CGRectMake(100, 10, 40, 30)];
    [text2 setBackgroundColor:[UIColor whiteColor]];
    text2.font = [UIFont systemFontOfSize:12];
    text2.text=@"121.13";
   
    [text2 addTarget:self action:@selector(m_passTextField_DidEndOnExit:)
              forControlEvents:UIControlEventEditingDidEndOnExit];
    
    location_switchButton=[[UISwitch alloc] initWithFrame:CGRectMake(70, 40, 20, 20)];
    [location_switchButton setOn:NO];
    [location_switchButton addTarget:self action:@selector(l_switchAction) forControlEvents:UIControlEventValueChanged];

    
    //点击悬浮窗弹出的主窗口设置，其他子控件添加在这上面
    nwindow = [[UIWindow alloc]initWithFrame:CGRectMake(kScreenWidth/2-75, kScreenHeight/2-140, 150, 280)];
    nwindow.backgroundColor = [UIColor grayColor];
    nwindow.windowLevel = UIWindowLevelStatusBar;

    [nwindow addSubview:location_switchButton];
    [nwindow addSubview:location_lable];
    [nwindow addSubview:jingwei_lable];
    [nwindow addSubview:text1];
    [nwindow addSubview:text2];

    [nwindow makeKeyAndVisible];
    nwindow.hidden=YES;
    
    //创建悬浮窗
    mwindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    mwindow.backgroundColor = [UIColor clearColor];
    mwindow.windowLevel = UIWindowLevelStatusBar;
    [mwindow makeKeyAndVisible];
    
    //悬浮窗背景图
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _imageView.image = [UIImage imageNamed:@"panda.png"];
    _imageView.alpha = 0.5;
    [mwindow addSubview:_imageView];
    
    
    //创建悬浮窗拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(m_locationChange:)];
    pan.delaysTouchesBegan = YES;
    [mwindow addGestureRecognizer:pan];
    
    //创建悬浮窗点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(m_showresult)];
    [mwindow addGestureRecognizer:tap];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];//不熄屏
    return;
}