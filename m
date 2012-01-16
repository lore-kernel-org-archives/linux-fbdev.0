From: Tabi Timur-B04825 <B04825@freescale.com>
Date: Mon, 16 Jan 2012 00:35:22 +0000
Subject: Re: [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
Message-Id: <4F1370C9.9010400@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <19504.1326673788@neuling.org>
In-Reply-To: <19504.1326673788@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Neuling <mikey@neuling.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Michael Neuling wrote:
> Fix a bunch of compiler errors and warnings introduced in:
>    commit ddd3d905436b572ebadc09dcf2d12ca5b37020a0
>    Author: Timur Tabi<timur@freescale.com>
>    drivers/video: fsl-diu-fb: merge all allocated data into one block
>
> Signed-off-by: Michael Neuling<mikey@neuling.org>
> ---
> Timur: you do compile test your patches, right? :-P

I have a script that tests each commit in a set to make sure it compiles, 
so that git-bisect isn't broken.

> This is effecting mpc85xx_defconfig on mainline (and has been in
> linux-next for while already).
>
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index acf292b..78cac52 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -366,7 +366,7 @@ struct mfb_info {
>    */
>   struct fsl_diu_data {
>   	dma_addr_t dma_addr;
> -	struct fb_info fsl_diu_info[NUM_AOIS];
> +	struct fb_info *fsl_diu_info[NUM_AOIS];

This doesn't make any sense.  If you change fsl_diu_info into a pointer, 
then where is the object being allocated?

-- 
Timur Tabi
Linux kernel developer at Freescale
