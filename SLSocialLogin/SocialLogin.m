//
//  SocialLogin.m
//  SocialLogin
//
//  Created by aadil on 19/08/15.
//  Copyright (c) 2015 zaptechsolutions. All rights reserved.
//

#import "SocialLogin.h"

@implementation SocialLogin 
-(instancetype)initWithSocialType:(SocialType)social
{
    _socialType = social;
    self = [super init];
    if(self) {
        self.strFBAppId=[[NSMutableString alloc]init];
        self.strFBSecretKey=[[NSMutableString alloc]init];
        self.strTwitterId=[[NSMutableString alloc]init];
        self.strTwitterSecretKey=[[NSMutableString alloc]init];
        self.strGoogleId=[[NSMutableString alloc]init];
        self.strGoogleSecretKey=[[NSMutableString alloc]init];
        self.strInstagramId=[[NSMutableString alloc]init];
        self.strInstagramSecretKey=[[NSMutableString alloc]init];
    }
    return self;
}
/***************************** Facebook Functions ***********************************/
-(BOOL)isFacebookLoggedIn
{
    if ([FBSDKAccessToken currentAccessToken]) {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(void)logoutFacebook
{
     [[FBSDKLoginManager new] logOut];
}
-(void)getFacebookDetails:(facebookDetail_completion_block) completion
{
    if ([FBSDKAccessToken currentAccessToken]) {
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"id,name,email" forKey:@"fields"];
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"%@",result);
                 if(completion)
                 {
                     completion(result,error,@"Facebook Details were retrived successfully.",1);
                 }
             }
             else{
                 if(completion)
                 {
                     completion(result,error,@"There was error recieving Facebook Information.",-1);
                 }

             }
         }];
        // User is logged in, do work such as go to next view controller.
    }
    else{
        if(completion)
        {
            NSError *err;
            completion(@"",err,@"Facebook user is not logged in, we can not get the details.",1);
        }
    }
}
-(void)postFacebookStatus:(NSString *)msg ViewController:(UIViewController *)view
{
    if ([FBSDKAccessToken currentAccessToken]) {
        if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
            NSLog(@"publish_actions is already granted.");
        } else {
            FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
            [loginManager logInWithPublishPermissions:@[] fromViewController:view handler:
             ^(FBSDKLoginManagerLoginResult *result, NSError *error){
             
             } ];
        }
        
        if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
            [[[FBSDKGraphRequest alloc]
              initWithGraphPath:@"me/feed"
              parameters: @{ @"message" : @"hello world!"}
              HTTPMethod:@"POST"]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     NSLog(@"Post id:%@", result[@"id"]);
                 }
             }];
        }
    }
    else
    {
        
    }
}
-(void)loginWithFacebook:(facebookLogin_completion_block)completion
{
    UIViewController *view;
    
    if(![self isFacebookLoggedIn])
    {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions:@[@"email"] fromViewController:view handler:^(FBSDKLoginManagerLoginResult *result, NSError *error){
            if (error) {
                //There was error processing your request. Try again later.
                if(completion)
                {
                    completion(result,error,@"There was error processing your request.",-1);
                }
                // Process error
            } else if (result.isCancelled) {
                
                //Facebook Registration process was canclled.
                if(completion)
                {
                    completion(result,error,@"Facebook Login was cancelled.",-1);
                }
                // Handle cancellations
            } else {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if ([result.grantedPermissions containsObject:@"email"]) {
                    
                    // Do work
                    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
                    [self getFacebookDetails:^(id result,NSError *err, NSString *msg, int status)
                     {
                         if(completion)
                         {
                             completion(result,err,msg,status);
                         }
                     }];
                    
                }
                else{
                    if(completion)
                    {
                        completion(result,error,@"Facebook Login permission was not granted.",-1);
                    }
                    //You have not granted the Email ID permission on Facebook. Please grant us permission to receive your email id
                }
            }
        }];
        
    }
    else{
        if(completion)
        {
            NSError *error;
            completion(@"",error,@"User is Already Logged in",-1);
        }
    }
}

