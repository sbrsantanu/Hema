//
//  PEditProfile.m
//  Hema
//
//  Created by Mac on 13/01/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "PEditProfile.h"
#import "RMPickerViewController.h"
#import "UIColor+HexColor.h"
#import "UITextField+Attribute.h"
#import "UITextView+Extentation.h"

typedef enum
{
    SelectionTypeNone,
    SelectionTypeGroup,
    SelectionTypeState
} SelectionType;

typedef enum {
    SubscribeMeTypeNone,
    SubscribeMeTypeYes
} SubscribeMe;

@interface PEditProfile ()<UIScrollViewDelegate,UITextFieldDelegate,RMPickerViewControllerDelegate,UIAlertViewDelegate,UITextViewDelegate>

@property (nonatomic,retain) UIScrollView *MainScrollView;
@property (nonatomic,retain) UIView *HeaderNavigationViewBackgroundView;
@property (nonatomic,retain) NSArray *RGroupArray;
@property (nonatomic,retain) NSArray *RStateArray;
@property (nonatomic,retain) NSArray *RStateShortCodeArray;
@property (assign) SelectionType DropdownSelectionMode;

// All fields

@property (nonatomic,retain) UITextField * TFSelectAgroup;
@property (nonatomic,retain) UITextField * TFName;
@property (nonatomic,retain) UITextField * TFMobile;
@property (nonatomic,retain) UITextField * TFofficephone;
@property (nonatomic,retain) UITextField * TFfax;
@property (nonatomic,retain) UITextField * TFTitle;
@property (nonatomic,retain) UITextField * TFAssignedto;
@property (nonatomic,retain) UITextField * TFAddress;
@property (nonatomic,retain) UITextField * TFcity;
@property (nonatomic,retain) UITextField * TFstate;
@property (nonatomic,retain) UITextField * TFzip;
@property (nonatomic,retain) UITextField * TFemail;
@property (nonatomic,retain) UITextField * TFPassword;
@property (nonatomic,retain) UITextField * TFCPassword;
@property (nonatomic,retain) UITextView  * TVDescription;
@property (nonatomic,retain) UITextView  * TVServicerequired;
@property (nonatomic,retain) UITextField * TFleadsource;
@property (nonatomic,retain) UIButton    * SubscribeMebutton;

@property (nonatomic,retain) UIButton * SubmitButton;

@property (nonatomic,retain) SDAPlaceholderTextView *DescriptionTextView;
@property (nonatomic,retain) SDAPlaceholderTextView *ServiceRequiredTextView;

@property (nonatomic,retain) NSArray *CurrencyArray;

@property (assign) SubscribeMe SubscribeMeType;
@end

