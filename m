From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 23 Apr 2012 06:19:44 +0000
Subject: Re: [PATCH] drivers/video/mbx/mbxfb.c: correct ioremap_nocache test
Message-Id: <4F94F480.2080500@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334779631-4361-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1334779631-4361-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/18/2012 08:07 PM, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> The test tested not the most recently allocated value but a previously
> allocated one.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
>  drivers/video/mbx/mbxfb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
> index 55bf619..ab0a8e5 100644
> --- a/drivers/video/mbx/mbxfb.c
> +++ b/drivers/video/mbx/mbxfb.c
> @@ -950,7 +950,7 @@ static int __devinit mbxfb_probe(struct platform_device *dev)
>  
>  	mfbi->fb_virt_addr = ioremap_nocache(mfbi->fb_phys_addr,
>  					     res_size(mfbi->fb_req));
> -	if (!mfbi->reg_virt_addr) {
> +	if (!mfbi->fb_virt_addr) {
>  		dev_err(&dev->dev, "failed to ioremap frame buffer\n");
>  		ret = -EINVAL;
>  		goto err4;
> 
> 

