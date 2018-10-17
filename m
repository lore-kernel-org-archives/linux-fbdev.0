From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 17 Oct 2018 14:05:00 +0000
Subject: Re: [PATCH 2/2] fbdev: sbuslib: integer overflow in sbusfb_ioctl_helper()
Message-Id: <20181017140459.o2cchpztocyejioy@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180831081000epcas1p34f5574107a61b0ef8fe700b2956c4196@epcas1p3.samsung.com>
 <20180831080943.ldzpzha5suktn4ln@kili.mountain>
 <20181008104908eucas1p115af76cd37d3830d51778cb1835c2998~bnHrJCNPJ2265622656eucas1p1h@eucas1p1.samsung.com>
In-Reply-To: <20181008104908eucas1p115af76cd37d3830d51778cb1835c2998~bnHrJCNPJ2265622656eucas1p1h@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Mathieu Malaterre <malat@debian.org>, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, Philippe Ombredanne <pombredanne@nexb.com>, Peter Malone <peter.malone@gmail.com>

On Mon, Oct 08, 2018 at 12:49:07PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On 08/31/2018 10:09 AM, Dan Carpenter wrote:
> > The "index + count" addition can overflow.  Both come directly from the
> > user.  This bug leads to an information leak.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Patch queued for 4.20, thanks.
> 
> > ---
> > Btw, commit 250c6c49e3b6 ("fbdev: Fixing arbitrary kernel leak in case
> > FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().") doesn't do anything so
> > far as I can see.  The "cmap->len" variable is type u32, so the
> > comparison was already unsigned in the original code because of type
> > promotion.  But the commit was also harmless and nice cleanup.
> 
> Both 'index' and 'count' are controlled by user so they could be set to
> i.e. -100 and 100 accordingly. Such arguments would pass the 'if' test
> (because '+' happens before  type promotion) but still result in leaking
> kernel memory (inside 'for' loop).

It's still basically the same when it's unsigned.

Before:  -100 + 100 => 0
 After:  -100U + 100U => 0

The result of the math is still zero.  It's hard to know how to catch
this sort of bug...

regards,
dan carpenter
