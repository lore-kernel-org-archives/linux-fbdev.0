From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Tue, 13 Mar 2012 10:22:51 +0000
Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
Message-Id: <CAJuYYwSUf-gsVesduMggSuues9OLOR6DUDAAMg_tL=e3=3c0tQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331585999-8604-1-git-send-email-thomas.abraham@linaro.org>
 <1331585999-8604-4-git-send-email-thomas.abraham@linaro.org>
 <002f01cd00fe$5df84fa0$19e8eee0$%han@samsung.com>
In-Reply-To: <002f01cd00fe$5df84fa0$19e8eee0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 13 March 2012 15:17, Jingoo Han <jg1.han@samsung.com> wrote:
>> -----Original Message-----
>> From: Thomas Abraham [mailto:thomas.abraham@linaro.org]
>> Sent: Tuesday, March 13, 2012 6:00 AM
>> To: linux-fbdev@vger.kernel.org
>> Cc: FlorianSchandinat@gmx.de; linux-arm-kernel@lists.infradead.org; linu=
x-samsung-soc@vger.kernel.org;
>> kgene.kim@samsung.com; jg1.han@samsung.com; ben-linux@fluff.org; patches=
@linaro.org; Kyungmin Park;
>> JeongHyeon Kim; Heiko Stuebner; Kwangwoo Lee; Mark Brown; Peter Korsgaar=
d; Darius Augulis; Maurus
>> Cuelenaere
>> Subject: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb dri=
ver
>>
>> For all the Samsung SoC based boards which have the platform data for
>> s3c-fb driver, the 'default_win' element in the platform data is removed
>> and the lcd panel video timing values are moved out of individual window
>> configuration data.
>>
>> Cc: Jingoo Han <jg1.han@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: JeongHyeon Kim <jhkim@insignal.co.kr>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Cc: Kwangwoo Lee <kwangwoo.lee@gmail.com>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Cc: Peter Korsgaard <jacmet@sunsite.dk>
>> Cc: Darius Augulis <augulis.darius@gmail.com>
>> Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> =A0arch/arm/mach-exynos/mach-nuri.c =A0 =A0 =A0 =A0 =A0 | =A0 26 +++++++=
+++-------
>> =A0arch/arm/mach-exynos/mach-origen.c =A0 =A0 =A0 =A0 | =A0 24 +++++++++=
+-------
>> =A0arch/arm/mach-exynos/mach-smdkv310.c =A0 =A0 =A0 | =A0 28 +++++++++++=
--------
>> =A0arch/arm/mach-exynos/mach-universal_c210.c | =A0 26 ++++++++++-------
>> =A0arch/arm/mach-s3c24xx/mach-smdk2416.c =A0 =A0 =A0| =A0 27 ++++++++++-=
-------
>> =A0arch/arm/mach-s3c64xx/mach-anw6410.c =A0 =A0 =A0 | =A0 25 ++++++++++-=
------
>> =A0arch/arm/mach-s3c64xx/mach-crag6410.c =A0 =A0 =A0| =A0 25 ++++++++++-=
------
>> =A0arch/arm/mach-s3c64xx/mach-hmt.c =A0 =A0 =A0 =A0 =A0 | =A0 24 +++++++=
+++-------
>> =A0arch/arm/mach-s3c64xx/mach-mini6410.c =A0 =A0 =A0| =A0 40 +++++++++++=
+---------------
>> =A0arch/arm/mach-s3c64xx/mach-real6410.c =A0 =A0 =A0| =A0 40 +++++++++++=
+---------------
>> =A0arch/arm/mach-s3c64xx/mach-smartq5.c =A0 =A0 =A0 | =A0 26 ++++++++++-=
------
>> =A0arch/arm/mach-s3c64xx/mach-smartq7.c =A0 =A0 =A0 | =A0 26 ++++++++++-=
------
>> =A0arch/arm/mach-s3c64xx/mach-smdk6410.c =A0 =A0 =A0| =A0 25 ++++++++++-=
------
>> =A0arch/arm/mach-s5p64x0/mach-smdk6440.c =A0 =A0 =A0| =A0 24 ++++++++++-=
------
>> =A0arch/arm/mach-s5p64x0/mach-smdk6450.c =A0 =A0 =A0| =A0 24 ++++++++++-=
------
>> =A0arch/arm/mach-s5pc100/mach-smdkc100.c =A0 =A0 =A0| =A0 27 ++++++++++-=
-------
>> =A0arch/arm/mach-s5pv210/mach-aquila.c =A0 =A0 =A0 =A0| =A0 36 +++++++++=
++--------------
>> =A0arch/arm/mach-s5pv210/mach-goni.c =A0 =A0 =A0 =A0 =A0| =A0 26 +++++++=
+++-------
>> =A0arch/arm/mach-s5pv210/mach-smdkv210.c =A0 =A0 =A0| =A0 24 ++++++++++-=
------
>> =A019 files changed, 285 insertions(+), 238 deletions(-)
>>
>
> [.....]
>
>> diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64=
xx/mach-mini6410.c
>> index c34c2ab..24dcdc9 100644
>> --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
>> +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
>> @@ -153,36 +153,32 @@ static struct s3c2410_platform_nand mini6410_nand_=
info =3D {
>>
>> =A0static struct s3c_fb_pd_win mini6410_fb_win[] =3D {
>> =A0 =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .win_mode =A0 =A0 =A0 =3D { =A0 =A0 /* 4.3" 48=
0x272 */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .left_margin =A0 =A0=3D 3,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .right_margin =A0 =3D 2,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .upper_margin =A0 =3D 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .lower_margin =A0 =3D 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hsync_len =A0 =A0 =A0=3D 40,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsync_len =A0 =A0 =A0=3D 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D =
480,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D =
272,
>> - =A0 =A0 =A0 =A0 =A0 =A0 },
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_bpp =A0 =A0 =A0 =A0=3D 32,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .default_bpp =A0 =A0=3D 16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D 480,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D 272,
>> =A0 =A0 =A0 }, {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .win_mode =A0 =A0 =A0 =3D { =A0 =A0 /* 7.0" 80=
0x480 */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .left_margin =A0 =A0=3D 8,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .right_margin =A0 =3D 13,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .upper_margin =A0 =3D 7,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .lower_margin =A0 =3D 5,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hsync_len =A0 =A0 =A0=3D 3,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsync_len =A0 =A0 =A0=3D 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D =
800,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D =
480,
>> - =A0 =A0 =A0 =A0 =A0 =A0 },
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_bpp =A0 =A0 =A0 =A0=3D 32,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .default_bpp =A0 =A0=3D 16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D 800,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D 480,
>> =A0 =A0 =A0 },
>> =A0};
>>
>> +static struct fb_videomode mini6410_lcd_timing =3D {
>> + =A0 =A0 .left_margin =A0 =A0=3D 8,
>> + =A0 =A0 .right_margin =A0 =3D 13,
>> + =A0 =A0 .upper_margin =A0 =3D 7,
>> + =A0 =A0 .lower_margin =A0 =3D 5,
>> + =A0 =A0 .hsync_len =A0 =A0 =A0=3D 3,
>> + =A0 =A0 .vsync_len =A0 =A0 =A0=3D 1,
>> + =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D 800,
>> + =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D 480,
>> +};
>> +
>> =A0static struct s3c_fb_platdata mini6410_lcd_pdata __initdata =3D {
>> =A0 =A0 =A0 .setup_gpio =A0 =A0 =3D s3c64xx_fb_gpio_setup_24bpp,
>> + =A0 =A0 .vtiming =A0 =A0 =A0 =A0=3D &mini6410_lcd_timing,
>> =A0 =A0 =A0 .win[0] =A0 =A0 =A0 =A0 =3D &mini6410_fb_win[0],
>> =A0 =A0 =A0 .vidcon0 =A0 =A0 =A0 =A0=3D VIDCON0_VIDOUT_RGB | VIDCON0_PNR=
MODE_RGB,
>> =A0 =A0 =A0 .vidcon1 =A0 =A0 =A0 =A0=3D VIDCON1_INV_HSYNC | VIDCON1_INV_=
VSYNC,
>> @@ -310,8 +306,8 @@ static void __init mini6410_machine_init(void)
>> =A0 =A0 =A0 mini6410_lcd_pdata.win[0] =3D &mini6410_fb_win[features.lcd_=
index];
>>
>> =A0 =A0 =A0 printk(KERN_INFO "MINI6410: selected LCD display is %dx%d\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 mini6410_lcd_pdata.win[0]->win_mode.xres,
>> - =A0 =A0 =A0 =A0 =A0 =A0 mini6410_lcd_pdata.win[0]->win_mode.yres);
>> + =A0 =A0 =A0 =A0 =A0 =A0 mini6410_lcd_pdata.win[0]->xres,
>> + =A0 =A0 =A0 =A0 =A0 =A0 mini6410_lcd_pdata.win[0]->yres);
>>
>> =A0 =A0 =A0 s3c_nand_set_platdata(&mini6410_nand_info);
>> =A0 =A0 =A0 s3c_fb_set_platdata(&mini6410_lcd_pdata);
>> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64=
xx/mach-real6410.c
>> index be2a9a2..41e4f74 100644
>> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
>> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
>> @@ -119,36 +119,32 @@ static struct platform_device real6410_device_eth =
=3D {
>>
>> =A0static struct s3c_fb_pd_win real6410_fb_win[] =3D {
>> =A0 =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .win_mode =A0 =A0 =A0 =3D { =A0 =A0 /* 4.3" 48=
0x272 */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .left_margin =A0 =A0=3D 3,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .right_margin =A0 =3D 2,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .upper_margin =A0 =3D 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .lower_margin =A0 =3D 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hsync_len =A0 =A0 =A0=3D 40,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsync_len =A0 =A0 =A0=3D 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D =
480,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D =
272,
>> - =A0 =A0 =A0 =A0 =A0 =A0 },
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_bpp =A0 =A0 =A0 =A0=3D 32,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .default_bpp =A0 =A0=3D 16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D 480,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D 272,
>> =A0 =A0 =A0 }, {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .win_mode =A0 =A0 =A0 =3D { =A0 =A0 /* 7.0" 80=
0x480 */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .left_margin =A0 =A0=3D 8,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .right_margin =A0 =3D 13,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .upper_margin =A0 =3D 7,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .lower_margin =A0 =3D 5,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hsync_len =A0 =A0 =A0=3D 3,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsync_len =A0 =A0 =A0=3D 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D =
800,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D =
480,
>> - =A0 =A0 =A0 =A0 =A0 =A0 },
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_bpp =A0 =A0 =A0 =A0=3D 32,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .default_bpp =A0 =A0=3D 16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D 800,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D 480,
>> =A0 =A0 =A0 },
>> =A0};
>>
>> +static struct fb_videomode real6410_lcd_timing =3D {
>> + =A0 =A0 .left_margin =A0 =A0=3D 3,
>> + =A0 =A0 .right_margin =A0 =3D 2,
>> + =A0 =A0 .upper_margin =A0 =3D 1,
>> + =A0 =A0 .lower_margin =A0 =3D 1,
>> + =A0 =A0 .hsync_len =A0 =A0 =A0=3D 40,
>> + =A0 =A0 .vsync_len =A0 =A0 =A0=3D 1,
>> + =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D 800,
>> + =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D 480,
>> +};
>
>
> What is the difference between mini6410_lcd_timing and real6410_lcd_timin=
g?
> In my opinion, it would be good as follows:
>
> +static struct fb_videomode real6410_lcd_timing =3D {
> + =A0 =A0 =A0 .left_margin =A0 =A0=3D 8,
> + =A0 =A0 =A0 .right_margin =A0 =3D 13,
> + =A0 =A0 =A0 .upper_margin =A0 =3D 7,
> + =A0 =A0 =A0 .lower_margin =A0 =3D 5,
> + =A0 =A0 =A0 .hsync_len =A0 =A0 =A0=3D 3,
> + =A0 =A0 =A0 .vsync_len =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D 800,
> + =A0 =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D 480,
> +};
>
>

Before this patch series, both real6410 and mini6410 had 'default_win'
=3D 0 in the platform data. And, the s3c-fb driver selected the video
timing from the window selected by the default_win parameter in s3c-fb
platform data, i.e window 0 for both mini6440 and real6410. So, in
this patch, while moving the timing values out of window data, the
timing values for window 0 was selected.

The timing value for window 1 was never used on mini6410 and real6410.
So I would suggest to use timing value of window 0 in this patch.

Thanks for your comments.

Regards,
Thomas.
