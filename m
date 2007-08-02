From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] tdfxfb: mtrr support (2nd revision)
Date: Thu, 2 Aug 2007 19:56:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708021952550.5150@anakin>
References: <20070729230653.d5dd086b.krzysztof.h1@wp.pl>
	<1185750991.9324.14.camel@daplas>
	<20070731115557.50b9b933.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGeuP-0007t3-S2 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 10:56:25 -0700
Received: from asia.telenet-ops.be ([195.130.137.74])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IGeuO-0006fA-8p
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 10:56:25 -0700
In-Reply-To: <20070731115557.50b9b933.krzysztof.h1@wp.pl>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

On Tue, 31 Jul 2007, Krzysztof Helt wrote:
> This patch adds mtrr support to the tdfxfb driver.
> It also kills one redundant include and initialization value.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> 
> This patch requires all previous tdfxfb patches sent to this list.
> It reduces ifdefs to only removing unused "nomtrr" parameter from the code.
> 
> --- linux-2.6.22/drivers/video/tdfxfb.c	2007-07-31 11:49:16.921420742 +0200
> +++ linux-2.6.23/drivers/video/tdfxfb.c	2007-07-31 11:49:46.147086218 +0200
> @@ -78,6 +77,24 @@
>  #define DPRINTK(a,b...)
>  #endif
>  
> +#ifdef CONFIG_MTRR
> +#include <asm/mtrr.h>
> +#else
> +/* duplicate asm/mtrr.h defines to work on archs without mtrr */
> +#define MTRR_TYPE_WRCOMB     1
> +
> +static __inline__ int mtrr_add (unsigned long base, unsigned long size,
> +				unsigned int type, char increment)
> +{
> +    return -ENODEV;
> +}
> +static __inline__ int mtrr_del (int reg, unsigned long base,
> +				unsigned long size)
> +{
> +    return -ENODEV;
> +}
> +#endif

While I like your suggestion to move mtrr.h to the include/asm-generic or
include/linux directory, and redefine all functions as dummies in case
CONFIG_MTRR is not defined, the above are not really dummies, as they
return an error code.

> @@ -1227,6 +1246,12 @@ static int __devinit tdfxfb_probe(struct
>  
>  	printk("fb: %s memory = %dK\n", tdfx_fix.id, tdfx_fix.smem_len >> 10);
>  
> +	default_par->mtrr_handle = -1;
> +	if (!nomtrr)
> +		default_par->mtrr_handle =
> +			mtrr_add(tdfx_fix.smem_start, tdfx_fix.smem_len,
> +				 MTRR_TYPE_WRCOMB, 1);
> +

... but everything works nicely, because no callers of mttr_{add,del}()
check for actual errors ;-)

In this case it's a bit tricky to have dummies _and_ check for
failures...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
