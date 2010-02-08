From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Mon, 08 Feb 2010 15:57:24 +0000
Subject: [PATCH 00/17] OMAP DSS2 model restructuring
Message-Id: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Here are a bunch of patches that change the DSS2 driver's driver model a bit.
This change was triggered by trying to support new hardware, and realizing that
the current model just won't work.

Currently the omapdss driver is in control of most aspects of the DSS, and
omapdss calls necessary functions in display drivers. I made it that way to
keep the display drivers simple, and I, naively, thought that it will work
because the display panels are using standard bus interfaces and thus will be
very similar. I was so wrong =).

This patch set moves the control to the display driver. The display driver then
calls omapdss functions to perform whatever deed is needed at that time. This
will make display drivers slightly more complex, but it will be easier to
control the hardware properly with strange or complex display devices.

As a simple example, let's look at the update function.

Currently user space app issues OMAPFB_UPDATE_WINDOW ioctl, and omapfb driver
then calls update() in corresponding dss device struct, which goes to omapdss.
omapdss will configure the update, calling the panel driver if needed.

After these patches, omapfb will call update() in the panel driver. The panel
driver will then call functions in omapdss to setup the update, start the
update, and the panel driver will eventually get a callback informing that the
update is done.

These patches are still under work, but my basic tests on 3430SDP board seems
to work ok.

The patches can also be found from
http://gitorious.org/linux-omap-dss2/linux work branch

Tomi Valkeinen (17):
  OMAP: DSS2: DSI: change DSI bus_lock to semaphore
  OMAP: DSS2: DSI: remove auto-update perf measurement
  OMAP: DSS2: move run_test()
  OMAP: DSS2: move memory_read()
  OMAP: DSS2: move set/get_mirror()
  OMAP: DSS2: move get/set_rotate()
  OMAP: DSS2: move wait_vsync()
  OMAP: DSS2: move enable/disable_channel to overlay manager
  OMAP: DSS2: move get_resolution()
  OMAP: DSS2: move get_recommended_bpp()
  OMAP: DSS2: move enable/get_te()
  OMAP: DSS2: move set/get_update_mode()
  OMAP: DSS2: move update() and sync()
  OMAP: DSS2: move enable/disable/suspend/resume
  OMAP: DSS2: move set/get_wss()
  OMAP: DSS2: move timing functions
  OMAP: DSS2: DSI: Add VC support for update

 arch/arm/plat-omap/include/plat/display.h          |  108 ++--
 drivers/video/omap2/displays/panel-generic.c       |   56 ++-
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |   67 ++-
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   42 +-
 drivers/video/omap2/displays/panel-taal.c          |  221 +++++--
 .../video/omap2/displays/panel-toppoly-tdo35s.c    |   56 ++-
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   61 ++-
 drivers/video/omap2/dss/core.c                     |    7 +
 drivers/video/omap2/dss/dispc.c                    |   36 +-
 drivers/video/omap2/dss/display.c                  |   87 +--
 drivers/video/omap2/dss/dpi.c                      |  149 +----
 drivers/video/omap2/dss/dsi.c                      |  829 ++++----------------
 drivers/video/omap2/dss/dss.h                      |    4 +-
 drivers/video/omap2/dss/manager.c                  |   48 +-
 drivers/video/omap2/dss/overlay.c                  |    2 +-
 drivers/video/omap2/dss/rfbi.c                     |  321 +-------
 drivers/video/omap2/dss/sdi.c                      |  115 +---
 drivers/video/omap2/dss/venc.c                     |  294 +++----
 drivers/video/omap2/omapfb/omapfb-ioctl.c          |   44 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |   89 ++-
 drivers/video/omap2/omapfb/omapfb.h                |    6 +
 21 files changed, 1004 insertions(+), 1638 deletions(-)