-(void)loginWithFacebookWithViewController: (UIViewController*)view :(facebookLogin_completion_block)completion
{
    
    if(![self isFacebookLoggedIn])
    {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions:@[@"email"] fromViewController:view handler:^(FBSDKLoginManagerLoginResult *result, NSError *error){
            if (error) {
                //There was error processing your request. Try again later.
                if(completion)
                {
                    completion(result,error,@"There was error processing your request.",-1);
                }
                // Process error
            } else if (result.isCancelled) {
                
                //Facebook Registration process was canclled.
                if(completion)
                {
                    completion(result,error,@"Facebook Login was cancelled.",-1);
                }
                // Handle cancellations
            } else {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if ([result.grantedPermissions containsObject:@"email"]) {
                    
                    // Do work
                    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
                    [self getFacebookDetails:^(id result,NSError *err, NSString *msg, int status)
                     {
                         if(completion)
                         {
                             completion(result,err,msg,status);
                         }
                     }];
                    
                }
                else{
                    if(completion)
                    {
                        completion(result,error,@"Facebook Login permission was not granted.",-1);
                    }
                    //You have not granted the Email ID permission on Facebook. Please grant us permission to receive your email id
                }
            }
        }];
        
    }
    else{
        if(completion)
        {
            NSError *error;
            completion(@"",error,@"User is Already Logged in",-1);
        }
    }
}
/***************************** Twitter Functions ***********************************/
-(BOOL)isTwitterLoggedIn
{
    if([[FHSTwitterEngine sharedEngine]isAuthorized])
    {
        return YES;
    }
    else{
        return NO;
    }

}
-(void)loginWithTwitter:(twitterLogin_completion_block)completion withViewController:(UIViewController *)view{
    if(![self isTwitterLoggedIn])
    {
        [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:_strTwitterId andSecret:_strTwitterSecretKey];
        
        [[FHSTwitterEngine sharedEngine]setDelegate:self];
        
        UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
            if(success)
            {
                NSLog(success?@"L0L success":@"O noes!!! Loggen faylur!!!");
                [[FHSTwitterEngine sharedEngine]loadAccessToken];
                NSString *username = [FHSTwitterEngine sharedEngine].authenticatedUsername;
                NSLog(@"user name is :%@",username);
                if (username.length > 0) {
                    //[self listResults];
                }
                if(completion)
                {
                    completion(username,nil,@"Success",1);
                }
            }
            else{
                if(completion)
                {
                    completion(@"",nil,@"Unable to login",-1);
                }
            }
        }];
        [view presentViewController:loginController animated:YES completion:nil];
        

    }
    else{
        if(completion)
        {
            NSError *error;
            completion(@"",error,@"User is Already Logged in",-1);
        }
    }
}

- (void)logTimeline: (twitterLogin_completion_block) completion{
    if([self isTwitterLoggedIn])
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                NSLog(@"%@",[[FHSTwitterEngine sharedEngine]getTimelineForUser:[[FHSTwitterEngine sharedEngine]authenticatedID] isID:YES count:10]);
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    @autoreleasepool {
                       if(completion)
                       {
                           completion([[FHSTwitterEngine sharedEngine]getTimelineForUser:[[FHSTwitterEngine sharedEngine]authenticatedID] isID:YES count:10],nil,@"Data returned",1);
                       }
                    }
                });
            }
        });
    }
}

- (void)postTweetWithMessage:(NSString *)msg withCompletionBlock:(twitterLogin_completion_block) completion {
    
    if([self isTwitterLoggedIn])
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                NSString *tweet = msg;
                id returned = [[FHSTwitterEngine sharedEngine]postTweet:tweet];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                NSString *title = nil;
                NSString *message = title;
                
                if ([returned isKindOfClass:[NSError class]]) {
                    NSError *error = (NSError *)returned;
                    //title = [NSString stringWithFormat:@"Error %ld",(long)error.code];
                    message = error.localizedDescription;
                    if(completion)
                    {
                        completion(@"",error,message,-1);
                    }
                } else {
                    NSLog(@"%@",returned);
                    //title = @"Tweet Posted";
                    message = tweet;
                    if(completion)
                    {
                        completion(message  ,nil,message,1);
                    }
                }
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    @autoreleasepool {
                        //[av show];
                    }
                });
            }
        });
    }
}


- (void)toggleStreaming:(twitterLogin_completion_block) completion {
    if([self isTwitterLoggedIn])
    {
        NSLog(@"Streaming");
        if (!_isStreaming) {
            self.isStreaming = YES;
            [[FHSTwitterEngine sharedEngine]streamSampleStatusesWithBlock:^(id result, BOOL *stop) {
                NSLog(@"%@",result);
                if(completion)
                {
                    completion(result,nil,@"Tweet Could not be posted",-1);
                }
                if (_isStreaming == NO) {
                    *stop = YES;
                }
            }];
        } else {
            self.isStreaming = NO;
        }
    }
}

