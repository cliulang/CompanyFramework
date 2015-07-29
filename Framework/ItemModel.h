//
//  ItemModel.h
//  Framework
//
//  Created by zero on 15/7/29.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import "BaseModel.h"

@interface ItemModel : BaseModel
@property (nonatomic,strong) NSNumber* itemKey;
@property (nonatomic,strong) NSString* itemValue;
@property (nonatomic,strong) NSString* info;
@end
