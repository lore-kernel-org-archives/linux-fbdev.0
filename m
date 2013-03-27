From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 27 Mar 2013 06:58:20 +0000
Subject: [PATCHv2 0/5] videomode patches
Message-Id: <1364367505-4366-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi,

Here's a v2 of the videomode series. The changes compared to v1:

* Dropped "videomode: rename fields", as it received only negative comments
* New patch: "videomode: videomode_from_timing work"

Patches 1-4 are unchanged.

 Tomi

Tomi Valkeinen (5):
  videomode: simplify videomode Kconfig and Makefile
  videomode: combine videomode dmt_flags and data_flags
  videomode: create enum for videomode's display flags
  videomode: remove timing_entry_index
  videomode: videomode_from_timing work

 drivers/gpu/drm/drm_modes.c           |   20 ++++++------
 drivers/gpu/drm/tilcdc/Kconfig        |    3 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel.c |    2 +-
 drivers/video/Kconfig                 |   22 ++-----------
 drivers/video/Makefile                |    8 ++---
 drivers/video/fbmon.c                 |   16 ++++-----
 drivers/video/of_display_timing.c     |   19 ++++++-----
 drivers/video/of_videomode.c          |    2 +-
 drivers/video/videomode.c             |   36 ++++++++++++---------
 include/video/display_timing.h        |   57 ++++++++++-----------------------
 include/video/videomode.h             |   18 ++++++++---
 11 files changed, 88 insertions(+), 115 deletions(-)

-- 
1.7.10.4

