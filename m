From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] skeletonfb: Various corrections
Date: Mon, 9 Apr 2007 13:00:05 -0700
Message-ID: <20070409130005.0581867d.akpm@linux-foundation.org>
References: <461A2BED.2050501@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hb02A-0006gt-8d for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 13:00:14 -0700
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hb029-0007rf-Qy
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 13:00:14 -0700
In-Reply-To: <461A2BED.2050501@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Gerd Hoffmann <kraxel@suse.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andi Kleen <ak@suse.de>, Krzysztof Halasa <khc@pm.waw.pl>

On Mon, 09 Apr 2007 20:05:01 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This is mainly correction of types, typos and missing characters
> in the skeletonfb.c file found while trying to prepare a new fb
> driver.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> ---
> 
>  drivers/video/skeletonfb.c |  118 ++++++++++++++++++++++++++------------------
>  1 files changed, 71 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
> index bb96cb6..30eb964 100644
> --- a/drivers/video/skeletonfb.c
> +++ b/drivers/video/skeletonfb.c
> @@ -51,6 +51,9 @@ #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/fb.h>
>  #include <linux/init.h>
> +#ifdef CONFIG_PCI
> +#include <linux/pci.h>
> +#endif

pci.h shouldn't need these include guards?

>      /*
>       *  This is just simple sample code.
> @@ -60,6 +63,11 @@ #include <linux/init.h>
>       */
>  
>  /*
> + * Driver data
> + */
> +static char *mode_option __devinitdata = NULL;

The initialisation to NULL is unneeded and undesirable (it increases
vmlinux size).

>  
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
> +static struct pci_device_id xxxfb_id_table[] = {
> +	{ PCI_VENDOR_ID_XXX, PCI_DEVICE_ID_XXX,
> +	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
> +	  ADDR, 0 },
> +	{ 0, }
> +};
> +
>  /* For PCI drivers */
>  static struct pci_driver xxxfb_driver = {
>  	.name =		"xxxfb",
> -	.id_table =	xxxfb_devices,
> +	.id_table =	xxxfb_id_table,
>  	.probe =	xxxfb_probe,
>  	.remove =	__devexit_p(xxxfb_remove),
>  	.suspend =      xxxfb_suspend, /* optional */
>  	.resume =       xxxfb_resume,  /* optional */
>  };

I think this example still need to handle the CONFIG_PM=n case?

Something like

#ifdef CONFIG_PM
void xxxfb_suspend(args)
{
	...
}
#else
#define xxxfb_suspend NULL
#define xxxfb_resume NULL
#endif


> -static int __init xxxfb_init(void)
> +int __init xxxfb_init(void)
>  {
>  	/*
>  	 *  For kernel boot options (in 'video=xxxfb:<options>' format)
> @@ -854,10 +898,12 @@ #endif
>  	return pci_register_driver(&xxxfb_driver);
>  }
>  
> +#ifdef MODULE
>  static void __exit xxxfb_exit(void)
>  {
>  	pci_unregister_driver(&xxxfb_driver);
>  }
> +#endif
>  #else
>  #include <linux/platform_device.h>
>  /* for platform devices */
> @@ -898,13 +944,16 @@ #endif
>  	return ret;
>  }
>  
> +#ifdef MODULE
>  static void __exit xxxfb_exit(void)
>  {
>  	platform_device_unregister(&xxxfb_device);
>  	driver_unregister(&xxxfb_driver);
>  }
>  #endif
> +#endif
>  

Are these ifdefs around the __exit functions really recommended fbdev
practice?  I hope not.


There are two types of exit code:

__exit: discarded at boot time, via free_initmem() (except for uml, which
does run exitcalls (or used to)).

__exit_call: discarded at link time via /DISCARD/ in vmlinux.lds.S.

So it is I think better to leave the __exit code in place so that the
compiler gets to check it.  It will increase vmlinux size, but that memory
gets reclaimed at runtime.

The __exit_call memory gets discarded at link-time, so I do think we should
always compile __exit_call functions.

(We don't actually _have_ any __exit_call functions in the kernel, which
makes one wonder why we bothered creating it)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
