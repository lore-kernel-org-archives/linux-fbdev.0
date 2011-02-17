From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 17 Feb 2011 11:03:21 +0000
Subject: Re: [PATCH 1/2] ARM: PXA: PXAFB: Fix double-free issue.
Message-Id: <20110217110321.GF24627@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201102151718.00800.anarsoul@gmail.com>
	<1297928588-10545-1-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1297928588-10545-1-git-send-email-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 17, 2011 at 09:43:07AM +0200, Vasily Khoruzhick wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> 
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>

No need for two From: lines.

> @@ -636,7 +639,8 @@ static void overlay1fb_disable(struct pxafb_layer *ofb)
>  	lcd_writel(ofb->fbi, FBR1, ofb->fbi->fdadr[DMA_OV1] | 0x3);
>  
>  	if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) = 0)
> -		pr_warning("%s: timeout disabling overlay1\n", __func__);
> +		pr_warning("%s: timeout disabling overlay1\n",
> +			__func__);

No need for this change.

> @@ -687,6 +691,9 @@ static void overlay2fb_disable(struct pxafb_layer *ofb)
>  {
>  	uint32_t lccr5 = lcd_readl(ofb->fbi, LCCR5);
>  
> +	if (!(lcd_readl(ofb->fbi, OVL2C1) & OVLxC1_OEN))
> +		return;
> +

You don't describe this change in the change log, and this wasn't in my
patch.

> @@ -696,7 +703,8 @@ static void overlay2fb_disable(struct pxafb_layer *ofb)
>  	lcd_writel(ofb->fbi, FBR4, ofb->fbi->fdadr[DMA_OV2_Cr] | 0x3);
>  
>  	if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) = 0)
> -		pr_warning("%s: timeout disabling overlay2\n", __func__);
> +		pr_warning("%s: timeout disabling overlay2\n",
> +			__func__);

No need for this change.

