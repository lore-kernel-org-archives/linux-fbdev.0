From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fb_pan_display
Date: Sat, 2 Nov 2002 14:20:55 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0211021420001.11959-100000@vervain.sonytel.be>
References: <Pine.LNX.4.33.0211010908390.6296-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187yDc-0002kE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 02 Nov 2002 05:21:40 -0800
In-Reply-To: <Pine.LNX.4.33.0211010908390.6296-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 1 Nov 2002, James Simmons wrote:
>   Looking at the last bits of the fbdev changes I have question. Currently
> I have in fbgen.c:
> 
> int fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
> {
>         int xoffset = var->xoffset;
>         int yoffset = var->yoffset;
>         int err;
> 
>         if (xoffset < 0 || yoffset < 0 ||
>             xoffset + info->var.xres > info->var.xres_virtual ||
>             yoffset + info->var.yres > info->var.yres_virtual)
>                 return -EINVAL;

The one above is generic.

>         if (info->fbops->fb_pan_display) {
>                 if ((err = info->fbops->fb_pan_display(var, info)))
>                         return err;
>                 else
>                         return -EINVAL;
>         }

This is weird. if 0 == info->fbops->fb_pan_display, there's no panning, but it
does succeed?

>         info->var.xoffset = var->xoffset;
>         info->var.yoffset = var->yoffset;
>         if (var->vmode & FB_VMODE_YWRAP)
>                 info->var.vmode |= FB_VMODE_YWRAP;
>         else
>                 info->var.vmode &= ~FB_VMODE_YWRAP;
>         return 0;
> }
> 
> Now what I was wondering are these test standard enough that we coudl call
> this instead of info->fb_ops->fb_pan_display. Several drivers have this
> test so it would me more code reduction.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
