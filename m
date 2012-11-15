From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 15 Nov 2012 10:28:50 +0000
Subject: Re: [PATCH v10 0/6] of: add display helper
Message-Id: <20121115102850.GB1963@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352971437-29877-1-git-send-email-s.trumtrar@pengutronix.de>
 <20121115102411.GA17272@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20121115102411.GA17272@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, kernel@pengutronix.de, Guennady Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org

On Thu, Nov 15, 2012 at 11:24:11AM +0100, Thierry Reding wrote:
> On Thu, Nov 15, 2012 at 10:23:51AM +0100, Steffen Trumtrar wrote:
> > Hi!
> > 
> > Changes since v9:
> > 	- don't leak memory when previous timings were correct
> > 	- CodingStyle fixes
> > 	- move blank lines around
> > 
> > Regards,
> > Steffen
> > 
> > 
> > Steffen Trumtrar (6):
> >   video: add display_timing and videomode
> >   video: add of helper for videomode
> >   fbmon: add videomode helpers
> >   fbmon: add of_videomode helpers
> >   drm_modes: add videomode helpers
> >   drm_modes: add of_videomode helpers
> > 
> >  .../devicetree/bindings/video/display-timings.txt  |  107 ++++++++++
> >  drivers/gpu/drm/drm_modes.c                        |   70 +++++++
> >  drivers/video/Kconfig                              |   19 ++
> >  drivers/video/Makefile                             |    4 +
> >  drivers/video/display_timing.c                     |   24 +++
> >  drivers/video/fbmon.c                              |   86 ++++++++
> >  drivers/video/of_display_timing.c                  |  212 ++++++++++++++++++++
> >  drivers/video/of_videomode.c                       |   47 +++++
> >  drivers/video/videomode.c                          |   45 +++++
> >  include/drm/drmP.h                                 |   12 ++
> >  include/linux/display_timing.h                     |   69 +++++++
> >  include/linux/fb.h                                 |   12 ++
> >  include/linux/of_display_timings.h                 |   20 ++
> >  include/linux/of_videomode.h                       |   17 ++
> >  include/linux/videomode.h                          |   40 ++++
> >  15 files changed, 784 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/video/display-timings.txt
> >  create mode 100644 drivers/video/display_timing.c
> >  create mode 100644 drivers/video/of_display_timing.c
> >  create mode 100644 drivers/video/of_videomode.c
> >  create mode 100644 drivers/video/videomode.c
> >  create mode 100644 include/linux/display_timing.h
> >  create mode 100644 include/linux/of_display_timings.h
> >  create mode 100644 include/linux/of_videomode.h
> >  create mode 100644 include/linux/videomode.h
> 
> With the one change that I pointed out, the whole series:
> 

Already fixed.

> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
> Acked-by: Thierry Reding <thierry.reding@avionic-design.de>

\o/ Thanks


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
