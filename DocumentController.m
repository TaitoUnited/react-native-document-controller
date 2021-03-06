#import "DocumentController.h"
#import "React/RCTBridge.h"

@implementation DocumentController

@synthesize bridge = _bridge;

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(show:(NSDictionary *)args)
{
    NSURL *file = [NSURL fileURLWithPath:args[@"file"]];

    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:file];
    self.documentController.delegate = self;

    UIViewController *ctrl = [[[[UIApplication sharedApplication] delegate] window] rootViewController];

    if (![self.documentController presentOpenInMenuFromRect:ctrl.view.bounds inView:ctrl.view animated:YES]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Sinulla ei ole tämän tiedostotyypin avaamiseen soveltuvaa sovellusta asennettuna." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}

@end
