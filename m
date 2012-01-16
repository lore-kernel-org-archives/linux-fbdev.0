From: Tabi Timur-B04825 <B04825@freescale.com>
Date: Mon, 16 Jan 2012 02:34:37 +0000
Subject: Re: [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
Message-Id: <4F138CBB.1080901@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <19504.1326673788@neuling.org> <4F1370C9.9010400@freescale.com>
 <21913.1326675139@neuling.org>
In-Reply-To: <21913.1326675139@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Neuling <mikey@neuling.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Michael Neuling wrote:
> In message<4F1370C9.9010400@freescale.com>  you wrote:
>> Michael Neuling wrote:
>>> Fix a bunch of compiler errors and warnings introduced in:
>>>     commit ddd3d905436b572ebadc09dcf2d12ca5b37020a0
>>>     Author: Timur Tabi<timur@freescale.com>
>>>     drivers/video: fsl-diu-fb: merge all allocated data into one block
>>>
>>> Signed-off-by: Michael Neuling<mikey@neuling.org>
>>> ---
>>> Timur: you do compile test your patches, right? :-P
>>
>> I have a script that tests each commit in a set to make sure it compiles,
>> so that git-bisect isn't broken.
>
> May I suggest you actually run the script next time :-P

Tomorrow, when I get into the office, I'll take a look.  But my code has 
always compiled.  Can you give me the output of your compiler?

> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index acf292b..3006b2b 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -1432,7 +1432,7 @@ static int fsl_diu_suspend(struct platform_device *ofdev, pm_message_t state)
>   	struct fsl_diu_data *data;
>
>   	data = dev_get_drvdata(&ofdev->dev);
> -	disable_lcdc(data->fsl_diu_info[0]);
> +	disable_lcdc(&(data->fsl_diu_info[0]));
>
>   	return 0;
>   }
> @@ -1442,7 +1442,7 @@ static int fsl_diu_resume(struct platform_device *ofdev)
>   	struct fsl_diu_data *data;
>
>   	data = dev_get_drvdata(&ofdev->dev);
> -	enable_lcdc(data->fsl_diu_info[0]);
> +	enable_lcdc(&(data->fsl_diu_info[0]));

I prefer this:

	disable_lcdc(data->fsl_diu_info);

Your change makes sense.  I don't understand why it compiles on my system. 
  Something strange is going on.

-- 
Timur Tabi
Linux kernel developer at Freescale
