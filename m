From: James Simmons <jsimmons@infradead.org>
Subject: Re: vfb updates.
Date: Fri, 23 Apr 2004 17:47:24 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404231747090.3997-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0404231043280.11983@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BH3pq-0005XV-Ik
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 09:47:30 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BH3po-0003qJ-A5
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 09:47:28 -0700
In-Reply-To: <Pine.GSO.4.58.0404231043280.11983@waterleaf.sonytel.be>
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


oops. As you can see I was debugging.


On Fri, 23 Apr 2004, Geert Uytterhoeven wrote:

> On Thu, 22 Apr 2004, James Simmons wrote:
> > This patch updates the Virtual framebuffer to use the
> > frmaebuffer_alloc/release functions.
> >
> > --- linus-2.6/drivers/video/vfb.c	2004-02-12 18:31:45.000000000 -0800
> > +++ fbdev-2.6/drivers/video/vfb.c	2004-04-21 17:46:38.000000000 -0700
> > @@ -72,7 +69,7 @@
> >  	.accel =	FB_ACCEL_NONE,
> >  };
> >
> > -static int vfb_enable __initdata = 0;	/* disabled by default */
> > +static int vfb_enable __initdata = 1;	/* disabled by default */
> >  MODULE_PARM(vfb_enable, "i");
> >
> >      /*
> 
> Please revert this hunk! You do _not_ want to enable vfb by default!
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
