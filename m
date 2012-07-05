From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 05 Jul 2012 14:08:07 +0000
Subject: Re: [PATCH v2] of: Add videomode helper
Message-Id: <3714247.L7zNpJpvuy@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, dri-devel@lists.freedesktop.org, Grant Likely <grant.likely@secretlab.ca>, kernel@pengutronix.de, Mitch Bradley <wmb@firmworks.com>, Anatolij Gustschin <agust@denx.de>

Hi Sascha,

Thanks for the patch.

On Wednesday 04 July 2012 09:56:35 Sascha Hauer wrote:
> This patch adds a helper function for parsing videomodes from the
> devicetree. The videomode can be either converted to a struct
> drm_display_mode or a struct fb_videomode.
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
>  drivers/of/of_videomode.c                          |  108 +++++++++++++++++
>  include/linux/of_videomode.h                       |   19 ++++
>  5 files changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/displaymode
>  create mode 100644 drivers/of/of_videomode.c
>  create mode 100644 include/linux/of_videomode.h
> 
> diff --git a/Documentation/devicetree/bindings/video/displaymode
> b/Documentation/devicetree/bindings/video/displaymode new file mode 100644
> index 0000000..43cc17d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/displaymode
> @@ -0,0 +1,40 @@
> +videomode bindings
> +=========
> +
> +Required properties:
> + - xres, yres: Display resolution
> + - left-margin, right-margin, hsync-len: Horizontal Display timing
> parameters +   in pixels
> +   upper-margin, lower-margin, vsync-len: Vertical display timing
> parameters in +   lines
> + - clock: displayclock in Hz
> +
> +Optional properties:
> + - width-mm, height-mm: Display dimensions in mm

I've always had mixed feelings about the physical display dimension being part 
of the display mode. Those are properties of the panel/display instead of the 
mode. Storing them as part of the mode can be convenient, but we then run into 
consistency issues (developers have to remember in which display mode 
instances the values are available, and in which instances they're set to 0 
for instance). If we want to clean this up, this patch would be a good 
occasion.

> + - hsync-active-high (bool): Hsync pulse is active high
> + - vsync-active-high (bool): Vsync pulse is active high
> + - interlaced (bool): This is an interlaced mode
> + - doublescan (bool): This is a doublescan mode
> +
> +There are different ways of describing a display mode. The devicetree
> representation +corresponds to the one used by the Linux Framebuffer
> framework described here in +Documentation/fb/framebuffer.txt. This
> representation has been chosen because it's +the only format which does not
> allow for inconsistent parameters.Unlike the Framebuffer +framework the
> devicetree has the clock in Hz instead of ps.
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
> +	};
> +

-- 
Regards,

Laurent Pinchart

