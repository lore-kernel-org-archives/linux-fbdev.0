From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 11 Jul 2012 08:34:54 +0000
Subject: Re: [PATCH v2] of: Add videomode helper
Message-Id: <Pine.LNX.4.64.1207111031200.18999@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, dri-devel@lists.freedesktop.org, Grant Likely <grant.likely@secretlab.ca>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, kernel@pengutronix.de, Mitch Bradley <wmb@firmworks.com>, Anatolij Gustschin <agust@denx.de>

Hi Sascha

On Wed, 4 Jul 2012, Sascha Hauer wrote:

> This patch adds a helper function for parsing videomodes from the devicetree.
> The videomode can be either converted to a struct drm_display_mode or a
> struct fb_videomode.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> changes since v1:
> - use hyphens instead of underscores for property names
> 
>  .../devicetree/bindings/video/displaymode          |   40 ++++++++
>  drivers/of/Kconfig                                 |    5 +
>  drivers/of/Makefile                                |    1 +
>  drivers/of/of_videomode.c                          |  108 ++++++++++++++++++++
>  include/linux/of_videomode.h                       |   19 ++++
>  5 files changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/displaymode
>  create mode 100644 drivers/of/of_videomode.c
>  create mode 100644 include/linux/of_videomode.h
> 
> diff --git a/Documentation/devicetree/bindings/video/displaymode b/Documentation/devicetree/bindings/video/displaymode
> new file mode 100644
> index 0000000..43cc17d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/displaymode
> @@ -0,0 +1,40 @@
> +videomode bindings
> +=========
> +
> +Required properties:
> + - xres, yres: Display resolution
> + - left-margin, right-margin, hsync-len: Horizontal Display timing parameters
> +   in pixels
> +   upper-margin, lower-margin, vsync-len: Vertical display timing parameters in
> +   lines
> + - clock: displayclock in Hz
> +
> +Optional properties:
> + - width-mm, height-mm: Display dimensions in mm
> + - hsync-active-high (bool): Hsync pulse is active high
> + - vsync-active-high (bool): Vsync pulse is active high

How about

+ - hsync-active: Hsync pulse polarity: 1 for high, 0 for low

and similar for vsync-active? Which would then become

> + - interlaced (bool): This is an interlaced mode
> + - doublescan (bool): This is a doublescan mode
> +
> +There are different ways of describing a display mode. The devicetree representation
> +corresponds to the one used by the Linux Framebuffer framework described here in
> +Documentation/fb/framebuffer.txt. This representation has been chosen because it's
> +the only format which does not allow for inconsistent parameters.Unlike the Framebuffer
> +framework the devicetree has the clock in Hz instead of ps.
> +
> +Example:
> +
> +	display@0 {
> +		/* 1920x1080p24 */
> +		clock = <52000000>;
> +		xres = <1920>;
> +		yres = <1080>;
> +		left-margin = <25>;
> +		right-margin = <25>;
> +		hsync-len = <25>;
> +		lower-margin = <2>;
> +		upper-margin = <2>;
> +		vsync-len = <2>;
> +		hsync-active-high;

+		hsync-active = <1>;

> +	};
> +

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
