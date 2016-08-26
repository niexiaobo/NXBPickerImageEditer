[![Wercker](https://img.shields.io/wercker/ci/wercker/docs.svg?maxAge=2592000)]()
[![License](https://img.shields.io/github/license/bang590/JSPatch.svg?style=flat)](https://github.com/bang590/JSPatch/blob/master/LICENSE)

# pickerImageEditer
图片选择器，自定义截图，拖动矩形框，返回需要的图片形状
pickerImageEditer
添加文件 XBPickerImageEditer 到项目中

1、控制器设置

        //1、导入头文件
        #import "XBEditPhotoView.h"
        #import "XBImagePicker.h"

        //2、代理和属性设置
        @interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,XBEditPhotoDelegate,UIActionSheetDelegate>
        @property (nonatomic, strong) XBEditPhotoView *backView;
        @property (nonatomic, strong) XBImagePicker *imagePicker;

        @property (nonatomic, strong) UIImageView *editImage;
        @end

        //3、添加 UIImageView 和 按钮 做测试
        - (void)viewDidLoad {
        [super viewDidLoad];
        self.view.backgroundColor = [UIColor whiteColor];
        _editImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, screenWidth, 200)];
        [self.view addSubview:_editImage];
        _editImage.contentMode = UIViewContentModeScaleToFill;
        _editImage.layer.borderWidth = 1;
        _editImage.layer.borderColor = [UIColor grayColor].CGColor;
        UIButton *selectBtn = [[UIButton alloc]initWithFrame:CGRectMake((screenWidth - 100)/2.0, 350, 100, 60)];
        [selectBtn setTitle:@"选择图片" forState:0];
        [selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
        selectBtn.backgroundColor = [UIColor redColor];
        [self.view addSubview:selectBtn];

        }

2、按钮事件 和 代理事件方法

        //相关方法如下
        #pragma mark 选择图片 按钮事件
        - (void)selectBtnClick {
        self.imagePicker = [[XBImagePicker alloc]init];
        [self.imagePicker selectImageWith:self];
        }

        #pragma mark - 弹框点击事件
        - (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
        if (buttonIndex == 0) {//从相册选择
        [self.imagePicker imageBtnClick];
        } else if (buttonIndex == 1) {//打开相机
        [self.imagePicker cameraBtnClick];
        } else {
        return;
        }
        }

        #pragma mark -相册代理
        - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];

        //可编辑区域
        _backView = [[XBEditPhotoView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andWithImage:image];
        _backView.delegate = self;

        _backView.userInteractionEnabled = YES;
        _backView.center = self.view.center;
        [[UIApplication sharedApplication].keyWindow addSubview:_backView];

        }

        #pragma mark -XBEditPhotoView 代理 取消 确定 按钮
        - (void)editPhotoViewSureCancelBtnClick:(UIButton*)SureCancelBtn {
        if (SureCancelBtn.tag == 1) {//确定
        UIImage *uiImage = [self.backView graphicsEditImage];
        _editImage.image = uiImage;
        _editImage.width = uiImage.size.width;
        _editImage.height = uiImage.size.height;
        } else {//取消
        }

        [self dismissViewControllerAnimated:YES completion:nil];

        [_backView removeFromSuperview];
        }
3、截图

