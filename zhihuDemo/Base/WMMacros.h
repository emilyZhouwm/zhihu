//
//  WMMacros_h
//

#ifndef WMMacros_h
#define WMMacros_h

// 日志输出
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif
#define DebugLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])

#pragma mark  ------------------------- version -------------------------

#define kGetVersion             [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleShortVersionString"]
#define kSaveVersion(version)   [[NSUserDefaults standardUserDefaults] setObject:(version) forKey:@"CFBundleShortVersionString"];[[NSUserDefaults standardUserDefaults] synchronize]

#define kGetRegister(key)               [[NSUserDefaults standardUserDefaults] objectForKey:(key)]
#define kSaveRegister(key, value)       [[NSUserDefaults standardUserDefaults] setObject:(value) forKey:(key)];\
                                        [[NSUserDefaults standardUserDefaults] synchronize]
#define kRemoveRegister(key)            [[NSUserDefaults standardUserDefaults] removeObjectForKey:(key)];\
                                        [[NSUserDefaults standardUserDefaults] synchronize]

#pragma mark  ------------------------- UI -------------------------

// App Frame
#define Application_Frame       [[UIScreen mainScreen] applicationFrame]

// App Frame Height&Width
#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width

// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

// 系统控件默认高度
#define kStatusBarHeight        (20.f)

#define kTopBarHeight           (44.f)
#define kBottomBarHeight        (49.f)

#define kCellDefaultHeight      (44.f)

#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)

// 当前版本
#define SSystemVersion  ([[UIDevice currentDevice] systemVersion])
#define FSystemVersion  ([SSystemVersion floatValue])
#define DSystemVersion  ([SSystemVersion doubleValue])

// 判断操作系统是否ios7\8
#define isIOS7          (FSystemVersion >= 7.0)
#define isIOS8          (FSystemVersion >= 8.0)

// 当前语言
#define CURRENTLANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])

// 是否Retina屏
#define isRetina        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

// 是否iPhone5
#define isiPhone5       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// 是否iPhone6
#define isiPhone6       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6Plus   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

// 是否iPad
#define isPad           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 角度转弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

#pragma mark  ------------------------- 沙盒路径  -------------------------

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#pragma mark  ------------------------- 方法宏  -------------------------

// ScrollView取消滚动条
#pragma mark 重写这个方法的目的。去掉父类默认的操作：显示滚动条
#define kHideScroll - (void)viewDidAppear:(BOOL)animated { }

// 隐藏状态栏
#define kHideStatusBar - (BOOL)prefersStatusBarHidden { return YES; }

// PNG JPG 图片路径
#define PNGPATH(NAME)       [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)       [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)     [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// 加载图片
#define PNGIMAGE(NAME)      [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)      [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

// 字体大小(常规/粗体)
#define SYSTEMFONT(FONTSIZE)        [UIFont systemFontOfSize:FONTSIZE]
#define BOLDSYSTEMFONT(FONTSIZE)    [UIFont boldSystemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)        [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// 本地化字符串
/** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
#define LocalString(x, ...)     NSLocalizedString(x, nil)
/** NSLocalizedStringFromTable宏做的其实就是在当前bundle中查找资源文件名“xxx.strings”(参数:键＋文件名＋注释) */
#define AppLocalString(x, ...)  NSLocalizedStringFromTable(x, @"someName", nil)

#if TARGET_OS_IPHONE
/** iPhone Device */
#endif

#if TARGET_IPHONE_SIMULATOR
/** iPhone Simulator */
#endif

// ARC
#if __has_feature(objc_arc)
/** Compiling with ARC */
#else
/** Compiling without ARC */
#endif

#pragma mark  ------------------------- 颜色部分 -------------------------

#define kColor(r, g, b)         [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define kColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kColorHexA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                                green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                                 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define kColorHex(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                                green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                                 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kColorFromImage(imageName) [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]]

#pragma mark  ------------------------- 正则判断 -------------------------

#define RegexKitEmail @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?"
#define RegexKitMobilePhone @"^[1][358][0-9]{9}$"

#pragma mark  ------------------------- 单例 ----------------------------
// @interface
#define singleton_interface(className) \
+ (className *)sharedInstance;

// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)sharedInstance \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

#pragma mark  ------------------------- 其他部分 -------------------------

#define IntToString(x)  [NSString stringWithFormat:@"%d", (x)]
#define LongToString(x)  [NSString stringWithFormat:@"%lld", (x)]
#define FloatToString(x)  [NSString stringWithFormat:@"%f", (x)]

#endif