@implementation PEditProfile

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:[self UIViewSetHeaderViewWithbackButton:YES]];
    [self.view addSubview:[self UIViewSetFooterView]];
    [self.view addSubview:[self UIViewSetHeaderNavigationViewWithSelectedTab:@"Dashboard"]];
    
     NSArray *DataArray = [[NSArray alloc] initWithObjects:@"Name",@"Phone Number",@"Description",@"Website",@"Logo",@"Sales Tax (%)",@"Service Tax (%)",@"Vat (%)",@"Currency",@"Delivery Mode",@"Questions",@"Minimum Delivery Time",@"Minimum Billing Value",@"Maximum Billing Value",@"Delivery Charge",@"Business Days",@"Business Hours",@"Allow Advance Order", nil];
    
    self.CurrencyArray = [[NSArray alloc] initWithObjects:
                          @"Afghani(AFN)",
                          @"Lek(ALL)",
                          @"Dinar(DZD)",
                          @"Dollar(USD)",
                          @"Euro(EUR)",
                          @"Kwanza(AOA)",
                          @"Dollar(XCD)",
                          @"Dollar(XCD)",
                          @"Peso(ARS)",
                          @"Dram(AMD)",
                          @"Guilder(AWG)",
                          @"Dollar(AUD)",
                          @"Euro(EUR)",
                          @"Manat(AZN)",
                          @"Dollar(BSD)",
                          @"Dinar(BHD)",
                          @"Taka(BDT)",
                          @"Dollar(BBD)",
                          @"Ruble(BYR)",
                          @"Euro(EUR)",
                          @"Dollar(BZD)",
                          @"Franc(XOF)",
                          @"Dollar(BMD)",
                          @"Ngultrum(BTN)",
                          @"Boliviano(BOB)",
                          @"Marka(BAM)",
                          @"Pula(BWP)",
                          @"Krone(NOK)",
                          @"Real(BRL)",
                          @"Dollar(USD)",
                          @"Dollar(USD)",
                          @"Dollar(BND)",
                          @"Lev(BGN)",
                          @"Franc(XOF)",
                          @"Franc(BIF)",
                          @"Riels(KHR)",
                          @"Franc(XAF)",
                          @"Dollar(CAD)",
                          @"Escudo(CVE)",
                          @"Dollar(KYD)",
                          @"Franc(XAF)",
                          @"Franc(XAF)",
                          @"Peso(CLP)",
                          @"Yuan Renminbi(CNY)",
                          @"Dollar(AUD)",
                          @"Dollar(AUD)",
                          @"Peso(COP)",
                          @"Franc(KMF)",
                          @"Dollar(NZD)",
                          @"Colon(CRC)",
                          @"Kuna(HRK)",
                          @"Peso(CUP)",
                          @"Pound(CYP)",
                          @"Koruna(CZK)",
                          @"Franc(CDF)",
                          @"Krone(DKK)",
                          @"Franc(DJF)",
                          @"Dollar(XCD)",
                          @"Peso(DOP)",
                          @"Dollar(USD)",
                          @"Dollar(USD)",
                          @"Pound(EGP)",
                          @"Colone(SVC)",
                          @"Franc(XAF)",
                          @"Nakfa(ERN)",
                          @"Kroon(EEK)",
                          @"Birr(ETB)",
                          @"Pound(FKP)",
                          @"Krone(DKK)",
                          @"Dollar(FJD)",
                          @"Euro(EUR)",
                          @"Euro(EUR)",
                          @"Euro(EUR)",
                          @"Franc(XPF)",
                          @"Euro  (EUR)",
                          @"Franc(XAF)",
                          @"Dalasi(GMD)",
                          @"Lari(GEL)",
                          @"Euro(EUR)",
                          @"Cedi(GHC)",
                          @"Pound(GIP)",
                          @"Euro(EUR)",
                          @"Krone(DKK)",
                          @"Dollar(XCD)",
                          @"Euro(EUR)",
                          @"Dollar(USD)",
                          @"Quetzal(GTQ)",
                          @"Franc(GNF)",
                          @"Franc(XOF)",
                          @"Dollar(GYD)",
                          @"Gourde(HTG)",
                          @"Dollar(AUD)",
                          @"Lempira(HNL)",
                          @"Dollar(HKD)",
                          @"Forint(HUF)",
                          @"Krona(ISK)",
                          @"Rupee(INR)",
                          @"Rupiah(IDR)",
                          @"Rial(IRR)",
                          @"Dinar(IQD)",
                          @"Euro(EUR)",
                          @"Shekel(ILS)",
                          @"Euro(EUR)",
                          @"Franc(XOF)",
                          @"Dollar(JMD)",
                          @"Yen(JPY)",
                          @"Dinar(JOD)",
                          @"Tenge(KZT)",
                          @"Shilling(KES)",
                          @"Dollar(AUD)",
                          @"Dinar(KWD)",
                          @"Som(KGS)",
                          @"Kip(LAK)",
                          @"Lat(LVL)",
                          @"Pound(LBP)",
                          @"Loti(LSL)",
                          @"Dollar(LRD)",
                          @"Dinar(LYD)",
                          @"Franc(CHF)",
                          @"Litas(LTL)",
                          @"Euro(EUR)",
                          @"Pataca(MOP)",
                          @"Denar(MKD)",
                          @"Ariary(MGA)",
                          @"Kwacha(MWK)",
                          @"Ringgit(MYR)",
                          @"Rufiyaa(MVR)",
                          @"Franc(XOF)",
                          @"Lira(MTL)",
                          @"Dollar(USD)",
                          @"Euro(EUR)",
                          @"Ouguiya(MRO)",
                          @"Rupee(MUR)",
                          @"Euro(EUR)",
                          @"Peso(MXN)",
                          @"Dollar(USD)",
                          @"Leu(MDL)",
                          @"Euro(EUR)",
                          @"Tugrik(MNT)",
                          @"Dollar(XCD)",
                          @"Dirham(MAD)",
                          @"Meticail(MZN)",
                          @"Kyat(MMK)",
                          @"Dollar(NAD)",
                          @"Dollar(AUD)",
                          @"Rupee(NPR)",
                          @"Euro(EUR)",
                          @"Guilder(ANG)",
                          @"Franc(XPF)",
                          @"Dollar(NZD)",
                          @"Cordoba(NIO)",
                          @"Franc(XOF)",
                          @"Naira(NGN)",
                          @"Dollar(NZD)",
                          @"Dollar(AUD)",
                          @"Won(KPW)",
                          @"Dollar(USD)",
                          @"Krone(NOK)",
                          @"Rial(OMR)",
                          @"Rupee(PKR)",
                          @"Dollar(USD)",
                          @"Shekel(ILS)",
                          @"Balboa(PAB)",
                          @"Kina(PGK)",
                          @"Guarani(PYG)",
                          @"Sol(PEN)",
                          @"Peso(PHP)",
                          @"Dollar(NZD)",
                          @"Zloty(PLN)",
                          @"Euro(EUR)",
                          @"Dollar(USD)",
                          @"Rial(QAR)",
                          @"Franc(XAF)",
                          @"Euro(EUR)",
                          @"Leu(RON)",
                          @"Ruble(RUB)",
                          @"Franc(RWF)",
                          @"Pound(SHP)",
                          @"Dollar(XCD)",
                          @"Dollar(XCD)",
                          @"Euro(EUR)",
                          @"Dollar(XCD)",
                          @"Tala(WST)",
                          @"Euro(EUR)",
                          @"Dobra(STD)",
                          @"Rial(SAR)",
                          @"Franc(XOF)",
                          @"Dinar(RSD)",
                          @"Rupee(SCR)",
                          @"Leone(SLL)",
                          @"Dollar(SGD)",
                          @"Koruna(SKK)",
                          @"Euro(EUR)",
                          @"Dollar(SBD)",
                          @"Shilling(SOS)",
                          @"Rand(ZAR)",
                          @"Pound(GBP)",
                          @"Won(KRW)",
                          @"Euro(EUR)",
                          @"Rupee(LKR)",
                          @"Dinar(SDD)",
                          @"Dollar(SRD)",
                          @"Krone(NOK)",
                          @"Lilangeni(SZL)",
                          @"Krona(SEK)",
                          @"Franc(CHF)",
                          @"Pound(SYP)",
                          @"Dollar(TWD)",
                          @"Somoni(TJS)",
                          @"Shilling(TZS)",
                          @"Baht(THB)",
                          @"Franc(XOF)",
                          @"Dollar(NZD)",
                          @"Pa'anga(TOP)",
                          @"Dollar(TTD)",
                          @"Dinar(TND)",
                          @"Lira(TRY)",
                          @"Manat(TMM)",
                          @"Dollar(USD)",
                          @"Dollar(AUD)",
                          @"Dollar(USD)",
                          @"Shilling(UGX)",
                          @"Hryvnia(UAH)",
                          @"Dirham(AED)",
                          @"Pound(GBP)",
                          @"Dollar(USD)",
                          @"Dollar (USD)",
                          @"Peso(UYU)",
                          @"Som(UZS)",
                          @"Vatu(VUV)",
                          @"Euro(EUR)",
                          @"Bolivar(VEF)",
                          @"Dong(VND)",
                          @"Franc(XPF)",
                          @"Dirham(MAD)",
                          @"Rial(YER)",
                          @"Kwacha(ZMK)",
                          @"Dollar(ZWD)",
                          nil];
    
    _MainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height-150)];
    [_MainScrollView setUserInteractionEnabled:YES];
    [_MainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1200)];
    [_MainScrollView setDelegate:self];
    [self.view addSubview:_MainScrollView];
    
    UILabel *WelcomeMessage = [[UILabel alloc] initWithFrame:CGRectMake(10, 15,  self.view.frame.size.width-10, 20)];
    [WelcomeMessage setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [WelcomeMessage setTextColor:[UIColor darkGrayColor]];
    [WelcomeMessage setBackgroundColor:[UIColor clearColor]];
    [WelcomeMessage setTextAlignment:NSTextAlignmentLeft];
    [WelcomeMessage setText:@"Edit Profile"];
    [_MainScrollView addSubview:WelcomeMessage];
    
    UILabel *WelcomeUnderline = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, self.view.frame.size.width-20, 1)];
    [WelcomeUnderline setBackgroundColor:[UIColor lightGrayColor]];
    [_MainScrollView addSubview:WelcomeUnderline];
    
    _RGroupArray = [[NSArray alloc] initWithObjects:@"Company",@"Individuals",@"Organizations",@"Families", nil];
    _RStateArray = [[NSArray alloc] initWithObjects:
                    @"Alabama",
                    @"Alaska",
                    @"Arizona",
                    @"Arkansas",
                    @"California",
                    @"Colorado",
                    @"Connecticut",
                    @"Delaware",
                    @"District of Columbia",
                    @"Florida",
                    @"Georgia",
                    @"Hawaii",
                    @"Idaho",
                    @"Illinois",
                    @"Indiana",
                    @"Iowa",
                    @"Kansas",
                    @"Kentucky",
                    @"Louisiana",
                    @"Maine",
                    @"Maryland",
                    @"Massachusetts",
                    @"Michigan",
                    @"Minnesota",
                    @"Mississippi",
                    @"Missouri",
                    @"Montana",
                    @"Nebraska",
                    @"Nevada",
                    @"New Hampshire",
                    @"New Jersey",
                    @"New Mexico",
                    @"New York",
                    @"North Carolina",
                    @"North Dakota",
                    @"Ohio",
                    @"Oklahoma",
                    @"Oregon",
                    @"Pennsylvania",
                    @"Puerto Rico",
                    @"Rhode Island",
                    @"South Carolina",
                    @"South Dakota",
                    @"Tennessee",
                    @"Texas",
                    @"Utah",
                    @"Vermont",
                    @"Virginia",
                    @"Washington",
                    @"West Virginia",
                    @"Wisconsin",
                    @"Wyoming",
                    nil];
    
    _RStateShortCodeArray = [[NSArray alloc] initWithObjects:
                             @"AL",
                             @"AK",
                             @"AZ",
                             @"AR",
                             @"CA",
                             @"CO",
                             @"CT",
                             @"DE",
                             @"DC",
                             @"FL",
                             @"GA",
                             @"HI",
                             @"ID",
                             @"IL",
                             @"IN",
                             @"IA",
                             @"KS",
                             @"KY",
                             @"LA",
                             @"ME",
                             @"MD",
                             @"MA",
                             @"MI",
                             @"MN",
                             @"MS",
                             @"MO",
                             @"MT",
                             @"NE",
                             @"NV",
                             @"NH",
                             @"NJ",
                             @"NM",
                             @"NY",
                             @"NC",
                             @"ND",
                             @"OH",
                             @"OK",
                             @"OR",
                             @"PA",
                             @"PR",
                             @"RI",
                             @"SC",
                             @"SD",
                             @"TN",
                             @"TX",
                             @"UT",
                             @"VT",
                             @"VA",
                             @"WA",
                             @"WV",
                             @"WI",
                             @"WY",
                             nil];
    
    _DropdownSelectionMode = SelectionTypeNone;
    _SubscribeMeType = SubscribeMeTypeNone;
    
    float StatingYPosition          = 50.0f;
    float Difference                = 50.0f;
    float LastPosition              = 50.0f;
    int nextdatatag                 = 2001;
    float TextfieldWidth            = self.view.frame.size.width-40;
    float TextfieldHeight           = 40;
    float TextfieldXposition        = 20;
    float SubmitButtonWidth         = 140.0f;
    float SubmitButtonHeight        = 40.0f;
    float SubmitButtonxposition     = (self.view.frame.size.width-SubmitButtonWidth)/2;
    
    // Select A group -- dropdown *
    
    self.TFSelectAgroup = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, StatingYPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFSelectAgroup customizeDropdownFieldWithPlaceholderText:@"Select A group" andLeftBarText:@""];
    [self.TFSelectAgroup setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFSelectAgroup];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    // Name *
    
    self.TFName = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFName customizeWithPlaceholderText:@"Name" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.TFName setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFName];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    // Mobile *
    
    self.TFMobile = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFMobile customizeWithPlaceholderText:@"Mobile" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.TFMobile setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFMobile];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    // office phone *
    
    self.TFofficephone = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFofficephone customizeWithPlaceholderText:@"Office Phone" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.TFofficephone setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFofficephone];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    // fax
    
    self.TFfax = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFfax customizeWithPlaceholderText:@"Fax" andImageOnRightView:nil andLeftBarText:nil];
    [self.TFfax setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFfax];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    // Title
    
    self.TFTitle = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFTitle customizeWithPlaceholderText:@"Title" andImageOnRightView:nil andLeftBarText:nil];
    [self.TFTitle setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFTitle];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    //Assigned to
    
    self.TFAssignedto = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFAssignedto customizeWithPlaceholderText:@"Assigned To" andImageOnRightView:nil andLeftBarText:nil];
    [self.TFAssignedto setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFAssignedto];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    // Address *
    
    self.TFAddress = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFAddress customizeWithPlaceholderText:@"Address" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.TFAddress setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFAddress];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    // city *
    
    self.TFcity = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFcity customizeWithPlaceholderText:@"City" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.TFcity setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFcity];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    // Please Select A state *
    
    self.TFstate = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFstate customizeDropdownFieldWithPlaceholderText:@"Select A State" andLeftBarText:@""];
    [self.TFstate setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFstate];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    // zip code *
    
    self.TFzip = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFzip customizeWithPlaceholderText:@"Zip Code" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.TFzip setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFzip];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    // Email *
    
    self.TFemail = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFemail customizeWithPlaceholderText:@"Email" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.TFemail setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFemail];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    // Password *
    
    self.TFPassword = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFPassword customizeWithPlaceholderText:@"Password" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.TFPassword setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFPassword];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    // Confirm Password *
    
    self.TFCPassword = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFCPassword customizeWithPlaceholderText:@"Confirm Password" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.TFCPassword setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFCPassword];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    // Description
    
    self.DescriptionTextView = [[SDAPlaceholderTextView alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, 100)];
    [self.DescriptionTextView setPlaceholder:@"Description"];
    [self.DescriptionTextView setPlaceholderColor:[UIColor colorFromHex:0x755049]];
    [self.DescriptionTextView setTag:nextdatatag];
    [_MainScrollView addSubview:self.DescriptionTextView];
    
    LastPosition = LastPosition + 60 + Difference;
    nextdatatag  = nextdatatag +1;
    
    // Service required
    
    self.ServiceRequiredTextView = [[SDAPlaceholderTextView alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, 100)];
    [self.ServiceRequiredTextView setPlaceholder:@"Service Required"];
    [self.ServiceRequiredTextView setPlaceholderColor:[UIColor colorFromHex:0x755049]];
    [self.ServiceRequiredTextView setTag:nextdatatag];
    [_MainScrollView addSubview:self.ServiceRequiredTextView];
    
    LastPosition = LastPosition + 60 + Difference;
    nextdatatag  = nextdatatag +1;
    
    // lead source
    
    self.TFleadsource = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.TFleadsource customizeWithPlaceholderText:@"Lead Source" andImageOnRightView:nil andLeftBarText:nil];
    [self.TFleadsource setTag:nextdatatag];
    [_MainScrollView addSubview:self.TFleadsource];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    
    // Subscribe me
    
    _SubscribeMebutton = [[UIButton alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, 22, 22)];
    [_SubscribeMebutton setBackgroundColor:[UIColor clearColor]];
    [_SubscribeMebutton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [_SubscribeMebutton addTarget:self action:@selector(SubscribeMe:) forControlEvents:UIControlEventTouchUpInside];
    [_MainScrollView addSubview:_SubscribeMebutton];
    
    UILabel *RemembermeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, LastPosition, 200, 22)];
    [RemembermeLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [RemembermeLabel setText:@"Subscribe Me"];
    [RemembermeLabel setTextColor:[UIColor colorFromHex:0xe66a4c]];
    [_MainScrollView addSubview:RemembermeLabel];
    
    // Find Now Button
    
    _SubmitButton = [[UIButton alloc] initWithFrame:CGRectMake(SubmitButtonxposition ,LastPosition+50, SubmitButtonWidth, SubmitButtonHeight)];
    [_SubmitButton setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [_SubmitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [_SubmitButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [_SubmitButton.layer setCornerRadius:3.0f];
    [_SubmitButton addTarget:self action:@selector(RegistrationProcess:) forControlEvents:UIControlEventTouchUpInside];
    [_SubmitButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [_SubmitButton setTag:104];
    [_MainScrollView addSubview:_SubmitButton];
    
    // Submit
    
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)aSubView;
            [textField setDelegate:self];
            NSLog(@"UITextField ---- %ld",(long)textField.tag);
        }
    }
    
    for(id ASubview in [_MainScrollView subviews])
    {
        if([ASubview isKindOfClass:[UITextView class]])
        {
            UITextView *textView = (UITextView *)ASubview;
            [textView setDelegate:self];
            [textView.layer setBorderColor:[UIColor colorFromHex:0xe66a4c].CGColor];
            [textView.layer setBorderWidth:1.0f];
            NSLog(@"textView ---- %ld",(long)textView.tag);
        }
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)openPickerController:(UITextField *)sender {
    
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)aSubView;
            [textField resignFirstResponder];
        }
    }
    
    RMPickerViewController *pickerVC = [RMPickerViewController pickerController];
    pickerVC.delegate = self;
    pickerVC.titleLabel.text = @"Please choose a row and press 'Select' or 'Cancel'.";
    if (sender.tag == 2001) {
        _DropdownSelectionMode = SelectionTypeGroup;
    } else if (sender.tag == 2010) {
        _DropdownSelectionMode = SelectionTypeState;
    }
    [pickerVC show];
}

