From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Fri, 19 Dec 2014 19:10:31 +0000
Subject: Re: [PATCH v2 3/7] drm_modes: add videomode_from_drm_display_mode
Message-Id: <54947827.5050104@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1418954426-21909-1-git-send-email-steve_longerbeam@mentor.com>	 <1418954426-21909-4-git-send-email-steve_longerbeam@mentor.com> <1418986984.3165.64.camel@pengutronix.de>
In-Reply-To: <1418986984.3165.64.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Denis Carikli <denis@eukrea.com>, Jiada Wang <jiada_wang@mentor.com>, Steve Longerbeam <steve_longerbeam@mentor.com>

On 12/19/2014 03:03 AM, Philipp Zabel wrote:
>
> +EXPORT_SYMBOL_GPL(videomode_from_drm_display_mode);
> Is it ok for drm_modes to export a function that doesn't start with
> drm_ ? We could just rename this to drm_display_mode_to_videomode if
> necessary. I can fix it up as I apply it, but I'd like to know which is
> preferred.

Yeah, drm_display_mode_to_videomode() is probably better,
makes it more clear it's part of the DRM kernel interfaces.

Steve

