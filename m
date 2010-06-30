From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Wed, 30 Jun 2010 00:02:31 +0000
Subject: Re: [PATCH 1/3] FB: Add some members for CPU Interface.
Message-Id: <AANLkTilgB3s8hy5Qg7IYpyBzwHCgK_GswVZqpxhryU5L@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4C29CFBD.3040205@samsung.com>
In-Reply-To: <4C29CFBD.3040205@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

2010/6/29 InKi Dae <inki.dae@samsung.com>:
> CPU interface needs cs, wr setup, wr act and hold delay.
> I added some members for them to common framework.

Hi InKi Dae,

The patch looks interesting. Could you help us understand more about
it from a big picture perspective? ie: how is this "cpu interface"
used? I think fb_var_screeninfo is intended to be a very generic data
structure and since it is exposed to userspace we should be cautious
about what we add to it. I didn't understand the purpose of exposing
cs, wr setup, wr act and hold delay to userspace. Are the MIPI display
parameters being specified from userspace? I also didn't understand
the fb_cmdmode_to_var export. I looked through the other 2 patches
(3/3 and 2/3) and didn't see it used so I might have missed something.
Also, I wanted to ask, since there are now multiple MIPI-DSI host
controller drivers in fbdev (omap and also mobile-sh), is there any
work that could be done to make these implementations share more code?

Thanks,
jaya

>
> Signed-off-by: InKi Dae <inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>
> diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
>
> index 0a4dbdc..74122d1 100644
> --- a/drivers/video/modedb.c
> +++ b/drivers/video/modedb.c
> @@ -759,6 +759,27 @@ void fb_videomode_to_var(struct fb_var_screeninfo *var,
>  }
>
>  /**
> + * fb_cpumode_to_var - convert fb_cpumode to fb_var_screeninfo
> + * @var: pointer to struct fb_var_screeninfo
> + * @mode: pointer to struct fb_cpumode
> + */
> +void fb_cmdmode_to_var(struct fb_var_screeninfo *var,
> +			 const struct fb_cmdmode *mode)
> +{
> +	var->xres = mode->xres;
> +	var->yres = mode->yres;
> +	var->xres_virtual = mode->xres;
> +	var->yres_virtual = mode->yres;
> +	var->xoffset = 0;
> +	var->yoffset = 0;
> +	var->pixclock = mode->pixclock;
> +	var->cs_setup = mode->cs_setup;
> +	var->wr_setup = mode->wr_setup;
> +	var->wr_act = mode->wr_act;
> +	var->wr_hold = mode->wr_hold;
> +}
> +
> +/**
>   * fb_mode_is_equal - compare 2 videomodes
>   * @mode1: first videomode
>   * @mode2: second videomode
> @@ -1048,6 +1069,7 @@ finished:
>  EXPORT_SYMBOL(fb_find_best_display);
>
>  EXPORT_SYMBOL(fb_videomode_to_var);
> +EXPORT_SYMBOL(fb_cmdmode_to_var);
>  EXPORT_SYMBOL(fb_var_to_videomode);
>  EXPORT_SYMBOL(fb_mode_is_equal);
>  EXPORT_SYMBOL(fb_add_videomode);
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 907ace3..73381c3 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -269,6 +269,12 @@ struct fb_var_screeninfo {
>  	__u32 vmode;			/* see FB_VMODE_*		*/
>  	__u32 rotate;			/* angle we rotate counter clockwise */
>  	__u32 reserved[5];		/* Reserved for future compatibility */
> +
> +	/* For cpu interface timing. */
> +	__u32 cs_setup;
> +	__u32 wr_setup;
> +	__u32 wr_act;
> +	__u32 wr_hold;
>  };
>
>  struct fb_cmap {
> @@ -1117,11 +1123,24 @@ struct fb_videomode {
>  	u32 lower_margin;
>  	u32 hsync_len;
>  	u32 vsync_len;
> +	u32 cmd_allow_len;
>  	u32 sync;
>  	u32 vmode;
>  	u32 flag;
>  };
>
> +struct fb_cmdmode {
> +	const char *name;	/* optional */
> +	u32 refresh;		/* optional */
> +	u32 xres;
> +	u32 yres;
> +	u32 pixclock;
> +	u32 cs_setup;
> +	u32 wr_setup;
> +	u32 wr_act;
> +	u32 wr_hold;
> +};
> +
>  extern const char *fb_mode_option;
>  extern const struct fb_videomode vesa_modes[];
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