#pragma mark - UITextField Delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 2001) {
        
        for(id aSubView in [_MainScrollView subviews])
        {
            if([aSubView isKindOfClass:[UITextField class]])
            {
                UITextField *textField=(UITextField*)aSubView;
                [textField resignFirstResponder];
            }
        }
        [self openPickerController:textField];
        
        return NO;
    } else if (textField.tag == 2010) {
        
        for(id aSubView in [_MainScrollView subviews])
        {
            if([aSubView isKindOfClass:[UITextField class]])
            {
                UITextField *textField=(UITextField*)aSubView;
                [textField resignFirstResponder];
            }
        }
        [self openPickerController:textField];
        return NO;
    } else if (textField.tag == 2002) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 80) animated:YES];
        }];
    } else if (textField.tag == 2003) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 120) animated:YES];
        }];
    } else if (textField.tag == 2004) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 160) animated:YES];
        }];
    } else if (textField.tag == 2005) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 200) animated:YES];
        }];
    } else if (textField.tag == 2006) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 240) animated:YES];
        }];
    } else if (textField.tag == 2007) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 280) animated:YES];
        }];
    } else if (textField.tag == 2008) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 320) animated:YES];
        }];
    } else if (textField.tag == 2009) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 360) animated:YES];
        }];
    } else if (textField.tag == 2011) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 440) animated:YES];
        }];
    } else if (textField.tag == 2012) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 480) animated:YES];
        }];
    } else if (textField.tag == 2013) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 520) animated:YES];
        }];
    } else if (textField.tag == 2014) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 560) animated:YES];
        }];
    } else if (textField.tag == 2017) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 800) animated:YES];
        }];
    }
    return YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)aSubView;
            [textField resignFirstResponder];
        }
    }
    _DropdownSelectionMode = SelectionTypeNone;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:1.0f animations:^(void){
        //[_MainScrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    }];
    [textField resignFirstResponder];
    _DropdownSelectionMode = SelectionTypeNone;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

#pragma mark - RMPickerViewController Delegates

- (void)pickerViewController:(RMPickerViewController *)vc didSelectRows:(NSArray *)selectedRows
{
    if (_DropdownSelectionMode == SelectionTypeGroup) {
        [self.TFSelectAgroup setText:[NSString stringWithFormat:@"%@",[_RGroupArray objectAtIndex:[[selectedRows objectAtIndex:0] intValue]]]];
    } else if (_DropdownSelectionMode == SelectionTypeState) {
        [self.TFstate setText:[NSString stringWithFormat:@"%@", [_RStateArray objectAtIndex:[[selectedRows objectAtIndex:0] intValue]]]];
    }
    _DropdownSelectionMode = SelectionTypeNone;
}

- (void)pickerViewControllerDidCancel:(RMPickerViewController *)vc
{
    _DropdownSelectionMode = SelectionTypeNone;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_DropdownSelectionMode == SelectionTypeGroup) {
        return [_RGroupArray count];
    } else {
        return [_RStateArray count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_DropdownSelectionMode == SelectionTypeGroup) {
        return [_RGroupArray objectAtIndex:row];
    } else {
        return [_RStateArray objectAtIndex:row];
    }
}

#pragma mark remove keyboard while clicking on return key

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma SubscribeMe button action

-(IBAction)SubscribeMe:(UIButton *)sender
{
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textfield=(UITextField*)aSubView;
            [textfield resignFirstResponder];
        }
    }
    
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextView class]])
        {
            UITextView *textView=(UITextView*)aSubView;
            [textView resignFirstResponder];
        }
    }
    
    if (_SubscribeMeType == SubscribeMeTypeNone) {
        [_SubscribeMebutton setImage:[UIImage imageNamed:@"tick.png"] forState:UIControlStateNormal];
        _SubscribeMeType = SubscribeMeTypeYes;
    } else {
        [_SubscribeMebutton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        _SubscribeMeType = SubscribeMeTypeNone;
    }
}

#pragma mark textview begin editing

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 2015) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 640) animated:YES];
        }];
    } else if (textView.tag == 2016) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 640) animated:YES];
        }];
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)aSubView;
            [textField resignFirstResponder];
        }
    }
    
    if (textView.tag == 2015) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 640) animated:YES];
        }];
    } else if (textView.tag == 2016) {
        [UIView animateWithDuration:1.0f animations:^(void){
            [_MainScrollView setContentOffset:CGPointMake(0, 640) animated:YES];
        }];
    }
    return YES;
}

#pragma match register clicekd

-(IBAction)RegistrationProcess:(id)sender
{
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textfield = (UITextField*)aSubView;
            [textfield resignFirstResponder];
        }
    }
    
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextView class]])
        {
            UITextView *textView=(UITextView*)aSubView;
            [textView resignFirstResponder];
        }
    }
}

@end

