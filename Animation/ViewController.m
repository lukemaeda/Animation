//
//  ViewController.m
//  Animation
//
//  Created by kunren10 on 2014/03/26.
//  Copyright (c) 2014年 Takahide Baba. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *ivTarget;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action Method

// [旧アニメーション]セグメント変更
- (IBAction)proc01:(UISegmentedControl *)sender {
	
	// ボタン判定
	switch (sender.selectedSegmentIndex) {
		case 0:
			[self doAnimation01a];
			break;
		case 1:
			[self doAnimation01b];
			break;
			
		default:
			break;
	}
}

// [ブロックアニメーション：プロパティ変更]セグメント変更
- (IBAction)proc02:(UISegmentedControl *)sender {
	
	// ボタン判定
	switch (sender.selectedSegmentIndex) {
		case 0:
			[self doAnimation02a];
			break;
		case 1:
			[self doAnimation02b];
			break;
		case 2:
			[self doAnimation02c];
			break;
		case 3:
			[self doAnimation02d];
			break;
			
		default:
			break;
	}
}

// [ブロックアニメーション：アフィン変換]セグメント変更
- (IBAction)proc03:(UISegmentedControl *)sender {
	
	// ボタン判定
	switch (sender.selectedSegmentIndex) {
		case 0:
			[self doAnimation03a];
			break;
		case 1:
			[self doAnimation03b];
			break;
		case 2:
			[self doAnimation03c];
			break;
		case 3:
			[self doAnimation03d];
			break;
			
		default:
			break;
	}
}

// [ブロックアニメーション：トランジション]セグメント変更
- (IBAction)proc04:(UISegmentedControl *)sender {
	
	// ボタン判定
	switch (sender.selectedSegmentIndex) {
		case 0:
			[self doAnimation04a];
			break;
		case 1:
			[self doAnimation04b];
			break;
			
		default:
			break;
	}
}


#pragma mark - Own Method（旧アニメーション）

// 旧アニメーション - 移動
- (void)doAnimation01a {
	
	// アニメーション準備
	[UIView beginAnimations:nil context:nil];
	
	// アニメーション設定（時間）
	[UIView setAnimationDuration:5.0];
	
	// アニメーション対象処理
	//------------------------------------------------
	// 移動処理
	CGPoint cnt = self.ivTarget.center;
	self.ivTarget.center = CGPointMake(cnt.x + 50.0f,
									   cnt.y + 50.0f);
	//------------------------------------------------
	
	// アニメーション再生
	[UIView commitAnimations];
}

// 旧アニメーション - 伸縮
- (void)doAnimation01b {
	
	// アニメーション準備
	[UIView beginAnimations:nil context:nil];
	
	// アニメーション設定（時間）
	[UIView setAnimationDuration:1.0];
	
	// アニメーション対象処理
	//------------------------------------------------
	// 伸縮処理 （/:縮む　*:拡大）
	CGRect rct = self.ivTarget.frame;
	CGPoint pnt = rct.origin;		// 原点座標
	CGSize  siz = rct.size;			// サイズ
	CGRect newRct = CGRectMake(pnt.x,
							   pnt.y,
							   siz.width  / 2.0f,
							   siz.height / 2.0f);
	self.ivTarget.frame = newRct;
	//------------------------------------------------
	
	// アニメーション再生
	[UIView commitAnimations];
}


#pragma mark - Own Method（ブロックアニメーション：プロパティ変更）

// ブロックアニメーション：プロパティ変更 - フェード
- (void)doAnimation02a {
	
	// パターン１{時間、対象処理}
	[UIView animateWithDuration:1.0
					 animations:^{
						 // フェードイン／アウト
						 self.ivTarget.alpha =
								!self.ivTarget.alpha;
					 }];

	// （ブロック機構の別記）
//	void (^ani)(void) = ^(void) {
//		
//		 // フェードイン／アウト
//		 self.ivTarget.alpha = !self.ivTarget.alpha;
//	};
//	
//	[UIView animateWithDuration:1.0
//					 animations:ani];
}

// ブロックアニメーション：プロパティ変更 - 移動
- (void)doAnimation02b {
	
	// パターン２{時間、対象処理、完了時処理}
	[UIView animateWithDuration:1.0
					 animations:^{
						 
						 // 移動処理
						 CGPoint pnt = self.ivTarget.center;
						 self.ivTarget.center =
							CGPointMake(pnt.x + 50.0f, pnt.y + 50.0f);
					 }
					 completion:^(BOOL finished) {
						 
						 // 移動処理
						 CGPoint pnt = self.ivTarget.center;
						 self.ivTarget.center =
							CGPointMake(pnt.x - 50.0f, pnt.y - 50.0f);
					 }];
}

// ブロックアニメーション：プロパティ変更 - 伸縮
- (void)doAnimation02c {
	
	// (パターン２ 別記)
	void (^ani)(void) = ^(void) {
		
		// 伸縮処理
//        CGPoint pnt = self.ivTarget.frame.origin;
		CGPoint pnt = self.ivTarget.frame.origin;
		CGSize  siz = self.ivTarget.frame.size;
		
//		CGRect rct = CGRectMake(pnt.x, pnt.y,
//								siz.width * 2, siz.height * 2); // /:縮む
        CGRect rct = CGRectMake(pnt.x, pnt.x,
								siz.width * 2, siz.height * 2); // /:縮む
		self.ivTarget.frame = rct;
	};
	
	void (^cmp)(BOOL) = ^(BOOL finished) {
		
		// 伸縮処理
		CGPoint pnt = self.ivTarget.frame.origin;
		CGSize  siz = self.ivTarget.frame.size;
		
		CGRect rct = CGRectMake(pnt.x, pnt.y,
								siz.width / 2, siz.height / 2); // *:戻る
		self.ivTarget.frame = rct;
	};
	
	[UIView animateWithDuration:1.0
					 animations:ani
					 completion:cmp];
}

