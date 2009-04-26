From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: fbcmap: non working tests on
	unsigned	cmap->start
Date: Sun, 26 Apr 2009 16:15:05 +0300
Message-ID: <20090426131505.GG7134@sci.fi>
References: <49EDD799.8060607@gmail.com>
	<20090423134110.51ea8df2.akpm@linux-foundation.org>
	<20090423214738.GF7134@sci.fi> <49F4519F.4090003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1Ly4CY-0003e9-0v
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Apr 2009 13:15:22 +0000
Received: from smtp6.welho.com ([213.243.153.40])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ly4CN-0006hD-OO for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Apr 2009 13:15:21 +0000
Content-Disposition: inline
In-Reply-To: <49F4519F.4090003@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Sun, Apr 26, 2009 at 02:20:47PM +0200, Roel Kluin wrote:
> cmap->start is unsigned, A negative start could result in incorrect
> colors. `start' is used as the starting index for the hardware palette,
> 'start+len-1' is the last index.
> =

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> >>> vi include/linux/fb.h +478
> >>>
> >>> Note that struct fb_cmap_user cmap->start in fb_set_user_cmap() is un=
signed.
> >>> Should there maybe be a test:
> >>>
> >>> if (cmap->start > MAX || ...)
> >>>
> >>> (and what should MAX be then?)
> >>>
> =

> > On Thu, Apr 23, 2009 at 01:41:10PM -0700, Andrew Morton wrote:
> >> argh.
> >>
> >> - Perhaps userspace can kill the kernel by sending a "negative"
> >>   `start'.  Removing the test will make it even less likely that we'll
> >>   fix this bug.
> > =

> > Shouldn't happen. 'start' is used as the starting index for the hardware
> > palette, 'start+len-1' is the last index. All drivers should already ch=
eck
> > the passed values since the maximum index depends on the display mode.
> > And I suppose the worst thing that could happen if the driver fails to
> > check the values would be incorrect colors.
> =

> Thanks for your explanation, I think this should fix it?
> =

> diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
> index f53b9f1..ea62d87 100644
> --- a/drivers/video/fbcmap.c
> +++ b/drivers/video/fbcmap.c
> @@ -266,7 +266,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struc=
t fb_info *info)
>  		rc =3D -ENODEV;
>  		goto out;
>  	}
> -	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
> +	if (cmap->start >=3D cmap->len || (!info->fbops->fb_setcolreg &&
>  				!info->fbops->fb_setcmap)) {
>  		rc =3D -EINVAL;
>  		goto out1;

That's not correct. There's nothing wrong with having 'start' >=3D 'len'.

You would rather need something like
'if (start+len > 1 << max(red.len, green.len, blue.len, transp.len))'
and a check to make sure that start+len doesn't overflow.

Oh and I guess it should also check that the visual is pseudocolor or
directcolor.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---
Crystal Reports &#45; New Free Runtime and 30 Day Trial
Check out the new simplified licensign option that enables unlimited
royalty&#45;free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
