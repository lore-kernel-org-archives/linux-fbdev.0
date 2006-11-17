From: James Simmons <jsimmons@infradead.org>
Subject: Re: [patch 09/25] annotate some variables in
 vesafb driver as __read_mostly
Date: Fri, 17 Nov 2006 18:51:29 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611171851190.32200@pentafluge.infradead.org>
References: <200611020550.kA25oNaj002306@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gl8oL-0001JA-MS for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 10:51:37 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gl8oI-0002OB-T9
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 10:51:37 -0800
In-Reply-To: <200611020550.kA25oNaj002306@shell0.pdx.osdl.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org, deller@gmx.de


Acked-by: James Simmons <jsimmons@infradead.org>

tested as well.

On Wed, 1 Nov 2006, akpm@osdl.org wrote:

> From: Helge Deller <deller@gmx.de>
> 
> - annotate some variables in vesafb driver as __read_mostly
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/video/vesafb.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff -puN drivers/video/vesafb.c~annotate-some-variables-in-vesafb drivers/video/vesafb.c
> --- a/drivers/video/vesafb.c~annotate-some-variables-in-vesafb
> +++ a/drivers/video/vesafb.c
> @@ -47,17 +47,16 @@ static struct fb_fix_screeninfo vesafb_f
>  	.accel	= FB_ACCEL_NONE,
>  };
>  
> -static int             inverse   = 0;
> -static int             mtrr      = 0; /* disable mtrr */
> -static int	       vram_remap __initdata = 0; /* Set amount of memory to be used */
> -static int	       vram_total __initdata = 0; /* Set total amount of memory */
> -static int             pmi_setpal = 1;	/* pmi for palette changes ??? */
> -static int             ypan       = 0;  /* 0..nothing, 1..ypan, 2..ywrap */
> -static unsigned short  *pmi_base  = NULL;
> -static void            (*pmi_start)(void);
> -static void            (*pmi_pal)(void);
> -static int             depth;
> -static int             vga_compat;
> +static int   inverse    __read_mostly;
> +static int   mtrr       __read_mostly;		/* disable mtrr */
> +static int   vram_remap __initdata;		/* Set amount of memory to be used */
> +static int   vram_total __initdata;		/* Set total amount of memory */
> +static int   pmi_setpal __read_mostly = 1;	/* pmi for palette changes ??? */
> +static int   ypan       __read_mostly;		/* 0..nothing, 1..ypan, 2..ywrap */
> +static void  (*pmi_start)(void) __read_mostly;
> +static void  (*pmi_pal)  (void) __read_mostly;
> +static int   depth      __read_mostly;
> +static int   vga_compat __read_mostly;
>  /* --------------------------------------------------------------------- */
>  
>  static int vesafb_pan_display(struct fb_var_screeninfo *var,
> @@ -312,6 +311,7 @@ static int __init vesafb_probe(struct pl
>  		ypan = pmi_setpal = 0; /* not available or some DOS TSR ... */
>  
>  	if (ypan || pmi_setpal) {
> +		unsigned short *pmi_base;
>  		pmi_base  = (unsigned short*)phys_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
>  		pmi_start = (void*)((char*)pmi_base + pmi_base[1]);
>  		pmi_pal   = (void*)((char*)pmi_base + pmi_base[2]);
> _
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