// ブロックアニメーション：プロパティ変更 - 色変更
- (void)doAnimation02d {
	
	// パターン３{時間、開始遅延時間、オプション、対象処理、完了時処理}
	[UIView animateWithDuration:1.0
						  delay:1.0
						options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat
					 animations:^{
						 
						 // 色変更処理
						 self.ivTarget.backgroundColor = [UIColor redColor];
					 }
					 completion:^(BOOL finished) {
						 
						 // 色変更処理
						 self.ivTarget.backgroundColor = nil;
					 }];
}


#pragma mark - Own Method（ブロックアニメーション：アフィン変換）

// ブロックアニメーション：アフィン変換 - 回転
- (void)doAnimation03a {
	
	// アニメーション対象処理
	void (^ani)(void) = ^(void) {
		
		// 回転の角度（正：右回り基準）
		CGFloat rol = -270.0f;
		
		// 回転設定（ラジアン角）
		CGAffineTransform af =
			CGAffineTransformMakeRotation(rol * M_PI / 180.0f);
		
		// 変換処理
		self.ivTarget.transform = af;
	};
	
	// アニメーション終了時処理
	void (^cmp)(BOOL) = ^(BOOL finished) {
		
		// 変換解除処理
		self.ivTarget.transform = CGAffineTransformIdentity;
	};
	
	// アニメーション実行
	[UIView animateWithDuration:1.0
					 animations:ani
					 completion:cmp];
}

// ブロックアニメーション：アフィン変換 - 移動
- (void)doAnimation03b {
	
	// アニメーション対象処理
	void (^ani)(void) = ^(void) {
		
		// 移動設定（移動量x,y）
		CGAffineTransform af =
			CGAffineTransformMakeTranslation(100.0f, 100.0f);
		
		// 変換処理
		self.ivTarget.transform = af;
	};
	
	// アニメーション終了時処理
	void (^cmp)(BOOL) = ^(BOOL finished) {
		
		// 変換解除処理
		self.ivTarget.transform = CGAffineTransformIdentity;
	};
	
	// アニメーション実行
	[UIView animateWithDuration:1.0
					 animations:ani
					 completion:cmp];
}

// ブロックアニメーション：アフィン変換 - 伸縮
- (void)doAnimation03c {
	
	// アニメーション対象処理
	void (^ani)(void) = ^(void) {
		
		// 伸縮設定（倍率x,y）
		CGAffineTransform af =
			CGAffineTransformMakeScale(3.0f, 3.0f); // 0.5 2.0
		
		// 変換処理
		self.ivTarget.transform = af;
	};
	
	// アニメーション終了時処理
	void (^cmp)(BOOL) = ^(BOOL finished) {
		
		// 変換解除処理
		self.ivTarget.transform = CGAffineTransformIdentity;
	};
	
	// アニメーション実行 animateWithDuration:2.0 表示時間
	[UIView animateWithDuration:2.0
					 animations:ani
					 completion:cmp];
}

// ブロックアニメーション：アフィン変換 - 複合
- (void)doAnimation03d {
	
	// アニメーション対象処理
	void (^ani)(void) = ^(void) {
		
		// 回転設定（ラジアン角）
		CGAffineTransform af01 =
			CGAffineTransformMakeRotation(180.0f * M_PI / 180.0f);
		
		// 移動設定（移動量x,y）
		CGAffineTransform af02 =
			CGAffineTransformMakeTranslation(100.0f, 100.0f);

		// 伸縮設定（倍率x,y）
		CGAffineTransform af03 =
			CGAffineTransformMakeScale(0.5f, 2.0f);
		
		// 処理の合成
		CGAffineTransform af;
		af = CGAffineTransformConcat(af01, af02);
		af = CGAffineTransformConcat(af, af03);
		
		// 変換処理
		self.ivTarget.transform = af;
	};
	
	// アニメーション終了時処理
	void (^cmp)(BOOL) = ^(BOOL finished) {
		
		// 変換解除処理
		self.ivTarget.transform = CGAffineTransformIdentity;
	};
	
	// アニメーション実行
	[UIView animateWithDuration:1.0
					 animations:ani
					 completion:cmp];
}


#pragma mark - Own Method（ブロックアニメーション：トランジション）

// ブロックアニメーション：トランジション - 回転
- (void)doAnimation04a {
	
	// アニメーション対象処理
	void (^ani)(void) = ^(void) {
		
		// トランジション設定
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
							   forView:self.ivTarget
								 cache:YES];
		
		// 画像の変更
		self.ivTarget.image = [UIImage imageNamed:@"Image01.png"];
	};
	
	// アニメーション実行
	[UIView animateWithDuration:1.0
					 animations:ani];
}

// ブロックアニメーション：トランジション - ページめくり
- (void)doAnimation04b {
	
	// アニメーション対象処理
	void (^ani)(void) = ^(void) {
		
		// トランジション設定
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
							   forView:self.ivTarget
								 cache:YES];
		
		// 画像の変更
		self.ivTarget.image = [UIImage imageNamed:@"Image01.png"];
	};
	
	// アニメーション実行
	[UIView animateWithDuration:1.0
					 animations:ani];
}

@end
