From: Wei Hu <weh@microsoft.com>
Date: Wed, 21 Aug 2019 11:59:18 +0000
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver
Message-Id: <KL1P15301MB026487D86E439FA67B25C42CBBAA0@KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190813103548.2008-1-weh@microsoft.com>
 <DM5PR21MB0137E0BB19D8A0E6385BB316D7A90@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB0137E0BB19D8A0E6385BB316D7A90@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Kelley <mikelley@microsoft.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "shc_work@mail.ru" <shc_work@mail.ru>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>, "info@metux.net" <info@metux.net>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>

Thanks Michael. See my reply inline to some of your comments.

> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Monday, August 19, 2019 6:41 AM
> To: Wei Hu <weh@microsoft.com>; rdunlap@infradead.org; shc_work@mail.ru;

> > -	msg.dirt.rect[0].x1 = 0;
> > -	msg.dirt.rect[0].y1 = 0;
> > -	msg.dirt.rect[0].x2 = info->var.xres;
> > -	msg.dirt.rect[0].y2 = info->var.yres;
> > +	msg.dirt.rect[0].x1 = (x1 < 0 || x1 > x2) ? 0 : x1;
> > +	msg.dirt.rect[0].y1 = (y2 < 0 || y1 > y2) ? 0 : y1;
> 
> This should be:
> 
> 	msg.dirt.rect[0].y1 = (y1 < 0 || y1 > y2) ? 0 : y1;
> 
> Also, throughout the code, I don't think there are any places where
> x or y coordinate values are ever negative.  INT_MAX or 0 is used as the
> sentinel value indicating "not set".  So can all the tests for less than 0
> now be eliminated, both in this function and in other functions?
> 
> > +	msg.dirt.rect[0].x2 =
> > +		(x2 < x1 || x2 > info->var.xres) ? info->var.xres : x2;
> > +	msg.dirt.rect[0].y2 =
> > +		(y2 < y1 || y2 > info->var.yres) ? info->var.yres : y2;
> 
> How exactly is the dirty rectangle specified to Hyper-V?  Suppose the frame
> buffer resolution is 100x200.  If you want to specify the entire rectangle, the
> first coordinate is (0, 0).  But what is the second coordinate?  Should it be
> (99, 199) or (100, 200)?  The above code (and original code) implies it
> should specified as (100, 200), which is actually a point outside the
> maximum resolution, which is counter-intuitive and makes me wonder
> if the code is correct.
> 
[Wei Hu] 
The current code treat the entire framebuffer rectangle as (0,0) -> (var.xres, var.yres).
Every time it sends refresh request, these are two points sent to host and host
seems accept it. See the above (x1, y1) and (x2, y2)  in the deleted lines.

So in your example the second coordinate is (100, 200). 


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
> > +	list_for_each_entry(page, pagelist, lru) {
> > +		start = page->index << PAGE_SHIFT;
> > +		end = start + PAGE_SIZE - 1;
> > +		y1 = start / p->fix.line_length;
> > +		y2 = end / p->fix.line_length;
> 
> The above division rounds down because any remainder is discarded.  I
> wondered whether rounding down is correct, which got me to thinking
> about how the dirty rectangle is specified.  Is y2 the index of the last
> dirty row?  If so, that's not consistent with the code in synthvid_update(),
> which might choose var.yres as y2, and that's the index of a row outside
> of the frame buffer.
> 
[Wei Hu] 
In this place we try to figure out and merge all the faulted pages into one
big dirty rectangle. A page in memory represents one or multiple lines in
frame buffer. For example, one faulted page could represent all the linear 
pixels from (x, y) to (x-1, y+1). In this case we just form the dirty rectangle
as (0, y) -> (var.xres, y+1). Also keep in mind we need to merge multiple
pages. That's why in the end the dirty rectangle is (0, miny) -> (var.xres, maxy).


> > +		if (y2 > p->var.yres)
> > +			y2 = p->var.yres;
> > +		miny = min_t(int, miny, y1);
> > +		maxy = max_t(int, maxy, y2);
> > +
> > +		/* Copy from dio space to mmio address */
> > +		if (par->fb_ready) {
> > +			spin_lock_irqsave(&par->docopy_lock, flags);
> > +			hvfb_docopy(par, start, PAGE_SIZE);
> > +			spin_unlock_irqrestore(&par->docopy_lock, flags);
> > +		}
> > +	}
> > +
> > +	if (par->fb_ready)
> > +		synthvid_update(p, 0, miny, p->var.xres, maxy);
> > +}




> > +
> > +		if (j == info->var.yres)
> > +			break;
> > +		hvfb_docopy(par,
> > +			    j * info->fix.line_length +
> > +			    (x1 * screen_depth / 8),
> > +			    (x2 - x1 + 1) * screen_depth / 8);
> 
> Whether the +1 is needed above gets back to the question I
> raised earlier about how to interpret the coordinates -- whether
> the (x2, y2) coordinate is just outside the dirty rectangle or
> just inside the dirty rectangle.  Most of the code seems to treat
> it as being just outside the dirty rectangle, in which case the +1
> should not be used.
> 
[Wei Hu] 
This dirty rectangle is not from page fault, but rather from frame buffer
framework when the screen is in text mode. I am not 100% sure if the dirty
rectangle given from kernel includes on extra line outside or not.  Here I 
just play it safe by copying one extra line in the worst case.

Suppose dirty rectangle only contain one pixel, for example (0,0) is the only
pixel changed in the entire frame buffer. If kernel sends me dirty rectangle as
(0, 0) -> (0, 0), the above function works correctly. If the kernel sends
 (0, 0) -> (1, 1), then the above function just copies one extra row and one extra
column, which should also be fine. The hvfb_docopy() takes care of the 
edge cases.

Thanks,
Wei
