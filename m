From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Patch to add mode setting to sysfs
Date: Mon, 21 Feb 2005 18:37:45 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502211837040.13423@pentafluge.infradead.org>
References: <9e4733910502161430ff1dad1@mail.gmail.com> 
 <200502172150.16256.adaplas@hotpop.com>  <9e47339105021712494955212d@mail.gmail.com>
  <200502180804.46005.adaplas@hotpop.com> <9e47339105021716392dcce795@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3IRQ-0003ek-5o
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 10:37:56 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3IRO-0002re-4j
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 10:37:56 -0800
In-Reply-To: <9e47339105021716392dcce795@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@pentafluge.infradead.org>


Here is a question. What about if the drivers are built and fbdev is 
modular? I will have to try it to see the results.

On Thu, 17 Feb 2005, Jon Smirl wrote:

> On Fri, 18 Feb 2005 08:04:46 +0800, Antonino A. Daplas
> <adaplas@hotpop.com> wrote:
> > If possible, separate the sysfs patch from making fbcore as module.
> 
> Split for making fbcore into a module. It's pretty minor.
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
> 
> 
> diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
> --- a/drivers/video/Kconfig	2005-02-17 19:11:37 -05:00
> +++ b/drivers/video/Kconfig	2005-02-17 19:11:37 -05:00
> @@ -5,7 +5,7 @@
>  menu "Graphics support"
>  
>  config FB
> -	bool "Support for frame buffer devices"
> +	tristate "Support for frame buffer devices"
>  	---help---
>  	  The frame buffer device provides an abstraction for the graphics
>  	  hardware. It represents the frame buffer of some video hardware and
> diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
> --- a/drivers/video/Makefile	2005-02-17 19:11:37 -05:00
> +++ b/drivers/video/Makefile	2005-02-17 19:11:37 -05:00
> @@ -8,11 +8,13 @@
>  obj-$(CONFIG_LOGO)		  += logo/
>  obj-$(CONFIG_SYSFS)		  += backlight/
>  
> -obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o
> fbsysfs.o modedb.o softcursor.o
> +obj-$(CONFIG_FB)                  += fb.o
> +fb-y                              := fbmem.o fbmon.o fbcmap.o
> fbsysfs.o modedb.o softcursor.o
>  # Only include macmodes.o if we have FB support and are PPC
> -ifeq ($(CONFIG_FB),y)
> -obj-$(CONFIG_PPC)                 += macmodes.o
> +ifneq ($(CONFIG_FB),n)
> +fb-$(CONFIG_PPC)                  += macmodes.o
>  endif
> +fb-objs                           := $(fb-y)
>  
>  # Hardware specific drivers go first
>  obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
> diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> --- a/drivers/video/fbmem.c	2005-02-17 19:11:37 -05:00
> +++ b/drivers/video/fbmem.c	2005-02-17 19:11:37 -05:00
> @@ -1204,7 +1204,22 @@
>  	}
>  	return 0;
>  }
> +
> +void __exit
> +fbmem_exit(void)
> +{
> +	class_simple_destroy(fb_class);
> +}
> +
> +#ifdef MODULE
> +module_init(fbmem_init);
> +module_exit(fbmem_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Framebuffer base");
> +#else
>  subsys_initcall(fbmem_init);
> +subsys_exitcall(fbmem_exit);
> +#endif
>  
>  static char *video_options[FB_MAX];
>  static int ofonly;
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
