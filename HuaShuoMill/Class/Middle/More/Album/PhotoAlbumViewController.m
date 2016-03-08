//
//  PhotoAlbumViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 16/1/18.
//  Copyright © 2016年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "PhotoAlbumViewController.h"
#import "PhotoAlbumCell.h"
#import "PhotoAlbumModel.h"

#import "MJPhotoBrowser.h"

#define  PhotoAlbumCellID @"PhotoAlbumCell"
#define kColOfMargin 10

#define kColOfRow 3
#define kCellSizeH 180
#define kCellSizeW ([UIScreen mainScreen].bounds.size.width - 4*kColOfMargin)/kColOfRow

@interface PhotoAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    int pageindex;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation PhotoAlbumViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupConfigeCollectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView setBackgroundColor:RGBColor(239,239,244)];
    
    __weak typeof(self) mySelf = self;
    //头部视图
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [mySelf performSelector:@selector(loadData:) withObject:[NSNumber numberWithBool:NO] afterDelay:0.1f];
    }];
    
    //尾部视图
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [mySelf performSelector:@selector(loadData:) withObject:[NSNumber numberWithBool:YES] afterDelay:0.1];
    }];
    
    self.collectionView.mj_footer.hidden = YES;
    //自动刷新
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - 配置collectionView
- (void)setupConfigeCollectionView
{
    //1.流水布局
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    //UICollectionViewFlowLayout  *layout = (UICollectionViewFlowLayout
    //                                        *)self.collectionView.collectionViewLayout;
    //2.每个cell的尺寸
    CGFloat cellWidth = kCellSizeW;
    layout.itemSize = CGSizeMake(cellWidth, kCellSizeH);
    //3.设置cell之间的垂直间距
    layout.minimumLineSpacing = kColOfMargin;
    //4.设置cell之间的水平间距
    layout.minimumInteritemSpacing = kColOfMargin;
    //5.设置四周的内边距
    layout.sectionInset = UIEdgeInsetsMake(kColOfMargin, kColOfMargin, kColOfMargin, kColOfMargin);
    
    //layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    //1.注册cell(告诉collectionView将来创建怎样的cell)
    UINib *nib = [UINib nibWithNibName:PhotoAlbumCellID bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:PhotoAlbumCellID];
}



- (void)loadData:(NSNumber*)more
{
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    
    if(more.boolValue == YES)
    {
        pageindex++;
    }
    else
    {
        pageindex = 1;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [XHMDataService getRequestWithURL:API_photos_index params:params isShowLoading:YES successBlock:^(id result) {
        
        if (pageindex == 1) {
            [self.dataArray removeAllObjects];
        }
        //列表数据
        NSMutableArray *categoriesArray = [result objectForKey:@"photos"];
        for (NSMutableDictionary *photoAlbumDic in categoriesArray) {
            PhotoAlbumModel *photoAlbumModel = [[PhotoAlbumModel alloc] init];
            [photoAlbumModel setValuesForKeysWithDictionary:photoAlbumDic];
            [self.dataArray addObject:photoAlbumModel];
        }
        
        [self.collectionView reloadData];
        if([categoriesArray count]>=10)
        {
            self.collectionView.mj_footer.hidden = NO;
            
        }
        else
        {
            self.collectionView.mj_footer.hidden = YES;
            
        }
        
        self.isLoading = NO;
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
    } errorBlock:^(NSError *error) {
        
        self.isLoading = NO;
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
    }];
    
}



#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获得cell
    PhotoAlbumCell *cell = (PhotoAlbumCell *)[collectionView dequeueReusableCellWithReuseIdentifier:PhotoAlbumCellID forIndexPath:indexPath];
    
    PhotoAlbumModel *photoAlbumModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.photoAlbumModel = photoAlbumModel;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    PhotoAlbumCell *cell = (PhotoAlbumCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    //PhotoAlbumModel *photoAlbumModel = [self.dataArray objectAtIndex:indexPath.row];
    
    long count = self.dataArray.count;
    
    //1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i=0; i<count; i++) {
        //一个photo对应的一张图片
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        photo.srcImageView = cell.headImageView; // 来源于哪个UIImageView
        //Photo *photoModel = self.photos[i];
        PhotoAlbumModel *photoAlbumModel = [self.dataArray objectAtIndex:i];
        NSString *photoUrl = photoAlbumModel.fullsize;
        photo.url = [NSURL URLWithString:photoUrl];
        [myphotos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = indexPath.item; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
