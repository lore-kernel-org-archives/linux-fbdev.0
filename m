From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 02 Mar 2015 16:08:29 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added support for FBIOPAN_DISPLAY and virtual y resolution
Message-Id: <1425312509.3092.7.camel@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
	 <1424898082-1522-2-git-send-email-arun.ramamurthy@broadcom.com>
In-Reply-To: <1424898082-1522-2-git-send-email-arun.ramamurthy@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>

On Wed, 2015-02-25 at 21:01 +0000, Arun Ramamurthy wrote:
> Added code to support FBIOPAN_DISPLAY. Also added yres_virtual
> parameter to device tree to set the virtual y resolution
> 
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> ---
>  .../devicetree/bindings/video/arm,pl11x.txt        |  4 +++
>  drivers/video/fbdev/amba-clcd.c                    | 31 +++++++++++++++++++---
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/video/arm,pl11x.txt b/Documentation/devicetree/bindings/video/arm,pl11x.txt
> index 14d6f87..2262cdb 100644
> --- a/Documentation/devicetree/bindings/video/arm,pl11x.txt
> +++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
> @@ -50,6 +50,10 @@ Optional properties:
>  	display mode, data is driven onto the LCD data lines at the
>  	programmed edge of CLCP when CLAC is in its active state.
>  
> +- yres_virtual: Virtual Y resolution,
> +	It can be used to configure a virtual y resolution. It
> +	must be a value larger than the actual y resolution.
> +

I'm not sure about this... The word "virtual" never works well with
device tree nodes defined as "hardware description".

I understand what you're doing, but adding this property to the display
controller's node doesn't sound right. How does this describe hardware?
If anywhere, it's more like a job for the panel node?

Pawel

