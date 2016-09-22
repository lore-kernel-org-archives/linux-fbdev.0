From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 22 Sep 2016 10:35:23 +0000
Subject: [PATCH v2 0/3] video: of: Drive edge selection for sync
Message-Id: <20160922103526.24925-1-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.vetter-/w4YWyX8dFk@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

Changes since v1:
- separated the code changes from the omap/drm videomode conversion patches
- the DT bindings document is now explicitly states that the drive edge is
  referring to the pixel clock

Since we have several panels under omapdrm/displays/ where the data drive edge
is set to be different then the sync drive edge, the first three patch will add
support to select the sync drive edge via DT.
I was not able to locate the datasheet for all the panels and because the
different edge was used in omapdrm and omapfb for a long time without complains
from users - and they were written this way - I think it is a valid that we can
have panels requiring different edge for data and sync to be driven.

This series will add support for the sync drive edge setting and the omapdrm's
videmode conversion series depends on this change. It is also planned that the
omapdrm is going to move to use the drm/panel in the future and to be able to
convert the panel drivers we will need this feature.

Regards,
Peter
---
Peter Ujfalusi (3):
  dt-bindings: display: display-timing: Add property to configure sync
    drive edge
  video: display_timing: Add flags to select the edge when the sync is
    driven
  video: of: display_timing: Add support for syncclk-active property

 .../devicetree/bindings/display/panel/display-timing.txt         | 8 ++++++++
 drivers/video/of_display_timing.c                                | 9 +++++++++
 include/video/display_timing.h                                   | 4 ++++
 3 files changed, 21 insertions(+)

--
2.10.0

