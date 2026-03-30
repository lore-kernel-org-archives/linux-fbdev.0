Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F1344D83;
	Mon, 30 Mar 2026 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886077; cv=none; b=X8n85COjYD6YwiI8qXYOJg7zsJJICSEB6WDU4/qDN2NJA4ab3neZZtNHR+Hk/X7CHcnxMEnPTgzM+OT33Bu5fiFcMOdzsMp+nw50ii97zm1IZvToiMElr3SvbccIlyhVbrDdRkmbJ/L4zDXYpwQ+bdScNN4yyMm/q+3tplXntDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886077; c=relaxed/simple;
	bh=cltxX7u+Bp3uxsAIOj3wmuMfYdTfYKPgpx5/zJA/jwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/8Can9kmXg84woU7tAdiqrrNY/dy9PTYH7LLMNhKfBGzd3qy+f3DN5t3GPhlb8qtSZvRPv4wl/KmbOlaADktpIH0QgXURA9fxBI9/xCEULrBfZBHUm7J7/9dFp22OW5+a70oZZvwDX+9ag3Lp38z6hA2ord7F5W1KCOYLegQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SwCw5mkJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SwCw5mkJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2827C19423;
	Mon, 30 Mar 2026 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774886077;
	bh=cltxX7u+Bp3uxsAIOj3wmuMfYdTfYKPgpx5/zJA/jwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SwCw5mkJ58203kB6QOZAuSIDlEhunvVF0uuwBjkXfjV8FhMH/YYKpoPNQPhVghfEF
	 77+yVaNN4EC2erVlZ7N2/GA4bQJmXuwccSDSemEITaTcB8QMFTaBGNth47WLCTRlH4
	 BUzuJzSQm8vf+tBlwKXGqcFsvFhVA4bBOqVA97x8=
Date: Mon, 30 Mar 2026 17:54:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hadi Chokr <hadichokr@icloud.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: fix naming conventions and remove
 dead code
Message-ID: <2026033013-imitate-direction-edb1@gregkh>
References: <20260327091402.55366-1-hadichokr@icloud.com>
 <20260327170846.11077-2-hadichokr@icloud.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327170846.11077-2-hadichokr@icloud.com>

