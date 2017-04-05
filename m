From: Juergen Gross <jgross@suse.com>
Date: Wed, 05 Apr 2017 08:18:43 +0000
Subject: Re: [PATCH] xen, fbfront: add support for specifying size via xenstore
Message-Id: <30c4d7f4-044e-9eff-bda9-fa9f5486e66f@suse.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170323125304.11891-1-jgross@suse.com>
In-Reply-To: <20170323125304.11891-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com
Cc: boris.ostrovsky@oracle.com

On 23/03/17 13:53, Juergen Gross wrote:
> Today xen-fbfront supports specifying the display size via module
> parameters only. Add support for specifying the size via Xenstore in
> order to enable doing this easily via the domain's Xen configuration.
> 
> Add an error message in case the configured display size conflicts
> with video memory size.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Bartlomiej, any comments? Can you please take this patch or should I
carry it through the Xen tree?


Juergen

> ---
>  drivers/video/fbdev/xen-fbfront.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
> index 3ee309c..46f6396 100644
> --- a/drivers/video/fbdev/xen-fbfront.c
> +++ b/drivers/video/fbdev/xen-fbfront.c
> @@ -18,6 +18,8 @@
>   * frame buffer.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/console.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> @@ -380,10 +382,18 @@ static int xenfb_probe(struct xenbus_device *dev,
>  			video[KPARAM_MEM] = val;
>  	}
>  
> +	video[KPARAM_WIDTH] = xenbus_read_unsigned(dev->otherend, "width",
> +						   video[KPARAM_WIDTH]);
> +	video[KPARAM_HEIGHT] = xenbus_read_unsigned(dev->otherend, "height",
> +						    video[KPARAM_HEIGHT]);
> +
>  	/* If requested res does not fit in available memory, use default */
>  	fb_size = video[KPARAM_MEM] * 1024 * 1024;
>  	if (video[KPARAM_WIDTH] * video[KPARAM_HEIGHT] * XENFB_DEPTH / 8
>  	    > fb_size) {
> +		pr_warn("display parameters %d,%d,%d invalid, use defaults\n",
> +			video[KPARAM_MEM], video[KPARAM_WIDTH],
> +			video[KPARAM_HEIGHT]);
>  		video[KPARAM_WIDTH] = XENFB_WIDTH;
>  		video[KPARAM_HEIGHT] = XENFB_HEIGHT;
>  		fb_size = XENFB_DEFAULT_FB_LEN;
> 

