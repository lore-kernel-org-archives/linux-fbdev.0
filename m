From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 18/33] pm3fb: mtrr support and
	noaccel option
Date: Thu, 26 Jul 2007 13:12:38 -0700
Message-ID: <20070726131238.9ed4bc7a.akpm@linux-foundation.org>
References: <46A8925B.8090801@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE9i6-0006p8-QE for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 13:13:22 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IE9i5-0005aq-J1
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 13:13:22 -0700
In-Reply-To: <46A8925B.8090801@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 26 Jul 2007 20:23:55 +0800 "Antonino A. Daplas" <adaplas@gmail.com> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch adds usage of MTRR registers and two new options: noaccel and
> nomtrr.
> 

It's been tested with CONFIG_MTRR=n, I trust?

> +#ifdef CONFIG_MTRR
> +#include <asm/mtrr.h>
> +#endif

Is the ifdef there needed for a successful compile?  If not, it's nicer to
leave it out.

>  #include <video/pm3fb.h>
>  
> @@ -52,6 +55,12 @@ #define PM3_PIXMAP_SIZE	(2048 * 4)
>   * Driver data
>   */
>  static char *mode_option __devinitdata;
> +static int noaccel   __devinitdata = 0;
> +
> +/* mtrr option */
> +#ifdef CONFIG_MTRR
> +static int nomtrr __devinitdata = 0;

Unneeded initialisation to zero.  scripts/checkpatch.pl detects and reports
this.

> +#ifdef CONFIG_MTRR
> +	if (!nomtrr) {
> +		par->mtrr_handle = mtrr_add(pm3fb_fix.smem_start,
> +						pm3fb_fix.smem_len,
> +						MTRR_TYPE_WRCOMB, 1);
> +	}
> +#endif
>  	info->fbops = &pm3fb_ops;
>  
>  	par->video = PM3_READ_REG(par, PM3VideoControl);
> @@ -1257,6 +1276,10 @@ #endif
>  			FBINFO_HWACCEL_IMAGEBLIT |
>  			FBINFO_HWACCEL_FILLRECT;
>  
> +	if (noaccel) {
> +	    	printk(KERN_DEBUG "disabling acceleration\n");
> +  		info->flags |= FBINFO_HWACCEL_DISABLED;
> +	}
>  	info->pixmap.addr = kmalloc(PM3_PIXMAP_SIZE, GFP_KERNEL);
>  	if (!info->pixmap.addr) {
>  		retval = -ENOMEM;
> @@ -1330,6 +1353,11 @@ static void __devexit pm3fb_remove(struc
>  		unregister_framebuffer(info);
>  		fb_dealloc_cmap(&info->cmap);
>  
> +#ifdef CONFIG_MTRR
> +	if (par->mtrr_handle >= 0)
> +		mtrr_del(par->mtrr_handle, info->fix.smem_start,
> +			 info->fix.smem_len);
> +#endif /* CONFIG_MTRR */

I suspect that with a bit of thought a lot of these unpleasing ifdefs could
be removed.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
