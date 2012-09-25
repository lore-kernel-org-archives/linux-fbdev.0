From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 25 Sep 2012 11:23:39 +0000
Subject: Re: [PATCH v4] of: Add videomode helper
Message-Id: <1378654.FmcPtcTNE1@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348042843-24673-1-git-send-email-s.trumtrar@pengutronix.de>
	<50606334.7030902@gmail.com>
In-Reply-To: <50606334.7030902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2@gmail.com>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, dri-devel@lists.freedesktop.org, kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>

Hi Rob,

On Monday 24 September 2012 08:42:12 Rob Herring wrote:
> On 09/19/2012 03:20 AM, Steffen Trumtrar wrote:
> > This patch adds a helper function for parsing videomodes from the
> > devicetree. The videomode can be either converted to a struct
> > drm_display_mode or a struct fb_videomode.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> > 
> > Hi!
> > 
> > changes since v3:
> > 	- print error messages
> > 	- free alloced memory
> > 	- general cleanup
> > 
> > Regards
> > Steffen
> > 
> >  .../devicetree/bindings/video/displaymode          |   74 +++++
> >  drivers/of/Kconfig                                 |    5 +
> >  drivers/of/Makefile                                |    1 +
> >  drivers/of/of_videomode.c                          |  283
> >  ++++++++++++++++++++ include/linux/of_videomode.h                      
> >  |   56 ++++
> >  5 files changed, 419 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/video/displaymode
> >  create mode 100644 drivers/of/of_videomode.c
> >  create mode 100644 include/linux/of_videomode.h
> > 
> > diff --git a/Documentation/devicetree/bindings/video/displaymode
> > b/Documentation/devicetree/bindings/video/displaymode new file mode
> > 100644
> > index 0000000..990ca52
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/displaymode
> > @@ -0,0 +1,74 @@
> > +videomode bindings
> > +=========
> > +
> > +Required properties:
> > + - hactive, vactive: Display resolution
> > + - hfront-porch, hback-porch, hsync-len: Horizontal Display timing
> > parameters +   in pixels
> > +   vfront-porch, vback-porch, vsync-len: Vertical display timing
> > parameters in +   lines
> > + - clock: displayclock in Hz
> 
> A major piece missing is the LCD controller to display interface width
> and component ordering.
> 
> > +
> > +Optional properties:
> > + - width-mm, height-mm: Display dimensions in mm
> > + - hsync-active-high (bool): Hsync pulse is active high
> > + - vsync-active-high (bool): Vsync pulse is active high
> > + - interlaced (bool): This is an interlaced mode
> > + - doublescan (bool): This is a doublescan mode
> > +
> > +There are different ways of describing a display mode. The devicetree
> > representation
> > +corresponds to the one commonly found in datasheets for displays.
> > +The description of the display and its mode is split in two parts: first
> > the display
> > +properties like size in mm and (optionally) multiple subnodes with the
> > supported modes.
> > +
> > +Example:
> > +
> > +	display@0 {
> 
> It would be useful to have a compatible string here. We may not always
> know the panel type or have a fixed panel though. We could define
> "generic-lcd" or something for cases where the panel type is unknown.

I'm working on a generic panel framework (see 
http://lwn.net/Articles/512363/). DT bindings are not there yet, but they're 
certainly a hot topic. A compatible string here will definitely be needed 
here.

The exact properties required in the display node will likely be panel-
dependent. width-mm, height-mm and modes sound like a good baseline to me.

> > +		width-mm = <800>;
> > +		height-mm = <480>;
> > +		modes {
> > +			mode0: mode@0 {
> > +				/* 1920x1080p24 */
> > +				clock = <52000000>;
> > +				hactive = <1920>;
> > +				vactive = <1080>;
> > +				hfront-porch = <25>;
> > +				hback-porch = <25>;
> > +				hsync-len = <25>;
> > +				vback-porch = <2>;
> > +				vfront-porch = <2>;
> > +				vsync-len = <2>;
> > +				hsync-active-high;
> > +			};
> > +		};
> > +	};
> > +
> > +Every property also supports the use of ranges, so the commonly used
> > datasheet +description with <min typ max>-tuples can be used.
> > +
> > +Example:
> > +
> > +	mode1: mode@1 {
> > +		/* 1920x1080p24 */
> > +		clock = <148500000>;
> > +		hactive = <1920>;
> > +		vactive = <1080>;
> > +		hsync-len = <0 44 60>;
> > +		hfront-porch = <80 88 95>;
> > +		hback-porch = <100 148 160>;
> > +		vfront-porch = <0 4 6>;
> > +		vback-porch = <0 36 50>;
> > +		vsync-len = <0 5 6>;
> > +	};
> > +
> > +The videomode can be linked to a connector via phandles. The connector
> > has to
> > +support the display- and default-mode-property to link to and select a
> > mode.
>
> Could also be phandle in the lcd controller node? What are the '-' for?
> Is "display-blah" a valid name or something?
> 
> "default-mode" is pretty generic. How about display-mode or
> display-default-mode?
> 
> Rob
> 
> > +
> > +Example:
> > +
> > +	hdmi@00120000 {
> > +		status = "okay";
> > +		display = <&benq>;
> > +		default-mode = <&mode1>;
> > +	};
> > +

-- 
Regards,

Laurent Pinchart

