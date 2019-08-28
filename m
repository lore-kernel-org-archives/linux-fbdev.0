From: Wei Hu <weh@microsoft.com>
Date: Wed, 28 Aug 2019 09:12:30 +0000
Subject: RE: [PATHC v2] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver
Message-Id: <KL1P15301MB026463D9F94CE517E7A63216BBA30@KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190827112421.2770-1-weh@microsoft.com>
 <DM5PR21MB0137969B8EB3146160C86A2DD7A30@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB0137969B8EB3146160C86A2DD7A30@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Kelley <mikelley@microsoft.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "shc_work@mail.ru" <shc_work@mail.ru>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>, "info@metux.net" <info@metux.net>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>



> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> 
> From: Wei Hu <weh@microsoft.com>  Sent: Tuesday, August 27, 2019 4:25 AM
> >
> > Without deferred IO support, hyperv_fb driver informs the host to refresh
> > the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter there
> > is screen update or not. This patch supports deferred IO for screens in
> > graphics mode and also enables the frame buffer on-demand refresh. The
> > highest refresh rate is still set at 20Hz.
> >
> > Currently Hyper-V only takes a physical address from guest as the starting
> > address of frame buffer. This implies the guest must allocate contiguous
> > physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
> > accept address from MMIO region as frame buffer address. Due to these
> > limitations on Hyper-V host, we keep a shadow copy of frame buffer
> > in the guest. This means one more copy of the dirty rectangle inside
> > guest when doing the on-demand refresh. This can be optimized in the
> > future with help from host. For now the host performance gain from deferred
> > IO outweighs the shadow copy impact in the guest.
> >
> > v2: Incorporated review comments from Michael Kelley
> > - Increased dirty rectangle by one row in deferred IO case when sending
> > to Hyper-V.
> > - Corrected the dirty rectangle size in the text mode.
> > - Added more comments.
> > - Other minor code cleanups.
> 
> Version history should go after the "---" below so it is not included in
> the commit message.
> 
[Wei Hu] 
I saw version history in the commit logs. 

> >
> > Signed-off-by: Wei Hu <weh@microsoft.com>
> > ---
> >  drivers/video/fbdev/Kconfig     |   1 +
> >  drivers/video/fbdev/hyperv_fb.c | 221 +++++++++++++++++++++++++++++---
> >  2 files changed, 202 insertions(+), 20 deletions(-)
> >
> > +/* Deferred IO callback */
> > +static void synthvid_deferred_io(struct fb_info *p,
> > +				 struct list_head *pagelist)
> > +{
> > +	struct hvfb_par *par = p->par;
> > +	struct page *page;
> > +	unsigned long start, end;
> > +	int y1, y2, miny, maxy;
> > +	unsigned long flags;
> > +
> > +	miny = INT_MAX;
> > +	maxy = 0;
> > +
> > +	/*
> > +	 * Merge dirty pages. It is possible that last page cross
> > +	 * over the end of frame buffer row yres. This is taken care of
> > +	 * in synthvid_update function by clamping the y2
> > +	 * value to yres.
> > +	 */
> > +	list_for_each_entry(page, pagelist, lru) {
> > +		start = page->index << PAGE_SHIFT;
> > +		end = start + PAGE_SIZE - 1;
> > +		y1 = start / p->fix.line_length;
> > +		y2 = end / p->fix.line_length;
> > +		if (y2 > p->var.yres)
> > +			y2 = p->var.yres;
> 
> The above test seems contradictory to the comment that
> says the clamping is done in synthvid_update().  Also, since
> the above calculation of y2 is "inclusive", the clamping should
> be done to yres - 1 in order to continue to be inclusive.  Then
> when maxy + 1 is passed to synthvid_update() everything works
> out correctly.
>
[Wei Hu] 
Actually the original code I sent out just works correctly.  It always get
the inclusive rectangle in the above loop, and only send one more extra
line (if y2 == yres) to sythvid_update() and it is clamped inside that 
function. Changing it to yres -1 and sending maxy + 1 to sytnvid_update()
makes it the same as the original code in this case, and would end up 
always copy and refresh one extra row when y2 < yres.

The comment I added was according to your last review comment asking
to add some comments explaining it. Maybe I mis-understood. I thought
since you wanted me to change to maxy + 1, the code could reach yres + 1
so it will be clamped in synthvid_update() to yres.

 Wei
