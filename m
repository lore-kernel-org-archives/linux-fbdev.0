From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Optimizing bitblit.c / fb_pad_*
Date: Sat, 30 Jul 2005 21:01:04 +0800
Message-ID: <42EB7A10.4080601@gmail.com>
References: <42EB46AB.1010005@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dyqxd-0005bW-RH
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 06:01:05 -0700
Received: from wproxy.gmail.com ([64.233.184.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dyqxa-0002th-Fk
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 06:01:06 -0700
Received: by wproxy.gmail.com with SMTP id i20so727427wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 30 Jul 2005 06:00:56 -0700 (PDT)
In-Reply-To: <42EB46AB.1010005@t-online.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Hi everybody,
> 
> could you please verify this change to bitblit.c.
> 
> Advantage: For drivers with accelerated blitting a significant 
> performance boost.
> 
> The execution time for my test3 with cyblafb and ypanning drops from
> 0,870s (2.6.13-rc4 with the patch from Antonino) to 0,772s.
> 
> If you agree that this is the way to go, we should add some additional 
> code for font
> resolutions different from 8x16.
> 
> Should we drop fb_pad_aligned() entirely from the kernel? As far as I
> see it is only
> used in cases that do not copy too much data. Replacing fb_pad_aligned 
> at those places
> with proper inline code should also help to optimize performance.
> 
> 
> cu,
> Knut
> 
> 
> --- linux-2.6.13-rc4/drivers/video/console/bitblit.c    2005-07-29 
> 10:01:01.000000000 +0200
> +++ linux/drivers/video/console/bitblit.c    2005-07-30 
> 09:34:49.000000000 +0200
> @@ -113,12 +113,15 @@
>     unsigned int maxcnt = info->pixmap.size/cellsize;
>     unsigned int scan_align = info->pixmap.scan_align - 1;
>     unsigned int buf_align = info->pixmap.buf_align - 1;
> -    unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
> -    unsigned int shift_high = 8, pitch, cnt, size, k;
> +    unsigned int shift_low = 0;
> +    unsigned int mod = vc->vc_font.width % 8;
>     unsigned int idx = vc->vc_font.width >> 3;
>     unsigned int attribute = get_attribute(info, scr_readw(s));
> +    unsigned int shift_high = 8;
> +    unsigned int pitch, cnt, size, k;
> +    unsigned int fast_8x16, i, j;
>     struct fb_image image;
> -    u8 *src, *dst, *buf = NULL;
> +    u8 *src, *dst, *dstp, *buf = NULL;
> 
>     if (attribute) {
>         buf = kmalloc(cellsize, GFP_KERNEL);
> @@ -134,6 +137,11 @@
>     image.height = vc->vc_font.height;
>     image.depth = 1;
> 
> +    if (vc->vc_font.height == 16 && vc->vc_font.width == 8)
> +        fast_8x16 = 1;
> +    else
> +        fast_8x16 = 0;
> +
>     while (count) {
>         if (count > maxcnt)
>             cnt = k = maxcnt;
> @@ -147,7 +155,8 @@
>         size &= ~buf_align;
>         dst = fb_get_buffer_offset(info, &info->pixmap, size);
>         image.data = dst;
> -        if (mod) {
> +
> +        if (!mod)
>             while (k--) {
>                 src = vc->vc_font.data + (scr_readw(s++)&
>                               charmask)*cellsize;
> @@ -157,15 +166,23 @@
>                     src = buf;
>                 }
> 
> -                fb_pad_unaligned_buffer(dst, pitch, src, idx,
> -                        image.height, shift_high,
> -                        shift_low, mod);
> -                shift_low += mod;
> -                dst += (shift_low >= 8) ? width : width - 1;
> -                shift_low &= 7;
> -                shift_high = 8 - shift_low;
> +                // Optimized for speed, memcpy() is too slow!
> +                dstp = dst;
> +                if (fast_8x16)
> +                    for (i = 16; i--; ) {
> +                        *dstp = src[15-i];
> +                        dstp += pitch;
> +                    }

why not make it to something like this?

		for (i = cellsize; i--;) {
			*dstp = src[cellsize-1-i];
			dstp += pitch;
		}

This way, it will work with any fontsize, as long as the width
is a 8-bit size-aligned.  You can do the same with
fb_pad_aligned_buffer(), so the rest can benefit too.

The above is probably a bit slower than your version, but it's a
good compromise -- bit_putcs is ugly enough, the price for
the optimization.

Tony

PS: Next time you submit a patch, add a Signed-off-line. See this
document by akpm:

http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
