From: James Simmons <jsimmons@phoenix.infradead.org>
Subject: Re: fb_pan_display
Date: Sat, 9 Nov 2002 01:04:41 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211090103270.14371-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0211021420001.11959-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18AK3K-0006Hg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 08 Nov 2002 17:04:47 -0800
In-Reply-To: <Pine.GSO.4.21.0211021420001.11959-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> >         if (info->fbops->fb_pan_display) {
> >                 if ((err = info->fbops->fb_pan_display(var, info)))
> >                         return err;
> >                 else
> >                         return -EINVAL;
> >         }
> 
> This is weird. if 0 == info->fbops->fb_pan_display, there's no panning, but it
> does succeed?

Thanks for noticing. That is just plain wrong. I need to fix that 
tomorrow.

> >         info->var.xoffset = var->xoffset;
> >         info->var.yoffset = var->yoffset;
> >         if (var->vmode & FB_VMODE_YWRAP)
> >                 info->var.vmode |= FB_VMODE_YWRAP;
> >         else
> >                 info->var.vmode &= ~FB_VMODE_YWRAP;
> >         return 0;
> > }
> > 
> > Now what I was wondering are these test standard enough that we coudl call
> > this instead of info->fb_ops->fb_pan_display. Several drivers have this
> > test so it would me more code reduction.

That is the idea. fb_pan_display above would always be called.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
