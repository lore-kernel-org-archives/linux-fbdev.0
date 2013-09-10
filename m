From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 10 Sep 2013 19:43:24 +0000
Subject: Re: [PATCH v2 1/2] video: ARM CLCD: Add DT support
Message-Id: <20130910194324.GE12758@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378808726-32535-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1378808726-32535-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Sep 10, 2013 at 11:25:25AM +0100, Pawel Moll wrote:
> +#ifdef CONFIG_OF
> +static int clcdfb_of_get_tft_panel(struct device_node *node,
> +		struct clcd_panel *panel)
> +{
> +	int err;
> +	u32 rgb[3];
> +
> +	err = of_property_read_u32_array(node, "panel-tft-interface", rgb, 3);
> +	if (err)
> +		return err;
> +
> +	/* Bypass pixel clock divider, data output on the falling edge */
> +	panel->tim2 = TIM2_BCD | TIM2_IPC;
> +
> +	/* TFT display, vert. comp. interrupt at the start of the back porch */
> +	panel->cntl |= CNTL_LCDTFT | CNTL_LCDVCOMP(1);
> +
> +	if (rgb[0] >= 4 && rgb[1] >= 4 && rgb[2] >= 4)
> +		panel->caps |= CLCD_CAP_444;
> +	if (rgb[0] >= 5 && rgb[1] >= 5 && rgb[2] >= 5)
> +		panel->caps |= CLCD_CAP_5551;
> +	if (rgb[0] >= 5 && rgb[1] >= 6 && rgb[2] >= 5)
> +		panel->caps |= CLCD_CAP_565;
> +	if (rgb[0] >= 8 && rgb[1] >= 8 && rgb[2] >= 8)
> +		panel->caps |= CLCD_CAP_888;

This definitely isn't right.  Why does a panel which has 8 bits of RGB
get to indicate that it supports everything below it?

This is not how this hardware works.  Look at table A-7 in the TRM.
If you wire the CLCD controller directly to a panel which is 8-bit RGB
only, it can't support any of the other formats.

The CLCD controller itself can only support on the hardware 8-bits of
RGB or 5 bits of RGB plus an intensity bit, so that's two formats.

However, things are complicated by ARMs addition of an external mux
on the CLCD output, which gives us the other format possibilities
by munging the signals to give appropriate formats in the framebuffer
memory.  In other words, in RGB444 mode, the mux ends up taking
red from CLD[4:1], green from CLD[9:7,5], blue from CLD[14:13,11:10].

So, it's not true that if you have a RGB888 panel, you can support
all the lower BPPs.

This is one of the dangers of directly converting what's in the kernel
to DT properties without getting the hardware documentation and fully
understanding that first - remember, DT properties are supposed to be
based on the hardware, not the Linux implementation.
