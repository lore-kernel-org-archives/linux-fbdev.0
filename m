Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38843E4BF;
	Mon, 11 May 2026 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518506; cv=none; b=o3QiOYc2bqk/qzbRpP/gflpF7tocrTOnkZWG66d3PG/iOxkIXq47d1Pno9+8Dg8TMTspf4ksEdjalgvzU2QkR/YmkQ3fNpG8vcf6P75gW6i/P75ay9igAXQXw+wOyVcL+l7FGSZUs8HAEBPX4N8AFXIbW/Jw7Tmq5bweLI+5Z8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518506; c=relaxed/simple;
	bh=m4iMRXsP+cyxo2K3oDa/1HBNQaSx71w6Ss/KEaO1Wfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU5CL4ENZLUUnJW6V4vLO1n4E5GCTa26PQe7m6MSWDl+9lhDFcX8zy0P++2NCUw54DYGAzVXWoZ8Q8wuvMxaezoQy5+xbiJsMpboOpgYpyfZ1Wdhnebs3v3PNMnNBSxeqh6+oxpo1QRkMvw7b/Rq6ziDdm1SmAErIU1B7fgJDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W6YmA/lh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W6YmA/lh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86FBC2BCC9;
	Mon, 11 May 2026 16:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778518506;
	bh=m4iMRXsP+cyxo2K3oDa/1HBNQaSx71w6Ss/KEaO1Wfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6YmA/lhnJRRg5cfgzBuu54LY1lClsILYbmbHHOUZrJyHQ8/cA4YWoUFmCNEKkSA8
	 z0RmVTCW5zv1Gz9TEmo64SDG+k5eFuzWO+JrjC1VhATMfnVzEosqCnK/syNyqr538+
	 dUz6+EYjogHPLv0H2clqhOQhNv6Lj0X5yFmkC5Xo=
Date: Mon, 11 May 2026 18:55:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chhabilal Dangal <yogeshdangal66@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: minor coding style cleanup
Message-ID: <2026051136-roving-goldmine-d65c@gregkh>
References: <20260511160905.29938-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511160905.29938-1-yogeshdangal66@gmail.com>

