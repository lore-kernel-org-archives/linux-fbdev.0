From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fbdev: workaround for broken X
	servers
Date: Fri, 05 Nov 2004 16:49:36 +1100
Message-ID: <1099633776.9260.160.camel@gaston>
References: <1099448020.900.25.camel@gaston>  <20041103032613.GA3677@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPx7U-0002XW-4L
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 21:58:44 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CPx7T-0001Nz-Ig
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 21:58:44 -0800
In-Reply-To: <20041103032613.GA3677@sci.fi>
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
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>


> > Index: linux-work/drivers/video/fbmem.c
> > ===================================================================
> > --- linux-work.orig/drivers/video/fbmem.c	2004-10-26 13:15:55.000000000 +1000
> > +++ linux-work/drivers/video/fbmem.c	2004-11-03 13:10:41.324932256 +1100
> > @@ -748,6 +748,10 @@
> >  	u16 *black = NULL;
> >  	int err = 0;
> >  	
> > +	/* Workaround for broken X servers */
> > +	if (blank > VESA_POWERDOWN)
> > +		blank = VESA_POWERDOWN;
> > +
> >  	if (info->fbops->fb_blank && !info->fbops->fb_blank(blank, info))
> >  		return 0;
> >  
> 
> This goes against documented behaviour (see fb.h). Also drivers/char/vt.c 
> seems to agree with fb.h, as do at least atyfb and matroxfb. I also used 
> the vesa level+1 convention in DirectFB. So AFAICS this patch would 
> confuse console power management, XFree86/X.Org, DirectFB and some fb 
> drivers.

Ok, can we agree here on what has to be done ? X is hard-coding numbers
that don't seem to be make any sense vs. our constants. In radeonfb, I
used switch case on constants, not +1, so there is something I'm not
getting. Besides, radeon always try to power down TFT panels when
blank != 0, maybe I should improve that ... What is this +1 thing, where
does it comes from ?

Ben.





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
