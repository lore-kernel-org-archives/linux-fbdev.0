From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 12 Nov 2012 15:37:00 +0000
Subject: [PATCH v8 0/6] of: add display helper
Message-Id: <1352734626-27412-1-git-send-email-s.trumtrar@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss@lists.ozlabs.org
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, Rob Herring <robherring2@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thierry Reding <thierry.reding@avionic-design.de>, Guennady Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de

Hi!

This is v8 of the display helper series

Changes since v7:
	- move of_xxx to drivers/video
	- remove non-binding documentation from display-timings.txt
	- squash display_timings and videomode in one patch
	- misc minor fixes

Regards,
Steffen


Steffen Trumtrar (6):
  video: add display_timing and videomode
  video: add of helper for videomode
  fbmon: add videomode helpers
  fbmon: add of_videomode helpers
  drm_modes: add videomode helpers
  drm_modes: add of_videomode helpers

 .../devicetree/bindings/video/display-timings.txt  |  107 +++++++++++
 drivers/gpu/drm/drm_modes.c                        |   77 ++++++++
 drivers/video/Kconfig                              |   19 ++
 drivers/video/Makefile                             |    4 +
 drivers/video/display_timing.c                     |   22 +++
 drivers/video/fbmon.c                              |   77 ++++++++
 drivers/video/of_display_timing.c                  |  186 ++++++++++++++++++++
 drivers/video/of_videomode.c                       |   47 +++++
 drivers/video/videomode.c                          |   45 +++++
 include/drm/drmP.h                                 |    8 +
 include/linux/display_timing.h                     |   69 ++++++++
 include/linux/fb.h                                 |    5 +
 include/linux/of_display_timings.h                 |   19 ++
 include/linux/of_videomode.h                       |   15 ++
 include/linux/videomode.h                          |   39 ++++
 15 files changed, 739 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/display-timings.txt
 create mode 100644 drivers/video/display_timing.c
 create mode 100644 drivers/video/of_display_timing.c
 create mode 100644 drivers/video/of_videomode.c
 create mode 100644 drivers/video/videomode.c
 create mode 100644 include/linux/display_timing.h
 create mode 100644 include/linux/of_display_timings.h
 create mode 100644 include/linux/of_videomode.h
 create mode 100644 include/linux/videomode.h

-- 
1.7.10.4

