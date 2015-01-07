From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 07 Jan 2015 18:27:28 +0000
Subject: Re: [PATCH v2 0/7] imx-drm: ipuv3-crtc: Implement mode_fixup
Message-Id: <1420655248.3191.73.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1418954426-21909-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1418954426-21909-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Denis Carikli <denis@eukrea.com>, Jiada Wang <jiada_wang@mentor.com>, Steve Longerbeam <steve_longerbeam@mentor.com>

Am Donnerstag, den 18.12.2014, 18:00 -0800 schrieb Steve Longerbeam:
> This patchset implements ->mode_fixup() in the imx ipuv3-crtc driver,
> using a new support function ipu_di_adjust_videomode(). This new
> function needs to be subsystem independent, so it accepts a video
> mode as a 'struct videomode'. Hence ipu-crtc ->mode_fixup() needs
> another support function to convert a drm_display_mode to a videomode
> before passing the mode to ipu_di_adjust_videomode() for fixup.
> 
> Also some related code cleanup: 'struct ipu_di_signal_cfg' should
> use 'struct videomode' for mode timings.

Alright, I have applied the series with
s/videomode_from_drm_display_mode/drm_display_mode_to_videomode/

thanks
Philipp

