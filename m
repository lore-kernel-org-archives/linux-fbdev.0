From: Archit Taneja <archit@ti.com>
Date: Tue, 18 Feb 2014 11:55:23 +0000
Subject: Re: [PATCH 1/9] Doc/DT: Add OMAP DSS DT Bindings
Message-Id: <53034A11.2050602@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392294752-18762-1-git-send-email-tomi.valkeinen@ti.com> <1392294752-18762-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1392294752-18762-2-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

On Thursday 13 February 2014 06:02 PM, Tomi Valkeinen wrote:
> Add device tree bindings for OMAP Display Subsystem for the following
> SoCs: OMAP2, OMAP3, OMAP4.


>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---

<snip>

> +A shortened example of the board description for OMAP4 Panda board, defined in
> +omap4-panda.dts.
> +
> +The Panda board has a DVI and a HDMI connector, and the board contains a TFP410
> +chip (MIPI DPI to DVI encoder) and a TPD12S015 chip (HDMI ESD protection & level
> +shifter). The video pipelines for the connectors are formed as follows:
> +
> +DSS Core --(MIPI DPI)--> TFP410 --(DVI)--> DVI Connector
> +OMAP HDMI --(HDMI)--> TPD12S015 --(HDMI)--> HDMI COnnector

Nitpick - 'CO' -> 'Co'

Archit

