From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 20 Jun 2011 13:06:41 +0000
Subject: Re: [PATCH 2/2] video: omap2: Compile omap2 support only when
Message-Id: <1308575201.2076.57.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308566761-2850-1-git-send-email-tushar.behera@linaro.org>
	<1308566761-2850-3-git-send-email-tushar.behera@linaro.org>
In-Reply-To: <1308566761-2850-3-git-send-email-tushar.behera@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 2011-06-20 at 16:16 +0530, Tushar Behera wrote:
> Currently display support for omap2 is selected by default and
> it gets built for all the configurations.
> 
> Instead of it being a built-in feature, it's compilation should
> depend on the config option CONFIG_FB_OMAP2.

No, I don't think so. omap2 directory contains vram, vrfb and omapdss,
all of which can be used without omapfb driver. vram and vrfb can be
even used without omapdss driver.

Is this patch fixing some real problem?

 Tomi


