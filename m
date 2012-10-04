From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 04 Oct 2012 17:59:18 +0000
Subject: [PATCH 0/2 v6] of: add display helper
Message-Id: <1349373560-11128-1-git-send-email-s.trumtrar@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss@lists.ozlabs.org
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, Rob Herring <robherring2@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi!

In accordance with Stepehn Warren, I downsized the binding.
Now, just the display-timing is described, as I think, it is way easier to agree
on those and have a complete binding.

Regards,
Steffen

Steffen Trumtrar (2):
  of: add helper to parse display timings
  of: add generic videomode description

 .../devicetree/bindings/video/display-timings.txt  |  222 ++++++++++++++++++++
 drivers/of/Kconfig                                 |   10 +
 drivers/of/Makefile                                |    2 +
 drivers/of/of_display_timings.c                    |  183 ++++++++++++++++
 drivers/of/of_videomode.c                          |  212 +++++++++++++++++++
 include/linux/of_display_timings.h                 |   85 ++++++++
 include/linux/of_videomode.h                       |   41 ++++
 7 files changed, 755 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/display-timings.txt
 create mode 100644 drivers/of/of_display_timings.c
 create mode 100644 drivers/of/of_videomode.c
 create mode 100644 include/linux/of_display_timings.h
 create mode 100644 include/linux/of_videomode.h

-- 
1.7.10.4

