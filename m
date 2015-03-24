From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Tue, 24 Mar 2015 21:23:47 +0000
Subject: [PATCHv5 00/11] Cleanup and add support for SSD1305
Message-Id: <1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

Hi,

this patch series is the result of making the ssd1307fb driver work with
a Newhaven OLED display using the Solomon SSD1305 controller. To achieve
this the intialization code for the SSD1306 and the SSD1307 is merged
and based on DT configuration to reflect the various possible wirings
of the SSD130X controller (04/11). Based on these changes it is straight
forward to add support for the SSD1305 controller (06/11).

While working on the driver I realized that it was not possible to
correctly mmap the video memory from userspace since the address handed
to the userspace app is a logical one where it should be a physical one.
Patch 01/10 fixes this. Furthermore the memory reserved by kzalloc is
not page aligned while the address handed to userspace is aligned to the
next page frame. This problem is fixed by using __get_free_pages() in 02/11.

Furthermore a module parameter is added to set the delay for the
deferred io update (07/11). Also the backlight class is implemented to make
the contrast setting available in userspace (10/11).

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
- rebased to apply on top of linux-next

changes since v2 (thanks to Maxime again):
- free memory allocated by vmalloc on driver unload
- set default values in the init code to the ones of the existing ssd1307
  init code
- added two ACKs (Maxime Ripard)

changes since v3:
- use backlight class rather than dedicated sysfs files to set the=20
  contrast (Thanks to Tomi Valkeinen)
- remove [PATCHv3 08/10] fbdev: ssd1307fb: Add module parameter bitsperpixel
- add new patch to blank the display (unreviewed)
- allocate video memory through __get_free_pages() rather than vmalloc
  (Thanks to Geert Uytterhoeven)
- minor rewordings of the commit messages

changes since v4 (thanks to Maxime):
- added two ACKs (Maxime Ripard)
- fixed typo: s/REFRASHRATE/REFRESHRATE
- updated the documentation to make clear the unit of com-offset
- move addition of the module parameter contrast to a separate patch (09/11)
- fix indentation errors
- get rid of device_id in the device_info struct


Thomas Niederpr=C3=BCm (11):
  fbdev: ssd1307fb: fix memory address smem_start.
  fbdev: ssd1307fb: Allocate page aligned video memory.
  of: Add Solomon Systech vendor prefix.
  fbdev: ssd1307fb: Unify init code and obtain hw specific bits from DT
  ARM: mxs: fix in tree users of ssd1306
  fbdev: ssd1307fb: Add support for SSD1305
  fbdev: ssd1307fb: Add a module parameter to set the refresh rate
  fbdev: ssd1307fb: Turn off display on driver unload.
  fbdev: ssd1307fb: Add module parameter to set the initial contrast
  fbdev: ssd1307fb: add backlight controls for setting the contrast
  fbdev: ssd1307fb: Add blank mode

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 .../devicetree/bindings/video/ssd1307fb.txt        |  23 +-
 arch/arm/boot/dts/imx28-cfa10036.dts               |   3 +
 drivers/video/fbdev/Kconfig                        |   1 +
 drivers/video/fbdev/ssd1307fb.c                    | 310 +++++++++++++++--=
----
 5 files changed, 250 insertions(+), 88 deletions(-)

--=20
2.3.0

