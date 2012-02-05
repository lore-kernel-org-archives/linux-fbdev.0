From: Tabi Timur-B04825 <B04825@freescale.com>
Date: Sun, 05 Feb 2012 15:12:18 +0000
Subject: Re: fsl-diu: enable_lcdc() takes a pointer, not struct...
Message-Id: <4F2E9C50.3050500@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120205062835.GA23916@ZenIV.linux.org.uk>
In-Reply-To: <20120205062835.GA23916@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Tabi Timur-B04825 <B04825@freescale.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mikey@neuling.org" <mikey@neuling.org>, "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Al Viro wrote:
> A couple of places missed in commit ddd3d905436b572ebadc09dcf2d12ca5b37020a0...
>
> Signed-off-by: Al Viro<viro@zeniv.linux.org.uk>

This is already fixed in fbdev, although I can't find the patch in the 
archives (http://marc.info/?l=linux-fbdev&r=3&b 1201&w=2).

>
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index acf292b..629ae00 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -1432,7 +1432,7 @@ static int fsl_diu_suspend(struct platform_device *ofdev, pm_message_t state)
>   	struct fsl_diu_data *data;
>
>   	data = dev_get_drvdata(&ofdev->dev);
> -	disable_lcdc(data->fsl_diu_info[0]);
> +	disable_lcdc(&data->fsl_diu_info[0]);
>
>   	return 0;
>   }
> @@ -1442,7 +1442,7 @@ static int fsl_diu_resume(struct platform_device *ofdev)
>   	struct fsl_diu_data *data;
>
>   	data = dev_get_drvdata(&ofdev->dev);
> -	enable_lcdc(data->fsl_diu_info[0]);
> +	enable_lcdc(&data->fsl_diu_info[0]);
>
>   	return 0;
>   }
>


-- 
Timur Tabi
Linux kernel developer at Freescale
