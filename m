From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] uvesafb: fix section mismatch
	warnings
Date: Sun, 13 Jan 2008 10:31:34 -0800
Message-ID: <20080113103134.d8955a1a.rdunlap@xenotime.net>
References: <20080111170409.10ecb8a9.rdunlap@xenotime.net>
	<20080112104203.GC2523@uranus.ravnborg.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JE7cP-0008GN-6C for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 Jan 2008 10:31:37 -0800
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JE7cO-00052O-To
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 Jan 2008 10:31:37 -0800
Received: from midway.site ([71.245.106.199]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 13 Jan 2008 10:31:34 -0800
In-Reply-To: <20080112104203.GC2523@uranus.ravnborg.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Sam Ravnborg <sam@ravnborg.org>
Cc: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net, akpm <akpm@linux-foundation.org>, adaplas@gmail.com

On Sat, 12 Jan 2008 11:42:03 +0100 Sam Ravnborg wrote:

> On Fri, Jan 11, 2008 at 05:04:09PM -0800, Randy Dunlap wrote:
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > Mark uvesafb_init_mtrr() as __devinit since its caller is __devinit
> > and since it accesses __devinitdata.
> > 
> > WARNING: vmlinux.o(.text+0x4df80e): Section mismatch: reference to .init.data: (between 'uvesafb_init_mtrr' and 'uvesafb_show_vbe_ver')
> 
> OK
> 
> > 
> > Variable 'blank' cannot be __devinitdata since it is referenced in an
> > fb_ops method that could be called at any time.
> 
> The patch is correct but the explanation is wrong.
> uvesafb uses local variables named blank in two spots that hides the
> global defined blank which I assume has confused you.

Ack, thanks.

> The problematic spot is this use as a parameter:
> module_param(blank, bool, 0);
> MODULE_PARM_DESC(blank, "Enable hardware blanking");
> 
> This is at least how I understand it looking at the code.
> 
> 	Sam
> 
> 
> 
> > 
> > WARNING: vmlinux.o(.text+0x4dfc1e): Section mismatch: reference to .init.data:blank (between 'param_set_scroll' and 'vesa_setpalette')
> > WARNING: vmlinux.o(.text+0x4dfc24): Section mismatch: reference to .init.data:blank (between 'param_set_scroll' and 'vesa_setpalette')
> > 
> > Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> > ---
> >  drivers/video/uvesafb.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- linux-2.6.24-rc7-git1.orig/drivers/video/uvesafb.c
> > +++ linux-2.6.24-rc7-git1/drivers/video/uvesafb.c
> > @@ -43,7 +43,7 @@ static struct fb_fix_screeninfo uvesafb_
> >  };
> >  
> >  static int mtrr		__devinitdata = 3; /* enable mtrr by default */
> > -static int blank	__devinitdata = 1; /* enable blanking by default */
> > +static int blank	= 1;		   /* enable blanking by default */
> >  static int ypan		__devinitdata = 1; /* 0: scroll, 1: ypan, 2: ywrap */
> >  static int pmi_setpal	__devinitdata = 1; /* use PMI for palette changes */
> >  static int nocrtc	__devinitdata; /* ignore CRTC settings */
> > @@ -1549,7 +1549,7 @@ static void __devinit uvesafb_init_info(
> >  		info->fbops->fb_pan_display = NULL;
> >  }
> >  
> > -static void uvesafb_init_mtrr(struct fb_info *info)
> > +static void __devinit uvesafb_init_mtrr(struct fb_info *info)
> >  {
> >  #ifdef CONFIG_MTRR
> >  	if (mtrr && !(info->fix.smem_start & (PAGE_SIZE - 1))) {
> > ---
> > ~Randy
> 


---
~Randy

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
