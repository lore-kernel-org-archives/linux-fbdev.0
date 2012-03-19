From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Mon, 19 Mar 2012 07:41:31 +0000
Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
Message-Id: <CAJuYYwQmJvx_uGZKbAJ9uds-ciLs2VDqcifhoqB-P0M5uhO-nA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331585999-8604-1-git-send-email-thomas.abraham@linaro.org>
 <1331585999-8604-4-git-send-email-thomas.abraham@linaro.org>
 <002f01cd00fe$5df84fa0$19e8eee0$%han@samsung.com>
 <CAJuYYwSUf-gsVesduMggSuues9OLOR6DUDAAMg_tL=e3=3c0tQ@mail.gmail.com>
 <000501cd0184$f088cb20$d19a6160$%han@samsung.com>
 <4F60E5C8.3040804@gmail.com>
 <001501cd0241$6bb53560$431fa020$%han@samsung.com>
 <CAEYLNCp5e=86rpRi2C-5OJptTyEeXAn8JHhbWw_BqGzSaDD9wQ@mail.gmail.com>
 <002a01cd0283$1f61b200$5e251600$%han@samsung.com>
 <CAEYLNCrprPE60ZS=_OWuck0JCJMhCxzVErZwuwGpEDYkQq-hXg@mail.gmail.com>
 <001d01cd0315$935cc720$ba165560$%han@samsung.com>
 <CAEYLNCrGCmb5EJjURLY=EGfM=4N54MirNkCCyQRxqKEN3Eka8Q@mail.gmail.com>
 <002d01cd034b$c56f2b00$504d8100$%han@samsung.com>
 <CAEYLNCpfQ0cYb4efw6PZNnKjQ2rF25rj5Ed=i884LJXHAwigBw@mail.gmail.com>
 <002f01cd0359$eb718330$c2548990$%han@samsung.com>
 <CAEYLNCpJU_5uVa-jo5HUNY8Av6eYaiow1gEZtHCiQZ5oKkGoMQ@mail.gmail.com>
 <001501cd0561$57c642b0$0752c810$%han@samsung.com>
In-Reply-To: <001501cd0561$57c642b0$0752c810$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Darius,

On 19 March 2012 05:16, Jingoo Han <jg1.han@samsung.com> wrote:
[...]

>
> Because there are not multiple windows and driver sees only single window=
 as you mentiond,
> Only 'struct s3c_fb_pd_win mini6410_fb_win[0]' should be used and
> 'struct s3c_fb_pd_win mini6410_fb_win[1]' should not be used.
> s3c_fb_pd_win[0] means window 0 of FIMD IP, s3c_fb_pd_win[1] means window=
 1 of FIMD IP.
>
> Therefore, if mini6410_fb_win[0] and mini6410_fb_win[1] are included, it =
means that
> 2 windows of FIMD IP are used in single LCD.
>
> If you want to support multiple LCDs, you should use struct s3c_fb_platda=
ta[0], struct s3c_fb_platdata[1],
> because 'struct s3c_fb_platdata' means LCD panel.
>
> If you understand the purpose of s3c_fb_platdata and s3c_fb_pd_win, you s=
hould do, at least, as below.
>
> static struct s3c_fb_pd_win mini6410_fb_lcd0_win[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.win_mode =A0 =A0 =A0 =3D { =A0 =A0 /* 4.3=
" 480x272 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.left_margin =A0 =A0=3D 3,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.right_margin =A0 =3D 2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.upper_margin =A0 =3D 1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.lower_margin =A0 =3D 1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.hsync_len =A0 =A0 =A0=3D =
40,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vsync_len =A0 =A0 =A0=3D =
1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.xres =A0 =A0 =A0 =A0 =A0 =
=3D 480,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.yres =A0 =A0 =A0 =A0 =A0 =
=3D 272,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_bpp =A0 =A0 =A0 =A0=3D 32,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.default_bpp =A0 =A0=3D 16,
> =A0 =A0 =A0 =A0},
> };
>
> static struct s3c_fb_platdata mini6410_lcd_pdata[0] __initdata =3D {
> =A0 =A0 =A0 =A0.setup_gpio =A0 =A0 =3D s3c64xx_fb_gpio_setup_24bpp,
> =A0 =A0 =A0 =A0.win[0] =A0 =A0 =A0 =A0 =3D &mini6410_fb_lcd0_win[0],
> =A0 =A0 =A0 =A0.vidcon0 =A0 =A0 =A0 =A0=3D VIDCON0_VIDOUT_RGB | VIDCON0_P=
NRMODE_RGB,
> =A0 =A0 =A0 =A0.vidcon1 =A0 =A0 =A0 =A0=3D VIDCON1_INV_HSYNC | VIDCON1_IN=
V_VSYNC,
> };
>
> static struct s3c_fb_pd_win mini6410_fb_lcd1_win[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.win_mode =A0 =A0 =A0 =3D { =A0 =A0 /* 7.0=
" 800x480 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.left_margin =A0 =A0=3D 8,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.right_margin =A0 =3D 13,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.upper_margin =A0 =3D 7,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.lower_margin =A0 =3D 5,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.hsync_len =A0 =A0 =A0=3D =
3,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vsync_len =A0 =A0 =A0=3D =
1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.xres =A0 =A0 =A0 =A0 =A0 =
=3D 800,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.yres =A0 =A0 =A0 =A0 =A0 =
=3D 480,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_bpp =A0 =A0 =A0 =A0=3D 32,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.default_bpp =A0 =A0=3D 16,
> =A0 =A0 =A0 =A0},
> };
>
> static struct s3c_fb_platdata mini6410_lcd_pdata[1] __initdata =3D {
> =A0 =A0 =A0 =A0.setup_gpio =A0 =A0 =3D s3c64xx_fb_gpio_setup_24bpp,
> =A0 =A0 =A0 =A0.win[0] =A0 =A0 =A0 =A0 =3D &mini6410_fb_lcd1_win[0],
> =A0 =A0 =A0 =A0.vidcon0 =A0 =A0 =A0 =A0=3D VIDCON0_VIDOUT_RGB | VIDCON0_P=
NRMODE_RGB,
> =A0 =A0 =A0 =A0.vidcon1 =A0 =A0 =A0 =A0=3D VIDCON1_INV_HSYNC | VIDCON1_IN=
V_VSYNC,
> };
>
> Each struct means:
> =A0mini6410_lcd_pdata[0]: 4.3" 480x272 LCD
> =A0mini6410_fb_lcd0_win[0]: window 0 used for 4.3" 480x272 LCD
>
> =A0mini6410_lcd_pdata[1]: 7.0" 800x480 LCD
> =A0mini6410_fb_lcd1_win[0]: window 0 used for 7.0" 800x480 LCD
>
> In this case, 4.3" or 7.0" LCD can be selected using mini6410_lcd_pdata[]=
, instead of selecting mini6410_fb_win[0] or
> mini6410_fb_win[1].
>
> My point is that 's3c_fb_platdata and s3c_fb_pd_win should be used exactl=
y'.

I agree with solution which Jingoo Han has proposed. Instead of
selecting one instance of s3c_fb_pd_win over the other at runtime, the
features->lcd_index can be used to select one of the instances of
platform data for s3c-fb driver.

s3c_fb_pd_win is used to describe a window supported by the fimd
controller. It is not meant to carry lcd timing information. The lcd
panel timing remains the same irrespective of the window sizes. And
this patchset is a step towards untangling window information and
video timing.

(Apologizes for the delayed reply. I was out of office for last 4 days.)

Thanks,
Thomas.
