//
//  SSimgTextBadgeBtn.h
//  baseProject
//
//  Created by F S on 2020/12/18.
//  Copyright © 2020 FL S. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///图文试图按钮（上图下文字）
@interface SSimgTextBadgeBtn : UIButton
@property(nonatomic,strong) NSString* imgNameStr;
@property(nonatomic,strong) NSString* badgeNum;
@end

NS_ASSUME_NONNULL_END
