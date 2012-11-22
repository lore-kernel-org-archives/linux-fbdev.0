From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 22 Nov 2012 16:00:08 +0000
Subject: [PATCHv13 0/7] of: add display helper
Message-Id: <1353600015-6974-1-git-send-email-s.trumtrar@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi!

Changes since v12:
	- rename struct display_timing to via_display_timing in via subsystem
	- fix refreshrate calculation
	- fix "const struct *" warnings
		(reported by: "Manjunathappa, Prakash" <prakash.pm@ti.com>)
	- some CodingStyle fixes
	- rewrite parts of commit messages and display-timings.txt
	- let display_timing_get_value get all values instead of just typical

Regards,
Steffen

Steffen Trumtrar (7):
  viafb: rename display_timing to via_display_timing
  video: add display_timing and videomode
  video: add of helper for display timings/videomode
  fbmon: add videomode helpers
  fbmon: add of_videomode helpers
  drm_modes: add videomode helpers
  drm_modes: add of_videomode helpers

 .../devicetree/bindings/video/display-timings.txt  |  107 ++++++++++
 drivers/gpu/drm/drm_modes.c                        |   69 ++++++
 drivers/video/Kconfig                              |   21 ++
 drivers/video/Makefile                             |    4 +
 drivers/video/display_timing.c                     |   24 +++
 drivers/video/fbmon.c                              |   84 ++++++++
 drivers/video/of_display_timing.c                  |  223 ++++++++++++++++++++
 drivers/video/of_videomode.c                       |   48 +++++
 drivers/video/via/hw.c                             |    6 +-
 drivers/video/via/hw.h                             |    2 +-
 drivers/video/via/lcd.c                            |    2 +-
 drivers/video/via/share.h                          |    2 +-
 drivers/video/via/via_modesetting.c                |    8 +-
 drivers/video/via/via_modesetting.h                |    6 +-
 drivers/video/videomode.c                          |   45 ++++
 include/drm/drmP.h                                 |   12 ++
 include/linux/display_timing.h                     |  104 +++++++++
 include/linux/fb.h                                 |   12 ++
 include/linux/of_display_timings.h                 |   20 ++
 include/linux/of_videomode.h                       |   18 ++
 include/linux/videomode.h                          |   52 +++++
 21 files changed, 856 insertions(+), 13 deletions(-)
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

