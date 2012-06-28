From: Archit Taneja <archit@ti.com>
Date: Thu, 28 Jun 2012 14:42:29 +0000
Subject: [PATCH 00/12] OMAPDSS: Apply LCD manager related parameters
Message-Id: <1340893842-10626-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The LCD interface drivers(DPI, DSI, RFBI, SDI) do some direct DISPC register
writes to configure LCD manager related fields. This series groups these fields
into a single struct, and let's the interface driver apply these parameters.

This allows us to:

- Check the LCD manager related parameters before applying them.
- Remove some omap_dss_device references as APPLY holds the applied parameters.

Pushed onto the branch:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git apply_lcd_mgr_params

Tested on 3430SDP, 4430SDP ans Pandaboard ES.

Archit Taneja (12):
  OMAPDSS: DISPC: Change return type of dispc_mgr_set_clock_div()
  OMAPDSS: Add struct to hold LCD overlay manager configuration
  OMAPDSS: DPI: Configure dss_lcd_mgr_config struct with lcd manager
    parameters
  OMAPDSS: RFBI: Configure dss_lcd_mgr_config struct with lcd manager
    parameters
  OMAPDSS: DSI: Configure dss_lcd_mgr_config struct with lcd manager
    parameters
  OMAPDSS: SDI: Configure dss_lcd_mgr_config struct with lcd manager
    parameters
  OMAPDSS: APPLY: Remove DISPC writes to manager's lcd parameters in
    interface drivers
  OMAPDSS: MANAGER: Check LCD related overlay manager parameters
  OMAPDSS: APPLY: Remove usage of omap_dss_device from manual/auto
    update checks
  OMAPDSS: DISPC: Remove a redundant function
  OMAPDSS: RFBI: Use dss_mgr_enable to enable the overlay manager
  OMAPDSS: OVERLAY: Clean up replication checking

 drivers/video/omap2/dss/apply.c   |   82 ++++++++++++++++++++++++++--
 drivers/video/omap2/dss/dispc.c   |   31 ++++-------
 drivers/video/omap2/dss/display.c |   34 ------------
 drivers/video/omap2/dss/dpi.c     |   31 ++++++-----
 drivers/video/omap2/dss/dsi.c     |  108 ++++++++++++++++++++++---------------
 drivers/video/omap2/dss/dss.h     |   30 +++++++++--
 drivers/video/omap2/dss/manager.c |   35 ++++++++++++
 drivers/video/omap2/dss/overlay.c |   13 +++++
 drivers/video/omap2/dss/rfbi.c    |   39 ++++++++++----
 drivers/video/omap2/dss/sdi.c     |   32 +++++------
 10 files changed, 286 insertions(+), 149 deletions(-)

-- 
1.7.9.5

