From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev: workaround for broken X
 servers
Date: Fri, 5 Nov 2004 10:04:14 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411051003160.14575@waterleaf.sonytel.be>
References: <1099448020.900.25.camel@gaston>  <20041103032613.GA3677@sci.fi>
 <1099633776.9260.160.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ018-000753-Om
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 01:04:22 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQ014-0000HZ-Ij
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 01:04:22 -0800
In-Reply-To: <1099633776.9260.160.camel@gaston>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>

On Fri, 5 Nov 2004, Benjamin Herrenschmidt wrote:
> > > Index: linux-work/drivers/video/fbmem.c
> > > ===================================================================
> > > --- linux-work.orig/drivers/video/fbmem.c	2004-10-26 13:15:55.000000000 +1000
> > > +++ linux-work/drivers/video/fbmem.c	2004-11-03 13:10:41.324932256 +1100
> > > @@ -748,6 +748,10 @@
> > >  	u16 *black = NULL;
> > >  	int err = 0;
> > >  	
> > > +	/* Workaround for broken X servers */
> > > +	if (blank > VESA_POWERDOWN)
> > > +		blank = VESA_POWERDOWN;
> > > +
> > >  	if (info->fbops->fb_blank && !info->fbops->fb_blank(blank, info))
> > >  		return 0;
> > >  
> > 
> > This goes against documented behaviour (see fb.h). Also drivers/char/vt.c 
> > seems to agree with fb.h, as do at least atyfb and matroxfb. I also used 
> > the vesa level+1 convention in DirectFB. So AFAICS this patch would 
> > confuse console power management, XFree86/X.Org, DirectFB and some fb 
> > drivers.
> 
> Ok, can we agree here on what has to be done ? X is hard-coding numbers
> that don't seem to be make any sense vs. our constants. In radeonfb, I
> used switch case on constants, not +1, so there is something I'm not
> getting. Besides, radeon always try to power down TFT panels when
> blank != 0, maybe I should improve that ... What is this +1 thing, where
> does it comes from ?

Hmm, I don't remember where this +1 comes from...

But I find all of this a bit strange: IIRC it was PaulM who asked me to add the
blank ioctl to fb.h, after he added support for blanking to X. So it would
surprise me a bit if it was wrong :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
