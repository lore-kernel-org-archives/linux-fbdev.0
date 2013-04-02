From: Tony Prisk <linux@prisktech.co.nz>
Date: Tue, 02 Apr 2013 04:49:54 +0000
Subject: [PATCHv2 0/6] fb: vt8500: patches for 3.10
Message-Id: <1364878200-26343-1-git-send-email-linux@prisktech.co.nz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

V2 Changes:
Split the SoC and board portions of the binding into their respective files.
Removed the forced non-interlaced code from wm8505fb.c and vt8500lcdfb.c

Julia Lawall (1):
  drivers/video/wm8505fb.c: use devm_ functions

Tony Prisk (5):
  video: vt8500: Make wmt_ge_rops optional
  video: vt8500: Remove unused platform_data/video-vt8500lcdfb.h
  video: vt8500: Correct descriptions in video/Kconfig
  video: vt8500: Adjust contrast in wm8505 framebuffer driver.
  video: fb: vt8500: Convert framebuffer drivers to standardized
    binding

 .../devicetree/bindings/video/via,vt8500-fb.txt    |   48 ++----
 .../devicetree/bindings/video/wm,wm8505-fb.txt     |   32 ++--
 arch/arm/boot/dts/vt8500-bv07.dts                  |   34 ++---
 arch/arm/boot/dts/vt8500.dtsi                      |    4 +-
 arch/arm/boot/dts/wm8505-ref.dts                   |   34 ++---
 arch/arm/boot/dts/wm8505.dtsi                      |    4 +-
 arch/arm/boot/dts/wm8650-mid.dts                   |   36 +++--
 arch/arm/boot/dts/wm8650.dtsi                      |    4 +-
 arch/arm/boot/dts/wm8850-w70v2.dts                 |   40 +++--
 arch/arm/boot/dts/wm8850.dtsi                      |    4 +-
 drivers/video/Kconfig                              |   37 +++--
 drivers/video/vt8500lcdfb.c                        |   70 ++++-----
 drivers/video/wm8505fb.c                           |  159 ++++++++------------
 include/linux/platform_data/video-vt8500lcdfb.h    |   31 ----
 14 files changed, 218 insertions(+), 319 deletions(-)
 delete mode 100644 include/linux/platform_data/video-vt8500lcdfb.h

-- 
1.7.9.5

