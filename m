From: niederp@physik.uni-kl.de
Date: Fri, 06 Feb 2015 22:28:06 +0000
Subject: [PATCH 0/8] Cleanup and add support for SSD1305
Message-Id: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

From: Thomas Niederprüm <niederp@physik.uni-kl.de>

This patch series is the result of making the ssd1307fb driver work with
a Newhaven OLED display using the Solomon SSD1305 controller. To achieve
this the intialization code for the SSD1306 and the SSD1307 is merged
and based on device tree configuration. This gets rid of the magic bit
values that were used so far.
Based on these changes it was straight forward to add support for the
SSD1305 controller.

While working with the driver I realized that it was not possible to
correctly mmap the video memory from userspace since the memory
reserved by kzalloc is not page aligned. This problem is fixed by
using vmalloc as it is done inthe vfb driver.

Furthermore module parameters are added to set the bits per pixel
and the delay for the deferred io update. It makes sense to set
the bits per pixel for the video memory to 8 bits since there is
only very poor userspace support for 1 bit framebuffers.

Also sysfs handles are added to make the contrast settings and dim
mode setting available in userspace.

Thomas Niederprüm (8):
  Documentation: dts: add missing Solomon Systech vendor prefix.
  fbdev: ssd1307fb: Unify init code and make controller configurable
    from device tree
  fbdev: ssd1307fb: Add support for SSD1305
  fbdev: ssd1307fb: Use vmalloc to allocate video memory.
  fbdev: ssd1307fb: Add module parameter bitsperpixel.
  fbdev: ssd1307fb: Add module parameter to set update delay of the 
    deffered io.
  fbdev: ssd1307fb: Add sysfs handles to expose contrast and dim setting
    to userspace.
  fbdev: ssd1307fb: Turn off display on driver unload.

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 .../devicetree/bindings/video/ssd1307fb.txt        |  13 +-
 drivers/video/fbdev/ssd1307fb.c                    | 426 ++++++++++++++++-----
 3 files changed, 346 insertions(+), 94 deletions(-)

-- 
2.1.1

