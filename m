From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 12 Mar 2011 15:34:44 +0000
Subject: Re: [PATCH] video via: make local variables static
Message-Id: <4D7B9294.7000005@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110303100008.2a288941@nehalam>
In-Reply-To: <20110303100008.2a288941@nehalam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Stephen Hemminger schrieb:
> Many local variables should be declared static.
> Found by sparse, compile tested only.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

Applied. Thanks,


Florian Tobias Schandinat

> 
> ---
> 
>  drivers/video/via/hw.c       |    2 
>  drivers/video/via/lcd.c      |   10 ++--
>  drivers/video/via/via_i2c.c  |    2 
>  drivers/video/via/viafbdev.c |    6 +-
>  drivers/video/via/viamode.c  |  100 +++++++++++++++++++++----------------------
>  5 files changed, 61 insertions(+), 59 deletions(-)
> 
> --- a/drivers/video/via/lcd.c	2011-03-03 09:43:23.529389476 -0800
> +++ b/drivers/video/via/lcd.c	2011-03-03 09:44:07.241570863 -0800
> @@ -26,10 +26,12 @@
>  
>  /* CLE266 Software Power Sequence */
>  /* {Mask}, {Data}, {Delay} */
> -int PowerSequenceOn[3][3] = { {0x10, 0x08, 0x06}, {0x10, 0x08, 0x06},
> -	{0x19, 0x1FE, 0x01} };
> -int PowerSequenceOff[3][3] = { {0x06, 0x08, 0x10}, {0x00, 0x00, 0x00},
> -	{0xD2, 0x19, 0x01} };
> +static const int PowerSequenceOn[3][3] = {
> +	{0x10, 0x08, 0x06}, {0x10, 0x08, 0x06},	{0x19, 0x1FE, 0x01}
> +};
> +static const int PowerSequenceOff[3][3] = {
> +	{0x06, 0x08, 0x10}, {0x00, 0x00, 0x00},	{0xD2, 0x19, 0x01}
> +};
>  
>  static struct _lcd_scaling_factor lcd_scaling_factor = {
>  	/* LCD Horizontal Scaling Factor Register */
> --- a/drivers/video/via/hw.c	2011-03-03 09:09:10.536603676 -0800
> +++ b/drivers/video/via/hw.c	2011-03-03 09:44:07.241570863 -0800
> @@ -751,7 +751,7 @@ void viafb_unlock_crt(void)
>  	viafb_write_reg_mask(CR47, VIACR, 0, BIT0);
>  }
>  
> -void write_dac_reg(u8 index, u8 r, u8 g, u8 b)
> +static void write_dac_reg(u8 index, u8 r, u8 g, u8 b)
>  {
>  	outb(index, LUT_INDEX_WRITE);
>  	outb(r, LUT_DATA);
> --- a/drivers/video/via/via_i2c.c	2011-03-03 09:09:10.544604009 -0800
> +++ b/drivers/video/via/via_i2c.c	2011-03-03 09:44:07.245570884 -0800
> @@ -32,7 +32,7 @@
>   */
>  #define VIAFB_NUM_I2C		5
>  static struct via_i2c_stuff via_i2c_par[VIAFB_NUM_I2C];
> -struct viafb_dev *i2c_vdev;  /* Passed in from core */
> +static struct viafb_dev *i2c_vdev;  /* Passed in from core */
>  
>  static void via_i2c_setscl(void *data, int state)
>  {
> --- a/drivers/video/via/viafbdev.c	2011-03-03 09:09:10.528603482 -0800
> +++ b/drivers/video/via/viafbdev.c	2011-03-03 09:44:07.245570884 -0800
> @@ -43,11 +43,11 @@ static int viafb_second_size;
>  static int viafb_accel = 1;
>  
>  /* Added for specifying active devices.*/
> -char *viafb_active_dev;
> +static char *viafb_active_dev;
>  
>  /*Added for specify lcd output port*/
> -char *viafb_lcd_port = "";
> -char *viafb_dvi_port = "";
> +static char *viafb_lcd_port = "";
> +static char *viafb_dvi_port = "";
>  
>  static void retrieve_device_setting(struct viafb_ioctl_setting
>  	*setting_info);
> --- a/drivers/video/via/viamode.c	2011-03-03 09:45:33.462159061 -0800
> +++ b/drivers/video/via/viamode.c	2011-03-03 09:46:28.826662504 -0800
> @@ -443,7 +443,7 @@ struct VPITTable VPIT = {
>  /********************/
>  
>  /* 480x640 */
> -struct crt_mode_table CRTM480x640[] = {
> +static struct crt_mode_table CRTM480x640[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_25_175M, M480X640_R60_HSP, M480X640_R60_VSP,
> @@ -451,7 +451,7 @@ struct crt_mode_table CRTM480x640[] = {
>  };
>  
>  /* 640x480*/
> -struct crt_mode_table CRTM640x480[] = {
> +static struct crt_mode_table CRTM640x480[] = {
>  	/*r_rate,vclk,hsp,vsp */
>  	/*HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_25_175M, M640X480_R60_HSP, M640X480_R60_VSP,
> @@ -469,7 +469,7 @@ struct crt_mode_table CRTM640x480[] = {
>  };
>  
>  /*720x480 (GTF)*/
> -struct crt_mode_table CRTM720x480[] = {
> +static struct crt_mode_table CRTM720x480[] = {
>  	/*r_rate,vclk,hsp,vsp      */
>  	/*HT, HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_26_880M, M720X480_R60_HSP, M720X480_R60_VSP,
> @@ -478,7 +478,7 @@ struct crt_mode_table CRTM720x480[] = {
>  };
>  
>  /*720x576 (GTF)*/
> -struct crt_mode_table CRTM720x576[] = {
> +static struct crt_mode_table CRTM720x576[] = {
>  	/*r_rate,vclk,hsp,vsp */
>  	/*HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_32_668M, M720X576_R60_HSP, M720X576_R60_VSP,
> @@ -486,7 +486,7 @@ struct crt_mode_table CRTM720x576[] = {
>  };
>  
>  /* 800x480 (CVT) */
> -struct crt_mode_table CRTM800x480[] = {
> +static struct crt_mode_table CRTM800x480[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_29_581M, M800X480_R60_HSP, M800X480_R60_VSP,
> @@ -494,7 +494,7 @@ struct crt_mode_table CRTM800x480[] = {
>  };
>  
>  /* 800x600*/
> -struct crt_mode_table CRTM800x600[] = {
> +static struct crt_mode_table CRTM800x600[] = {
>  	/*r_rate,vclk,hsp,vsp     */
>  	/*HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_40_000M, M800X600_R60_HSP, M800X600_R60_VSP,
> @@ -512,7 +512,7 @@ struct crt_mode_table CRTM800x600[] = {
>  };
>  
>  /* 848x480 (CVT) */
> -struct crt_mode_table CRTM848x480[] = {
> +static struct crt_mode_table CRTM848x480[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_31_500M, M848X480_R60_HSP, M848X480_R60_VSP,
> @@ -520,7 +520,7 @@ struct crt_mode_table CRTM848x480[] = {
>  };
>  
>  /*856x480 (GTF) convert to 852x480*/
> -struct crt_mode_table CRTM852x480[] = {
> +static struct crt_mode_table CRTM852x480[] = {
>  	/*r_rate,vclk,hsp,vsp     */
>  	/*HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_31_728M, M852X480_R60_HSP, M852X480_R60_VSP,
> @@ -528,7 +528,7 @@ struct crt_mode_table CRTM852x480[] = {
>  };
>  
>  /*1024x512 (GTF)*/
> -struct crt_mode_table CRTM1024x512[] = {
> +static struct crt_mode_table CRTM1024x512[] = {
>  	/*r_rate,vclk,hsp,vsp     */
>  	/*HT,   HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_41_291M, M1024X512_R60_HSP, M1024X512_R60_VSP,
> @@ -537,7 +537,7 @@ struct crt_mode_table CRTM1024x512[] = {
>  };
>  
>  /* 1024x600*/
> -struct crt_mode_table CRTM1024x600[] = {
> +static struct crt_mode_table CRTM1024x600[] = {
>  	/*r_rate,vclk,hsp,vsp */
>  	/*HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_48_875M, M1024X600_R60_HSP, M1024X600_R60_VSP,
> @@ -545,7 +545,7 @@ struct crt_mode_table CRTM1024x600[] = {
>  };
>  
>  /* 1024x768*/
> -struct crt_mode_table CRTM1024x768[] = {
> +static struct crt_mode_table CRTM1024x768[] = {
>  	/*r_rate,vclk,hsp,vsp */
>  	/*HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_65_000M, M1024X768_R60_HSP, M1024X768_R60_VSP,
> @@ -559,7 +559,7 @@ struct crt_mode_table CRTM1024x768[] = {
>  };
>  
>  /* 1152x864*/
> -struct crt_mode_table CRTM1152x864[] = {
> +static struct crt_mode_table CRTM1152x864[] = {
>  	/*r_rate,vclk,hsp,vsp      */
>  	/*HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_75, CLK_108_000M, M1152X864_R75_HSP, M1152X864_R75_VSP,
> @@ -568,7 +568,7 @@ struct crt_mode_table CRTM1152x864[] = {
>  };
>  
>  /* 1280x720 (HDMI 720P)*/
> -struct crt_mode_table CRTM1280x720[] = {
> +static struct crt_mode_table CRTM1280x720[] = {
>  	/*r_rate,vclk,hsp,vsp */
>  	/*HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE      */
>  	{REFRESH_60, CLK_74_481M, M1280X720_R60_HSP, M1280X720_R60_VSP,
> @@ -578,7 +578,7 @@ struct crt_mode_table CRTM1280x720[] = {
>  };
>  
>  /*1280x768 (GTF)*/
> -struct crt_mode_table CRTM1280x768[] = {
> +static struct crt_mode_table CRTM1280x768[] = {
>  	/*r_rate,vclk,hsp,vsp     */
>  	/*HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_80_136M, M1280X768_R60_HSP, M1280X768_R60_VSP,
> @@ -588,7 +588,7 @@ struct crt_mode_table CRTM1280x768[] = {
>  };
>  
>  /* 1280x800 (CVT) */
> -struct crt_mode_table CRTM1280x800[] = {
> +static struct crt_mode_table CRTM1280x800[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_83_375M, M1280X800_R60_HSP, M1280X800_R60_VSP,
> @@ -596,7 +596,7 @@ struct crt_mode_table CRTM1280x800[] = {
>  };
>  
>  /*1280x960*/
> -struct crt_mode_table CRTM1280x960[] = {
> +static struct crt_mode_table CRTM1280x960[] = {
>  	/*r_rate,vclk,hsp,vsp */
>  	/*HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_108_000M, M1280X960_R60_HSP, M1280X960_R60_VSP,
> @@ -604,7 +604,7 @@ struct crt_mode_table CRTM1280x960[] = {
>  };
>  
>  /* 1280x1024*/
> -struct crt_mode_table CRTM1280x1024[] = {
> +static struct crt_mode_table CRTM1280x1024[] = {
>  	/*r_rate,vclk,,hsp,vsp */
>  	/*HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_108_000M, M1280X1024_R60_HSP, M1280X1024_R60_VSP,
> @@ -618,7 +618,7 @@ struct crt_mode_table CRTM1280x1024[] >  };
>  
>  /* 1368x768 (GTF) */
> -struct crt_mode_table CRTM1368x768[] = {
> +static struct crt_mode_table CRTM1368x768[] = {
>  	/* r_rate,  vclk, hsp, vsp */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_85_860M, M1368X768_R60_HSP, M1368X768_R60_VSP,
> @@ -626,7 +626,7 @@ struct crt_mode_table CRTM1368x768[] = {
>  };
>  
>  /*1440x1050 (GTF)*/
> -struct crt_mode_table CRTM1440x1050[] = {
> +static struct crt_mode_table CRTM1440x1050[] = {
>  	/*r_rate,vclk,hsp,vsp      */
>  	/*HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_125_104M, M1440X1050_R60_HSP, M1440X1050_R60_VSP,
> @@ -634,7 +634,7 @@ struct crt_mode_table CRTM1440x1050[] >  };
>  
>  /* 1600x1200*/
> -struct crt_mode_table CRTM1600x1200[] = {
> +static struct crt_mode_table CRTM1600x1200[] = {
>  	/*r_rate,vclk,hsp,vsp */
>  	/*HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_162_000M, M1600X1200_R60_HSP, M1600X1200_R60_VSP,
> @@ -646,7 +646,7 @@ struct crt_mode_table CRTM1600x1200[] >  };
>  
>  /* 1680x1050 (CVT) */
> -struct crt_mode_table CRTM1680x1050[] = {
> +static struct crt_mode_table CRTM1680x1050[] = {
>  	/* r_rate,          vclk,              hsp,             vsp  */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE,    VT,  VA,  VBS, VBE,  VSS, VSE */
>  	{REFRESH_60, CLK_146_760M, M1680x1050_R60_HSP, M1680x1050_R60_VSP,
> @@ -657,7 +657,7 @@ struct crt_mode_table CRTM1680x1050[] >  };
>  
>  /* 1680x1050 (CVT Reduce Blanking) */
> -struct crt_mode_table CRTM1680x1050_RB[] = {
> +static struct crt_mode_table CRTM1680x1050_RB[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE,    VT,  VA,  VBS, VBE,  VSS, VSE */
>  	{REFRESH_60, CLK_119_000M, M1680x1050_RB_R60_HSP,
> @@ -666,7 +666,7 @@ struct crt_mode_table CRTM1680x1050_RB[]
>  };
>  
>  /* 1920x1080 (CVT)*/
> -struct crt_mode_table CRTM1920x1080[] = {
> +static struct crt_mode_table CRTM1920x1080[] = {
>  	/*r_rate,vclk,hsp,vsp */
>  	/*HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_172_798M, M1920X1080_R60_HSP, M1920X1080_R60_VSP,
> @@ -674,7 +674,7 @@ struct crt_mode_table CRTM1920x1080[] >  };
>  
>  /* 1920x1080 (CVT with Reduce Blanking) */
> -struct crt_mode_table CRTM1920x1080_RB[] = {
> +static struct crt_mode_table CRTM1920x1080_RB[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_138_400M, M1920X1080_RB_R60_HSP,
> @@ -683,7 +683,7 @@ struct crt_mode_table CRTM1920x1080_RB[]
>  };
>  
>  /* 1920x1440*/
> -struct crt_mode_table CRTM1920x1440[] = {
> +static struct crt_mode_table CRTM1920x1440[] = {
>  	/*r_rate,vclk,hsp,vsp */
>  	/*HT,  HA,   HBS,  HBE, HSS,  HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_234_000M, M1920X1440_R60_HSP, M1920X1440_R60_VSP,
> @@ -694,7 +694,7 @@ struct crt_mode_table CRTM1920x1440[] >  };
>  
>  /* 1400x1050 (CVT) */
> -struct crt_mode_table CRTM1400x1050[] = {
> +static struct crt_mode_table CRTM1400x1050[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE,  HSS, HSE,   VT,  VA,  VBS, VBE,  VSS, VSE */
>  	{REFRESH_60, CLK_121_750M, M1400X1050_R60_HSP, M1400X1050_R60_VSP,
> @@ -705,7 +705,7 @@ struct crt_mode_table CRTM1400x1050[] >  };
>  
>  /* 1400x1050 (CVT Reduce Blanking) */
> -struct crt_mode_table CRTM1400x1050_RB[] = {
> +static struct crt_mode_table CRTM1400x1050_RB[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE,  HSS, HSE,   VT,  VA,  VBS, VBE,  VSS, VSE */
>  	{REFRESH_60, CLK_101_000M, M1400X1050_RB_R60_HSP,
> @@ -714,7 +714,7 @@ struct crt_mode_table CRTM1400x1050_RB[]
>  };
>  
>  /* 960x600 (CVT) */
> -struct crt_mode_table CRTM960x600[] = {
> +static struct crt_mode_table CRTM960x600[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_45_250M, M960X600_R60_HSP, M960X600_R60_VSP,
> @@ -722,7 +722,7 @@ struct crt_mode_table CRTM960x600[] = {
>  };
>  
>  /* 1000x600 (GTF) */
> -struct crt_mode_table CRTM1000x600[] = {
> +static struct crt_mode_table CRTM1000x600[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_48_000M, M1000X600_R60_HSP, M1000X600_R60_VSP,
> @@ -730,7 +730,7 @@ struct crt_mode_table CRTM1000x600[] = {
>  };
>  
>  /* 1024x576 (GTF) */
> -struct crt_mode_table CRTM1024x576[] = {
> +static struct crt_mode_table CRTM1024x576[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_46_996M, M1024X576_R60_HSP, M1024X576_R60_VSP,
> @@ -738,7 +738,7 @@ struct crt_mode_table CRTM1024x576[] = {
>  };
>  
>  /* 1088x612 (CVT) */
> -struct crt_mode_table CRTM1088x612[] = {
> +static struct crt_mode_table CRTM1088x612[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_52_977M, M1088X612_R60_HSP, M1088X612_R60_VSP,
> @@ -746,7 +746,7 @@ struct crt_mode_table CRTM1088x612[] = {
>  };
>  
>  /* 1152x720 (CVT) */
> -struct crt_mode_table CRTM1152x720[] = {
> +static struct crt_mode_table CRTM1152x720[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_66_750M, M1152X720_R60_HSP, M1152X720_R60_VSP,
> @@ -754,7 +754,7 @@ struct crt_mode_table CRTM1152x720[] = {
>  };
>  
>  /* 1200x720 (GTF) */
> -struct crt_mode_table CRTM1200x720[] = {
> +static struct crt_mode_table CRTM1200x720[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_70_159M, M1200X720_R60_HSP, M1200X720_R60_VSP,
> @@ -762,7 +762,7 @@ struct crt_mode_table CRTM1200x720[] = {
>  };
>  
>  /* 1200x900 (DCON) */
> -struct crt_mode_table DCON1200x900[] = {
> +static struct crt_mode_table DCON1200x900[] = {
>  	/* r_rate,          vclk,               hsp,               vsp   */
>  	{REFRESH_60, CLK_57_275M, M1200X900_R60_HSP, M1200X900_R60_VSP,
>  	/* The correct htotal is 1240, but this doesn't raster on VX855. */
> @@ -772,7 +772,7 @@ struct crt_mode_table DCON1200x900[] = {
>  };
>  
>  /* 1280x600 (GTF) */
> -struct crt_mode_table CRTM1280x600[] = {
> +static struct crt_mode_table CRTM1280x600[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE,  HSS, HSE, VT,  VA,  VBS, VBE,  VSS, VSE */
>  	{REFRESH_60, CLK_61_500M, M1280x600_R60_HSP, M1280x600_R60_VSP,
> @@ -780,7 +780,7 @@ struct crt_mode_table CRTM1280x600[] = {
>  };
>  
>  /* 1360x768 (CVT) */
> -struct crt_mode_table CRTM1360x768[] = {
> +static struct crt_mode_table CRTM1360x768[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_84_750M, M1360X768_R60_HSP, M1360X768_R60_VSP,
> @@ -788,7 +788,7 @@ struct crt_mode_table CRTM1360x768[] = {
>  };
>  
>  /* 1360x768 (CVT Reduce Blanking) */
> -struct crt_mode_table CRTM1360x768_RB[] = {
> +static struct crt_mode_table CRTM1360x768_RB[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_72_000M, M1360X768_RB_R60_HSP,
> @@ -797,7 +797,7 @@ struct crt_mode_table CRTM1360x768_RB[]
>  };
>  
>  /* 1366x768 (GTF) */
> -struct crt_mode_table CRTM1366x768[] = {
> +static struct crt_mode_table CRTM1366x768[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_85_860M, M1368X768_R60_HSP, M1368X768_R60_VSP,
> @@ -807,7 +807,7 @@ struct crt_mode_table CRTM1366x768[] = {
>  };
>  
>  /* 1440x900 (CVT) */
> -struct crt_mode_table CRTM1440x900[] = {
> +static struct crt_mode_table CRTM1440x900[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_106_500M, M1440X900_R60_HSP, M1440X900_R60_VSP,
> @@ -817,7 +817,7 @@ struct crt_mode_table CRTM1440x900[] = {
>  };
>  
>  /* 1440x900 (CVT Reduce Blanking) */
> -struct crt_mode_table CRTM1440x900_RB[] = {
> +static struct crt_mode_table CRTM1440x900_RB[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_88_750M, M1440X900_RB_R60_HSP,
> @@ -826,7 +826,7 @@ struct crt_mode_table CRTM1440x900_RB[]
>  };
>  
>  /* 1600x900 (CVT) */
> -struct crt_mode_table CRTM1600x900[] = {
> +static struct crt_mode_table CRTM1600x900[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_118_840M, M1600X900_R60_HSP, M1600X900_R60_VSP,
> @@ -834,7 +834,7 @@ struct crt_mode_table CRTM1600x900[] = {
>  };
>  
>  /* 1600x900 (CVT Reduce Blanking) */
> -struct crt_mode_table CRTM1600x900_RB[] = {
> +static struct crt_mode_table CRTM1600x900_RB[] = {
>  	/* r_rate,        vclk,           hsp,        vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_97_750M, M1600X900_RB_R60_HSP,
> @@ -843,7 +843,7 @@ struct crt_mode_table CRTM1600x900_RB[]
>  };
>  
>  /* 1600x1024 (GTF) */
> -struct crt_mode_table CRTM1600x1024[] = {
> +static struct crt_mode_table CRTM1600x1024[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE,  HSS, HSE,   VT,  VA,  VBS, VBE,  VSS, VSE */
>  	{REFRESH_60, CLK_136_700M, M1600X1024_R60_HSP, M1600X1024_R60_VSP,
> @@ -851,7 +851,7 @@ struct crt_mode_table CRTM1600x1024[] >  };
>  
>  /* 1792x1344 (DMT) */
> -struct crt_mode_table CRTM1792x1344[] = {
> +static struct crt_mode_table CRTM1792x1344[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE,  HSS, HSE,   VT,  VA,  VBS, VBE,  VSS, VSE */
>  	{REFRESH_60, CLK_204_000M, M1792x1344_R60_HSP, M1792x1344_R60_VSP,
> @@ -859,7 +859,7 @@ struct crt_mode_table CRTM1792x1344[] >  };
>  
>  /* 1856x1392 (DMT) */
> -struct crt_mode_table CRTM1856x1392[] = {
> +static struct crt_mode_table CRTM1856x1392[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE,  HSS, HSE,   VT,  VA,  VBS, VBE,  VSS, VSE */
>  	{REFRESH_60, CLK_218_500M, M1856x1392_R60_HSP, M1856x1392_R60_VSP,
> @@ -867,7 +867,7 @@ struct crt_mode_table CRTM1856x1392[] >  };
>  
>  /* 1920x1200 (CVT) */
> -struct crt_mode_table CRTM1920x1200[] = {
> +static struct crt_mode_table CRTM1920x1200[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_193_295M, M1920X1200_R60_HSP, M1920X1200_R60_VSP,
> @@ -875,7 +875,7 @@ struct crt_mode_table CRTM1920x1200[] >  };
>  
>  /* 1920x1200 (CVT with Reduce Blanking) */
> -struct crt_mode_table CRTM1920x1200_RB[] = {
> +static struct crt_mode_table CRTM1920x1200_RB[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE, HSS, HSE, VT,  VA,  VBS, VBE, VSS, VSE */
>  	{REFRESH_60, CLK_153_920M, M1920X1200_RB_R60_HSP,
> @@ -884,14 +884,14 @@ struct crt_mode_table CRTM1920x1200_RB[]
>  };
>  
>  /* 2048x1536 (CVT) */
> -struct crt_mode_table CRTM2048x1536[] = {
> +static struct crt_mode_table CRTM2048x1536[] = {
>  	/* r_rate,          vclk,              hsp,             vsp   */
>  	/* HT,  HA,  HBS, HBE,  HSS, HSE,   VT,  VA,  VBS, VBE,  VSS, VSE */
>  	{REFRESH_60, CLK_267_250M, M2048x1536_R60_HSP, M2048x1536_R60_VSP,
>  	 {2800, 2048, 2048, 752, 2200, 224, 1592, 1536, 1536, 56, 1539, 4} }
>  };
>  
> -struct VideoModeTable viafb_modes[] = {
> +static struct VideoModeTable viafb_modes[] = {
>  	/* Display : 480x640 (GTF) */
>  	{CRTM480x640, ARRAY_SIZE(CRTM480x640)},
>  
> @@ -1016,7 +1016,7 @@ struct VideoModeTable viafb_modes[] = {
>  	{CRTM1400x1050, ARRAY_SIZE(CRTM1400x1050)}
>  };
>  
> -struct VideoModeTable viafb_rb_modes[] = {
> +static struct VideoModeTable viafb_rb_modes[] = {
>  	/* Display : 1360x768 (CVT Reduce Blanking) */
>  	{CRTM1360x768_RB, ARRAY_SIZE(CRTM1360x768_RB)},
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

