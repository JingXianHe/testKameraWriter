//
//  ViewController.m
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>
#import "THCameraController.h"
#import "THPreviewView.h"
#import "THContextManager.h"
#import "THPhotoFilters.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *ButtonView;

@property (weak, nonatomic) IBOutlet UIView *displayView;
@property (strong, nonatomic) THCameraController *controller;
@property (strong, nonatomic) THPreviewView *previewView1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.controller = [[THCameraController alloc] init];
    
    CGRect frame = self.view.bounds;
    EAGLContext *eaglContext = [THContextManager sharedInstance].eaglContext;
    self.previewView1 = [[THPreviewView alloc] initWithFrame:frame context:eaglContext];
    self.previewView1.filter = [THPhotoFilters defaultFilter];
    
    self.controller.imageTarget = self.previewView1;
    
    self.previewView1.coreImageContext = [THContextManager sharedInstance].ciContext;
    [self.view insertSubview:self.previewView1 belowSubview:self.ButtonView];
    NSError *error;
    if ([self.controller setupSession:&error]) {
        [self.controller startSession];
    } else {
        NSLog(@"Error: %@", [error localizedDescription]);
    }

}
- (IBAction)trigger:(id)sender {
    if (!self.controller.isRecording) {
        dispatch_async(dispatch_queue_create("com.tapharmonic.kamera", NULL), ^{
            [self.controller startRecording];
        });
    } else {
        [self.controller stopRecording];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
