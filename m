From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 30 Jan 2013 21:49:31 +0000
Subject: Re: [PATCH v5 2/8] video: mmp fb support
Message-Id: <20130130134931.ea1eb040.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358410998-2631-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1358410998-2631-1-git-send-email-zzhu3@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 17 Jan 2013 16:23:18 +0800
Zhou Zhu <zzhu3@marvell.com> wrote:

> Added fb support for Marvell mmp display subsystem.
> This driver is configured using "buffer driver mach info".
> With configured name of path, this driver get path using
> using exported interface of mmp display driver.
> Then this driver get ovly using configured id and operates
> on this ovly to show buffers on display devices.
> 
> ...
>
> +static void *alloc_framebuffer(size_t size, dma_addr_t *dma)
> +{
> +	int nr, i = 0;
> +	struct page **pages;
> +	void *start;
> +
> +	nr = size >> PAGE_SHIFT;

If `size' is not a multiple of PAGE_SIZE, this will cause various
overruns later on.

> +	start = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
> +	if (start = NULL)
> +		return NULL;
> +
> +	*dma = virt_to_phys(start);
> +	pages = vmalloc(sizeof(struct page *) * nr);
> +	if (pages = NULL)
> +		return NULL;

Did we leak the memory at `start'?

> +
> +	while (i < nr) {
> +		pages[i] = phys_to_page(*dma + (i << PAGE_SHIFT));
> +		i++;
> +	}
> +	start = vmap(pages, nr, 0, pgprot_writecombine(pgprot_kernel));
> +
> +	vfree(pages);
> +	return start;
> +}
>
> ...
>
> +static int mmpfb_set_par(struct fb_info *info)
> +{
> +	struct mmpfb_info *fbi = info->par;
> +	struct fb_var_screeninfo *var = &info->var;
> +	struct mmp_addr addr;
> +	struct mmp_win win;
> +	struct mmp_mode mode;
> +
> +	int ret = var_update(info);

Strange code layout here.  I suggest:

	struct mmp_win win;
	struct mmp_mode mode;
	int ret;

	ret = var_update(info);

> +	if (ret != 0)
> +		return ret;
> +
> +	/* set window/path according to new videomode */
> +	fbmode_to_mmpmode(&mode, &fbi->mode, fbi->output_fmt);
> +	mmp_path_set_mode(fbi->path, &mode);
> +
> +	memset(&win, 0, sizeof(win));
> +	win.xsrc = win.xdst = fbi->mode.xres;
> +	win.ysrc = win.ydst = fbi->mode.yres;
> +	win.pix_fmt = fbi->pix_fmt;
> +	mmp_ovly_set_win(fbi->ovly, &win);
> +
> +	/* set address always */
> +	memset(&addr, 0, sizeof(addr));
> +	addr.phys[0] = (var->yoffset * var->xres_virtual + var->xoffset)
> +		* var->bits_per_pixel / 8 + fbi->fb_start_dma;
> +	mmp_ovly_set_addr(fbi->ovly, &addr);
> +
> +	return 0;
> +}
>
> ...
>
