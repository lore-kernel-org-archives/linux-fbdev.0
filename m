From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 25 Nov 2015 17:22:21 +0000
Subject: Re: [RFC PATCH 1/2] drm: add support for for clk and de polarity
Message-Id: <1448472141.3390.17.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <55A67FDB.8010602@gmx.at> <55A6813A.8090706@gmx.at>
In-Reply-To: <55A6813A.8090706@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Cc: linux-fbdev@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Steve Longerbeam <slongerbeam@gmail.com>, Deepak Das <deepak_das@mentor.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Am Mittwoch, den 15.07.2015, 17:50 +0200 schrieb Manfred Schlaegl:
> To get full support for parallel and LVDS displays with drm:
> Add representation for clock and data enable polarity in drm_display_mode
> flags (similar to HSYNC/VSYNC polarity) and update conversion functions
> from/to videomode accordingly.
> 
> This is especially important for embedded devices where parallel(RGB) and
> LVDS displays are still widely used and drm already plays an important
> role.
> 
> Tested on Freescale i.MX53(parallel) and i.MX6(LVDS).
> 
> Background:
> There was the ability to set polarity of clock and data enable signals
> in devicetree(display-timing), struct display_timing and struct videomode,
> but there was no representation for this in struct drm_display_mode.
> Example on Freescale i.MX53/i.MX6 SoC's:
>  * A parallel display using different clock polarity is set up using
>    display-timing in devicetree
>  * ipuv3 parallel outputs clock with wrong polarity
> 
> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>

Any comments on whether data enable and pixel clock polarity flags can
be added to the visible DRM_MODE_FLAGs, and if not, where else this
information should be kept? struct drm_display_info?

This patch and the following IPUv3 patch are useful and necessary for
quite some panels connected to i.MX SoCs, but adding DRM_MODE_FLAGs is
somewhat out of my jurisdiction.

best regards
Philipp

