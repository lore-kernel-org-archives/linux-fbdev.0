From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 12 Nov 2012 20:40:12 +0000
Subject: Re: [PATCH v8 2/6] video: add of helper for videomode
Message-Id: <50A15EAC.9030608@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352734626-27412-1-git-send-email-s.trumtrar@pengutronix.de> <1352734626-27412-3-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1352734626-27412-3-git-send-email-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: devicetree-discuss@lists.ozlabs.org, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robherring2@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thierry Reding <thierry.reding@avionic-design.de>, Guennady Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, kernel@pengutronix.de

On 11/12/2012 08:37 AM, Steffen Trumtrar wrote:
> This adds support for reading display timings from DT or/and convert one of those
> timings to a videomode.
> The of_display_timing implementation supports multiple children where each
> property can have up to 3 values. All children are read into an array, that
> can be queried.
> of_get_videomode converts exactly one of that timings to a struct videomode.

> diff --git a/Documentation/devicetree/bindings/video/display-timings.txt b/Documentation/devicetree/bindings/video/display-timings.txt

The device tree bindings look reasonable to me, so,

Acked-by: Stephen Warren <swarren@nvidia.com>
