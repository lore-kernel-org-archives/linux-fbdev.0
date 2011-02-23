From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 23 Feb 2011 10:16:48 +0000
Subject: [PATCH 0/2] fbdev: sh_mobile_lcdc: YUV framebuffer support
Message-Id: <1298456210-26519-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

These patches add support for 12, 16, and 24 bit YUV framebuffers.

These patches are a reworking of an earlier submitted patch 
"Add NV12 input framebuffer support" to include the two other modes.

Additionally updated are:

* Y and C plane ordering.  When double-buffering both Y planes appear before
  the C planes (Y-Y-C-C), instead of Y-C-Y-C.  
* In YUV 420 mode, panning is only possible in 2 line increments
* Additionally in YUV 420 mode the value of yres must be set to an even number
* The value of .nonstd in struct sh_mobile_lcdc_chan_cfg from the platform data is
  exposed to applications via the .nonstd element of struct fb_var_screeninfo.
  Additionally this value is written to bits 16-31 of LDDFR in the LCDC.
* Chip dependent flags for the bits of LDDFR greater that bit 17 are defined
* Add a userspace include file <linux/sh_mobile_fb.h> as a place to hold defines
  and future ioctl definitions.

Damian Hobson-Garcia (2):
  fbdev: sh_mobile_lcdc: Add YUV input support
  fbdev: sh_mobile_lcdc: Define additional .nonstd flags for sh7372

 arch/arm/mach-shmobile/include/mach/sh7372.h |   11 ++
 drivers/video/sh_mobile_lcdcfb.c             |  142 +++++++++++++++++++++-----
 drivers/video/sh_mobile_lcdcfb.h             |    2 +-
 include/linux/sh_mobile_fb.h                 |   14 +++
 include/video/sh_mobile_lcdc.h               |    1 +
 5 files changed, 141 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/sh_mobile_fb.h

