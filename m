From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 27 Dec 2011 14:15:51 +0000
Subject: [PATCH 0/6] video: s3c-fb: Use runtime suspend while blanked
Message-Id: <20111227141550.GA3331@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

This patch series (the first two of which I posted the other day)
improves the runtime power management in the s3c-fb driver by moving it
to keeping the device runtime suspended when the screen is powered down
by userspace.  This saves a trivial amount of power in the framebuffer
controller and allows the SoC core code to enter system wide idle
states which offer much more substantial gains.

Currently it's only lightly tested but it certainly seems to the right
thing for me.

Mark Brown (6):
      video: s3c-fb: Make runtime PM functional again
      video: s3c-fb: Use s3c_fb_enable() to enable the framebuffer
      video: s3c-fb: Disable runtime PM in error paths from probe
      video: s3c-fb: Take a runtime PM reference when unblanked
      video: s3c-fb: Hold runtime PM references when touching registers
      video: s3c-fb: Don't keep device runtime active when open

 drivers/video/s3c-fb.c |  127 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 92 insertions(+), 35 deletions(-)

