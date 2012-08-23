From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:40:42 +0000
Subject: Re: [PATCH 1/5] drivers/video/epson1355fb.c: use devm_ functions
Message-Id: <5036954A.6000207@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344008414-2894-1-git-send-email-damien.cassou@lifl.fr> <1344008414-2894-2-git-send-email-damien.cassou@lifl.fr>
In-Reply-To: <1344008414-2894-2-git-send-email-damien.cassou@lifl.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Damien Cassou <damien.cassou@lifl.fr>
Cc: Christopher Hoover <ch@murgatroid.com>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/03/2012 03:40 PM, Damien Cassou wrote:
> From: Damien Cassou <damien.cassou@lifl.fr>
> 
> The various devm_ functions allocate memory that is released when a driver
> detaches. This patch uses these functions for data that is allocated in the
> probe function of a platform device and is only freed in the remove function.
> 
> Signed-off-by: Damien Cassou <damien.cassou@lifl.fr>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
>  drivers/video/epson1355fb.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
> index 68b9b51..246da1e 100644
> --- a/drivers/video/epson1355fb.c
> +++ b/drivers/video/epson1355fb.c
> @@ -592,12 +592,8 @@ static int epson1355fb_remove(struct platform_device *dev)
> 
>  	if (info) {
>  		fb_dealloc_cmap(&info->cmap);
> -		if (info->screen_base)
> -			iounmap(info->screen_base);
>  		framebuffer_release(info);
>  	}
> -	release_mem_region(EPSON1355FB_FB_PHYS, EPSON1355FB_FB_LEN);
> -	release_mem_region(EPSON1355FB_REGS_PHYS, EPSON1355FB_REGS_LEN);
>  	return 0;
>  }
> 
> @@ -608,15 +604,18 @@ static int __devinit epson1355fb_probe(struct platform_device *dev)
>  	u8 revision;
>  	int rc = 0;
> 
> -	if (!request_mem_region(EPSON1355FB_REGS_PHYS, EPSON1355FB_REGS_LEN, "S1D13505 registers")) {
> +	if (!devm_request_mem_region(&dev->dev, EPSON1355FB_REGS_PHYS,
> +				     EPSON1355FB_REGS_LEN,
> +				     "S1D13505 registers")) {
>  		printk(KERN_ERR "epson1355fb: unable to reserve "
>  		       "registers at 0x%0x\n", EPSON1355FB_REGS_PHYS);
>  		rc = -EBUSY;
>  		goto bail;
>  	}
> 
> -	if (!request_mem_region(EPSON1355FB_FB_PHYS, EPSON1355FB_FB_LEN,
> -				"S1D13505 framebuffer")) {
> +	if (!devm_request_mem_region(&dev->dev, EPSON1355FB_FB_PHYS,
> +				     EPSON1355FB_FB_LEN,
> +				     "S1D13505 framebuffer")) {
>  		printk(KERN_ERR "epson1355fb: unable to reserve "
>  		       "framebuffer at 0x%0x\n", EPSON1355FB_FB_PHYS);
>  		rc = -EBUSY;
> @@ -638,7 +637,8 @@ static int __devinit epson1355fb_probe(struct platform_device *dev)
>  	}
>  	info->pseudo_palette = default_par->pseudo_palette;
> 
> -	info->screen_base = ioremap(EPSON1355FB_FB_PHYS, EPSON1355FB_FB_LEN);
> +	info->screen_base = devm_ioremap(&dev->dev, EPSON1355FB_FB_PHYS,
> +					 EPSON1355FB_FB_LEN);
>  	if (!info->screen_base) {
>  		printk(KERN_ERR "epson1355fb: unable to map framebuffer\n");
>  		rc = -ENOMEM;
> 

