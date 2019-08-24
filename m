From: Michael Kelley <mikelley@microsoft.com>
Date: Sat, 24 Aug 2019 18:11:11 +0000
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver
Message-Id: <DM5PR21MB0137A956360B52118AF164EAD7A70@DM5PR21MB0137.namprd21.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190813103548.2008-1-weh@microsoft.com>
 <DM5PR21MB0137E0BB19D8A0E6385BB316D7A90@DM5PR21MB0137.namprd21.prod.outlook.com>
 <KL1P15301MB026487D86E439FA67B25C42CBBAA0@KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB026487D86E439FA67B25C42CBBAA0@KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "shc_work@mail.ru" <shc_work@mail.ru>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>, "info@metux.net" <info@metux.net>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Hai

From: Wei Hu <weh@microsoft.com> Sent: Wednesday, August 21, 2019 4:59 AM
>
> > From: Michael Kelley <mikelley@microsoft.com>
> > Sent: Monday, August 19, 2019 6:41 AM
> > To: Wei Hu <weh@microsoft.com>; rdunlap@infradead.org; shc_work@mail.ru;
> 
> > > -	msg.dirt.rect[0].x1 = 0;
> > > -	msg.dirt.rect[0].y1 = 0;
> > > -	msg.dirt.rect[0].x2 = info->var.xres;
> > > -	msg.dirt.rect[0].y2 = info->var.yres;
> > > +	msg.dirt.rect[0].x1 = (x1 < 0 || x1 > x2) ? 0 : x1;
> > > +	msg.dirt.rect[0].y1 = (y2 < 0 || y1 > y2) ? 0 : y1;
> >
> > This should be:
> >
> > 	msg.dirt.rect[0].y1 = (y1 < 0 || y1 > y2) ? 0 : y1;
> >
> > Also, throughout the code, I don't think there are any places where
> > x or y coordinate values are ever negative.  INT_MAX or 0 is used as the
> > sentinel value indicating "not set".  So can all the tests for less than 0
> > now be eliminated, both in this function and in other functions?
> >
> > > +	msg.dirt.rect[0].x2 =
> > > +		(x2 < x1 || x2 > info->var.xres) ? info->var.xres : x2;
> > > +	msg.dirt.rect[0].y2 =
> > > +		(y2 < y1 || y2 > info->var.yres) ? info->var.yres : y2;
> >
> > How exactly is the dirty rectangle specified to Hyper-V?  Suppose the frame
> > buffer resolution is 100x200.  If you want to specify the entire rectangle, the
> > first coordinate is (0, 0).  But what is the second coordinate?  Should it be
> > (99, 199) or (100, 200)?  The above code (and original code) implies it
> > should specified as (100, 200), which is actually a point outside the
> > maximum resolution, which is counter-intuitive and makes me wonder
> > if the code is correct.
> >
> [Wei Hu]
> The current code treat the entire framebuffer rectangle as (0,0) -> (var.xres, var.yres).
> Every time it sends refresh request, these are two points sent to host and host
> seems accept it. See the above (x1, y1) and (x2, y2)  in the deleted lines.
> 
> So in your example the second coordinate is (100, 200).

OK, agreed.  I ran some experiments and confirmed that this is indeed the
Hyper-V behavior.

