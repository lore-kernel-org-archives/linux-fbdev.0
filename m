From: Liu Ying <Ying.Liu@freescale.com>
Date: Fri, 23 Jan 2015 02:56:45 +0000
Subject: Re: [PATCH v2 0/7] imx-drm: ipuv3-crtc: Implement mode_fixup
Message-Id: <20150123025643.GA11412@victor>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1418954426-21909-1-git-send-email-steve_longerbeam@mentor.com>
 <1420655248.3191.73.camel@pengutronix.de>
In-Reply-To: <1420655248.3191.73.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Denis Carikli <denis@eukrea.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Steve Longerbeam <slongerbeam@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hi,

It looks that the below commit makes my Hannstar XGA LVDS panel stop working
on the i.MX6DL SabreSD board.  Any idea?

commit eb10d6355532def3a74aaabd115e2373cca70b9d
Author: Steve Longerbeam <slongerbeam@gmail.com>
Date:   Thu Dec 18 18:00:24 2014 -0800

imx-drm: encoder prepare/mode_set must use adjusted mode

The encoder ->prepare() and ->mode_set() methods need to use the
hw adjusted mode, not the original mode.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Regards,
Liu Ying

On Wed, Jan 07, 2015 at 07:27:28PM +0100, Philipp Zabel wrote:
> Am Donnerstag, den 18.12.2014, 18:00 -0800 schrieb Steve Longerbeam:
> > This patchset implements ->mode_fixup() in the imx ipuv3-crtc driver,
> > using a new support function ipu_di_adjust_videomode(). This new
> > function needs to be subsystem independent, so it accepts a video
> > mode as a 'struct videomode'. Hence ipu-crtc ->mode_fixup() needs
> > another support function to convert a drm_display_mode to a videomode
> > before passing the mode to ipu_di_adjust_videomode() for fixup.
> > 
> > Also some related code cleanup: 'struct ipu_di_signal_cfg' should
> > use 'struct videomode' for mode timings.
> 
> Alright, I have applied the series with
> s/videomode_from_drm_display_mode/drm_display_mode_to_videomode/
> 
> thanks
> Philipp
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