On Mon, May 11, 2026 at 09:54:05PM +0545, Chhabilal Dangal wrote:
> Clean up various coding style issues including spacing in struct initializers and indentation of wrapped lines.
> 
> Signed-off-by: Alone <yogeshdangal66@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 203 ++++++++++++++++----------------
>  1 file changed, 103 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 9f3e3d37e82a..7fca2c9f6966 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,7 +33,8 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel;
>  static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> +/* intentionally non-const since array is modified at runtime */
> +static const char *g_fbmode[] = { NULL, NULL };
>  static const char *g_def_fbmode = "1024x768-32@60";
>  static char *g_settings;
>  static int g_dualview;
> @@ -41,64 +42,62 @@ static char *g_option;
>  
>  static const struct fb_videomode lynx750_ext[] = {
>  	/*	1024x600-60 VESA	[1.71:1] */
> -	{NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
> -	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -	 FB_VMODE_NONINTERLACED},
> +	{ NULL, 60, 1024, 600, 20423, 144, 40, 18, 1, 104, 3,
> +	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +	  FB_VMODE_NONINTERLACED },
>  
>  	/*	1024x600-70 VESA */
> -	{NULL,  70, 1024, 600, 17211, 152,  48, 21, 1, 104, 3,
> -	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -	 FB_VMODE_NONINTERLACED},
> +	{ NULL, 70, 1024, 600, 17211, 152, 48, 21, 1, 104, 3,
> +	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +	  FB_VMODE_NONINTERLACED },
>  
>  	/*	1024x600-75 VESA */
> -	{NULL,  75, 1024, 600, 15822, 160,  56, 23, 1, 104, 3,
> -	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -	 FB_VMODE_NONINTERLACED},
> +	{ NULL, 75, 1024, 600, 15822, 160, 56, 23, 1, 104, 3,
> +	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +	  FB_VMODE_NONINTERLACED },
>  
>  	/*	1024x600-85 VESA */
> -	{NULL,  85, 1024, 600, 13730, 168,  56, 26, 1, 112, 3,
> -	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -	 FB_VMODE_NONINTERLACED},
> +	{ NULL, 85, 1024, 600, 13730, 168, 56, 26, 1, 112, 3,
> +	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +	  FB_VMODE_NONINTERLACED },
>  
>  	/*	720x480	*/
> -	{NULL, 60,  720,  480,  37427, 88,   16, 13, 1,   72,  3,
> -	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -	 FB_VMODE_NONINTERLACED},
> +	{ NULL, 60, 720, 480, 37427, 88, 16, 13, 1, 72, 3,
> +	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +	  FB_VMODE_NONINTERLACED },
>  
>  	/*	1280x720		[1.78:1]	*/
> -	{NULL, 60,  1280,  720,  13426, 162, 86, 22, 1,  136, 3,
> -	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -	 FB_VMODE_NONINTERLACED},
> +	{ NULL, 60, 1280, 720, 13426, 162, 86, 22, 1, 136, 3,
> +	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +	  FB_VMODE_NONINTERLACED },
>  
>  	/*	1280x768@60 */
> -	{NULL, 60, 1280, 768, 12579, 192, 64, 20, 3, 128, 7,
> -	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -	 FB_VMODE_NONINTERLACED},
> +	{ NULL, 60, 1280, 768, 12579, 192, 64, 20, 3, 128, 7,
> +	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +	  FB_VMODE_NONINTERLACED },
>  
>  	/*	1360 x 768	[1.77083:1]	*/
> -	{NULL,  60, 1360, 768, 11804, 208,  64, 23, 1, 144, 3,
> -	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -	 FB_VMODE_NONINTERLACED},
> +	{ NULL, 60, 1360, 768, 11804, 208, 64, 23, 1, 144, 3,
> +	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +	  FB_VMODE_NONINTERLACED },
>  
>  	/*	1368 x 768      [1.78:1]	*/
> -	{NULL, 60,  1368,  768,  11647, 216, 72, 23, 1,  144, 3,
> -	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -	 FB_VMODE_NONINTERLACED},
> +	{ NULL, 60, 1368, 768, 11647, 216, 72, 23, 1, 144, 3,
> +	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +	  FB_VMODE_NONINTERLACED },
>  
>  	/*	1440 x 900		[16:10]	*/
> -	{NULL, 60, 1440, 900, 9392, 232, 80, 28, 1, 152, 3,
> -	 FB_SYNC_VERT_HIGH_ACT,
> -	 FB_VMODE_NONINTERLACED},
> +	{ NULL, 60, 1440, 900, 9392, 232, 80, 28, 1, 152, 3,
> +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
>  
>  	/*	1440x960		[15:10]	*/
> -	{NULL, 60, 1440, 960, 8733, 240, 88, 30, 1, 152, 3,
> -	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -	 FB_VMODE_NONINTERLACED},
> +	{ NULL, 60, 1440, 960, 8733, 240, 88, 30, 1, 152, 3,
> +	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +	  FB_VMODE_NONINTERLACED },
>  
>  	/*	1920x1080	[16:9]	*/
> -	{NULL, 60, 1920, 1080, 6734, 148, 88, 41, 1, 44, 3,
> -	 FB_SYNC_VERT_HIGH_ACT,
> -	 FB_VMODE_NONINTERLACED},
> +	{ NULL, 60, 1920, 1080, 6734, 148, 88, 41, 1, 44, 3,
> +	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
>  };
>  
>  /* no hardware cursor supported under version 2.6.10, kernel bug */
> @@ -120,8 +119,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  
>  	sm750_hw_cursor_disable(cursor);
>  	if (fbcursor->set & FB_CUR_SETSIZE)
> -		sm750_hw_cursor_set_size(cursor,
> -					 fbcursor->image.width,
> +		sm750_hw_cursor_set_size(cursor, fbcursor->image.width,
>  					 fbcursor->image.height);
>  
>  	if (fbcursor->set & FB_CUR_SETPOS)
> @@ -134,19 +132,23 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  		u16 fg, bg;
>  
>  		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800)) |
> -		     ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5) |
> -		     ((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
> +		     ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >>
> +		      5) |
> +		     ((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >>
> +		      11);
>  
>  		bg = ((info->cmap.red[fbcursor->image.bg_color] & 0xf800)) |
> -		     ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
> -		     ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
> +		     ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >>
> +		      5) |
> +		     ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >>
> +		      11);
>  
>  		sm750_hw_cursor_set_color(cursor, fg, bg);
>  	}
>  
>  	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
> -		sm750_hw_cursor_set_data(cursor, fbcursor->rop, fbcursor->image.data,
> -					 fbcursor->mask);
> +		sm750_hw_cursor_set_data(cursor, fbcursor->rop,
> +					 fbcursor->image.data, fbcursor->mask);
>  	}
>  
>  	if (fbcursor->enable)
> @@ -178,7 +180,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
>  	bpp = info->var.bits_per_pixel >> 3;
>  
>  	color = (bpp == 1) ? region->color :
> -		((u32 *)info->pseudo_palette)[region->color];
> +			     ((u32 *)info->pseudo_palette)[region->color];
>  	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR : HW_ROP2_COPY;
>  
>  	/*
> @@ -189,11 +191,9 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
>  	 */
>  	spin_lock(&sm750_dev->slock);
>  
> -	sm750_dev->accel.de_fillrect(&sm750_dev->accel,
> -				     base, pitch, bpp,
> -				     region->dx, region->dy,
> -				     region->width, region->height,
> -				     color, rop);
> +	sm750_dev->accel.de_fillrect(&sm750_dev->accel, base, pitch, bpp,
> +				     region->dx, region->dy, region->width,
> +				     region->height, color, rop);
>  	spin_unlock(&sm750_dev->slock);
>  }
>  
> @@ -223,10 +223,9 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
>  	 */
>  	spin_lock(&sm750_dev->slock);
>  
> -	sm750_dev->accel.de_copyarea(&sm750_dev->accel,
> -				     base, pitch, region->sx, region->sy,
> -				     base, pitch, bpp, region->dx, region->dy,
> -				     region->width, region->height,
> +	sm750_dev->accel.de_copyarea(&sm750_dev->accel, base, pitch, region->sx,
> +				     region->sy, base, pitch, bpp, region->dx,
> +				     region->dy, region->width, region->height,
>  				     HW_ROP2_COPY);
>  	spin_unlock(&sm750_dev->slock);
>  }
> @@ -272,12 +271,11 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
>  	 */
>  	spin_lock(&sm750_dev->slock);
>  
> -	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
> -				      image->data, image->width >> 3, 0,
> -				      base, pitch, bpp,
> -				      image->dx, image->dy,
> -				      image->width, image->height,
> -				      fgcol, bgcol, HW_ROP2_COPY);
> +	sm750_dev->accel.de_imageblit(&sm750_dev->accel, image->data,
> +				      image->width >> 3, 0, base, pitch, bpp,
> +				      image->dx, image->dy, image->width,
> +				      image->height, fgcol, bgcol,
> +				      HW_ROP2_COPY);
>  	spin_unlock(&sm750_dev->slock);
>  }
>  
> @@ -385,7 +383,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
>  
>  	var->height = -1;
>  	var->width = -1;
> -	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
> +	var->accel_flags = 0; /*FB_ACCELF_TEXT;*/
>  
>  	if (ret) {
>  		dev_err(info->device, "bpp %d not supported\n",
> @@ -498,7 +496,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
>  
>  	var->height = -1;
>  	var->width = -1;
> -	var->accel_flags = 0;/* FB_ACCELF_TEXT; */
> +	var->accel_flags = 0; /* FB_ACCELF_TEXT; */
>  
>  	/* check if current fb's video memory big enough to hold the onscreen*/
>  	request = var->xres_virtual * (var->bits_per_pixel >> 3);
> @@ -514,12 +512,9 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
>  	return hw_sm750_crtc_check_mode(crtc, var);
>  }
>  
> -static int lynxfb_ops_setcolreg(unsigned int regno,
> -				unsigned int red,
> -				unsigned int green,
> -				unsigned int blue,
> -				unsigned int transp,
> -				struct fb_info *info)
> +static int lynxfb_ops_setcolreg(unsigned int regno, unsigned int red,
> +				unsigned int green, unsigned int blue,
> +				unsigned int transp, struct fb_info *info)
>  {
>  	struct lynxfb_par *par;
>  	struct lynxfb_crtc *crtc;
> @@ -556,8 +551,7 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
>  	if (info->fix.visual == FB_VISUAL_TRUECOLOR && regno < 256) {
>  		u32 val;
>  
> -		if (var->bits_per_pixel == 16 ||
> -		    var->bits_per_pixel == 32 ||
> +		if (var->bits_per_pixel == 16 || var->bits_per_pixel == 32 ||
>  		    var->bits_per_pixel == 24) {
>  			val = chan_to_field(red, &var->red);
>  			val |= chan_to_field(green, &var->green);
> @@ -616,7 +610,8 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
>  
>  	/* chip specific phase */
>  	sm750_dev->accel.de_wait = (sm750_dev->revid == SM750LE_REVISION_ID) ?
> -				    hw_sm750le_de_wait : hw_sm750_de_wait;
> +					   hw_sm750le_de_wait :
> +					   hw_sm750_de_wait;
>  	switch (sm750_dev->dataflow) {
>  	case sm750_simul_pri:
>  		output->paths = sm750_pnc;
> @@ -670,7 +665,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
>  static const struct fb_ops lynxfb_ops = {
>  	.owner = THIS_MODULE,
>  	FB_DEFAULT_IOMEM_OPS,
> -	.fb_check_var =  lynxfb_ops_check_var,
> +	.fb_check_var = lynxfb_ops_check_var,
>  	.fb_set_par = lynxfb_ops_set_par,
>  	.fb_setcolreg = lynxfb_ops_setcolreg,
>  	.fb_blank = lynxfb_ops_blank,
> @@ -680,7 +675,7 @@ static const struct fb_ops lynxfb_ops = {
>  static const struct fb_ops lynxfb_ops_with_cursor = {
>  	.owner = THIS_MODULE,
>  	FB_DEFAULT_IOMEM_OPS,
> -	.fb_check_var =  lynxfb_ops_check_var,
> +	.fb_check_var = lynxfb_ops_check_var,
>  	.fb_set_par = lynxfb_ops_set_par,
>  	.fb_setcolreg = lynxfb_ops_setcolreg,
>  	.fb_blank = lynxfb_ops_blank,
> @@ -691,7 +686,7 @@ static const struct fb_ops lynxfb_ops_with_cursor = {
>  static const struct fb_ops lynxfb_ops_accel = {
>  	.owner = THIS_MODULE,
>  	__FB_DEFAULT_IOMEM_OPS_RDWR,
> -	.fb_check_var =  lynxfb_ops_check_var,
> +	.fb_check_var = lynxfb_ops_check_var,
>  	.fb_set_par = lynxfb_ops_set_par,
>  	.fb_setcolreg = lynxfb_ops_setcolreg,
>  	.fb_blank = lynxfb_ops_blank,
> @@ -705,7 +700,7 @@ static const struct fb_ops lynxfb_ops_accel = {
>  static const struct fb_ops lynxfb_ops_accel_with_cursor = {
>  	.owner = THIS_MODULE,
>  	__FB_DEFAULT_IOMEM_OPS_RDWR,
> -	.fb_check_var =  lynxfb_ops_check_var,
> +	.fb_check_var = lynxfb_ops_check_var,
>  	.fb_set_par = lynxfb_ops_set_par,
>  	.fb_setcolreg = lynxfb_ops_setcolreg,
>  	.fb_blank = lynxfb_ops_blank,
> @@ -728,11 +723,14 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>  	struct fb_fix_screeninfo *fix;
>  
>  	const struct fb_videomode *pdb[] = {
> -		lynx750_ext, NULL, vesa_modes,
> +		lynx750_ext,
> +		NULL,
> +		vesa_modes,
>  	};
> -	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
> +	int cdb[] = { ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE };
>  	static const char *fix_id[2] = {
> -		"sm750_fb1", "sm750_fb2",
> +		"sm750_fb1",
> +		"sm750_fb2",
>  	};
>  
>  	int ret, line_length;
> @@ -755,8 +753,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>  	 * must be set after crtc member initialized
>  	 */
>  	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
> -	crtc->cursor.mmio = sm750_dev->pvReg +
> -		0x800f0 + (int)crtc->channel * 0x140;
> +	crtc->cursor.mmio =
> +		sm750_dev->pvReg + 0x800f0 + (int)crtc->channel * 0x140;
>  
>  	crtc->cursor.max_h = 64;
>  	crtc->cursor.max_w = 64;
> @@ -788,8 +786,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>  	}
>  
>  	for (i = 0; i < 3; i++) {
> -		ret = fb_find_mode(var, info, g_fbmode[index],
> -				   pdb[i], cdb[i], NULL, 8);
> +		ret = fb_find_mode(var, info, g_fbmode[index], pdb[i], cdb[i],
> +				   NULL, 8);
>  
>  		if (ret == 1 || ret == 2)
>  			break;
> @@ -901,7 +899,8 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>  				dev_info(&sm750_dev->pdev->dev,
>  					 "find fbmode1 : %s\n", g_fbmode[1]);
>  			} else {
> -				dev_warn(&sm750_dev->pdev->dev, "How many view you wann set?\n");
> +				dev_warn(&sm750_dev->pdev->dev,
> +					 "How many view you wann set?\n");
>  			}
>  		}
>  	}
> @@ -1112,8 +1111,12 @@ static int __init lynxfb_setup(char *options)
>  }
>  
>  static const struct pci_device_id smi_pci_table[] = {
> -	{ PCI_DEVICE(0x126f, 0x0750), },
> -	{0,}
> +	{
> +		PCI_DEVICE(0x126f, 0x0750),
> +	},
> +	{
> +		0,
> +	}
>  };
>  
>  MODULE_DEVICE_TABLE(pci, smi_pci_table);
> @@ -1121,11 +1124,11 @@ MODULE_DEVICE_TABLE(pci, smi_pci_table);
>  static SIMPLE_DEV_PM_OPS(lynxfb_pm_ops, lynxfb_suspend, lynxfb_resume);
>  
>  static struct pci_driver lynxfb_driver = {
> -	.name =		"sm750fb",
> -	.id_table =	smi_pci_table,
> -	.probe =	lynxfb_pci_probe,
> -	.remove =	lynxfb_pci_remove,
> -	.driver.pm =	&lynxfb_pm_ops,
> +	.name = "sm750fb",
> +	.id_table = smi_pci_table,
> +	.probe = lynxfb_pci_probe,
> +	.remove = lynxfb_pci_remove,
> +	.driver.pm = &lynxfb_pm_ops,
>  };
>  
>  static int __init lynxfb_init(void)
> @@ -1155,15 +1158,15 @@ module_exit(lynxfb_exit);
>  
>  module_param(g_option, charp, 0444);
>  
> -MODULE_PARM_DESC(g_option,
> -		 "\n\t\tCommon options:\n"
> -		 "\t\tnoaccel:disable 2d capabilities\n"
> -		 "\t\tnomtrr:disable MTRR attribute for video memory\n"
> -		 "\t\tdualview:dual frame buffer feature enabled\n"
> -		 "\t\tnohwc:disable hardware cursor\n"
> -		 "\t\tUsual example:\n"
> -		 "\t\tinsmod ./sm750fb.ko g_option=\"noaccel,nohwc,1280x1024-8@60\"\n"
> -		 );
> +MODULE_PARM_DESC(
> +	g_option,
> +	"\n\t\tCommon options:\n"
> +	"\t\tnoaccel:disable 2d capabilities\n"
> +	"\t\tnomtrr:disable MTRR attribute for video memory\n"
> +	"\t\tdualview:dual frame buffer feature enabled\n"
> +	"\t\tnohwc:disable hardware cursor\n"
> +	"\t\tUsual example:\n"
> +	"\t\tinsmod ./sm750fb.ko g_option=\"noaccel,nohwc,1280x1024-8@60\"\n");
>  
>  MODULE_AUTHOR("monk liu <monk.liu@siliconmotion.com>");
>  MODULE_AUTHOR("Sudip Mukherjee <sudip@vectorindia.org>");
> -- 
> 2.54.0
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
