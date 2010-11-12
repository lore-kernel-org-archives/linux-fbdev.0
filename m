From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 12 Nov 2010 10:08:52 +0000
Subject: Re: [PATCH 3/4] s3c-fb: Add support S5PV310 FIMD
Message-Id: <20101112100851.GA18511@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1287406528-15324-1-git-send-email-sbkim73@samsung.com>
	<1287406528-15324-4-git-send-email-sbkim73@samsung.com>
	<053f01cb822a$2758a7f0$7609f7d0$%kim@samsung.com>
	<00a501cb824f$9942f300$cbc8d900$%dae@samsung.com>
In-Reply-To: <00a501cb824f$9942f300$cbc8d900$%dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Nov 12, 2010 at 06:54:29PM +0900, Inki Dae wrote:
> @@ -1314,13 +1319,22 @@ static int __devinit s3c_fb_probe(struct
> platform_device *pdev)
>  	sfb->pdata = pd;
>  	sfb->variant = fbdrv->variant;
>  
> -	sfb->bus_clk = clk_get(dev, "lcd");
> -	if (IS_ERR(sfb->bus_clk)) {
> -		dev_err(dev, "failed to get bus clock\n");
> +	/* if sclk_name is NULL then it would use bus clock as default. */
> +	if (!pd->sclk_name)
> +		sfb->lcd_clk = clk_get(dev, "lcd");
> +	else
> +		sfb->lcd_clk = clk_get(dev, pd->sclk_name);
> +
No, this is totally pointless. Simply establish a clk lookup for the
configuration you are running on in your board code and always have
clk_get() operate on a fixed id. You can use this same scheme with any
optional clocks you have too, and reconfigure according to whether the
lookups for optional clocks succeeded or not.
