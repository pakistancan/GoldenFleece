#import "GFGistCommentWindowController.h"
#import "GFClient.h"

@interface GFGistCommentWindowController ()

@end

@implementation GFGistCommentWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)postButtonClicked:(id)sender {
    NSLog(@"POST username=%@ comment=[%@]", self.usernameTextField.stringValue, self.commentTextField.stringValue);
    [[[GFClient sharedInstance] httpClient].requestSerializer setAuthorizationHeaderFieldWithUsername:self.usernameTextField.stringValue password:self.passwordTextField.stringValue];
    
    GitHubComment *comment = [[GitHubComment alloc] init];
    comment.body = self.commentTextField.stringValue;
    [[GitHubApi sharedInstance] postGistComment:comment forGist:self.gistIdTextField.stringValue delegate:self];
}

- (void)postGistCommentSucceeded:(GitHubComment *)comment {
    if (comment) {
        NSLog(@"gist comment: %@", comment.body);
    } else {
        NSLog(@"post gist comment result was nil");
    }
}

- (void)postGistCommentError:(NSError *)error {
    NSLog(@"post gist comment failed: %@", [error localizedDescription]);
}

@end
