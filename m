From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 23 Jan 2015 10:50:36 +0000
Subject: Re: [PATCH v2 0/7] imx-drm: ipuv3-crtc: Implement mode_fixup
Message-Id: <1422010236.3017.12.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1418954426-21909-1-git-send-email-steve_longerbeam@mentor.com>
 <1420655248.3191.73.camel@pengutronix.de> <20150123025643.GA11412@victor>
In-Reply-To: <20150123025643.GA11412@victor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liu Ying <Ying.Liu@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Denis Carikli <denis@eukrea.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Steve Longerbeam <slongerbeam@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hi Liu,

Am Freitag, den 23.01.2015, 10:56 +0800 schrieb Liu Ying:
> Hi,
> 
> It looks that the below commit makes my Hannstar XGA LVDS panel stop working
> on the i.MX6DL SabreSD board.  Any idea?
> 
> commit eb10d6355532def3a74aaabd115e2373cca70b9d
> Author: Steve Longerbeam <slongerbeam@gmail.com>
> Date:   Thu Dec 18 18:00:24 2014 -0800
> 
> imx-drm: encoder prepare/mode_set must use adjusted mode
> 
> The encoder ->prepare() and ->mode_set() methods need to use the
> hw adjusted mode, not the original mode.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Regards,
> Liu Ying

What are this panel timings? The adjustment should increase the vertical
back porch by up to two lines (so it is at least two lines), reducing
the front porch or vsync length by the same amount. Does this panel use
the HSYNC/VSYNC signals embedded in the LVDS stream?

regards
Philipp

