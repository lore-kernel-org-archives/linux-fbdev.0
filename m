From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] tdfxfb: mtrr support
Date: Mon, 30 Jul 2007 07:16:31 +0800
Message-ID: <1185750991.9324.14.camel@daplas>
References: <20070729230653.d5dd086b.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IFI0K-0004Vt-2T for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Jul 2007 16:16:52 -0700
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IFI0H-0002V1-Sn
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Jul 2007 16:16:52 -0700
Received: by wa-out-1112.google.com with SMTP id k22so1710807waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 29 Jul 2007 16:16:49 -0700 (PDT)
In-Reply-To: <20070729230653.d5dd086b.krzysztof.h1@wp.pl>
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

On Sun, 2007-07-29 at 23:06 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch adds mtrr support to the tdfxfb driver.
> 
> It also kills one redundant include and initialization value.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> 
> This patch requires all previous tdfxfb patches sent to this list.
> 
> --- linux-2.6.22.old/drivers/video/tdfxfb.c	2007-07-28 23:37:00.000000000 +0200
> +++ linux-2.6.22/drivers/video/tdfxfb.c	2007-07-28 23:35:49.000000000 +0200
> @@ -67,7 +67,9 @@
>  #include <linux/init.h>
>  #include <linux/pci.h>
>  #include <asm/io.h>
> -#include <linux/spinlock.h>
> +#ifdef CONFIG_MTRR
> +#include <asm/mtrr.h>
> +#endif
>  
>  #include <video/tdfx.h>
>  
> @@ -150,7 +152,11 @@ MODULE_DEVICE_TABLE(pci, tdfxfb_id_table
>  static int nopan;
>  static int nowrap = 1;      /* not implemented (yet) */
>  static int hwcursor = 1;
> -static char *mode_option __devinitdata = NULL;
> +static char *mode_option __devinitdata;
> +/* mtrr option */
> +#ifdef CONFIG_MTRR
> +static int nomtrr __devinitdata;
> +#endif
>  
>  /* -------------------------------------------------------------------------
>   *                      Hardware-specific funcions
> @@ -1227,6 +1233,14 @@ static int __devinit tdfxfb_probe(struct
>  
>  	printk("fb: %s memory = %dK\n", tdfx_fix.id, tdfx_fix.smem_len >> 10);
>  
> +#ifdef CONFIG_MTRR
> +	default_par->mtrr_handle = -1;
> +	if (!nomtrr)
> +		default_par->mtrr_handle =
> +			mtrr_add(tdfx_fix.smem_start, tdfx_fix.smem_len,
> +				 MTRR_TYPE_WRCOMB, 1);
> +#endif
> +

Since akpm already commented against using #ifdef's within functions,
might as well modify the patch to something like this:

#ifdef CONFIG_MTRR
static inline void tdfxfb_mtrr_add(struct fb_info *info)
{
	struct tdfxfb_par *par = info->par;

	par->mtrr_handle =  mtrr_add(info->fix.smem_start,
				 info->fix.smem_len, 
				 MTRR_TYPE_WRCOMB, 1);
}
#else
#define tdfxfb_mtrr_add(...) do {} while (0)
#endif

...tdfxfb_probe(...)
{
	...
	tdfxfb_mtrr_add();
	...
} 

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
