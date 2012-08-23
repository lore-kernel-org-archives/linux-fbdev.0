From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:37:18 +0000
Subject: Re: [PATCH 3/5] drivers/video/mbx/mbxfb.c: use devm_ functions
Message-Id: <5036947E.3040707@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343752762-16861-1-git-send-email-damien.cassou@lifl.fr> <1343752762-16861-2-git-send-email-damien.cassou@lifl.fr>
In-Reply-To: <1343752762-16861-2-git-send-email-damien.cassou@lifl.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Damien Cassou <damien.cassou@lifl.fr>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/31/2012 04:39 PM, Damien Cassou wrote:
> From: Damien Cassou <damien.cassou@lifl.fr>
> 
> The various devm_ functions allocate memory that is released when a driver
> detaches.  This patch uses these functions for data that is allocated in
> the probe function of a platform device and is only freed in the remove
> function.
> 
> Signed-off-by: Damien Cassou <damien.cassou@lifl.fr>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
>  drivers/video/mbx/mbxfb.c |   22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
> index 85e4f44..9229acf 100644
> --- a/drivers/video/mbx/mbxfb.c
> +++ b/drivers/video/mbx/mbxfb.c
> @@ -939,8 +939,9 @@ static int __devinit mbxfb_probe(struct platform_device *dev)
>  	}
>  	mfbi->reg_phys_addr = mfbi->reg_res->start;
>  
> -	mfbi->reg_virt_addr = ioremap_nocache(mfbi->reg_phys_addr,
> -					      res_size(mfbi->reg_req));
> +	mfbi->reg_virt_addr = devm_ioremap_nocache(&dev->dev,
> +						   mfbi->reg_phys_addr,
> +						   res_size(mfbi->reg_req));
>  	if (!mfbi->reg_virt_addr) {
>  		dev_err(&dev->dev, "failed to ioremap Marathon registers\n");
>  		ret = -EINVAL;
> @@ -948,12 +949,12 @@ static int __devinit mbxfb_probe(struct platform_device *dev)
>  	}
>  	virt_base_2700 = mfbi->reg_virt_addr;
>  
> -	mfbi->fb_virt_addr = ioremap_nocache(mfbi->fb_phys_addr,
> -					     res_size(mfbi->fb_req));
> +	mfbi->fb_virt_addr = devm_ioremap_nocache(&dev->dev, mfbi->fb_phys_addr,
> +						  res_size(mfbi->fb_req));
>  	if (!mfbi->fb_virt_addr) {
>  		dev_err(&dev->dev, "failed to ioremap frame buffer\n");
>  		ret = -EINVAL;
> -		goto err4;
> +		goto err3;
>  	}
>  
>  	fbi->screen_base = (char __iomem *)(mfbi->fb_virt_addr + 0x60000);
> @@ -971,7 +972,7 @@ static int __devinit mbxfb_probe(struct platform_device *dev)
>  	if (ret < 0) {
>  		dev_err(&dev->dev, "fb_alloc_cmap failed\n");
>  		ret = -EINVAL;
> -		goto err5;
> +		goto err3;
>  	}
>  
>  	platform_set_drvdata(dev, fbi);
> @@ -996,10 +997,6 @@ static int __devinit mbxfb_probe(struct platform_device *dev)
>  
>  err6:
>  	fb_dealloc_cmap(&fbi->cmap);
> -err5:
> -	iounmap(mfbi->fb_virt_addr);
> -err4:
> -	iounmap(mfbi->reg_virt_addr);
>  err3:
>  	release_mem_region(mfbi->reg_res->start, res_size(mfbi->reg_res));
>  err2:
> @@ -1026,10 +1023,7 @@ static int __devexit mbxfb_remove(struct platform_device *dev)
>  			if (mfbi->platform_remove)
>  				mfbi->platform_remove(fbi);
>  
> -			if (mfbi->fb_virt_addr)
> -				iounmap(mfbi->fb_virt_addr);
> -			if (mfbi->reg_virt_addr)
> -				iounmap(mfbi->reg_virt_addr);
> +
>  			if (mfbi->reg_req)
>  				release_mem_region(mfbi->reg_req->start,
>  						   res_size(mfbi->reg_req));
> 
> 

