From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [Linux-fbdev-devel] [PATCH 11/15] tgafb: fix cmap memory leak
Date: Mon, 9 Feb 2009 18:09:11 +0100
Message-ID: <20090209180911.fe7337a8.krzysztof.h1@wp.pl>
References: <20090207121831.11c34988@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756396AbZBIRFU@vger.kernel.org>
In-Reply-To: <20090207121831.11c34988@ephemeral>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andres Salomon <dilinger@queued.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Sat, 7 Feb 2009 12:18:31 -0500
Andres Salomon <dilinger@queued.net> wrote:

> 
>  - fix cmap leak when register_framebuffer fails
> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


>  drivers/video/tgafb.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
> index 680642c..a86046f 100644
> --- a/drivers/video/tgafb.c
> +++ b/drivers/video/tgafb.c
> @@ -1663,7 +1663,7 @@ tgafb_register(struct device *dev)
>  	if (register_framebuffer(info) < 0) {
>  		printk(KERN_ERR "tgafb: Could not register framebuffer\n");
>  		ret = -EINVAL;
> -		goto err1;
> +		goto err2;
>  	}
>  
>  	if (tga_bus_pci) {
> @@ -1682,6 +1682,8 @@ tgafb_register(struct device *dev)
>  
>  	return 0;
>  
> + err2:
> +	fb_dealloc_cmap(&info->cmap);
>   err1:
>  	if (mem_base)
>  		iounmap(mem_base);
> -- 
> 1.5.6.5
> 
> 
> ------------------------------------------------------------------------------
> Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
> software. With Adobe AIR, Ajax developers can use existing skills and code to
> build responsive, highly engaging applications that combine the power of local
> resources and data with the reach of the web. Download the Adobe AIR SDK and
> Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 
