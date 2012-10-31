From: Archit Taneja <archit@ti.com>
Date: Wed, 31 Oct 2012 06:54:34 +0000
Subject: Re: [PATCH 09/12] OMAPDSS: hide dss_select_dispc_clk_source()
Message-Id: <5090CB17.4070400@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-10-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351613409-21186-10-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

On Tuesday 30 October 2012 09:40 PM, Tomi Valkeinen wrote:
> dss.c currently exposes functions to configure the dispc source clock
> and lcd source clock. There are configured separately from the output
> drivers.
>
> However, there is no safe way for the output drivers to handle dispc
> clock, as it's shared between the outputs. Thus, if, say, the DSI driver
> sets up DSI PLL and configures both the dispc and lcd clock sources to
> that DSI PLL, the resulting dispc clock could be too low for, say, HDMI.
>
> Thus the output drivers should really only be concerned about the lcd
> clock, which is what the output drivers actually use. There's lot to do
> to clean up the dss clock handling, but this patch takes one step
> forward and removes the use of dss_select_dispc_clk_source() from the
> output drivers.
>
> After this patch, the output drivers only configure the lcd source
> clock. On omap4+ the dispc src clock is never changed from the default
> PRCM source. On omap3, where the dispc and lcd clocks are actually the
> same, setting the lcd clock source sets the dispc clock source.

Maybe we could have one call to dss_select_dispc_clk_source() in 
omap_dsshw_porbe(). This is not necessary now, but if we support a 
splash screen on bootloader, and skip the hwmod resets, we might want to 
switch back our dispc clock source to PRCM if the output drivers don't 
to it. This is just a point though, we don't necessarily need it right now.

Archit