On Fri, Mar 27, 2026 at 06:08:47PM +0100, Hadi Chokr wrote:
> - Convert camelCase to snake_case to fix all checkpatch warnings.
> 
> - Remove unused function sm750_hw_cursor_set_data2() and its declaration.
> 
> - checkpatch warned that g_fbmode should be 'static const char * const';
>   this revealed that lynxfb_set_fbinfo() was writing back into g_fbmode
>   unnecessarily. Refactor to resolve the mode string into a local
>   const char * instead. Also drop the redundant NULL initializer since
>   static storage is zero-initialized.
> 
> - Remove manual write to pdev->dev.power.power_state.event in
>   lynxfb_resume(); fb_set_suspend() already handles the resume state
>   correctly.
> 
> Changes in v2:
> 
> - Further rename Hungarian-encoded or mixed-case variables etc. to descriptive names:
>   pv_mem → fb_mem, pv_reg → reg_base, bpp → bits_per_pixel,
>   src_delta → src_pitch, f_color → fg_color etc.
> 
> Signed-off-by: Hadi Chokr <hadichokr@icloud.com>
> ---
>  drivers/staging/sm750fb/readme         |  6 +--
>  drivers/staging/sm750fb/sm750.c        | 71 +++++++++++++-------------
>  drivers/staging/sm750fb/sm750.h        | 26 +++++-----
>  drivers/staging/sm750fb/sm750_accel.c  | 32 ++++++------
>  drivers/staging/sm750fb/sm750_accel.h  | 44 ++++++++--------
>  drivers/staging/sm750fb/sm750_cursor.c | 43 ----------------
>  drivers/staging/sm750fb/sm750_cursor.h |  2 -
>  drivers/staging/sm750fb/sm750_hw.c     | 22 ++++----
>  8 files changed, 100 insertions(+), 146 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/readme b/drivers/staging/sm750fb/readme
> index cfa45958b..95b7d2539 100644
> --- a/drivers/staging/sm750fb/readme
> +++ b/drivers/staging/sm750fb/readme
> @@ -7,7 +7,7 @@ Introduction:
>  
>  About the kernel module parameter of driver:
>  
> -	Use 1280,8bpp index color and 60 hz mode:
> +	Use 1280,8 bits_per_pixel index color and 60 hz mode:
>  	insmod ./sm750fb.ko g_option="1280x1024-8@60"
>  
>  	Disable MTRR,Disable 2d acceleration,Disable hardware cursor,
> @@ -29,8 +29,8 @@ About the kernel module parameter of driver:
>  		it equal to modular method with below command:
>  		insmod ./sm750fb.ko g_option="noaccel:1280x1024@60:otherparm:etc..."
>  
> -	2) if you put 800x600 into the parameter without bpp and
> -		refresh rate, kernel driver will defaulty use 16bpp and 60hz
> +	2) if you put 800x600 into the parameter without bits_per_pixel and
> +		refresh rate, kernel driver will defaulty use 16 bits_per_pixel and 60hz
>  
>  Important:
>  	if you have vesafb enabled in your config then /dev/fb0 will be created by vesafb
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 9a42a08c8..103258819 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,7 +33,7 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel;
>  static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char *g_fbmode[2];
>  static const char *g_def_fbmode = "1024x768-32@60";
>  static char *g_settings;
>  static int g_dualview;
> @@ -160,7 +160,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
>  {
>  	struct lynxfb_par *par;
>  	struct sm750_dev *sm750_dev;
> -	unsigned int base, pitch, bpp, rop;
> +	unsigned int base, pitch, bits_per_pixel, rop;
>  	u32 color;
>  
>  	if (info->state != FBINFO_STATE_RUNNING)
> @@ -175,9 +175,9 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
>  	 */
>  	base = par->crtc.o_screen;
>  	pitch = info->fix.line_length;
> -	bpp = info->var.bits_per_pixel >> 3;
> +	bits_per_pixel = info->var.bits_per_pixel >> 3;
>  
> -	color = (bpp == 1) ? region->color :
> +	color = (bits_per_pixel == 1) ? region->color :
>  		((u32 *)info->pseudo_palette)[region->color];
>  	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR : HW_ROP2_COPY;
>  
> @@ -190,7 +190,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
>  	spin_lock(&sm750_dev->slock);
>  
>  	sm750_dev->accel.de_fillrect(&sm750_dev->accel,
> -				     base, pitch, bpp,
> +				     base, pitch, bits_per_pixel,
>  				     region->dx, region->dy,
>  				     region->width, region->height,
>  				     color, rop);
> @@ -202,7 +202,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
>  {
>  	struct lynxfb_par *par;
>  	struct sm750_dev *sm750_dev;
> -	unsigned int base, pitch, bpp;
> +	unsigned int base, pitch, bits_per_pixel;
>  
>  	par = info->par;
>  	sm750_dev = par->dev;
> @@ -213,7 +213,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
>  	 */
>  	base = par->crtc.o_screen;
>  	pitch = info->fix.line_length;
> -	bpp = info->var.bits_per_pixel >> 3;
> +	bits_per_pixel = info->var.bits_per_pixel >> 3;
>  
>  	/*
>  	 * If not use spin_lock, system will die if user load driver
> @@ -225,7 +225,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
>  
>  	sm750_dev->accel.de_copyarea(&sm750_dev->accel,
>  				     base, pitch, region->sx, region->sy,
> -				     base, pitch, bpp, region->dx, region->dy,
> +				     base, pitch, bits_per_pixel, region->dx, region->dy,
>  				     region->width, region->height,
>  				     HW_ROP2_COPY);
>  	spin_unlock(&sm750_dev->slock);
> @@ -234,7 +234,7 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
>  static void lynxfb_ops_imageblit(struct fb_info *info,
>  				 const struct fb_image *image)
>  {
> -	unsigned int base, pitch, bpp;
> +	unsigned int base, pitch, bits_per_pixel;
>  	unsigned int fgcol, bgcol;
>  	struct lynxfb_par *par;
>  	struct sm750_dev *sm750_dev;
> @@ -247,7 +247,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
>  	 */
>  	base = par->crtc.o_screen;
>  	pitch = info->fix.line_length;
> -	bpp = info->var.bits_per_pixel >> 3;
> +	bits_per_pixel = info->var.bits_per_pixel >> 3;
>  
>  	/* TODO: Implement hardware acceleration for image->depth > 1 */
>  	if (image->depth != 1) {
> @@ -274,7 +274,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
>  
>  	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
>  				      image->data, image->width >> 3, 0,
> -				      base, pitch, bpp,
> +				      base, pitch, bits_per_pixel,
>  				      image->dx, image->dy,
>  				      image->width, image->height,
>  				      fgcol, bgcol, HW_ROP2_COPY);
> @@ -388,7 +388,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
>  	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
>  
>  	if (ret) {
> -		dev_err(info->device, "bpp %d not supported\n",
> +		dev_err(info->device, "bits_per_pixel %d not supported\n",
>  			var->bits_per_pixel);
>  		return ret;
>  	}
> @@ -467,8 +467,6 @@ static int __maybe_unused lynxfb_resume(struct device *dev)
>  		fb_set_suspend(info, 0);
>  	}
>  
> -	pdev->dev.power.power_state.event = PM_EVENT_RESUME;
> -
>  	console_unlock();
>  	return 0;
>  }
> @@ -488,7 +486,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
>  	ret = lynxfb_set_color_offsets(info);
>  
>  	if (ret) {
> -		dev_err(info->device, "bpp %d not supported\n",
> +		dev_err(info->device, "bits_per_pixel %d not supported\n",
>  			var->bits_per_pixel);
>  		return ret;
>  	}
> @@ -619,26 +617,26 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
>  		output->paths = sm750_pnc;
>  		crtc->channel = sm750_primary;
>  		crtc->o_screen = 0;
> -		crtc->v_screen = sm750_dev->pvMem;
> +		crtc->v_screen = sm750_dev->fb_mem;
>  		break;
>  	case sm750_simul_sec:
>  		output->paths = sm750_pnc;
>  		crtc->channel = sm750_secondary;
>  		crtc->o_screen = 0;
> -		crtc->v_screen = sm750_dev->pvMem;
> +		crtc->v_screen = sm750_dev->fb_mem;
>  		break;
>  	case sm750_dual_normal:
>  		if (par->index == 0) {
>  			output->paths = sm750_panel;
>  			crtc->channel = sm750_primary;
>  			crtc->o_screen = 0;
> -			crtc->v_screen = sm750_dev->pvMem;
> +			crtc->v_screen = sm750_dev->fb_mem;
>  		} else {
>  			output->paths = sm750_crt;
>  			crtc->channel = sm750_secondary;
>  			/* not consider of padding stuffs for o_screen,need fix */
>  			crtc->o_screen = sm750_dev->vidmem_size >> 1;
> -			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
> +			crtc->v_screen = sm750_dev->fb_mem + crtc->o_screen;
>  		}
>  		break;
>  	case sm750_dual_swap:
> @@ -646,7 +644,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
>  			output->paths = sm750_panel;
>  			crtc->channel = sm750_secondary;
>  			crtc->o_screen = 0;
> -			crtc->v_screen = sm750_dev->pvMem;
> +			crtc->v_screen = sm750_dev->fb_mem;
>  		} else {
>  			output->paths = sm750_crt;
>  			crtc->channel = sm750_primary;
> @@ -654,7 +652,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
>  			 * need fix
>  			 */
>  			crtc->o_screen = sm750_dev->vidmem_size >> 1;
> -			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
> +			crtc->v_screen = sm750_dev->fb_mem + crtc->o_screen;
>  		}
>  		break;
>  	default:
> @@ -752,13 +750,13 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>  	 * must be set after crtc member initialized
>  	 */
>  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
> -	crtc->cursor.mmio = sm750_dev->pvReg +
> +	crtc->cursor.mmio = sm750_dev->reg_base +
>  		0x800f0 + (int)crtc->channel * 0x140;
>  
>  	crtc->cursor.max_h = 64;
>  	crtc->cursor.max_w = 64;
>  	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
> -	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
> +	crtc->cursor.vstart = sm750_dev->fb_mem + crtc->cursor.offset;
>  
>  	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
>  	if (!g_hwcursor)
> @@ -777,15 +775,16 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>  		else
>  			info->fbops = &lynxfb_ops_with_cursor;
>  	}
> +	const char *mode = g_fbmode[index];
>  
> -	if (!g_fbmode[index]) {
> -		g_fbmode[index] = g_def_fbmode;
> -		if (index)
> -			g_fbmode[index] = g_fbmode[0];
> +	if (!mode) {
> +		mode = g_def_fbmode;
> +		if (index && g_fbmode[0])
> +			mode = g_fbmode[0];
>  	}
>  
>  	for (i = 0; i < 3; i++) {
> -		ret = fb_find_mode(var, info, g_fbmode[index],
> +		ret = fb_find_mode(var, info, mode,
>  				   pdb[i], cdb[i], NULL, 8);
>  
>  		if (ret == 1 || ret == 2)
> @@ -856,9 +855,9 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>  	sm750_dev->init_parm.chip_clk = 0;
>  	sm750_dev->init_parm.mem_clk = 0;
>  	sm750_dev->init_parm.master_clk = 0;
> -	sm750_dev->init_parm.powerMode = 0;
> -	sm750_dev->init_parm.setAllEngOff = 0;
> -	sm750_dev->init_parm.resetMemory = 1;
> +	sm750_dev->init_parm.power_mode = 0;
> +	sm750_dev->init_parm.set_all_eng_off = 0;
> +	sm750_dev->init_parm.reset_memory = 1;
>  
>  	/* defaultly turn g_hwcursor on for both view */
>  	g_hwcursor = 3;
> @@ -877,9 +876,9 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>  		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
>  			sm750_dev->nocrt = 1;
>  		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
> -			sm750_dev->pnltype = sm750_doubleTFT;
> +			sm750_dev->pnltype = sm750_double_tft;
>  		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
> -			sm750_dev->pnltype = sm750_dualTFT;
> +			sm750_dev->pnltype = sm750_dual_tft;
>  		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
>  			sm750_dev->pnltype = sm750_24TFT;
>  		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
> @@ -1025,7 +1024,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
>  		sm750_dev->mtrr.vram = arch_phys_wc_add(sm750_dev->vidmem_start,
>  							sm750_dev->vidmem_size);
>  
> -	memset_io(sm750_dev->pvMem, 0, sm750_dev->vidmem_size);
> +	memset_io(sm750_dev->fb_mem, 0, sm750_dev->vidmem_size);
>  
>  	pci_set_drvdata(pdev, sm750_dev);
>  
> @@ -1056,8 +1055,8 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
>  	sm750fb_framebuffer_release(sm750_dev);
>  	arch_phys_wc_del(sm750_dev->mtrr.vram);
>  
> -	iounmap(sm750_dev->pvReg);
> -	iounmap(sm750_dev->pvMem);
> +	iounmap(sm750_dev->reg_base);
> +	iounmap(sm750_dev->fb_mem);
>  	pci_release_region(pdev, 1);
>  	kfree(g_settings);
>  }
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index 67b9bfa23..130ec3770 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -14,8 +14,8 @@
>  
>  enum sm750_pnltype {
>  	sm750_24TFT = 0,	/* 24bit tft */
> -	sm750_dualTFT = 2,	/* dual 18 bit tft */
> -	sm750_doubleTFT = 1,	/* 36 bit double pixel tft */
> +	sm750_dual_tft = 2,	/* dual 18 bit tft */
> +	sm750_double_tft = 1,	/* 36 bit double pixel tft */
>  };
>  
>  /* vga channel is not concerned  */
> @@ -39,13 +39,13 @@ enum sm750_path {
>  };
>  
>  struct init_status {
> -	ushort powerMode;
> +	ushort power_mode;
>  	/* below three clocks are in unit of MHZ*/
>  	ushort chip_clk;
>  	ushort mem_clk;
>  	ushort master_clk;
> -	ushort setAllEngOff;
> -	ushort resetMemory;
> +	ushort set_all_eng_off;
> +	ushort reset_memory;
>  };
>  
>  struct lynx_accel {
> @@ -60,22 +60,22 @@ struct lynx_accel {
>  	int (*de_wait)(void);/* see if hardware ready to work */
>  
>  	int (*de_fillrect)(struct lynx_accel *accel,
> -			   u32 base, u32 pitch, u32 bpp,
> +			   u32 base, u32 pitch, u32 bits_per_pixel,
>  			   u32 x, u32 y, u32 width, u32 height,
>  			   u32 color, u32 rop);
>  
>  	int (*de_copyarea)(struct lynx_accel *accel,
>  			   u32 s_base, u32 s_pitch,
>  			   u32 sx, u32 sy,
> -			   u32 d_base, u32 d_pitch,
> -			   u32 bpp, u32 dx, u32 dy,
> +			   u32 dest_base, u32 dest_pitch,
> +			   u32 bits_per_pixel, u32 dx, u32 dy,
>  			   u32 width, u32 height,
>  			   u32 rop2);
>  
> -	int (*de_imageblit)(struct lynx_accel *accel, const char *p_srcbuf,
> -			    u32 src_delta, u32 start_bit, u32 d_base, u32 d_pitch,
> +	int (*de_imageblit)(struct lynx_accel *accel, const char *src_buf,
> +			    u32 src_pitch, u32 start_bit, u32 dest_base, u32 dest_pitch,
>  			    u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
> -			    u32 height, u32 f_color, u32 b_color, u32 rop2);
> +			    u32 height, u32 fg_color, u32 bg_color, u32 rop2);
>  
>  };
>  
> @@ -97,8 +97,8 @@ struct sm750_dev {
>  	unsigned long vidreg_start;
>  	__u32 vidmem_size;
>  	__u32 vidreg_size;
> -	void __iomem *pvReg;
> -	unsigned char __iomem *pvMem;
> +	void __iomem *reg_base;
> +	unsigned char __iomem *fb_mem;
>  	/* locks*/
>  	spinlock_t slock;
>  
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 0f94d859e..b72d7f78e 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -48,7 +48,7 @@ void sm750_hw_de_init(struct lynx_accel *accel)
>  	      DE_STRETCH_FORMAT_ADDRESSING_MASK |
>  	      DE_STRETCH_FORMAT_SOURCE_HEIGHT_MASK;
>  
> -	/* DE_STRETCH bpp format need be initialized in setMode routine */
> +	/* DE_STRETCH bits_per_pixel format need be initialized in setMode routine */
>  	write_dpr(accel, DE_STRETCH_FORMAT,
>  		  (read_dpr(accel, DE_STRETCH_FORMAT) & ~clr) | reg);
>  
> @@ -76,7 +76,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
>  {
>  	u32 reg;
>  
> -	/* fmt=0,1,2 for 8,16,32,bpp on sm718/750/502 */
> +	/* fmt=0,1,2 for 8,16,32,bits_per_pixel on sm718/750/502 */
>  	reg = read_dpr(accel, DE_STRETCH_FORMAT);
>  	reg &= ~DE_STRETCH_FORMAT_PIXEL_FORMAT_MASK;
>  	reg |= ((fmt << DE_STRETCH_FORMAT_PIXEL_FORMAT_SHIFT) &
> @@ -85,7 +85,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
>  }
>  
>  int sm750_hw_fillrect(struct lynx_accel *accel,
> -		      u32 base, u32 pitch, u32 Bpp,
> +		      u32 base, u32 pitch, u32 bits_per_pixel,
>  		      u32 x, u32 y, u32 width, u32 height,
>  		      u32 color, u32 rop)
>  {
> @@ -102,14 +102,14 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>  
>  	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
>  	write_dpr(accel, DE_PITCH,
> -		  ((pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
> +		  ((pitch / bits_per_pixel << DE_PITCH_DESTINATION_SHIFT) &
>  		   DE_PITCH_DESTINATION_MASK) |
> -		  (pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
> +		  (pitch / bits_per_pixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
>  
>  	write_dpr(accel, DE_WINDOW_WIDTH,
> -		  ((pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
> +		  ((pitch / bits_per_pixel << DE_WINDOW_WIDTH_DST_SHIFT) &
>  		   DE_WINDOW_WIDTH_DST_MASK) |
> -		   (pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
> +		   (pitch / bits_per_pixel & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
>  
>  	write_dpr(accel, DE_FOREGROUND, color); /* DPR14 */
>  
> @@ -138,7 +138,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>   * @sy: Starting y coordinate of source surface
>   * @dest_base: Address of destination: offset in frame buffer
>   * @dest_pitch: Pitch value of destination surface in BYTE
> - * @Bpp: Color depth of destination surface
> + * @bits_per_pixel: Color depth of destination surface
>   * @dx: Starting x coordinate of destination surface
>   * @dy: Starting y coordinate of destination surface
>   * @width: width of rectangle in pixel value
> @@ -149,7 +149,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
>  		      unsigned int source_base, unsigned int source_pitch,
>  		      unsigned int sx, unsigned int sy,
>  		      unsigned int dest_base, unsigned int dest_pitch,
> -		      unsigned int Bpp, unsigned int dx, unsigned int dy,
> +		      unsigned int bits_per_pixel, unsigned int dx, unsigned int dy,
>  		      unsigned int width, unsigned int height,
>  		      unsigned int rop2)
>  {
> @@ -249,9 +249,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
>  	 * pixel values. Need Byte to pixel conversion.
>  	 */
>  	write_dpr(accel, DE_PITCH,
> -		  ((dest_pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
> +		  ((dest_pitch / bits_per_pixel << DE_PITCH_DESTINATION_SHIFT) &
>  		   DE_PITCH_DESTINATION_MASK) |
> -		  (source_pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
> +		  (source_pitch / bits_per_pixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
>  
>  	/*
>  	 * Screen Window width in Pixels.
> @@ -259,9 +259,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
>  	 * for a given point.
>  	 */
>  	write_dpr(accel, DE_WINDOW_WIDTH,
> -		  ((dest_pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
> +		  ((dest_pitch / bits_per_pixel << DE_WINDOW_WIDTH_DST_SHIFT) &
>  		   DE_WINDOW_WIDTH_DST_MASK) |
> -		  (source_pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
> +		  (source_pitch / bits_per_pixel & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
>  
>  	if (accel->de_wait() != 0)
>  		return -1;
> @@ -300,7 +300,7 @@ static unsigned int de_get_transparency(struct lynx_accel *accel)
>   * sm750_hw_imageblit
>   * @accel: Acceleration device data
>   * @src_buf: pointer to start of source buffer in system memory
> - * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
> + * @src_pitch: Pitch value (in bytes) of the source buffer, +ive means top down
>   *	      and -ive mean button up
>   * @start_bit: Mono data can start at any bit in a byte, this value should be
>   *	      0 to 7
> @@ -316,7 +316,7 @@ static unsigned int de_get_transparency(struct lynx_accel *accel)
>   * @rop2: ROP value
>   */
>  int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
> -		       u32 src_delta, u32 start_bit, u32 dest_base, u32 dest_pitch,
> +		       u32 src_pitch, u32 start_bit, u32 dest_base, u32 dest_pitch,
>  		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
>  		       u32 height, u32 fg_color, u32 bg_color, u32 rop2)
>  {
> @@ -405,7 +405,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
>  			write_dp_port(accel, *(unsigned int *)remain);
>  		}
>  
> -		src_buf += src_delta;
> +		src_buf += src_pitch;
>  	}
>  
>  	return 0;
> diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
> index 2c79cb730..d0b3b653a 100644
> --- a/drivers/staging/sm750fb/sm750_accel.h
> +++ b/drivers/staging/sm750fb/sm750_accel.h
> @@ -190,19 +190,19 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt);
>  void sm750_hw_de_init(struct lynx_accel *accel);
>  
>  int sm750_hw_fillrect(struct lynx_accel *accel,
> -		      u32 base, u32 pitch, u32 Bpp,
> +		      u32 base, u32 pitch, u32 bits_per_pixel,
>  		      u32 x, u32 y, u32 width, u32 height,
>  		      u32 color, u32 rop);
>  
>  /**
> - * sm750_hm_copyarea
> - * @sBase: Address of source: offset in frame buffer
> - * @sPitch: Pitch value of source surface in BYTE
> + * sm750_hw_copyarea
> + * @s_base: Address of source: offset in frame buffer
> + * @s_pitch: Pitch value of source surface in BYTE
>   * @sx: Starting x coordinate of source surface
>   * @sy: Starting y coordinate of source surface
> - * @dBase: Address of destination: offset in frame buffer
> - * @dPitch: Pitch value of destination surface in BYTE
> - * @Bpp: Color depth of destination surface
> + * @dest_base: Address of destination: offset in frame buffer
> + * @dest_pitch: Pitch value of destination surface in BYTE
> + * @bits_per_pixel: Color depth of destination surface
>   * @dx: Starting x coordinate of destination surface
>   * @dy: Starting y coordinate of destination surface
>   * @width: width of rectangle in pixel value
> @@ -210,34 +210,34 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>   * @rop2: ROP value
>   */
>  int sm750_hw_copyarea(struct lynx_accel *accel,
> -		      unsigned int sBase, unsigned int sPitch,
> +		      unsigned int s_base, unsigned int s_pitch,
>  		      unsigned int sx, unsigned int sy,
> -		      unsigned int dBase, unsigned int dPitch,
> -		      unsigned int Bpp, unsigned int dx, unsigned int dy,
> +		      unsigned int dest_base, unsigned int dest_pitch,
> +		      unsigned int bits_per_pixel, unsigned int dx, unsigned int dy,
>  		      unsigned int width, unsigned int height,
>  		      unsigned int rop2);
>  
>  /**
>   * sm750_hw_imageblit
> - * @pSrcbuf: pointer to start of source buffer in system memory
> - * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
> + * @src_buf: pointer to start of source buffer in system memory
> + * @src_pitch: Pitch value (in bytes) of the source buffer, +ive means top down
>   *>-----      and -ive mean button up
> - * @startBit: Mono data can start at any bit in a byte, this value should be
> + * @start_bit: Mono data can start at any bit in a byte, this value should be
>   *>-----      0 to 7
> - * @dBase: Address of destination: offset in frame buffer
> - * @dPitch: Pitch value of destination surface in BYTE
> - * @bytePerPixel: Color depth of destination surface
> + * @dest_base: Address of destination: offset in frame buffer
> + * @dest_pitch: Pitch value of destination surface in BYTE
> + * @byte_per_pixel: Color depth of destination surface
>   * @dx: Starting x coordinate of destination surface
>   * @dy: Starting y coordinate of destination surface
>   * @width: width of rectangle in pixel value
>   * @height: height of rectangle in pixel value
> - * @fColor: Foreground color (corresponding to a 1 in the monochrome data
> - * @bColor: Background color (corresponding to a 0 in the monochrome data
> + * @fg_color: Foreground color (corresponding to a 1 in the monochrome data
> + * @bg_color: Background color (corresponding to a 0 in the monochrome data
>   * @rop2: ROP value
>   */
> -int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
> -		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
> -		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
> -		       u32 height, u32 fColor, u32 bColor, u32 rop2);
> +int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
> +		       u32 src_pitch, u32 start_bit, u32 dest_base, u32 dest_pitch,
> +		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
> +		       u32 height, u32 fg_color, u32 bg_color, u32 rop2);
>  
>  #endif
> diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
> index 7ede14490..f0338e6e7 100644
> --- a/drivers/staging/sm750fb/sm750_cursor.c
> +++ b/drivers/staging/sm750fb/sm750_cursor.c
> @@ -130,46 +130,3 @@ void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
>  		}
>  	}
>  }
> -
> -void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
> -			       const u8 *pcol, const u8 *pmsk)
> -{
> -	int i, j, count, pitch, offset;
> -	u8 color, mask;
> -	u16 data;
> -	void __iomem *pbuffer, *pstart;
> -
> -	/*  in byte*/
> -	pitch = cursor->w >> 3;
> -
> -	/* in byte	*/
> -	count = pitch * cursor->h;
> -
> -	/* in byte */
> -	offset = cursor->max_w * 2 / 8;
> -
> -	data = 0;
> -	pstart = cursor->vstart;
> -	pbuffer = pstart;
> -
> -	for (i = 0; i < count; i++) {
> -		color = *pcol++;
> -		mask = *pmsk++;
> -		data = 0;
> -
> -		for (j = 0; j < 8; j++) {
> -			if (mask & (1 << j))
> -				data |= ((color & (1 << j)) ? 1 : 2) << (j * 2);
> -		}
> -		iowrite16(data, pbuffer);
> -
> -		/* assume pitch is 1,2,4,8,...*/
> -		if (!(i & (pitch - 1))) {
> -			/* need a return */
> -			pstart += offset;
> -			pbuffer = pstart;
> -		} else {
> -			pbuffer += sizeof(u16);
> -		}
> -	}
> -}
> diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
> index 88fa02f63..51ba0da02 100644
> --- a/drivers/staging/sm750fb/sm750_cursor.h
> +++ b/drivers/staging/sm750fb/sm750_cursor.h
> @@ -10,6 +10,4 @@ void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
>  void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg);
>  void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
>  			      const u8 *data, const u8 *mask);
> -void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
> -			       const u8 *data, const u8 *mask);
>  #endif
> diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
> index a2798d428..b1045b088 100644
> --- a/drivers/staging/sm750fb/sm750_hw.c
> +++ b/drivers/staging/sm750fb/sm750_hw.c
> @@ -42,18 +42,18 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
>  	}
>  
>  	/* now map mmio and vidmem */
> -	sm750_dev->pvReg =
> +	sm750_dev->reg_base =
>  		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
> -	if (!sm750_dev->pvReg) {
> +	if (!sm750_dev->reg_base) {
>  		dev_err(&pdev->dev, "mmio failed\n");
>  		ret = -EFAULT;
>  		goto err_release_region;
>  	}
>  
> -	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
> -	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
> +	sm750_dev->accel.dpr_base = sm750_dev->reg_base + DE_BASE_ADDR_TYPE1;
> +	sm750_dev->accel.dp_port_base = sm750_dev->reg_base + DE_PORT_ADDR_TYPE1;
>  
> -	mmio750 = sm750_dev->pvReg;
> +	mmio750 = sm750_dev->reg_base;
>  	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
>  
>  	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
> @@ -66,9 +66,9 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
>  	sm750_dev->vidmem_size = ddk750_get_vm_size();
>  
>  	/* reserve the vidmem space of smi adaptor */
> -	sm750_dev->pvMem =
> +	sm750_dev->fb_mem =
>  		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
> -	if (!sm750_dev->pvMem) {
> +	if (!sm750_dev->fb_mem) {
>  		dev_err(&pdev->dev, "Map video memory failed\n");
>  		ret = -EFAULT;
>  		goto err_unmap_reg;
> @@ -77,7 +77,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
>  	return 0;
>  
>  err_unmap_reg:
> -	iounmap(sm750_dev->pvReg);
> +	iounmap(sm750_dev->reg_base);
>  err_release_region:
>  	pci_release_region(pdev, 1);
>  	return ret;
> @@ -130,10 +130,10 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
>  		switch (sm750_dev->pnltype) {
>  		case sm750_24TFT:
>  			break;
> -		case sm750_doubleTFT:
> +		case sm750_double_tft:
>  			val |= PANEL_DISPLAY_CTRL_DOUBLE_PIXEL;
>  			break;
> -		case sm750_dualTFT:
> +		case sm750_dual_tft:
>  			val |= PANEL_DISPLAY_CTRL_DUAL_DISPLAY;
>  			break;
>  		}
> @@ -248,7 +248,7 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
>  	sm750_dev = par->dev;
>  
>  	if (!sm750_dev->accel_off) {
> -		/* set 2d engine pixel format according to mode bpp */
> +		/* set 2d engine pixel format according to mode bits_per_pixel */
>  		switch (var->bits_per_pixel) {
>  		case 8:
>  			fmt = 0;
> -- 
> 2.53.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
