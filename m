From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:42:07 +0000
Subject: Re: [PATCH 5/5] drivers/video/msm/mddi_client_nt35399.c: use devm_ functions
Message-Id: <5036959F.4010506@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344008414-2894-1-git-send-email-damien.cassou@lifl.fr> <1344008414-2894-5-git-send-email-damien.cassou@lifl.fr>
In-Reply-To: <1344008414-2894-5-git-send-email-damien.cassou@lifl.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Damien Cassou <damien.cassou@lifl.fr>
Cc: David Brown <davidb@codeaurora.org>, kernel-janitors@vger.kernel.org, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/03/2012 03:40 PM, Damien Cassou wrote:
> From: Damien Cassou <damien.cassou@lifl.fr>
> 
> The various devm_ functions allocate memory that is released when a driver
> detaches. This patch replaces the use of kzalloc by devm_kzalloc.
> 
> Additionally, this patch fixes a memory leak: some memory was allocated for
> 'panel' but not released when the subsequent call to setup_vsync fails.
> 
> Signed-off-by: Damien Cassou <damien.cassou@lifl.fr>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
>  drivers/video/msm/mddi_client_nt35399.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/msm/mddi_client_nt35399.c b/drivers/video/msm/mddi_client_nt35399.c
> index 7fcd67e..66b314e 100644
> --- a/drivers/video/msm/mddi_client_nt35399.c
> +++ b/drivers/video/msm/mddi_client_nt35399.c
> @@ -189,8 +189,9 @@ static int mddi_nt35399_probe(struct platform_device *pdev)
> 
>  	int ret;
> 
> -	struct panel_info *panel = kzalloc(sizeof(struct panel_info),
> -					   GFP_KERNEL);
> +	struct panel_info *panel = devm_kzalloc(&pdev->dev,
> +						sizeof(struct panel_info),
> +						GFP_KERNEL);
> 
>  	printk(KERN_DEBUG "%s: enter.\n", __func__);
> 
> @@ -233,7 +234,6 @@ static int mddi_nt35399_remove(struct platform_device *pdev)
>  	struct panel_info *panel = platform_get_drvdata(pdev);
> 
>  	setup_vsync(panel, 0);
> -	kfree(panel);
>  	return 0;
>  }
> 

