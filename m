From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [RFC 2.6.27 1/2] fbdev: add E-Ink
	Broadsheet controller support
Date: Sun, 21 Dec 2008 23:58:53 +0900
Message-ID: <aec7e5c30812210658m4fe9b00eibc8f68dd5216b756@mail.gmail.com>
References: <12298571743158-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LEPlh-0007kY-5n
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Dec 2008 14:58:57 +0000
Received: from wf-out-1314.google.com ([209.85.200.169])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LEPle-0004rY-TV for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Dec 2008 14:58:57 +0000
Received: by wf-out-1314.google.com with SMTP id 27so1766309wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 21 Dec 2008 06:58:53 -0800 (PST)
In-Reply-To: <12298571743158-git-send-email-jayakumar.lkml@gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Eric Miao <eric.miao@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Hi Jaya,

On Sun, Dec 21, 2008 at 7:59 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> This patch adds support for the E-Ink Broadsheet display controller

Looking good. While at the topic of deferred io I took the opportunity
to ask a bit about that below.

> +++ b/drivers/video/broadsheetfb.c

> +/*
> + * this is the slow path from userspace. they can seek and write to
> + * the fb. it's inefficient to do anything less than a full screen draw
> + */
> +static ssize_t broadsheetfb_write(struct fb_info *info, const char __user *buf,
> +                               size_t count, loff_t *ppos)
> +{
> +       struct broadsheetfb_par *par = info->par;
> +       unsigned long p = *ppos;
> +       void *dst;
> +       int err = 0;
> +       unsigned long total_size;
> +
> +       if (info->state != FBINFO_STATE_RUNNING)
> +               return -EPERM;
> +
> +       total_size = info->fix.smem_len;
> +
> +       if (p > total_size)
> +               return -EFBIG;
> +
> +       if (count > total_size) {
> +               err = -EFBIG;
> +               count = total_size;
> +       }
> +
> +       if (count + p > total_size) {
> +               if (!err)
> +                       err = -ENOSPC;
> +
> +               count = total_size - p;
> +       }
> +
> +       dst = (void __force *) (info->screen_base + p);
> +
> +       if (copy_from_user(dst, buf, count))
> +               err = -EFAULT;
> +
> +       if  (!err)
> +               *ppos += count;
> +
> +       broadsheetfb_dpy_update(par);
> +
> +       return (err) ? err : count;
> +}
> +
> +static struct fb_ops broadsheetfb_ops = {
> +       .owner          = THIS_MODULE,
> +       .fb_read        = fb_sys_read,
> +       .fb_write       = broadsheetfb_write,

I sort of expected to see fb_sys_write here. Same thing for
metronomefb. I wonder why you chose a custom write callback instead of
fb_sys_write. Maybe I need to do the same thing for sh_mobile_lcdcfb
and if so then we could hopefully share that code between our drivers.
=)

By using the xxx_dpy_update() function these drivers seem to force a
full screen update in their write() path. I'm not sure why though,
shouldn't the write() case should just let the fb_sync callback do the
sync for you? The fb_sys_write() function calls fb_sync _before_
writing though, I wonder why. Doesn't make sense to me - _after_
copying data sounds like a better place to flush. I don't know the
history of the code though, so there may be a good reason for this.

Also, this brings up to another interesting topic. While I was hacking
on deferred io for the sh_mobile_lcdcfb driver I realized that I
needed hooks to update the screen for the callbacks fb_fillarea,
fb_copyarea and fb_imageblit. The metronomefb driver and this one both
force a full screen update for each operation. In sh_mobile_lcdcfb I
chose to just schedule the delayed work instead. Either way is fine of
course, but this issue does not seem driver specific to me. So I
wonder if it is worth breaking out these sys-functions and handle all
that in fb_defio.c instead. But maybe we're just covering for the fact
that the fb console isn't syncing as it should?

Cheers,

/ magnus

------------------------------------------------------------------------------
