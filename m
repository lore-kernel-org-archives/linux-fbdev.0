From: James Simmons <jsimmons@infradead.org>
Subject: Re: Vesafb patch
Date: Fri, 23 Apr 2004 17:47:03 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404231746410.3997-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0404231037360.11983@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BH3pU-0005SZ-Gv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 09:47:08 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BH3pT-0003ll-Rp
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 09:47:08 -0700
In-Reply-To: <Pine.GSO.4.58.0404231037360.11983@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Okay. I fixed that. I remember there was a debt but I didn't see the 
conclusion. Fixed.


On Fri, 23 Apr 2004, Geert Uytterhoeven wrote:

> On Thu, 22 Apr 2004, James Simmons wrote:
> > This patch updates vesafb to use the framebuffer_alloc/framebuffer_release
> > function. It also adds a long ago patch for mtrr handling.
> >
> > --- linus-2.6/drivers/video/vesafb.c	2004-04-21 15:39:16.000000000 -0700
> > +++ fbdev-2.6/drivers/video/vesafb.c	2004-04-21 18:41:44.000000000 -0700
> > @@ -47,12 +47,13 @@
> >  	.accel	= FB_ACCEL_NONE,
> >  };
> >
> > -static struct fb_info fb_info;
> > -static u32 pseudo_palette[17];
> > -
> >  static int             inverse   = 0;
> > +#ifdef __x86_64__
> >  static int             mtrr      = 1;
> > -
> > +#else
> > +static int	       mtrr	 = 0;
> > +#endif
> 
> IIRC, the consensus a while ago was that MTRR was always OK, not only on
> x86-64?
> 
> Cfr. the previous change
> http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/video/vesafb.c@1.33?nav=index.html|src/|src/drivers|src/drivers/video|hist/drivers/video/vesafb.c
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
