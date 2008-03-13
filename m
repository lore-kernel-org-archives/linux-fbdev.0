From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH] atmel_lcdfb: suspend/resume support
Date: Thu, 13 Mar 2008 16:24:54 +0100
Message-ID: <20080313162454.3859ef1a@hskinnemo-gx620.norway.atmel.com>
References: <47D53CFC.8050907@atmel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756435AbYCMQrb@vger.kernel.org>
In-Reply-To: <47D53CFC.8050907@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel list <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@gmail.com>, ARM Linux Mailing List <linux-arm-kernel@lists.arm.linux.org.uk>, David Brownell <david-b@pacbell.net>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Sedji GAOUAOU <sedji.gaouaou@atmel.com>, Patrice VILCHEZ <patrice.vilchez@atmel.com>, Andrew Victor <linux@maxim.org.za>, Andrew Morton <akpm@linux-foundation.org>

On Mon, 10 Mar 2008 14:51:56 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> +static int atmel_lcdfb_suspend(struct platform_device *pdev, pm_message_t mesg)
> +{
> +	struct fb_info *info = platform_get_drvdata(pdev);
> +	struct atmel_lcdfb_info *sinfo = info->par;
> +
> +	sinfo->saved_lcdcon = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);

You're saving CONTRAST_VAL into a field called saved_lcdcon even though
it has nothing to do with LCDCON1 or LCDCON2...

> +	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, 0);

...then you're altering CONTRAST_CTR...

> +}
> +
> +static int atmel_lcdfb_resume(struct platform_device *pdev)
> +{

> +	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, sinfo->saved_lcdcon);

...and later restoring the saved value of CONTRAST_VAL into CONTRAST_CTR.

Confused.

> @@ -39,6 +39,7 @@ struct atmel_lcdfb_info {
>  	u8			bl_power;
>  #endif
>  	bool			lcdcon_is_backlight;
> +	u8			saved_lcdcon;

All of the registers involved are 32 bits wide, although the
interesting bits are all in the low byte. Do we really want to save
three bytes in the struct that badly?

Haavard
