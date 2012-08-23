From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:38:20 +0000
Subject: Re: [PATCH 1/5] drivers/video/fsl-diu-fb.c: use devm_ functions
Message-Id: <503694BC.8090707@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343752762-16861-1-git-send-email-damien.cassou@lifl.fr> <1343752762-16861-4-git-send-email-damien.cassou@lifl.fr>
In-Reply-To: <1343752762-16861-4-git-send-email-damien.cassou@lifl.fr>
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
>  drivers/video/fsl-diu-fb.c |   11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index 458c006..19194c5 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -1501,8 +1501,8 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
>  	unsigned int i;
>  	int ret;
> 
> -	data = dma_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
> -				  &dma_addr, GFP_DMA | __GFP_ZERO);
> +	data = dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
> +				   &dma_addr, GFP_DMA | __GFP_ZERO);
>  	if (!data)
>  		return -ENOMEM;
>  	data->dma_addr = dma_addr;
> @@ -1628,9 +1628,6 @@ error:
> 
>  	iounmap(data->diu_reg);
> 
> -	dma_free_coherent(&pdev->dev, sizeof(struct fsl_diu_data), data,
> -			  data->dma_addr);
> -
>  	return ret;
>  }
> 
> @@ -1648,9 +1645,6 @@ static int fsl_diu_remove(struct platform_device *pdev)
> 
>  	iounmap(data->diu_reg);
> 
> -	dma_free_coherent(&pdev->dev, sizeof(struct fsl_diu_data), data,
> -			  data->dma_addr);
> -
>  	return 0;
>  }
> 

