From: Michael Kelley <mikelley@microsoft.com>
Date: Wed, 28 Aug 2019 00:07:20 +0000
Subject: RE: [PATHC v2] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver
Message-Id: <DM5PR21MB0137969B8EB3146160C86A2DD7A30@DM5PR21MB0137.namprd21.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190827112421.2770-1-weh@microsoft.com>
In-Reply-To: <20190827112421.2770-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "shc_work@mail.ru" <shc_work@mail.ru>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>, "info@metux.net" <info@metux.net>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Hai

From: Wei Hu <weh@microsoft.com>  Sent: Tuesday, August 27, 2019 4:25 AM
> 
> Without deferred IO support, hyperv_fb driver informs the host to refresh
> the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter there
> is screen update or not. This patch supports deferred IO for screens in
> graphics mode and also enables the frame buffer on-demand refresh. The
> highest refresh rate is still set at 20Hz.
> 
> Currently Hyper-V only takes a physical address from guest as the starting
> address of frame buffer. This implies the guest must allocate contiguous
> physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
> accept address from MMIO region as frame buffer address. Due to these
> limitations on Hyper-V host, we keep a shadow copy of frame buffer
> in the guest. This means one more copy of the dirty rectangle inside
> guest when doing the on-demand refresh. This can be optimized in the
> future with help from host. For now the host performance gain from deferred
> IO outweighs the shadow copy impact in the guest.
> 
> v2: Incorporated review comments from Michael Kelley
> - Increased dirty rectangle by one row in deferred IO case when sending
> to Hyper-V.
> - Corrected the dirty rectangle size in the text mode.
> - Added more comments.
> - Other minor code cleanups.

Version history should go after the "---" below so it is not included in
the commit message.

> 
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/video/fbdev/Kconfig     |   1 +
>  drivers/video/fbdev/hyperv_fb.c | 221 +++++++++++++++++++++++++++++---
>  2 files changed, 202 insertions(+), 20 deletions(-)
> 
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
> +	/*
> +	 * Merge dirty pages. It is possible that last page cross
> +	 * over the end of frame buffer row yres. This is taken care of
> +	 * in synthvid_update function by clamping the y2
> +	 * value to yres.
> +	 */
> +	list_for_each_entry(page, pagelist, lru) {
> +		start = page->index << PAGE_SHIFT;
> +		end = start + PAGE_SIZE - 1;
> +		y1 = start / p->fix.line_length;
> +		y2 = end / p->fix.line_length;
> +		if (y2 > p->var.yres)
> +			y2 = p->var.yres;

The above test seems contradictory to the comment that
says the clamping is done in synthvid_update().  Also, since
the above calculation of y2 is "inclusive", the clamping should
be done to yres - 1 in order to continue to be inclusive.  Then
when maxy + 1 is passed to synthvid_update() everything works
out correctly.

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
> +		synthvid_update(p, 0, miny, p->var.xres, maxy + 1);
> +}
> +
> +static struct fb_deferred_io synthvid_defio = {
> +	.delay		= HZ / 20,
> +	.deferred_io	= synthvid_deferred_io,
> +};
> 
>  /*
>   * Actions on received messages from host:
> @@ -604,7 +683,7 @@ static int synthvid_send_config(struct hv_device *hdev)
>  	msg->vid_hdr.type = SYNTHVID_VRAM_LOCATION;
>  	msg->vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
>  		sizeof(struct synthvid_vram_location);
> -	msg->vram.user_ctx = msg->vram.vram_gpa = info->fix.smem_start;
> +	msg->vram.user_ctx = msg->vram.vram_gpa = par->mmio_pp;
>  	msg->vram.is_vram_gpa_specified = 1;
>  	synthvid_send(hdev, msg);
> 
> @@ -614,7 +693,7 @@ static int synthvid_send_config(struct hv_device *hdev)
>  		ret = -ETIMEDOUT;
>  		goto out;
>  	}
> -	if (msg->vram_ack.user_ctx != info->fix.smem_start) {
> +	if (msg->vram_ack.user_ctx != par->mmio_pp) {
>  		pr_err("Unable to set VRAM location\n");
>  		ret = -ENODEV;
>  		goto out;
> @@ -631,19 +710,82 @@ static int synthvid_send_config(struct hv_device *hdev)
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
> +
> +	spin_unlock_irqrestore(&par->delayed_refresh_lock, flags);
> 
> +	if (x1 < 0 || x1 > info->var.xres || x2 < 0 ||
> +	    x2 > info->var.xres || y1 < 0 || y1 > info->var.yres ||
> +	    y2 < 0 || y2 > info->var.yres || x2 <= x1)
> +		return;

Are the tests for less than 0 needed?  I think all possibility of
negative values has been eliminated.

> +
> +	/* Copy the dirty rectangle to frame buffer memory */
> +	spin_lock_irqsave(&par->docopy_lock, flags);
> +	for (j = y1; j < y2; j++) {
> +		if (j == info->var.yres)
> +			break;

The above test isn't needed.  The maximum value that y2 can be
is yres (that is checked a few lines above in the big "if" statement).
Since j is always less than y2, j can never be equal to yres.

> +		hvfb_docopy(par,
> +			    j * info->fix.line_length +
> +			    (x1 * screen_depth / 8),
> +			    (x2 - x1) * screen_depth / 8);
> +	}
> +	spin_unlock_irqrestore(&par->docopy_lock, flags);
> +
> +	/* Refresh */
>  	if (par->fb_ready)
> -		synthvid_update(info);
> +		synthvid_update(info, x1, y1, x2, y2);
> +}
> +

Michael
