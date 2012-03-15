From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 15 Mar 2012 00:20:26 +0000
Subject: RE: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
Message-Id: <001501cd0241$6bb53560$431fa020$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331585999-8604-1-git-send-email-thomas.abraham@linaro.org>
 <1331585999-8604-4-git-send-email-thomas.abraham@linaro.org>
 <002f01cd00fe$5df84fa0$19e8eee0$%han@samsung.com>
 <CAJuYYwSUf-gsVesduMggSuues9OLOR6DUDAAMg_tL=e3=3c0tQ@mail.gmail.com>
 <000501cd0184$f088cb20$d19a6160$%han@samsung.com> <4F60E5C8.3040804@gmail.com>
In-Reply-To: <4F60E5C8.3040804@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Darius Augulis [mailto:augulis.darius@gmail.com]
> Sent: Thursday, March 15, 2012 3:39 AM
> To: Jingoo Han
> Cc: 'Thomas Abraham'; linux-fbdev@vger.kernel.org; FlorianSchandinat@gmx.de; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; kgene.kim@samsung.com; ben-
> linux@fluff.org; patches@linaro.org; 'Kyungmin Park'; 'JeongHyeon Kim'; 'Heiko Stuebner'; 'Kwangwoo Lee';
> 'Mark Brown'; 'Peter Korsgaard'; 'Maurus Cuelenaere'
> Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
> 
> On 03/14/2012 03:51 AM, Jingoo Han wrote:
> >> -----Original Message-----
> >> From: Thomas Abraham [mailto:thomas.abraham@linaro.org]
> >> Sent: Tuesday, March 13, 2012 7:11 PM
> >> To: Jingoo Han
> >> Cc: linux-fbdev@vger.kernel.org; FlorianSchandinat@gmx.de; linux-arm-kernel@lists.infradead.org;
> linux-
> >> samsung-soc@vger.kernel.org; kgene.kim@samsung.com; ben-linux@fluff.org; patches@linaro.org; Kyungmin
> >> Park; JeongHyeon Kim; Heiko Stuebner; Kwangwoo Lee; Mark Brown; Peter Korsgaard; Darius Augulis;
> Maurus
> >> Cuelenaere
> >> Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
> >>
> >> On 13 March 2012 15:17, Jingoo Han<jg1.han@samsung.com>  wrote:
> >>>> -----Original Message-----
> >>>> From: Thomas Abraham [mailto:thomas.abraham@linaro.org]
> >>>> Sent: Tuesday, March 13, 2012 6:00 AM
> >>>> To: linux-fbdev@vger.kernel.org
> >>>> Cc: FlorianSchandinat@gmx.de; linux-arm-kernel@lists.infradead.org; linux-samsung-
> soc@vger.kernel.org;
> >>>> kgene.kim@samsung.com; jg1.han@samsung.com; ben-linux@fluff.org; patches@linaro.org; Kyungmin Park;
> >>>> JeongHyeon Kim; Heiko Stuebner; Kwangwoo Lee; Mark Brown; Peter Korsgaard; Darius Augulis; Maurus
> >>>> Cuelenaere
> >>>> Subject: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
> >>>>
> >>>> For all the Samsung SoC based boards which have the platform data for
> >>>> s3c-fb driver, the 'default_win' element in the platform data is removed
> >>>> and the lcd panel video timing values are moved out of individual window
> >>>> configuration data.
> >>>>
> >>>> Cc: Jingoo Han<jg1.han@samsung.com>
> >>>> Cc: Kyungmin Park<kyungmin.park@samsung.com>
> >>>> Cc: JeongHyeon Kim<jhkim@insignal.co.kr>
> >>>> Cc: Kukjin Kim<kgene.kim@samsung.com>
> >>>> Cc: Heiko Stuebner<heiko@sntech.de>
> >>>> Cc: Ben Dooks<ben-linux@fluff.org>
> >>>> Cc: Kwangwoo Lee<kwangwoo.lee@gmail.com>
> >>>> Cc: Mark Brown<broonie@opensource.wolfsonmicro.com>
> >>>> Cc: Peter Korsgaard<jacmet@sunsite.dk>
> >>>> Cc: Darius Augulis<augulis.darius@gmail.com>
> >>>> Cc: Maurus Cuelenaere<mcuelenaere@gmail.com>
> >>>> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> >>>> ---
> >>>>   arch/arm/mach-exynos/mach-nuri.c           |   26 ++++++++++-------
> >>>>   arch/arm/mach-exynos/mach-origen.c         |   24 ++++++++++-------
> >>>>   arch/arm/mach-exynos/mach-smdkv310.c       |   28 +++++++++++--------
> >>>>   arch/arm/mach-exynos/mach-universal_c210.c |   26 ++++++++++-------
> >>>>   arch/arm/mach-s3c24xx/mach-smdk2416.c      |   27 ++++++++++--------
> >>>>   arch/arm/mach-s3c64xx/mach-anw6410.c       |   25 ++++++++++-------
> >>>>   arch/arm/mach-s3c64xx/mach-crag6410.c      |   25 ++++++++++-------
> >>>>   arch/arm/mach-s3c64xx/mach-hmt.c           |   24 ++++++++++-------
> >>>>   arch/arm/mach-s3c64xx/mach-mini6410.c      |   40 ++++++++++++---------------
> >>>>   arch/arm/mach-s3c64xx/mach-real6410.c      |   40 ++++++++++++---------------
> >>>>   arch/arm/mach-s3c64xx/mach-smartq5.c       |   26 ++++++++++-------
> >>>>   arch/arm/mach-s3c64xx/mach-smartq7.c       |   26 ++++++++++-------
> >>>>   arch/arm/mach-s3c64xx/mach-smdk6410.c      |   25 ++++++++++-------
> >>>>   arch/arm/mach-s5p64x0/mach-smdk6440.c      |   24 ++++++++++-------
> >>>>   arch/arm/mach-s5p64x0/mach-smdk6450.c      |   24 ++++++++++-------
> >>>>   arch/arm/mach-s5pc100/mach-smdkc100.c      |   27 ++++++++++--------
> >>>>   arch/arm/mach-s5pv210/mach-aquila.c        |   36 +++++++++++--------------
> >>>>   arch/arm/mach-s5pv210/mach-goni.c          |   26 ++++++++++-------
> >>>>   arch/arm/mach-s5pv210/mach-smdkv210.c      |   24 ++++++++++-------
> >>>>   19 files changed, 285 insertions(+), 238 deletions(-)
> >>>>
> >>> [.....]
> >>>
> >>>> diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
> >>>> index c34c2ab..24dcdc9 100644
> >>>> --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
> >>>> +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> >>>> @@ -153,36 +153,32 @@ static struct s3c2410_platform_nand mini6410_nand_info = {
> >>>>
> >>>>   static struct s3c_fb_pd_win mini6410_fb_win[] = {
> >>>>        {
> >>>> -             .win_mode       = {     /* 4.3" 480x272 */
> >>>> -                     .left_margin    = 3,
> >>>> -                     .right_margin   = 2,
> >>>> -                     .upper_margin   = 1,
> >>>> -                     .lower_margin   = 1,
> >>>> -                     .hsync_len      = 40,
> >>>> -                     .vsync_len      = 1,
> >>>> -                     .xres           = 480,
> >>>> -                     .yres           = 272,
> >>>> -             },
> >>>>                .max_bpp        = 32,
> >>>>                .default_bpp    = 16,
> >>>> +             .xres           = 480,
> >>>> +             .yres           = 272,
> >>>>        }, {
> >>>> -             .win_mode       = {     /* 7.0" 800x480 */
> >>>> -                     .left_margin    = 8,
> >>>> -                     .right_margin   = 13,
> >>>> -                     .upper_margin   = 7,
> >>>> -                     .lower_margin   = 5,
> >>>> -                     .hsync_len      = 3,
> >>>> -                     .vsync_len      = 1,
> >>>> -                     .xres           = 800,
> >>>> -                     .yres           = 480,
> >>>> -             },
> >>>>                .max_bpp        = 32,
> >>>>                .default_bpp    = 16,
> >>>> +             .xres           = 800,
> >>>> +             .yres           = 480,
> >>>>        },
> >>>>   };
> >>>>
> >>>> +static struct fb_videomode mini6410_lcd_timing = {
> >>>> +     .left_margin    = 8,
> >>>> +     .right_margin   = 13,
> >>>> +     .upper_margin   = 7,
> >>>> +     .lower_margin   = 5,
> >>>> +     .hsync_len      = 3,
> >>>> +     .vsync_len      = 1,
> >>>> +     .xres           = 800,
> >>>> +     .yres           = 480,
> >>>> +};
> >>>> +
> >>>>   static struct s3c_fb_platdata mini6410_lcd_pdata __initdata = {
> >>>>        .setup_gpio     = s3c64xx_fb_gpio_setup_24bpp,
> >>>> +     .vtiming        =&mini6410_lcd_timing,
> >>>>        .win[0]         =&mini6410_fb_win[0],
> >>>>        .vidcon0        = VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
> >>>>        .vidcon1        = VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
> >>>> @@ -310,8 +306,8 @@ static void __init mini6410_machine_init(void)
> >>>>        mini6410_lcd_pdata.win[0] =&mini6410_fb_win[features.lcd_index];
> >>>>
> >>>>        printk(KERN_INFO "MINI6410: selected LCD display is %dx%d\n",
> >>>> -             mini6410_lcd_pdata.win[0]->win_mode.xres,
> >>>> -             mini6410_lcd_pdata.win[0]->win_mode.yres);
> >>>> +             mini6410_lcd_pdata.win[0]->xres,
> >>>> +             mini6410_lcd_pdata.win[0]->yres);
> >>>>
> >>>>        s3c_nand_set_platdata(&mini6410_nand_info);
> >>>>        s3c_fb_set_platdata(&mini6410_lcd_pdata);
> >>>> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
> >>>> index be2a9a2..41e4f74 100644
> >>>> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> >>>> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> >>>> @@ -119,36 +119,32 @@ static struct platform_device real6410_device_eth = {
> >>>>
> >>>>   static struct s3c_fb_pd_win real6410_fb_win[] = {
> >>>>        {
> >>>> -             .win_mode       = {     /* 4.3" 480x272 */
> >>>> -                     .left_margin    = 3,
> >>>> -                     .right_margin   = 2,
> >>>> -                     .upper_margin   = 1,
> >>>> -                     .lower_margin   = 1,
> >>>> -                     .hsync_len      = 40,
> >>>> -                     .vsync_len      = 1,
> >>>> -                     .xres           = 480,
> >>>> -                     .yres           = 272,
> >>>> -             },
> >>>>                .max_bpp        = 32,
> >>>>                .default_bpp    = 16,
> >>>> +             .xres           = 480,
> >>>> +             .yres           = 272,
> >>>>        }, {
> >>>> -             .win_mode       = {     /* 7.0" 800x480 */
> >>>> -                     .left_margin    = 8,
> >>>> -                     .right_margin   = 13,
> >>>> -                     .upper_margin   = 7,
> >>>> -                     .lower_margin   = 5,
> >>>> -                     .hsync_len      = 3,
> >>>> -                     .vsync_len      = 1,
> >>>> -                     .xres           = 800,
> >>>> -                     .yres           = 480,
> >>>> -             },
> >>>>                .max_bpp        = 32,
> >>>>                .default_bpp    = 16,
> >>>> +             .xres           = 800,
> >>>> +             .yres           = 480,
> >>>>        },
> >>>>   };
> >>>>
> >>>> +static struct fb_videomode real6410_lcd_timing = {
> >>>> +     .left_margin    = 3,
> >>>> +     .right_margin   = 2,
> >>>> +     .upper_margin   = 1,
> >>>> +     .lower_margin   = 1,
> >>>> +     .hsync_len      = 40,
> >>>> +     .vsync_len      = 1,
> >>>> +     .xres           = 800,
> >>>> +     .yres           = 480,
> >>>> +};
> >>>
> >>> What is the difference between mini6410_lcd_timing and real6410_lcd_timing?
> >>> In my opinion, it would be good as follows:
> >>>
> >>> +static struct fb_videomode real6410_lcd_timing = {
> >>> +       .left_margin    = 8,
> >>> +       .right_margin   = 13,
> >>> +       .upper_margin   = 7,
> >>> +       .lower_margin   = 5,
> >>> +       .hsync_len      = 3,
> >>> +       .vsync_len      = 1,
> >>> +       .xres           = 800,
> >>> +       .yres           = 480,
> >>> +};
> >>>
> >>>
> >> Before this patch series, both real6410 and mini6410 had 'default_win'
> >> = 0 in the platform data. And, the s3c-fb driver selected the video
> >> timing from the window selected by the default_win parameter in s3c-fb
> >> platform data, i.e window 0 for both mini6440 and real6410. So, in
> >> this patch, while moving the timing values out of window data, the
> >> timing values for window 0 was selected.
> >>
> >> The timing value for window 1 was never used on mini6410 and real6410.
> >> So I would suggest to use timing value of window 0 in this patch.
> > OK, I see.
> > Then, as you mentioned above, the timing value of mini6410 and real6410 should be same.
> > Also, the mini6410 should use the timing value for window 0 as below.
> >
> > Also, this timing value is used for 4.3" 480x272 LCD.
> > So, xres and yres would be 480 and 272, respectively, instead of 800 and 480.
> >
> > The mini6410 seems to use 4.3" 480x272 LCD as default LCD.
> > Please refer to 'http://www.friendlyarm.net/products/mini6410'.
> >
> > Also, real6410 seems to use 4.3" 480x272 LCD as default LCD.
> > http://s3c6410kits.googlecode.com/files/overview_Real6410.pdf
> >
> > Therefore, given this, the timing value of mini6410 and real6410 would be as follows.
> >
> > +static struct fb_videomode mini6410_lcd_timing = {
> > +	.left_margin	= 8,
> > +	.right_margin	= 13,
> > +	.upper_margin	= 7,
> > +	.lower_margin	= 5,
> > +	.hsync_len	= 3,
> > +	.vsync_len	= 1,
> > +	.xres		= 480,
> > +	.yres		= 272,
> > +};
> >
> > +static struct fb_videomode real6410_lcd_timing = {
> > +	.left_margin	= 8,
> > +	.right_margin	= 13,
> > +	.upper_margin	= 7,
> > +	.lower_margin	= 5,
> > +	.hsync_len	= 3,
> > +	.vsync_len	= 1,
> > +	.xres		= 480,
> > +	.yres		= 272,
> > +};
> >
> > Darius Augulis, can you confirm it?
> > (Darius Augulis is a maintainer for real6410 and mini6410 boards.)
> 
> Are you going to leave only single LCD resolution for every of two
> boards? If so, then my answer is no.

Yes, only single LCD resolution will be left.

> I have mini6410 with both 4.3" and 7" LCDs and real6410 with 7" LCD. Now
> we have possibility to choose LCD size dynamically - leave it there.
> What you mean "default" 4.3" size LCD? The 7" size LCD is also provided
> by board sellers - I've bought it.

OK, I see.
Both mini6410 and real6410 provide both 4.3" and 7" LCDs,
so you needs to select both LCDs.

Um, usually, single LCD is provided on the single board.
Also, the daughter board with another kind LCD can be connected to the board.

However, .win_mode is used not for LCD, but for windows of FIMD IP.
Actually, our current framework does not support to choose multi LCD,
so, I understand that you use .win_mode[1] as second LCD.
However, that's not accurate way to select multi LCD.

Thomas, can you consider Augulis's opinion?
I think that the method to select multi LCDs is necessary.

Ideal process is such as:
  1. add the patch to support to select multi LCDs
  2. apply above patch to make the mini6410 and real6410 to select multi LCDs.
  3. apply Thomas's patchset to remove timing value from .win_mode variable.

Best regards,
Jingoo Han

> 
> regards,
> Darius Augulis
> 
> >
> > Best regards,
> > Jingoo Han
> >
> >> Thanks for your comments.
> >>
> >> Regards,
> >> Thomas.
> >

