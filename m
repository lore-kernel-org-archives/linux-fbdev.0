From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 18 Apr 2013 10:24:44 +0000
Subject: Re: [RFC 06/10] video: ARM CLCD: Add DT & CDF support
Message-Id: <20130418102444.GL14496@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366211842-21497-1-git-send-email-pawel.moll@arm.com> <1366211842-21497-7-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1366211842-21497-7-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pawel Moll <pawel.moll@arm.com>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>

On Wed, Apr 17, 2013 at 04:17:18PM +0100, Pawel Moll wrote:
> +#if defined(CONFIG_OF)
> +static int clcdfb_of_get_tft_parallel_panel(struct clcd_panel *panel,
> +		struct display_entity_interface_params *params)
> +{
> +	int r = params->p.tft_parallel.r_bits;
> +	int g = params->p.tft_parallel.g_bits;
> +	int b = params->p.tft_parallel.b_bits;
> +
> +	/* Bypass pixel clock divider, data output on the falling edge */
> +	panel->tim2 = TIM2_BCD | TIM2_IPC;
> +
> +	/* TFT display, vert. comp. interrupt at the start of the back porch */
> +	panel->cntl |= CNTL_LCDTFT | CNTL_LCDVCOMP(1);
> +
> +	if (params->p.tft_parallel.r_b_swapped)
> +		panel->cntl |= CNTL_BGR;

NAK.  Do not set this explicitly.  Note the driver talks about this being
"the old way" - this should not be used with the panel capabilities - and
in fact it will be overwritten.

Instead, you need to encode this into the capabilities by masking the
below with CLCD_CAP_RGB or CLCD_CAP_BGR depending on the ordering.
