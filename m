From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Sun, 01 Mar 2015 22:27:53 +0000
Subject: [PATCHv2 00/10] fbdev: ssd1307fb: Cleanup and add support for SSD1305
Message-Id: <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

This patch series is the result of making the ssd1307fb driver work with
a Newhaven OLED display using the Solomon SSD1305 controller. To achieve
this the intialization code for the SSD1306 and the SSD1307 is merged
and based on DT configuration to reflect to various possible wirings
of the SSD130X controller (04/10). Based on these changes it is straight
forward to add support for the SSD1305 controller (05/10).

While working on the driver I realized that it was not possible to
correctly mmap the video memory from userspace since the address handed
to the userspace app is a virtual one where it should be a physical one.
Patch 01/10 fixes this. Furthermore the memory reserved by kzalloc is
not page aligned while the address handed to userspace is aligned to the
next page frame. This problem is fixed by using vmalloc in 02/10.

Furthermore module parameters are added to set the bits per pixel
and the delay for the deferred io update. It makes sense to set
the bits per pixel for the video memory to 8 bits since there is
only very poor userspace support for 1 bit framebuffers.

Also sysfs handles are added to make the contrast settings and dim
mode setting available in userspace.

changes since v1 (thanks to Maxime for the feedback):
- dedicated patch for fixing smem_start address
- remove page reserve upon vmalloc
- remove return value check upon display turn-off at module unload
- use a module parameter refreshrate rather than delaydivider
- allocate fbdefio dynamically
- use sysfs_create_groups to create sysfs entries
- remove contrast, vhcom and dclk properties from DT since they are
  not part of hw description. The contrast module parameter was added
  to set contrast at load time. vhcom and dclk stays at it's default
  values for now.
- add new DT properties to in tree users of ssd130X
- rebased to apply on top of linux-nextThis patch series is the result of m=
aking the ssd1307fb driver work with

Thomas Niederpr=C3=BCm (10):
  fbdev: ssd1307fb: fix memory address smem_start.
  fbdev: ssd1307fb: Use vmalloc to allocate video memory.
  Documentation: dts: add missing Solomon Systech vendor prefix.
  fbdev: ssd1307fb: Unify init code and obtain hw specific bits from DT
  fbdev: ssd1307fb: fix in tree users of ssd1306
  fbdev: ssd1307fb: Add support for SSD1305
  fbdev: ssd1307fb: Add module parameter to set refresh rate of the
    display
  fbdev: ssd1307fb: Add module parameter bitsperpixel.
  fbdev: ssd1307fb: Add sysfs handles to expose contrast and dim setting
    to userspace.
  fbdev: ssd1307fb: Turn off display on driver unload.

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 .../devicetree/bindings/video/ssd1307fb.txt        |  24 +-
 arch/arm/boot/dts/imx28-cfa10036.dts               |   4 +
 drivers/video/fbdev/ssd1307fb.c                    | 354 +++++++++++++++--=
----
 4 files changed, 286 insertions(+), 97 deletions(-)

--=20
2.3.0

