//
//  QKWebViewController.m
//  KXWSaoDaAn
//
//  Created by 张思源 on 16/2/6.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import "QKWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface QKWebViewController()<UIWebViewDelegate,NJKWebViewProgressDelegate>
/**
 *  网页视图
 */
@property(nonatomic,weak)UIWebView * webView;

@property(nonatomic,strong)NJKWebViewProgressView * webViewProgressView;
@property(nonatomic,strong)NJKWebViewProgress * webProgress;

@end
@implementation QKWebViewController

-(NJKWebViewProgress *)webProgress{
    if (!_webProgress) {
        _webProgress = [[NJKWebViewProgress alloc]init];
        _webProgress.webViewProxyDelegate = self;
        _webProgress.progressDelegate = self;
    }
    return _webProgress;
}
-(void)viewDidLoad{
    [super viewDidLoad];
     self.title = @"网页";
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar addSubview:self.webViewProgressView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [self.webViewProgressView removeFromSuperview];
}

-(void)setupUI{
    UIWebView * webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.delegate = self.webProgress;
    self.webView = webView;
    [self.view addSubview:webView];
    
    //创建加载进度条
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    self.webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    [self loadUrlWithString:self.urlString];
}

-(void)loadUrlWithString:(NSString *)urlStr
{
    self.webViewProgressView.hidden = NO;
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:req];
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.webViewProgressView setProgress:progress animated:YES];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if ([self.title isEqualToString:@""]||self.title == nil) {
        self.title = @"网页";
    }
}
@end
