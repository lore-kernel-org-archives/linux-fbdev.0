From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 4/6] [PATCH] gxfb: Support command
 line options
Date: Wed, 29 Nov 2006 14:21:54 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611291421500.26581@pentafluge.infradead.org>
References: <20061128230639.25769.43.stgit@cosmic.amd.com>
	<20061128231507.25769.75366.stgit@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GpQK1-0000ad-GO for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 29 Nov 2006 06:22:01 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GpQJx-0004DH-AM
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 29 Nov 2006 06:22:00 -0800
In-Reply-To: <20061128231507.25769.75366.stgit@cosmic.amd.com>
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
Cc: info-linux@ldcmail.amd.com, akpm@osdl.org


Acked-By: James Simmons <jsimmons@infradead.org>

On Tue, 28 Nov 2006, Jordan Crouse wrote:

> From: Jordan Crouse <jordan.crouse@amd.com>
> 
> Add support for command line options for setting the mode and various
> settings.
> 
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> ---
> 
>  drivers/video/geode/gxfb_core.c |   36 ++++++++++++++++++++++++++++++------
>  1 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
> index ccc50fc..d404f56 100644
> --- a/drivers/video/geode/gxfb_core.c
> +++ b/drivers/video/geode/gxfb_core.c
> @@ -35,10 +35,10 @@ #include "geodefb.h"
>  #include "display_gx.h"
>  #include "video_gx.h"
>  
> -static char mode_option[32] = "640x480-16@60";
> +static char *mode_option;
>  
>  /* Modes relevant to the GX (taken from modedb.c) */
> -static const struct fb_videomode __initdata gx_modedb[] = {
> +static const struct fb_videomode gx_modedb[] __initdata = {
>  	/* 640x480-60 VESA */
>  	{ NULL, 60, 640, 480, 39682,  48, 16, 33, 10, 96, 2,
>  	  0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
> @@ -341,7 +341,8 @@ static int __init gxfb_probe(struct pci_
>  		goto err;
>  	}
>  
> -        /* Clear the frame buffer of garbage. */
> +       
> +	/* Clear the frame buffer of garbage. */
>          memset_io(info->screen_base, 0, info->fix.smem_len);
>  
>  	gxfb_check_var(&info->var, info);
> @@ -411,11 +412,34 @@ static struct pci_driver gxfb_driver = {
>  	.remove		= gxfb_remove,
>  };
>  
> +#ifndef MODULE
> +static int __init gxfb_setup(char *options) {
> +
> +	char *opt;
> +
> +	if (!options || !*options)
> +		return 0;
> +
> +	while((opt = strsep(&options, ",")) != NULL) {
> +		if (!*opt)
> +			continue;
> +
> +		mode_option = opt;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>  static int __init gxfb_init(void)
>  {
>  #ifndef MODULE
> -	if (fb_get_options("gxfb", NULL))
> +	char *option = NULL;
> +
> +	if (fb_get_options("gxfb", &option))
>  		return -ENODEV;
> +
> +	gxfb_setup(option);
>  #endif
>  	return pci_register_driver(&gxfb_driver);
>  }
> @@ -428,8 +452,8 @@ static void __exit gxfb_cleanup(void)
>  module_init(gxfb_init);
>  module_exit(gxfb_cleanup);
>  
> -module_param_string(mode, mode_option, sizeof(mode_option), 0444);
> -MODULE_PARM_DESC(mode, "video mode (<x>x<y>[-<bpp>][@<refr>])");
> +module_param(mode_option, charp, 0);
> +MODULE_PARM_DESC(mode_option, "video mode (<x>x<y>[-<bpp>][@<refr>])");
>  
>  MODULE_DESCRIPTION("Framebuffer driver for the AMD Geode GX");
>  MODULE_LICENSE("GPL");
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
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
