From: Tomi Valkeinen <tomba@iki.fi>
Date: Mon, 18 Feb 2013 14:09:25 +0000
Subject: Re: [PATCH v17 2/7] video: add display_timing and videomode
Message-Id: <51223615.4090709@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359104515-8907-1-git-send-email-s.trumtrar@pengutronix.de> <1359104515-8907-3-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1359104515-8907-3-git-send-email-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: devicetree-discuss@lists.ozlabs.org, Dave Airlie <airlied@linux.ie>, Rob Herring <robherring2@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thierry Reding <thierry.reding@avionic-design.de>, Guennady Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Rob Clark <robdclark@gmail.com>, Leela Krishna Amudala <leelakrishna.a@gmail.com>, "Mohammed, Afzal" <afzal@ti.com>, kernel@pengutronix.de

Hi Steffen,

On 2013-01-25 11:01, Steffen Trumtrar wrote:

> +/* VESA display monitor timing parameters */
> +#define VESA_DMT_HSYNC_LOW		BIT(0)
> +#define VESA_DMT_HSYNC_HIGH		BIT(1)
> +#define VESA_DMT_VSYNC_LOW		BIT(2)
> +#define VESA_DMT_VSYNC_HIGH		BIT(3)
> +
> +/* display specific flags */
> +#define DISPLAY_FLAGS_DE_LOW		BIT(0)	/* data enable flag */
> +#define DISPLAY_FLAGS_DE_HIGH		BIT(1)
> +#define DISPLAY_FLAGS_PIXDATA_POSEDGE	BIT(2)	/* drive data on pos. edge */
> +#define DISPLAY_FLAGS_PIXDATA_NEGEDGE	BIT(3)	/* drive data on neg. edge */
> +#define DISPLAY_FLAGS_INTERLACED	BIT(4)
> +#define DISPLAY_FLAGS_DOUBLESCAN	BIT(5)

<snip>

> +	unsigned int dmt_flags;	/* VESA DMT flags */
> +	unsigned int data_flags; /* video data flags */

Why did you go for this approach? To be able to represent
true/false/not-specified?

Would it be simpler to just have "flags" field? What does it give us to
have those two separately?

Should the above say raising edge/falling edge instead of positive
edge/negative edge?

 Tomi

