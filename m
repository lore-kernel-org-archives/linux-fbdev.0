From: archit taneja <archit@ti.com>
Date: Wed, 09 Mar 2011 13:50:23 +0000
Subject: Re: [PATCH 0/6] OMAP: DSS2: DSI: IRQ restructuring
Message-Id: <4D77868A.7020700@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1299655288-7121-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1299655288-7121-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Wednesday 09 March 2011 12:51 PM, Valkeinen, Tomi wrote:
> Hi,
>
> In the future we will have more features using the DSI interrupts, like ULPS
> handling, and making use-case specific hooks into the main IRQ handler would
> become burdensome.
>
> This patch set cleans up the DSI IRQ handling a bit by implementing a generic
> way to register/unregister interrupt service routines. This allows us to remove
> the use-case specific callbacks from the main IRQ handler.
>

Would this make it more easy/difficult to migrate to irq_chip(if needed) 
later on? I guess it will atleast bring dispc and dsi irq 
requesting/handling in a similar state, hence the changes needed to move 
to irq_chip would be the same for both.

Archit

>   Tomi
>
> Tomi Valkeinen (6):
>    OMAP: DSS2: DSI: Restructure IRQ handler
>    OMAP: DSS2: DSI: Add ISR support
>    OMAP: DSS2: DSI: use ISR in send_bta_sync
>    OMAP: DSS2: DSI: use ISR for BTA in framedone
>    OMAP: DSS2: DSI: catch DSI errors in send_bta_sync
>    OMAP: DSS2: DSI: fix IRQ debug prints
>
>   drivers/video/omap2/dss/dsi.c |  523 ++++++++++++++++++++++++++++++++---------
>   1 files changed, 408 insertions(+), 115 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

