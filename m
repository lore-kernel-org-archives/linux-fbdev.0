From: Jingoo Han <jg1.han@samsung.com>
Date: Sun, 18 Mar 2012 23:46:25 +0000
Subject: RE: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
Message-Id: <001501cd0561$57c642b0$0752c810$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331585999-8604-1-git-send-email-thomas.abraham@linaro.org>
 <1331585999-8604-4-git-send-email-thomas.abraham@linaro.org>
 <002f01cd00fe$5df84fa0$19e8eee0$%han@samsung.com>
 <CAJuYYwSUf-gsVesduMggSuues9OLOR6DUDAAMg_tL=e3=3c0tQ@mail.gmail.com>
 <000501cd0184$f088cb20$d19a6160$%han@samsung.com> <4F60E5C8.3040804@gmail.com>
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
In-Reply-To: <CAEYLNCpJU_5uVa-jo5HUNY8Av6eYaiow1gEZtHCiQZ5oKkGoMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: linux-samsung-soc-owner@vger.kernel.org [mailto:linux-samsung-soc-owner@vger.kernel.org] On Behalf
> Of Darius Augulis
> Sent: Friday, March 16, 2012 7:19 PM
> To: Jingoo Han
> Cc: Thomas Abraham; linux-fbdev@vger.kernel.org; FlorianSchandinat@gmx.de; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; ben-linux@fluff.org; patches@linaro.org;
> kgene.kim@samsung.com; Kyungmin Park; JeongHyeon Kim; Heiko Stuebner; Kwangwoo Lee; Mark Brown; Peter
> Korsgaard; Maurus Cuelenaere; Tushar Behera
> Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
> 
> On Fri, Mar 16, 2012 at 11:48 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> >> > It's just bug.
> >> >
> >> > struct s3c_fb_pd_win should be used for windows of FIMD IP.
> >> > It should not be used for selecting multi-LCDs.
> >>
> >> why not? s3c_fb_pd_win contains timing values which depend directly on
> >> LCD size and resolution.
> >> Please look into the code again - mini6410 doesn't use platform data
> >> so select different LCD sizes.
> >> It has only single window in platform data - exactly what you want.
> >> Now tell my, why you are arguing, that this platform data cannot be
> >> rewritten dynamically by board setup routines at kernel startup time?
> >> Many ARM architectures are doing the same - takes kernel command line
> >> argument to select LCD and passes necessary data for its fb drivers
> >> via platform data structures. It not a bug, it's correct approach to
> >> support different sizes of LCD display for the same board.
> >
> >
> > Hey, it is not my point.
> > To take kernel command line is not problem to support multiple LCDs.
> >
> > My point is that s3c_fb_pd_win should not include variable LCD option.
> > So, if you want to support multiple LCDs, you should use another variable,
> > instead of using s3c_fb_pd_win[0] and s3c_fb_pd_win[1] as 4.3" LCD, 7.0" LCD.
> 
> But I use s3c_fb_pd_win only as container to hold timing values in
> board setup code.
> s3c-fb platform data has only single window and does not perform any
> LCD selection.
> What is wrong here? You suggest to declare some custom structure to
> hold these timing values? What's the point?
> 
> >
> > You use s3c_fb_pd_win[0], s3c_fb_pd_win[1] as 4.3" LCD, 7.0" LCD.
> > However, s3c_fb_pd_win[0], s3c_fb_pd_win[1] means the windows of FIMD IP.
> 
> There is no multiple windows in platform data! driver sees only single
> window. And this wont change in any way if you drop LCD selection from
> board setup code.
> Driver will see the same single window. So - your are arguing, that
> board setup code sets platform data in bad way. I don't accept your
> opinion, because tens of boards are doing the same and nobody call it
> bug.

Because there are not multiple windows and driver sees only single window as you mentiond, 
Only 'struct s3c_fb_pd_win mini6410_fb_win[0]' should be used and 
'struct s3c_fb_pd_win mini6410_fb_win[1]' should not be used.
s3c_fb_pd_win[0] means window 0 of FIMD IP, s3c_fb_pd_win[1] means window 1 of FIMD IP.

Therefore, if mini6410_fb_win[0] and mini6410_fb_win[1] are included, it means that
2 windows of FIMD IP are used in single LCD.

If you want to support multiple LCDs, you should use struct s3c_fb_platdata[0], struct s3c_fb_platdata[1],
because 'struct s3c_fb_platdata' means LCD panel.

If you understand the purpose of s3c_fb_platdata and s3c_fb_pd_win, you should do, at least, as below.

static struct s3c_fb_pd_win mini6410_fb_lcd0_win[] = {
	{
		.win_mode	= {	/* 4.3" 480x272 */
			.left_margin	= 3,
			.right_margin	= 2,
			.upper_margin	= 1,
			.lower_margin	= 1,
			.hsync_len	= 40,
			.vsync_len	= 1,
			.xres		= 480,
			.yres		= 272,
		},
		.max_bpp	= 32,
		.default_bpp	= 16,
	},
};

static struct s3c_fb_platdata mini6410_lcd_pdata[0] __initdata = {
	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
	.win[0]		= &mini6410_fb_lcd0_win[0],
	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
};

static struct s3c_fb_pd_win mini6410_fb_lcd1_win[] = {
	{
		.win_mode	= {	/* 7.0" 800x480 */
			.left_margin	= 8,
			.right_margin	= 13,
			.upper_margin	= 7,
			.lower_margin	= 5,
			.hsync_len	= 3,
			.vsync_len	= 1,
			.xres		= 800,
			.yres		= 480,
		},
		.max_bpp	= 32,
		.default_bpp	= 16,
	},
};

static struct s3c_fb_platdata mini6410_lcd_pdata[1] __initdata = {
	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
	.win[0]		= &mini6410_fb_lcd1_win[0],
	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
};

Each struct means:
  mini6410_lcd_pdata[0]: 4.3" 480x272 LCD
  mini6410_fb_lcd0_win[0]: window 0 used for 4.3" 480x272 LCD

  mini6410_lcd_pdata[1]: 7.0" 800x480 LCD
  mini6410_fb_lcd1_win[0]: window 0 used for 7.0" 800x480 LCD

In this case, 4.3" or 7.0" LCD can be selected using mini6410_lcd_pdata[], instead of selecting mini6410_fb_win[0] or
mini6410_fb_win[1].

My point is that 's3c_fb_platdata and s3c_fb_pd_win should be used exactly'.

> 
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

