From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:49:07 +0000
Subject: Re: [PATCH 2/2] fbdev: sbuslib: integer overflow in sbusfb_ioctl_helper()
Message-Id: <20181008104908eucas1p115af76cd37d3830d51778cb1835c2998~bnHrJCNPJ2265622656eucas1p1h@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180831081000epcas1p34f5574107a61b0ef8fe700b2956c4196@epcas1p3.samsung.com>
 <20180831080943.ldzpzha5suktn4ln@kili.mountain>
In-Reply-To: <20180831080943.ldzpzha5suktn4ln@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-fbdev@vger.kernel.org, Mathieu Malaterre <malat@debian.org>, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, Philippe Ombredanne <pombredanne@nexb.com>, Peter Malone <peter.malone@gmail.com>


On 08/31/2018 10:09 AM, Dan Carpenter wrote:
> The "index + count" addition can overflow.  Both come directly from the
> user.  This bug leads to an information leak.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch queued for 4.20, thanks.

> ---
> Btw, commit 250c6c49e3b6 ("fbdev: Fixing arbitrary kernel leak in case
> FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().") doesn't do anything so
> far as I can see.  The "cmap->len" variable is type u32, so the
> comparison was already unsigned in the original code because of type
> promotion.  But the commit was also harmless and nice cleanup.

Both 'index' and 'count' are controlled by user so they could be set to
i.e. -100 and 100 accordingly. Such arguments would pass the 'if' test
(because '+' happens before  type promotion) but still result in leaking
kernel memory (inside 'for' loop).

> diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
> index 90c51330969c..01a7110e61a7 100644
> --- a/drivers/video/fbdev/sbuslib.c
> +++ b/drivers/video/fbdev/sbuslib.c
> @@ -171,7 +171,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
>  		    get_user(ublue, &c->blue))
>  			return -EFAULT;
>  
> -		if (index + count > cmap->len)
> +		if (index > cmap->len || count > cmap->len - index)
>  			return -EINVAL;
>  
>  		for (i = 0; i < count; i++) {

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
