From: Michael Kelley <mikelley@microsoft.com>
Date: Sun, 18 Aug 2019 22:41:13 +0000
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver
Message-Id: <DM5PR21MB0137E0BB19D8A0E6385BB316D7A90@DM5PR21MB0137.namprd21.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190813103548.2008-1-weh@microsoft.com>
In-Reply-To: <20190813103548.2008-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "shc_work@mail.ru" <shc_work@mail.ru>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>, "info@metux.net" <info@metux.net>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Hai

From: Wei Hu <weh@microsoft.com> Sent: Tuesday, August 13, 2019 3:37 AM
> 
> Without deferred IO support, hyperv_fb driver informs the host to refresh
> the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter there
> is screen update or not. This patch supports defered IO for screens in

s/defered/deferred/

> graphic mode and also enables the framme buffer on-demand refresh. The

s/graphic/graphics/
s/framme/frame/

> highest refresh rate is still set at 20Hz.
> 
> Due to limitation on Hyper-V host, we keep a shadow copy of frame buffer

I think it might be worthwhile to explain exactly what the issue is so that
there's a record kept.

> in the guest. This means one more copy of the dirty rectangle inside
> guest when doing the on-demand refresh. This can be optimized in the
> future with help from host. For now the host performance gain from deferred
> IO outweighs the shadow copy impact in the guest.
> 
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/video/fbdev/Kconfig     |   1 +
>  drivers/video/fbdev/hyperv_fb.c | 217 +++++++++++++++++++++++++++++---
>  2 files changed, 198 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 1b2f5f31fb6f..e781f89a1824 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2241,6 +2241,7 @@ config FB_HYPERV
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> +	select FB_DEFERRED_IO
>  	help
>  	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
> 
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 1042f3311fa2..85198a6ea8e7 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -233,6 +233,7 @@ struct synthvid_msg {
>  #define RING_BUFSIZE (256 * 1024)
>  #define VSP_TIMEOUT (10 * HZ)
>  #define HVFB_UPDATE_DELAY (HZ / 20)
> +#define HVFB_ONDEMAND_THROTTLE (HZ / 20)
> 
>  struct hvfb_par {
>  	struct fb_info *info;
> @@ -252,6 +253,17 @@ struct hvfb_par {
>  	bool synchronous_fb;
> 
>  	struct notifier_block hvfb_panic_nb;
> +
> +	/* Memory for deferred IO and frame buffer itself */
> +	unsigned char *dio_vp;
> +	unsigned char *mmio_vp;
> +	unsigned long mmio_pp;
> +	spinlock_t docopy_lock; /* Lock to protect memory copy */
> +
> +	/* Dirty rectangle, protected by delayed_refresh_lock */
> +	int x1, y1, x2, y2;
> +	bool delayed_refresh;
> +	spinlock_t delayed_refresh_lock;
>  };
> 
>  static uint screen_width = HVFB_WIDTH;
> @@ -260,6 +272,7 @@ static uint screen_width_max = HVFB_WIDTH;
>  static uint screen_height_max = HVFB_HEIGHT;
>  static uint screen_depth;
>  static uint screen_fb_size;
> +static uint dio_fb_size; /* FB size for deferred IO */
> 
>  /* Send message to Hyper-V host */
>  static inline int synthvid_send(struct hv_device *hdev,
> @@ -346,28 +359,88 @@ static int synthvid_send_ptr(struct hv_device *hdev)
>  }
> 
>  /* Send updated screen area (dirty rectangle) location to host */
> -static int synthvid_update(struct fb_info *info)
> +static int
> +synthvid_update(struct fb_info *info, int x1, int y1, int x2, int y2)
>  {
>  	struct hv_device *hdev = device_to_hv_device(info->device);
>  	struct synthvid_msg msg;
> 
>  	memset(&msg, 0, sizeof(struct synthvid_msg));
> +	if (x2 == INT_MAX)
> +		x2 = info->var.xres;
> +	if (y2 == INT_MAX)
> +		y2 = info->var.yres;
> 
>  	msg.vid_hdr.type = SYNTHVID_DIRT;
>  	msg.vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
>  		sizeof(struct synthvid_dirt);
>  	msg.dirt.video_output = 0;
>  	msg.dirt.dirt_count = 1;
> -	msg.dirt.rect[0].x1 = 0;
> -	msg.dirt.rect[0].y1 = 0;
> -	msg.dirt.rect[0].x2 = info->var.xres;
> -	msg.dirt.rect[0].y2 = info->var.yres;
> +	msg.dirt.rect[0].x1 = (x1 < 0 || x1 > x2) ? 0 : x1;
> +	msg.dirt.rect[0].y1 = (y2 < 0 || y1 > y2) ? 0 : y1;

This should be:

	msg.dirt.rect[0].y1 = (y1 < 0 || y1 > y2) ? 0 : y1;

Also, throughout the code, I don't think there are any places where
x or y coordinate values are ever negative.  INT_MAX or 0 is used as the
sentinel value indicating "not set".  So can all the tests for less than 0
now be eliminated, both in this function and in other functions?

> +	msg.dirt.rect[0].x2 =
> +		(x2 < x1 || x2 > info->var.xres) ? info->var.xres : x2;
> +	msg.dirt.rect[0].y2 =
> +		(y2 < y1 || y2 > info->var.yres) ? info->var.yres : y2;

How exactly is the dirty rectangle specified to Hyper-V?  Suppose the frame
buffer resolution is 100x200.  If you want to specify the entire rectangle, the
first coordinate is (0, 0).  But what is the second coordinate?  Should it be
(99, 199) or (100, 200)?  The above code (and original code) implies it
should specified as (100, 200), which is actually a point outside the
maximum resolution, which is counter-intuitive and makes me wonder
if the code is correct.

> 
>  	synthvid_send(hdev, &msg);
> 
>  	return 0;
>  }
> 
> +static void hvfb_docopy(struct hvfb_par *par,
> +			unsigned long offset,
> +			unsigned long size)
> +{
> +	if (!par || !par->mmio_vp || !par->dio_vp || !par->fb_ready ||
> +	    size == 0 || offset >= dio_fb_size)
> +		return;
> +
> +	if (offset + size > dio_fb_size)
> +		size = dio_fb_size - offset;
> +
> +	memcpy(par->mmio_vp + offset, par->dio_vp + offset, size);
> +}
> +
> +/* Deferred IO callback */
> +static void synthvid_deferred_io(struct fb_info *p,
> +				 struct list_head *pagelist)
> +{
> +	struct hvfb_par *par = p->par;
> +	struct page *page;
> +	unsigned long start, end;
> +	int y1, y2, miny, maxy;
> +	unsigned long flags;
> +
> +	miny = INT_MAX;
> +	maxy = 0;
> +
> +	list_for_each_entry(page, pagelist, lru) {
> +		start = page->index << PAGE_SHIFT;
> +		end = start + PAGE_SIZE - 1;
> +		y1 = start / p->fix.line_length;
> +		y2 = end / p->fix.line_length;

The above division rounds down because any remainder is discarded.  I
wondered whether rounding down is correct, which got me to thinking
about how the dirty rectangle is specified.  Is y2 the index of the last
dirty row?  If so, that's not consistent with the code in synthvid_update(),
which might choose var.yres as y2, and that's the index of a row outside
of the frame buffer.

> +		if (y2 > p->var.yres)
> +			y2 = p->var.yres;
> +		miny = min_t(int, miny, y1);
> +		maxy = max_t(int, maxy, y2);
> +
> +		/* Copy from dio space to mmio address */
> +		if (par->fb_ready) {
> +			spin_lock_irqsave(&par->docopy_lock, flags);
> +			hvfb_docopy(par, start, PAGE_SIZE);
> +			spin_unlock_irqrestore(&par->docopy_lock, flags);
> +		}
> +	}
> +
> +	if (par->fb_ready)
> +		synthvid_update(p, 0, miny, p->var.xres, maxy);
> +}
> +
> +static struct fb_deferred_io synthvid_defio = {
> +	.delay		= HZ / 20,
> +	.deferred_io	= synthvid_deferred_io,
> +};
> 
>  /*
>   * Actions on received messages from host:
> @@ -597,7 +670,7 @@ static int synthvid_send_config(struct hv_device *hdev)
>  	msg->vid_hdr.type = SYNTHVID_VRAM_LOCATION;
>  	msg->vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
>  		sizeof(struct synthvid_vram_location);
> -	msg->vram.user_ctx = msg->vram.vram_gpa = info->fix.smem_start;
> +	msg->vram.user_ctx = msg->vram.vram_gpa = par->mmio_pp;
>  	msg->vram.is_vram_gpa_specified = 1;
>  	synthvid_send(hdev, msg);
> 
> @@ -607,7 +680,7 @@ static int synthvid_send_config(struct hv_device *hdev)
>  		ret = -ETIMEDOUT;
>  		goto out;
>  	}
> -	if (msg->vram_ack.user_ctx != info->fix.smem_start) {
> +	if (msg->vram_ack.user_ctx != par->mmio_pp) {
>  		pr_err("Unable to set VRAM location\n");
>  		ret = -ENODEV;
>  		goto out;
> @@ -624,19 +697,85 @@ static int synthvid_send_config(struct hv_device *hdev)
> 
>  /*
>   * Delayed work callback:
> - * It is called at HVFB_UPDATE_DELAY or longer time interval to process
> - * screen updates. It is re-scheduled if further update is necessary.
> + * It is scheduled to call whenever update request is received and it has
> + * not been called in last HVFB_ONDEMAND_THROTTLE time interval.
>   */
>  static void hvfb_update_work(struct work_struct *w)
>  {
>  	struct hvfb_par *par = container_of(w, struct hvfb_par, dwork.work);
>  	struct fb_info *info = par->info;
> +	unsigned long flags;
> +	int x1, x2, y1, y2;
> +	int j;
> +
> +	x1 = y1 = 0;
> +	x2 = y2 = INT_MAX;

The above two lines seem superfluous since all four values
are unconditionally set below when storing the dirty
rectangle to local variables.

> +
> +	spin_lock_irqsave(&par->delayed_refresh_lock, flags);
> +	/* Reset the request flag */
> +	par->delayed_refresh = false;
> +
> +	/* Store the dirty rectangle to local variables */
> +	x1 = par->x1;
> +	x2 = par->x2;
> +	y1 = par->y1;
> +	y2 = par->y2;
> +
> +	/* Clear dirty rectangle */
> +	par->x1 = par->y1 = INT_MAX;
> +	par->x2 = par->y2 = 0;
> 
> +	spin_unlock_irqrestore(&par->delayed_refresh_lock, flags);
> +
> +	if (x1 < 0 || x1 > info->var.xres || x2 < 0 ||
> +	    x2 > info->var.xres || y1 < 0 || y1 > info->var.yres ||
> +	    y2 < 0 || y2 > info->var.yres)
> +		return;
> +
> +	/* Copy the dirty rectangle to frame buffer memory */
> +	spin_lock_irqsave(&par->docopy_lock, flags);
> +	for (j = y1; j <= y2 && x1 < x2; j++) {

x1 < x2 doesn't seem to be needed as a loop control test as
neither value is changed in the loop.

> +		if (j == info->var.yres)
> +			break;
> +		hvfb_docopy(par,
> +			    j * info->fix.line_length +
> +			    (x1 * screen_depth / 8),
> +			    (x2 - x1 + 1) * screen_depth / 8);

Whether the +1 is needed above gets back to the question I
raised earlier about how to interpret the coordinates -- whether
the (x2, y2) coordinate is just outside the dirty rectangle or
just inside the dirty rectangle.  Most of the code seems to treat
it as being just outside the dirty rectangle, in which case the +1
should not be used.

> +	}
> +	spin_unlock_irqrestore(&par->docopy_lock, flags);
> +
> +	/* Refresh */
>  	if (par->fb_ready)
> -		synthvid_update(info);
> +		synthvid_update(info, x1, y1, x2, y2);
> +}
> +
> +/*
> + * Control the on-demand refresh frequency. It schedules a delayed
> + * screen update if it has not yet.
> + */
> +static void hvfb_ondemand_refresh_throttle(struct hvfb_par *par,
> +					   int x1, int y1, int w, int h)
> +{
> +	unsigned long flags;
> +	int x2 = x1 + w;
> +	int y2 = y1 + h;
> +
> +	spin_lock_irqsave(&par->delayed_refresh_lock, flags);
> +
> +	/* Merge dirty rectangle */
> +	par->x1 = min_t(int, par->x1, x1);
> +	par->y1 = min_t(int, par->y1, y1);
> +	par->x2 = max_t(int, par->x2, x2);
> +	par->y2 = max_t(int, par->y2, y2);
> +
> +	/* Schedule a delayed screen update if not yet */
> +	if (par->delayed_refresh == false) {
> +		schedule_delayed_work(&par->dwork,
> +				      HVFB_ONDEMAND_THROTTLE);
> +		par->delayed_refresh = true;
> +	}
> 
> -	if (par->update)
> -		schedule_delayed_work(&par->dwork, HVFB_UPDATE_DELAY);
> +	spin_unlock_irqrestore(&par->delayed_refresh_lock, flags);
>  }
> 
>  static int hvfb_on_panic(struct notifier_block *nb,
> @@ -648,7 +787,8 @@ static int hvfb_on_panic(struct notifier_block *nb,
>  	par = container_of(nb, struct hvfb_par, hvfb_panic_nb);
>  	par->synchronous_fb = true;
>  	info = par->info;
> -	synthvid_update(info);
> +	hvfb_docopy(par, 0, dio_fb_size);
> +	synthvid_update(info, 0, 0, INT_MAX, INT_MAX);
> 
>  	return NOTIFY_DONE;
>  }
> @@ -709,7 +849,10 @@ static void hvfb_cfb_fillrect(struct fb_info *p,
> 
>  	cfb_fillrect(p, rect);
>  	if (par->synchronous_fb)
> -		synthvid_update(p);
> +		synthvid_update(p, 0, 0, INT_MAX, INT_MAX);
> +	else
> +		hvfb_ondemand_refresh_throttle(par, rect->dx, rect->dy,
> +					       rect->width, rect->height);
>  }
> 
>  static void hvfb_cfb_copyarea(struct fb_info *p,
> @@ -719,7 +862,10 @@ static void hvfb_cfb_copyarea(struct fb_info *p,
> 
>  	cfb_copyarea(p, area);
>  	if (par->synchronous_fb)
> -		synthvid_update(p);
> +		synthvid_update(p, 0, 0, INT_MAX, INT_MAX);
> +	else
> +		hvfb_ondemand_refresh_throttle(par, area->dx, area->dy,
> +					       area->width, area->height);
>  }
> 
>  static void hvfb_cfb_imageblit(struct fb_info *p,
> @@ -729,7 +875,10 @@ static void hvfb_cfb_imageblit(struct fb_info *p,
> 
>  	cfb_imageblit(p, image);
>  	if (par->synchronous_fb)
> -		synthvid_update(p);
> +		synthvid_update(p, 0, 0, INT_MAX, INT_MAX);
> +	else
> +		hvfb_ondemand_refresh_throttle(par, image->dx, image->dy,
> +					       image->width, image->height);
>  }
> 
>  static struct fb_ops hvfb_ops = {
> @@ -788,6 +937,9 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  	resource_size_t pot_start, pot_end;
>  	int ret;
> 
> +	dio_fb_size =
> +		screen_width * screen_height * screen_depth / 8;
> +
>  	if (gen2vm) {
>  		pot_start = 0;
>  		pot_end = -1;
> @@ -822,9 +974,15 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  	if (!fb_virt)
>  		goto err2;
> 
> +	/* Allocate memory for deferred IO */
> +	par->dio_vp = vzalloc(((dio_fb_size >> PAGE_SHIFT) + 1)
> +				 << PAGE_SHIFT);

I'd suggest using the round_up() function so that what you are doing
is explicit.

> +	if (par->dio_vp == NULL)
> +		goto err3;
> +
>  	info->apertures = alloc_apertures(1);
>  	if (!info->apertures)
> -		goto err3;
> +		goto err4;
> 
>  	if (gen2vm) {
>  		info->apertures->ranges[0].base = screen_info.lfb_base;
> @@ -836,16 +994,23 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
>  	}
> 
> +	/* Physical address of FB device */
> +	par->mmio_pp = par->mem->start;
> +	/* Virtual address of FB device */
> +	par->mmio_vp = (unsigned char *) fb_virt;
> +
>  	info->fix.smem_start = par->mem->start;
> -	info->fix.smem_len = screen_fb_size;
> -	info->screen_base = fb_virt;
> -	info->screen_size = screen_fb_size;
> +	info->fix.smem_len = dio_fb_size;
> +	info->screen_base = par->dio_vp;
> +	info->screen_size = dio_fb_size;
> 
>  	if (!gen2vm)
>  		pci_dev_put(pdev);
> 
>  	return 0;
> 
> +err4:
> +	vfree(par->dio_vp);
>  err3:
>  	iounmap(fb_virt);
>  err2:
> @@ -863,6 +1028,7 @@ static void hvfb_putmem(struct fb_info *info)
>  {
>  	struct hvfb_par *par = info->par;
> 
> +	vfree(par->dio_vp);
>  	iounmap(info->screen_base);
>  	vmbus_free_mmio(par->mem->start, screen_fb_size);
>  	par->mem = NULL;
> @@ -888,6 +1054,12 @@ static int hvfb_probe(struct hv_device *hdev,
>  	init_completion(&par->wait);
>  	INIT_DELAYED_WORK(&par->dwork, hvfb_update_work);
> 
> +	par->delayed_refresh = false;
> +	spin_lock_init(&par->delayed_refresh_lock);
> +	spin_lock_init(&par->docopy_lock);
> +	par->x1 = par->y1 = INT_MAX;
> +	par->x2 = par->y2 = 0;
> +
>  	/* Connect to VSP */
>  	hv_set_drvdata(hdev, info);
>  	ret = synthvid_connect_vsp(hdev);
> @@ -939,6 +1111,10 @@ static int hvfb_probe(struct hv_device *hdev,
>  	info->fbops = &hvfb_ops;
>  	info->pseudo_palette = par->pseudo_palette;
> 
> +	/* Initialize deferred IO */
> +	info->fbdefio = &synthvid_defio;
> +	fb_deferred_io_init(info);
> +
>  	/* Send config to host */
>  	ret = synthvid_send_config(hdev);
>  	if (ret)
> @@ -960,6 +1136,7 @@ static int hvfb_probe(struct hv_device *hdev,
>  	return 0;
> 
>  error:
> +	fb_deferred_io_cleanup(info);
>  	hvfb_putmem(info);
>  error2:
>  	vmbus_close(hdev->channel);
> --
> 2.20.1
