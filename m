From: Archit Taneja <archit@ti.com>
Date: Fri, 10 Aug 2012 10:49:01 +0000
Subject: [PATCH 0/5] Pass data lines and pixel format info from panel driver to interface
Message-Id: <1344595026-10607-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This is a continuation of the work started in the series:

http://marc.info/?l=linux-omap&m4381744304672&w=2

This makes the panel driver call interface specific functions to configure the
data lines and pixel format requested by the panel.

Configuration of data lines doesn't happen for DSI or HDMI. For DSI, this
information is more complex and is taken care by omapdss_dsi_configure_pins(),
for HDMI, the number of TMDS lines is always fixed.

Configuration of pixel format is done only for DSI in command mode and RFBI.
Currently, these new functions take different arguments,
omapdss_dsi_set_pixel_format() takes pixel format of type
omap_dss_dsi_pixel_format enum, and RFBI omapdss_rfbi_set_pixel_size() takes
the pixel size directly. It would be good if these could be merged by using
some sort of MIPI standard for pixel formats. Having the same argument would
help in having a common interface op in the future.

Reference tree:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git pass_timings_and_others

Archit Taneja (5):
  OMAPDSS: DSI: Maintain copy of pixel format in driver data
  OMAPDSS: RFBI: Maintain copy of pixel size in driver data
  OMAPDSS: RFBI: Maintain copy of number of data lines in driver data
  OMAPDSS: DPI: Maitain copy of number of data lines in driver data
  OMAPDSS: SDI: Maintain copy of data pairs in driver data

 drivers/video/omap2/displays/panel-acx565akm.c     |    1 +
 drivers/video/omap2/displays/panel-generic-dpi.c   |    1 +
 .../omap2/displays/panel-lgphilips-lb035q02.c      |    1 +
 drivers/video/omap2/displays/panel-n8x0.c          |   13 ++++++--
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    1 +
 drivers/video/omap2/displays/panel-picodlp.c       |    1 +
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    1 +
 drivers/video/omap2/displays/panel-taal.c          |    1 +
 drivers/video/omap2/displays/panel-tfp410.c        |    1 +
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    1 +
 drivers/video/omap2/dss/dpi.c                      |   13 +++++++-
 drivers/video/omap2/dss/dsi.c                      |   34 ++++++++++++++------
 drivers/video/omap2/dss/dss.c                      |    2 +-
 drivers/video/omap2/dss/dss.h                      |    2 +-
 drivers/video/omap2/dss/rfbi.c                     |   28 ++++++++++++----
 drivers/video/omap2/dss/sdi.c                      |   10 +++++-
 include/video/omapdss.h                            |    9 +++++-
 17 files changed, 97 insertions(+), 23 deletions(-)

-- 
1.7.9.5

