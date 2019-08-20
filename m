From: Andrzej Hajda <a.hajda@samsung.com>
Date: Tue, 20 Aug 2019 11:07:48 +0000
Subject: Re: [PATCH 3/3] video: fbdev: mmp: fix sparse warnings about using incorrect types
Message-Id: <bb23a213-e86f-8057-566d-926c1b5eb10b@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c@eucas1p1.samsung.com>
        <ee796b43-f200-d41a-b18c-ae3d6bcaaa67@samsung.com>
In-Reply-To: <ee796b43-f200-d41a-b18c-ae3d6bcaaa67@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On 27.06.2019 16:08, Bartlomiej Zolnierkiewicz wrote:
> Use ->screen_buffer instead of ->screen_base in mmpfb driver.
>
> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>   pointer") for details. ]
>
> Also fix all other sparse warnings about using incorrect types in
> mmp display subsystem.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

=C2=A0--
Regards
Andrzej


> ---
>  drivers/video/fbdev/mmp/fb/mmpfb.c    |    2 -
>  drivers/video/fbdev/mmp/hw/mmp_ctrl.c |   55 +++++++++++++++++++--------=
-------
>  drivers/video/fbdev/mmp/hw/mmp_ctrl.h |   10 +++---
>  drivers/video/fbdev/mmp/hw/mmp_spi.c  |    6 +--
>  4 files changed, 41 insertions(+), 32 deletions(-)
>
> Index: b/drivers/video/fbdev/mmp/fb/mmpfb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/mmp/fb/mmpfb.c
> +++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
> @@ -522,7 +522,7 @@ static int fb_info_setup(struct fb_info
>  		info->var.bits_per_pixel / 8;
>  	info->fbops =3D &mmpfb_ops;
>  	info->pseudo_palette =3D fbi->pseudo_palette;
> -	info->screen_base =3D fbi->fb_start;
> +	info->screen_buffer =3D fbi->fb_start;
>  	info->screen_size =3D fbi->fb_size;
> =20
>  	/* For FB framework: Allocate color map and Register framebuffer*/
> Index: b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> +++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> @@ -136,19 +136,26 @@ static void overlay_set_win(struct mmp_o
>  	mutex_lock(&overlay->access_ok);
> =20
>  	if (overlay_is_vid(overlay)) {
> -		writel_relaxed(win->pitch[0], &regs->v_pitch_yc);
> -		writel_relaxed(win->pitch[2] << 16 |
> -				win->pitch[1], &regs->v_pitch_uv);
> -
> -		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->v_size);
> -		writel_relaxed((win->ydst << 16) | win->xdst, &regs->v_size_z);
> -		writel_relaxed(win->ypos << 16 | win->xpos, &regs->v_start);
> +		writel_relaxed(win->pitch[0],
> +				(void __iomem *)&regs->v_pitch_yc);
> +		writel_relaxed(win->pitch[2] << 16 | win->pitch[1],
> +				(void __iomem *)&regs->v_pitch_uv);
> +
> +		writel_relaxed((win->ysrc << 16) | win->xsrc,
> +				(void __iomem *)&regs->v_size);
> +		writel_relaxed((win->ydst << 16) | win->xdst,
> +				(void __iomem *)&regs->v_size_z);
> +		writel_relaxed(win->ypos << 16 | win->xpos,
> +				(void __iomem *)&regs->v_start);
>  	} else {
> -		writel_relaxed(win->pitch[0], &regs->g_pitch);
> +		writel_relaxed(win->pitch[0], (void __iomem *)&regs->g_pitch);
> =20
> -		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->g_size);
> -		writel_relaxed((win->ydst << 16) | win->xdst, &regs->g_size_z);
> -		writel_relaxed(win->ypos << 16 | win->xpos, &regs->g_start);
> +		writel_relaxed((win->ysrc << 16) | win->xsrc,
> +				(void __iomem *)&regs->g_size);
> +		writel_relaxed((win->ydst << 16) | win->xdst,
> +				(void __iomem *)&regs->g_size_z);
> +		writel_relaxed(win->ypos << 16 | win->xpos,
> +				(void __iomem *)&regs->g_start);
>  	}
> =20
>  	dmafetch_set_fmt(overlay);
> @@ -233,11 +240,11 @@ static int overlay_set_addr(struct mmp_o
>  	memcpy(&overlay->addr, addr, sizeof(struct mmp_addr));
> =20
>  	if (overlay_is_vid(overlay)) {
> -		writel_relaxed(addr->phys[0], &regs->v_y0);
> -		writel_relaxed(addr->phys[1], &regs->v_u0);
> -		writel_relaxed(addr->phys[2], &regs->v_v0);
> +		writel_relaxed(addr->phys[0], (void __iomem *)&regs->v_y0);
> +		writel_relaxed(addr->phys[1], (void __iomem *)&regs->v_u0);
> +		writel_relaxed(addr->phys[2], (void __iomem *)&regs->v_v0);
>  	} else
> -		writel_relaxed(addr->phys[0], &regs->g_0);
> +		writel_relaxed(addr->phys[0], (void __iomem *)&regs->g_0);
> =20
>  	return overlay->addr.phys[0];
>  }
> @@ -268,16 +275,18 @@ static void path_set_mode(struct mmp_pat
>  	tmp |=3D dsi_rbswap & CFG_INTFRBSWAP_MASK;
>  	writel_relaxed(tmp, ctrl_regs(path) + intf_rbswap_ctrl(path->id));
> =20
> -	writel_relaxed((mode->yres << 16) | mode->xres, &regs->screen_active);
> +	writel_relaxed((mode->yres << 16) | mode->xres,
> +		(void __iomem *)&regs->screen_active);
>  	writel_relaxed((mode->left_margin << 16) | mode->right_margin,
> -		&regs->screen_h_porch);
> +		(void __iomem *)&regs->screen_h_porch);
>  	writel_relaxed((mode->upper_margin << 16) | mode->lower_margin,
> -		&regs->screen_v_porch);
> +		(void __iomem *)&regs->screen_v_porch);
>  	total_x =3D mode->xres + mode->left_margin + mode->right_margin +
>  		mode->hsync_len;
>  	total_y =3D mode->yres + mode->upper_margin + mode->lower_margin +
>  		mode->vsync_len;
> -	writel_relaxed((total_y << 16) | total_x, &regs->screen_size);
> +	writel_relaxed((total_y << 16) | total_x,
> +		(void __iomem *)&regs->screen_size);
> =20
>  	/* vsync ctrl */
>  	if (path->output_type =3D PATH_OUT_DSI)
> @@ -285,7 +294,7 @@ static void path_set_mode(struct mmp_pat
>  	else
>  		vsync_ctrl =3D ((mode->xres + mode->right_margin) << 16)
>  					| (mode->xres + mode->right_margin);
> -	writel_relaxed(vsync_ctrl, &regs->vsync_ctrl);
> +	writel_relaxed(vsync_ctrl, (void __iomem *)&regs->vsync_ctrl);
> =20
>  	/* set pixclock div */
>  	sclk_src =3D clk_get_rate(path_to_ctrl(path)->clk);
> @@ -366,9 +375,9 @@ static void path_set_default(struct mmp_
>  	writel_relaxed(dma_ctrl1, ctrl_regs(path) + dma_ctrl(1, path->id));
> =20
>  	/* Configure default register values */
> -	writel_relaxed(0x00000000, &regs->blank_color);
> -	writel_relaxed(0x00000000, &regs->g_1);
> -	writel_relaxed(0x00000000, &regs->g_start);
> +	writel_relaxed(0x00000000, (void __iomem *)&regs->blank_color);
> +	writel_relaxed(0x00000000, (void __iomem *)&regs->g_1);
> +	writel_relaxed(0x00000000, (void __iomem *)&regs->g_start);
> =20
>  	/*
>  	 * 1.enable multiple burst request in DMA AXI
> Index: b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> +++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> @@ -1393,7 +1393,7 @@ struct mmphw_ctrl {
>  	/* platform related, get from config */
>  	const char *name;
>  	int irq;
> -	void *reg_base;
> +	void __iomem *reg_base;
>  	struct clk *clk;
> =20
>  	/* sys info */
> @@ -1429,7 +1429,7 @@ static inline struct mmphw_ctrl *overlay
>  	return path_to_ctrl(overlay->path);
>  }
> =20
> -static inline void *ctrl_regs(struct mmp_path *path)
> +static inline void __iomem *ctrl_regs(struct mmp_path *path)
>  {
>  	return path_to_ctrl(path)->reg_base;
>  }
> @@ -1438,11 +1438,11 @@ static inline void *ctrl_regs(struct mmp
>  static inline struct lcd_regs *path_regs(struct mmp_path *path)
>  {
>  	if (path->id =3D PATH_PN)
> -		return (struct lcd_regs *)(ctrl_regs(path) + 0xc0);
> +		return (struct lcd_regs __force *)(ctrl_regs(path) + 0xc0);
>  	else if (path->id =3D PATH_TV)
> -		return (struct lcd_regs *)ctrl_regs(path);
> +		return (struct lcd_regs __force  *)ctrl_regs(path);
>  	else if (path->id =3D PATH_P2)
> -		return (struct lcd_regs *)(ctrl_regs(path) + 0x200);
> +		return (struct lcd_regs __force *)(ctrl_regs(path) + 0x200);
>  	else {
>  		dev_err(path->dev, "path id %d invalid\n", path->id);
>  		BUG_ON(1);
> Index: b/drivers/video/fbdev/mmp/hw/mmp_spi.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/mmp/hw/mmp_spi.c
> +++ b/drivers/video/fbdev/mmp/hw/mmp_spi.c
> @@ -31,7 +31,7 @@ static inline int lcd_spi_write(struct s
>  {
>  	int timeout =3D 100000, isr, ret =3D 0;
>  	u32 tmp;
> -	void *reg_base > +	void __iomem *reg_base =3D (void __iomem *)
>  		*(void **)spi_master_get_devdata(spi->master);
> =20
>  	/* clear ISR */
> @@ -80,7 +80,7 @@ static inline int lcd_spi_write(struct s
> =20
>  static int lcd_spi_setup(struct spi_device *spi)
>  {
> -	void *reg_base > +	void __iomem *reg_base =3D (void __iomem *)
>  		*(void **)spi_master_get_devdata(spi->master);
>  	u32 tmp;
> =20
> @@ -146,7 +146,7 @@ int lcd_spi_register(struct mmphw_ctrl *
>  		return -ENOMEM;
>  	}
>  	p_regbase =3D spi_master_get_devdata(master);
> -	*p_regbase =3D ctrl->reg_base;
> +	*p_regbase =3D (void __force *)ctrl->reg_base;
> =20
>  	/* set bus num to 5 to avoid conflict with other spi hosts */
>  	master->bus_num =3D 5;
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
