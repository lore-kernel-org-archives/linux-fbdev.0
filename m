From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] make viafb work on x86_64
Date: Mon, 11 May 2009 23:08:12 +0200
Message-ID: <20090511230812.9bad3b0d.krzysztof.h1@poczta.fm>
References: <20090511164915.GC4163@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M3ce8-0005PI-Nm
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 May 2009 21:02:48 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M3ce4-0002t2-54 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 May 2009 21:02:48 +0000
In-Reply-To: <20090511164915.GC4163@prithivi.gnumonks.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Harald Welte <HaraldWelte@viatech.com>
Cc: JosephChan@via.com.tw, Andrew Morton <akpm@linux-foundation.org>, ScottFang@viatech.com.cn, linux-fbdev-devel@lists.sourceforge.net

On Tue, 12 May 2009 00:49:15 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> [FB] make viafb work on x86_64
> 
> This patch makes fixes a bug in viafb on x86_64 builds (e.g. for VIA Nano CPU).
> You cannot make the assumption that sizeof(unsigned int) == sizeof(unsigned
> long), so the parsing of the default mode (640x480) fails, leading to a
> division by zero during insmod of the driver.
> 
> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index e327b84..02e7a72 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -2103,7 +2106,7 @@ static void viafb_remove_proc(struct proc_dir_entry *viafb_entry)
>  
>  static int __devinit via_pci_probe(void)
>  {
> -	unsigned int default_xres, default_yres;
> +	unsigned long default_xres, default_yres;
>  	char *tmpc, *tmpm;
>  	char *tmpc_sec, *tmpm_sec;
>  	int vmode_index;
> @@ -2196,8 +2199,8 @@ static int __devinit via_pci_probe(void)
>  	viafb_FB_MM = viaparinfo->fbmem_virt;
>  	tmpm = viafb_mode;
>  	tmpc = strsep(&tmpm, "x");
> -	strict_strtoul(tmpc, 0, (unsigned long *)&default_xres);
> -	strict_strtoul(tmpm, 0, (unsigned long *)&default_yres);
> +	strict_strtoul(tmpc, 0, &default_xres);
> +	strict_strtoul(tmpm, 0, &default_yres);
>  
>  	vmode_index = viafb_get_mode_index(default_xres, default_yres, 0);
>  	DEBUG_MSG(KERN_INFO "0->index=%d\n", vmode_index);
> -- 
> - Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
> ============================================================================
> VIA Open Source Liaison
> 

----------------------------------------------------------------------
Doladuj telefon! 
Sprawdz >> http://link.interia.pl/f215b


------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