- (void)storeAccessToken:(NSString *)accessToken {
    [[NSUserDefaults standardUserDefaults]setObject:accessToken forKey:@"SavedAccessHTTPBody"];
}

- (NSString *)loadAccessToken {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"SavedAccessHTTPBody"];
}

/***************************** Instagram Functions ***********************************/

-(BOOL)isInstagramLoggedIn
{
    return YES;
}

/***************************** Google Functions ***********************************/
-(void)loginWithGoogle:(google_completion_block)completion{
    if(![self isGoogleLoggedIn])
    {
        GPPSignIn *signIn = [GPPSignIn sharedInstance];
        signIn.shouldFetchGooglePlusUser = YES;

        signIn.clientID = self.strGoogleId;
        
        // Uncomment one of these two statements for the scope you chose in the previous step
       // signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
        signIn.scopes = @[ kGTLAuthScopePlusLogin, @"profile" ];            // "profile" scope
        
        // Optional: declare signIn.actions, see "app activities"
        signIn.delegate = self;
        [signIn authenticate];
        self.objGoogleBlock=completion;
        
    }
    else{
        if(completion)
        {
            NSError *error;
            completion(@"",error,@"User is Already Logged in",-1);
        }
    }
}
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    if(error)
    {
        self.objGoogleBlock(@"",error,@"User is Already Logged in",-1);
        //Getting Google Plus Profile Information
        
        
    }
    else{
        GTLServicePlus* plusService = [[GTLServicePlus alloc] init ];
        plusService.retryEnabled = YES;
        [plusService setAuthorizer:[[GPPSignIn sharedInstance] authentication]];
        
        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
        
        [plusService executeQuery:query
                completionHandler:^(GTLServiceTicket *ticket,
                                    GTLPlusPerson *person,
                                    NSError *error) {
                    if (error) {
                        GTMLoggerError(@"Error: %@", error);
                    } else {
                        // Retrieve the display name and "about me" text
//                        NSString *description = [NSString stringWithFormat:
//                                                 @"%@\n%@", person.displayName,
//                                                 person.aboutMe];
                        self.objGoogleBlock(person,nil,@"User Logged in success",1);
                    }
                }];
        
    }
    NSLog(@"Received error %@ and auth object %@",error, auth);
}
-(void)logoutGoogle{
    [[GPPSignIn sharedInstance] signOut];
}
-(BOOL)isGoogleLoggedIn
{
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        return YES;
        // Perform other actions here, such as showing a sign-out button
    } else {
        return  NO;
        // Perform other actions here
    }
}
-(void)postToGooglePlus{
        id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
        [shareBuilder open];

}
-(void)peopleListGooglePlus:(google_completion_block) completion{
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init ];
    plusService.retryEnabled = YES;
    [plusService setAuthorizer:[[GPPSignIn sharedInstance] authentication]];
    
    GTLQueryPlus *query =
    [GTLQueryPlus queryForPeopleListWithUserId:@"me"
                                    collection:kGTLPlusCollectionVisible];
    [plusService executeQuery:query
            completionHandler:^(GTLServiceTicket *ticket,
                                GTLPlusPeopleFeed *peopleFeed,
                                NSError *error) {
                if (error) {
                    GTMLoggerError(@"Error: %@", error);
                    if(completion)
                    {
                        completion(@"",error,@"Error Getting People List",-1);
                    }
                } else {
                    // Get an array of people from GTLPlusPeopleFeed
                    NSArray* peopleList = peopleFeed.items;
                    if(completion)
                    {
                        completion(peopleList,nil,@"Getting People List Success",1);
                    }
                }
            }];}

/***************************** LinkedInn Functions ***********************************/
-(void)loginWithLinkedInn:(linkedIn_completion_block)completion
{
    @try {
        
        NSLog(@"%s","sync pressed2");
        [LISDKSessionManager createSessionWithAuth:[NSArray arrayWithObjects:LISDK_BASIC_PROFILE_PERMISSION, LISDK_EMAILADDRESS_PERMISSION, LISDK_W_SHARE_PERMISSION, nil]
                                             state:@"some state"
                            showGoToAppStoreDialog:YES
                                      successBlock:^(NSString *returnState) {
                                          
                                          NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                                          if(completion)
                                          {
                                            completion(returnState,nil,@"LinkedIn login success",1);
                                          }
                                          
                                          
                                      }
                                        errorBlock:^(NSError *error) {
                                            if(completion)
                                            {
                                                completion(nil,error,[error description],-1);
                                            }
                                            NSLog(@"%s %@","error called! ", [error description]);
                                            //  _responseLabel.text = [error description];
                                        }
         ];
        NSLog(@"%s","sync pressed3");
        
        return;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
        if(completion)
        {
            completion(nil,nil,@"Exception error",-1);
        }

    }
    @finally {
    }
}