> 
> 
> > > +/* Deferred IO callback */
> > > +static void synthvid_deferred_io(struct fb_info *p,
> > > +				 struct list_head *pagelist)
> > > +{
> > > +	struct hvfb_par *par = p->par;
> > > +	struct page *page;
> > > +	unsigned long start, end;
> > > +	int y1, y2, miny, maxy;
> > > +	unsigned long flags;
> > > +
> > > +	miny = INT_MAX;
> > > +	maxy = 0;
> > > +
> > > +	list_for_each_entry(page, pagelist, lru) {
> > > +		start = page->index << PAGE_SHIFT;
> > > +		end = start + PAGE_SIZE - 1;
> > > +		y1 = start / p->fix.line_length;
> > > +		y2 = end / p->fix.line_length;
> >
> > The above division rounds down because any remainder is discarded.  I
> > wondered whether rounding down is correct, which got me to thinking
> > about how the dirty rectangle is specified.  Is y2 the index of the last
> > dirty row?  If so, that's not consistent with the code in synthvid_update(),
> > which might choose var.yres as y2, and that's the index of a row outside
> > of the frame buffer.
> >
> [Wei Hu]
> In this place we try to figure out and merge all the faulted pages into one
> big dirty rectangle. A page in memory represents one or multiple lines in
> frame buffer. For example, one faulted page could represent all the linear
> pixels from (x, y) to (x-1, y+1). In this case we just form the dirty rectangle
> as (0, y) -> (var.xres, y+1). Also keep in mind we need to merge multiple
> pages. That's why in the end the dirty rectangle is (0, miny) -> (var.xres, maxy).

Let me give an example of where I think the new code doesn't work.  Suppose
the frame buffer resolution is 1024x768.  With 4 bytes per pixel, each row
is 4096 bytes, or exactly one page.  So each page contains exactly one row of
pixels. For simplicity in my example, let's look at the case when this function
is called with only one dirty page.   The calculation of y1 will identify the row
that is dirty.   The calculation of y2 will identify the same row.  So y1 will
equal y2, and miny will equal maxy.  Then when synthvid_update() is called,
Hyper-V will interpret the parameters as no rows needing to be updated.  In
a more complex case where the pagelist contains multiple dirty pages, maxy
also ends up one less than it needs to be.

I think passing 'maxy + 1' instead of 'maxy' to synthvid_update() will solve
the problem.  It certainly warrants a comment that the calculation of maxy
is "inclusive", while synthvid_update() expects its parameters to be "exclusive"
per Hyper-V's expectations.

There's also another interesting situation.  Suppose the resolution and page size
is such that a page contains multiple rows.  If the last page of the frame buffer
is dirty, this routine could calculate a y2 value identifying a "phantom" row
that is off the end of the frame buffer -- i.e., that is bigger than yres.  You
have synthvid_send() handling that case by clamping the y2 value to yres, but
it might be worth a comment here acknowledging the situation and how it is
handled.  I did a test, and it appears that Hyper-V does its own clamping of
the values passed in, but we should not take a dependency on how Hyper-V
handles incorrect inputs.

> 
> 
> > > +		if (y2 > p->var.yres)
> > > +			y2 = p->var.yres;
> > > +		miny = min_t(int, miny, y1);
> > > +		maxy = max_t(int, maxy, y2);
> > > +
> > > +		/* Copy from dio space to mmio address */
> > > +		if (par->fb_ready) {
> > > +			spin_lock_irqsave(&par->docopy_lock, flags);
> > > +			hvfb_docopy(par, start, PAGE_SIZE);
> > > +			spin_unlock_irqrestore(&par->docopy_lock, flags);
> > > +		}
> > > +	}
> > > +
> > > +	if (par->fb_ready)
> > > +		synthvid_update(p, 0, miny, p->var.xres, maxy);
> > > +}
> 
> 
> 
> 
> > > +
> > > +	/* Copy the dirty rectangle to frame buffer memory */
> > > +	spin_lock_irqsave(&par->docopy_lock, flags);
> > > +	for (j = y1; j <= y2 && x1 < x2; j++) {
> > > +		if (j == info->var.yres)
> > > +			break;
> > > +		hvfb_docopy(par,
> > > +			    j * info->fix.line_length +
> > > +			    (x1 * screen_depth / 8),
> > > +			    (x2 - x1 + 1) * screen_depth / 8);
> >
> > Whether the +1 is needed above gets back to the question I
> > raised earlier about how to interpret the coordinates -- whether
> > the (x2, y2) coordinate is just outside the dirty rectangle or
> > just inside the dirty rectangle.  Most of the code seems to treat
> > it as being just outside the dirty rectangle, in which case the +1
> > should not be used.
> >
> [Wei Hu]
> This dirty rectangle is not from page fault, but rather from frame buffer
> framework when the screen is in text mode. I am not 100% sure if the dirty
> rectangle given from kernel includes on extra line outside or not.  Here I
> just play it safe by copying one extra line in the worst case.

Got it.  I was incorrectly conflating the two ways the frame buffer can get
updated.

I looked at the how x2 and y2 of the dirty rectangle get set in this case.  It
looks to me like it's always calculated as x1 + width, and y1 + height in
hvfb_ondemand_refresh_throttle().  If that's correct, then the dirty
rectangle coordinates are "exclusive", which is what Hyper-V wants.   And
indeed the call to synthvid_update() later in this function assumes the
"exclusive" format.  Also, the "j == info->var.yres" test is correct only
if the y2 value is in the "exclusive" format.

With that being the case, the "for" loop control above should have j < y2
instead of j <= y2, as we don't need to copy the y2 row.  And the +1
isn't needed in the arguments to hvfb_docopy().

I really don't like the idea of copying an extra row, or an extra byte in a
row, "just in case".

Michael

> 
> Suppose dirty rectangle only contain one pixel, for example (0,0) is the only
> pixel changed in the entire frame buffer. If kernel sends me dirty rectangle as
> (0, 0) -> (0, 0), the above function works correctly. If the kernel sends
>  (0, 0) -> (1, 1), then the above function just copies one extra row and one extra
> column, which should also be fine. The hvfb_docopy() takes care of the
> edge cases.
> 
> Thanks,
> Wei
