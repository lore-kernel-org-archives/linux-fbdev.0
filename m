From: Darren Etheridge <detheridge@ti.com>
Date: Mon, 05 Aug 2013 22:02:19 +0000
Subject: [PATCH v3 00/20] video: da8xx-fb: driver enhance to support TI am335x SoC
Message-Id: <1375740159-1045-1-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Changes in v3:
	Address the patch authorship requirements
	Pull out the DT changes into a separate series
	Fix an issue where FB_MODE_HELPERS was not included in build
		but is a dependency.
	Include the devm_ changes and error reporting that Prabhakar Lad 
		had pushed a patch for,
	A few more cosmetic changes
	Add a patch to remove the use on inline from a number of functions


Changes in v2:
	Addressing review comments from Tomi Valkeinen:
	Dropped readl/writel patch as it is not necessary for non-cached, 
		non-buffered memory.
	Many cosmetic changes to make code easier to understand


This is primarily a resend of a series of patches that were original
submitted to linux-fbdev back in January of 2013 for 3.8 by Afzal
Mohammed. I have rebased them on 3.10 and also made sure they
apply cleanly to the 'for-next' branch of linux-fbdev git.
The patches enable use of the current mainline da8xx-fb driver on the
TI AM335x SOC along with some bug fixes and cleanup.

The original patch series can be found here:
https://patchwork.kernel.org/project/linux-fbdev/list/?submitter9101
if you want to see the history.


Afzal Mohammed (11):
  video: da8xx-fb: fb_check_var enhancement
  video: da8xx-fb: simplify lcd_reset
  video: da8xx-fb: use modedb helper to update var
  video: da8xx-fb: remove unneeded "var" initialization
  video: da8xx-fb: store current display information
  video: da8xx-fb: store clk rate even if !CPUFREQ
  video: da8xx-fb: store struct device *
  video: da8xx-fb: report correct pixclock
  video: da8xx-fb: enable sync lost intr for v2 ip
  video: da8xx-fb: ensure non-null cfg in pdata
  video: da8xx-fb: reorganize panel detection

Darren Etheridge (9):
  video: da8xx-fb: pix clk and clk div handling cleanup
  video: da8xx-fb: fb_set_par support
  video: da8xx-fb: improve readability of code
  video: da8xx-fb: fix 24bpp raster configuration
  video: da8xx-fb: use devres
  video: da8xx-fb: set upstream clock rate (if reqd)
  video: da8xx-fb: make clock naming consistent
  video: da8xx-fb: let compiler decide what to inline
  video: da8xx-fb: adding am33xx as dependency

 drivers/video/Kconfig    |    8 +-
 drivers/video/da8xx-fb.c |  352 +++++++++++++++++++++++++++-------------------
 include/video/da8xx-fb.h |    5 +
 3 files changed, 216 insertions(+), 149 deletions(-)

