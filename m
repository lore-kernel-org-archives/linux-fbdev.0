From: Darren Etheridge <detheridge@ti.com>
Date: Tue, 25 Jun 2013 14:22:28 +0000
Subject: [PATCH 00/23] video/da8xx-fb fbdev driver enhance to support TI am335x SoC
Message-Id: <1372170171-9561-1-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is primarily a resend of a series of patches that were original
submitted to linux-fbdev back in January of 2013 for 3.8 by Afzal
Mohammed. I have rebased them on 3.10-rc6 and also made sure they
apply cleanly to the 'for-next' branch of linux-fbdev git.
The patches enable use of the current mainline da8xx-fb driver on the
TI AM335x SOC along with some bug fixes and cleanup.

The original patch series can be found here:
https://patchwork.kernel.org/project/linux-fbdev/list/?submitter9101
if you want to see the history.


Afzal Mohammed (21):
  video: da8xx-fb: fb_check_var enhancement
  video: da8xx-fb: simplify lcd_reset
  video: da8xx-fb: use modedb helper to update var
  video: da8xx-fb: remove unneeded "var" initialization
  video: da8xx-fb: store current display information
  video: da8xx-fb: store clk rate even if !CPUFREQ
  video: da8xx-fb: pix clk and clk div handling cleanup
  video: da8xx-fb: store struct device *
  video: da8xx-fb: report correct pixclock
  video: da8xx-fb: fb_set_par support
  video: da8xx-fb: make io operations safe
  video: da8xx-fb: enable sync lost intr for v2 ip
  video: da8xx-fb: use devres
  video: da8xx-fb: ensure non-null cfg in pdata
  video: da8xx-fb: reorganize panel detection
  video: da8xx-fb: minimal dt support
  video: da8xx-fb: invoke platform callback safely
  video: da8xx-fb: obtain fb_videomode info from dt
  video: da8xx-fb: ensure pdata only for non-dt
  video: da8xx-fb: setup struct lcd_ctrl_config for dt
  video: da8xx-fb: set upstream clock rate (if reqd)

Darren Etheridge (1):
  video/da8xx-fb adding am33xx as dependency

Manjunathappa, Prakash (1):
  video: da8xx-fb: fix 24bpp raster configuration

 .../devicetree/bindings/video/fb-da8xx.txt         |   37 ++
 drivers/video/Kconfig                              |    7 +-
 drivers/video/da8xx-fb.c                           |  363 +++++++++++++-------
 3 files changed, 279 insertions(+), 128 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/fb-da8xx.txt