-(void) postLinkedInnWithMessage:(NSDictionary *)msg withCompletionBlock:(linkedIn_completion_block) completion{
    
    LISDKSession *session = [[LISDKSessionManager sharedInstance] session];
    NSLog(@"value=%@ isvalid=%@",[session value],[session isValid] ? @"YES" : @"NO");
    NSMutableString *text = [[NSMutableString alloc] initWithString:[session.accessToken description]];
    [text appendString:[NSString stringWithFormat:@",state=\"%@\"",@"some state"]];
    NSLog(@"Response label text %@",text);
    
    NSDictionary *link=[[NSDictionary alloc] initWithObjects:@[@"anyone"] forKeys:@[@"code"] ];
    
    NSDictionary *imageDict =[NSDictionary dictionaryWithObjectsAndKeys:[msg valueForKey:@"title"],@"title",[msg valueForKey:@"link"],@"submitted-url",[msg valueForKey:@"description"],@"description",[msg valueForKey:@"image-url"],@"submitted-image-url", nil];
    NSString *addCommentStr;

        addCommentStr = [NSString stringWithFormat:@" %@ \n %@ \n %@",[msg valueForKey:@"title"],[msg valueForKey:@"description"],[msg valueForKey:@"link"]];
    NSDictionary *post;
    
    post=[[NSDictionary alloc] initWithObjects:@[addCommentStr,imageDict,link] forKeys:@[@"comment",@"content",@"visibility"]];
    
    
    BOOL prettyPrint=YES;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:post
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    [[LISDKAPIHelper sharedInstance] apiRequest:@"https://api.linkedin.com/v1/people/~/shares?format=json"
                                         method:@"POST"
                                           body:jsonData
                                        success:^(LISDKAPIResponse *response) {
                                            NSLog(@"success called %@", response.data);
                                            if(completion)
                                            {
                                                completion(response.data,nil,@"Posted",1);
                                            }
                                            
                                        }
                                          error:^(LISDKAPIError *apiError) {
                                              
                                              NSLog(@"error called %@", apiError.description);
                                              dispatch_sync(dispatch_get_main_queue(), ^{
                                                  LISDKAPIResponse *response = [apiError errorResponse];
                                                  NSString *errorText;
                                                  if (response) {
                                                      if(completion)
                                                      {
                                                          completion(nil,nil,response.data,-1);
                                                      }
                                                      errorText = response.data;
                                                  }
                                                  else {
                                                      if(completion)
                                                      {
                                                          completion(nil,nil,apiError.description,-1);
                                                      }

                                                      errorText = apiError.description;
                                                  }
                                              });
                                          }];
    
}
/***************************** Instagram Functions ***********************************/
-(void)loginWithInstagram:(linkedIn_completion_block)completion withViewController:(UIViewController *)view
{
    @try {
        self.webView.scrollView.bounces = NO;
        [[InstagramEngine sharedEngine] setAppRedirectURL:@"https://instagram.com"];
        [[InstagramEngine sharedEngine] setAppClientID:@"ba5f88117a6f471d9d222c6b28b04785"];
        NSURL *authURL = [[InstagramEngine sharedEngine] authorizationURL];
        self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, view.view.frame.size.width, view.view.frame.size.height)];
        [self.webView loadRequest:[NSURLRequest requestWithURL:authURL]];
        self.webView.delegate=self;
        [view.view addSubview:self.webView];
        self.viewController=view;
        self.objInstagramBlock=completion;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
        if(completion)
        {
            completion(nil,nil,@"Exception error",-1);
        }
        
    }
    @finally {
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSError *error;
    if ([[InstagramEngine sharedEngine] receivedValidAccessTokenFromURL:request.URL error:&error])
    {
        if(!error)
        {
            [self.webView removeFromSuperview];
            self.objInstagramBlock(@"",nil,@"User is Logged in",1);
        }
        else
        {
            [self.webView removeFromSuperview];
            self.objInstagramBlock(@"",error,@"User not Logged in",-1);
        }
        [self authenticationSuccess];
    }
    return YES;
}

- (void)authenticationSuccess
{
    //
}
@end
