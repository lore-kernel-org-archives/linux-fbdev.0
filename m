From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 30 Jan 2012 05:14:51 +0000
Subject: Re: [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
Message-Id: <4F26274B.2040401@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <19504.1326673788@neuling.org> <4F1370C9.9010400@freescale.com>
 <21913.1326675139@neuling.org> <4F138CBB.1080901@freescale.com>
 <21370.1326683320@neuling.org>
In-Reply-To: <21370.1326683320@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Neuling <mikey@neuling.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Tabi Timur-B04825 <B04825@freescale.com>

On 01/16/2012 03:08 AM, Michael Neuling wrote:
[...]
> From: Michael Neuling <mikey@neuling.org>
> 
> [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
> 
> Fix a compiler errors introduced in:
>   commit ddd3d905436b572ebadc09dcf2d12ca5b37020a0
>   Author: Timur Tabi <timur@freescale.com>
>   drivers/video: fsl-diu-fb: merge all allocated data into one block
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index acf292b..6af3f16 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -1432,7 +1432,7 @@ static int fsl_diu_suspend(struct platform_device *ofdev, pm_message_t state)
>  	struct fsl_diu_data *data;
>  
>  	data = dev_get_drvdata(&ofdev->dev);
> -	disable_lcdc(data->fsl_diu_info[0]);
> +	disable_lcdc(data->fsl_diu_info);
>  
>  	return 0;
>  }
> @@ -1442,7 +1442,7 @@ static int fsl_diu_resume(struct platform_device *ofdev)
>  	struct fsl_diu_data *data;
>  
>  	data = dev_get_drvdata(&ofdev->dev);
> -	enable_lcdc(data->fsl_diu_info[0]);
> +	enable_lcdc(data->fsl_diu_info);
>  
>  	return 0;
>  }
> 

