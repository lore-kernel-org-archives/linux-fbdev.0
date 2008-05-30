From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc3 1/5] pxafb: module
 unloading support
Date: Fri, 30 May 2008 19:04:53 +0200
Message-ID: <20080530190453.2e205e1d.krzysztof.h1@poczta.fm>
References: <1212150530-14941-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212150530-14941-2-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K280C-0004tr-Bs for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 10:02:52 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K280A-0000Js-Mc
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 10:02:52 -0700
In-Reply-To: <1212150530-14941-2-git-send-email-jayakumar.lkml@gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Fri, 30 May 2008 08:28:46 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> This patch to pxafb adds:
>  - exit and remove handlers
>  - changes to use __devinit/exit for probe functions and __init/exit for
>    init/exit functions
>  - set g_options to initdata since it is only accessed from pxafb_init
> in order to enable module loading/unloading of pxafb.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---
>  drivers/video/pxafb.c |   52 ++++++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index 274bc93..a4bb733 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c

> @@ -1584,10 +1584,10 @@ static int __init pxafb_parse_options(struct device *dev, char *options)
>  	return 0;
>  }
>  
> -static char g_options[256] __devinitdata = "";
> +static char g_options[256] __initdata = "";
>  

This is not right. The g_options is used by
the pxafb_probe (below) and pxafb_parse_options
which are now __devinit.

> @@ -1611,7 +1611,7 @@ MODULE_PARM_DESC(options, "LCD parameters (see Documentation/fb/pxafb.txt)");
>  #define pxafb_setup_options()		(0)
>  #endif
>  
> -static int __init pxafb_probe(struct platform_device *dev)
> +static int __devinit pxafb_probe(struct platform_device *dev)
>  {
>  	struct pxafb_info *fbi;
>  	struct pxafb_mach_info *inf;


> @@ -1776,16 +1776,44 @@ failed:
>  	return ret;
>  }
>  
> +static int __devexit pxafb_remove(struct platform_device *dev)
> +{
> +	struct pxafb_info *fbi = platform_get_drvdata(dev);
> +	struct resource *r;
> +	int irq;
> +
> +	if (fbi) {
> +		struct fb_info *info = &fbi->fb;
> +
> +		irq = platform_get_irq(dev, 0);
> +		free_irq(irq, fbi);
> +
> +		r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +		release_mem_region(r->start, r->end - r->start + 1);
> +
> +		iounmap(fbi->mmio_base);
> +

I can be wrong here, but should not the iounmap be done before
releasing the iomaped region?

Regards,
Krzysztof


----------------------------------------------------------------------
Mucha powraca!
Sprawdz >>> http://link.interia.pl/f1e0d


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
