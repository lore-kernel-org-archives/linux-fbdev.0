From: Peter Jones <pjones@redhat.com>
Date: Thu, 12 May 2016 20:19:10 +0000
Subject: Re: [PATCH] efifb: Don't show the mapping VA
Message-Id: <20160512201910.GD1973@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c980a1a405f54b39fc6382c20182786c894c7ffd.1463011030.git.luto@kernel.org>
In-Reply-To: <c980a1a405f54b39fc6382c20182786c894c7ffd.1463011030.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@kernel.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>

On Wed, May 11, 2016 at 04:57:47PM -0700, Andy Lutomirski wrote:
> The framebuffer mapping virtual address leaks information about the
> kernel memory layout.  Stop logging it.
> 
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

In practice it also hasn't ever helped any actual debugging.

Signed-off-by: Peter Jones <pjones@redhat.com>

> ---
>  drivers/video/fbdev/efifb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 95d293b7445a..3dcaf4e82885 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -247,10 +247,8 @@ static int efifb_probe(struct platform_device *dev)
>  		goto err_release_fb;
>  	}
>  
> -	printk(KERN_INFO "efifb: framebuffer at 0x%lx, mapped to 0x%p, "
> -	       "using %dk, total %dk\n",
> -	       efifb_fix.smem_start, info->screen_base,
> -	       size_remap/1024, size_total/1024);
> +	printk(KERN_INFO "efifb: framebuffer at 0x%lx, using %dk, total %dk\n",
> +	       efifb_fix.smem_start, size_remap/1024, size_total/1024);
>  	printk(KERN_INFO "efifb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
>  	       efifb_defined.xres, efifb_defined.yres,
>  	       efifb_defined.bits_per_pixel, efifb_fix.line_length,
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
  Peter
