From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH][FBDEV] Fix copy_to/from_user in
 fbmem.c:fb_read/write
Date: Mon, 30 Aug 2004 11:10:35 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0408301107430.3353@waterleaf.sonytel.be>
References: <200408301047.28117.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1iBT-0001wC-EG
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 02:10:39 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C1iBS-0008OL-LF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 02:10:39 -0700
In-Reply-To: <200408301047.28117.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, "David S.Miller" <davem@redhat.com>

On Mon, 30 Aug 2004, Antonino A. Daplas wrote:
> This patch fixes a prblem reported by David S. Miller <davem@redhat.com>
>
> "I just noticed that fb_{read,write}() uses copy_*_user() with
> the kernel buffer being the frame buffer.  It needs to use
> the proper device address accessor functions."
>
> Tony
>
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
>
> diff -uprN linux-2.6.9-rc1-mm1-orig/drivers/video/fbmem.c linux-2.6.9-rc1-mm1/drivers/video/fbmem.c
> --- linux-2.6.9-rc1-mm1-orig/drivers/video/fbmem.c	2004-08-27 05:24:32.000000000 +0800
> +++ linux-2.6.9-rc1-mm1/drivers/video/fbmem.c	2004-08-27 05:25:02.200341392 +0800
> @@ -878,6 +878,8 @@ fb_read(struct file *file, char __user *
>  	struct inode *inode = file->f_dentry->d_inode;
>  	int fbidx = iminor(inode);
>  	struct fb_info *info = registered_fb[fbidx];
> +	u32 *buffer, *dst, *src;
> +	int c, i, cnt = 0, err = 0;
>
>  	if (!info || ! info->screen_base)
>  		return -ENODEV;
> @@ -894,18 +896,40 @@ fb_read(struct file *file, char __user *
>  	    count = info->fix.smem_len;
>  	if (count + p > info->fix.smem_len)
>  		count = info->fix.smem_len - p;
> +
> +	cnt = 0;
> +	buffer = kmalloc((count > 64 * 1024) ? 64 * 1024 : count,
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +			 GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;

Woops, what's the probability of a 64 kiB kmalloc() to fail?

    [...]

> +	while (count) {
> +		c  = (count > 64 * 1024) ? 64 * 1024 : count;
> +		dst = buffer;
> +		for (i = c >> 2; i--; )
> +			*dst++ = fb_readl(src++);
> +		if (c & 3) {
> +			for (i = c & 3; i--;)
> +				*((u8 *)dst++) = fb_readb((u8 *) src++);
> +		}
> +
> +		if (copy_to_user(buf, buffer, c)) {
> +			err = -EFAULT;
> +			break;
> +		}
> +		*ppos += c;
> +		buf += c;
> +		cnt += c;
> +		count -= c;
>  	}

I don't expect the penalty for always using a buffer of PAGE_SIZE to be very
large. Or am I missing something?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
