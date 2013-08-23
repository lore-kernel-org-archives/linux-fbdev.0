From: Darren Etheridge <detheridge@ti.com>
Date: Fri, 23 Aug 2013 21:52:49 +0000
Subject: [PATCH 0/4] video: da8xx-fb: numerous bugfixes
Message-Id: <1377294773-25678-1-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

In developing a driver for an HDMI encoder to be attached to the LCD controller
on TI AM335x SoC I ran across a number of bugs in the da8xx-fb.c fbdev driver.
Two of them appear to have been in the driver for a while (02 and 04), one of
them is a deficiency where some LCD controller version 2 features have not been
utilized (03) and the last one was introduced in the last patch series that I
submitted for this driver (01).

These patches do not change the behavior of the AM335x EVM's platforms LCD
panel even though the current values set by the driver are wrong.  I guess LCD
panels (at least the one used on AM335x EVM) must be fairly immune to bad
timings coming from the LCD controller.  However the HDMI encoder simply will
not work without these fixes, and quite possibly other LCD panels could behave
the same way.

These patches apply on top of the patch series called:
"video/da8xx-fb fbdev driver enhance to support TI am335x SoC"
that was submitted by me.

Darren Etheridge (4):
  video: da8xx-fb fixing incorrect porch mappings
  video: da8xx-fb: fixing timing off by one errors
  video: da8xx-fb: support lcdc v2 timing register expansion
  video: da8xx-fb: fix the polarities of the hsync/vsync pulse

 drivers/video/da8xx-fb.c |   35 +++++++++++++++++++++++++----------
 1 files changed, 25 insertions(+), 10 deletions(-)

