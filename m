From: Ryan Harkin <ryan.harkin@linaro.org>
Date: Wed, 19 Sep 2012 16:04:23 +0000
Subject: [RFC PATCH 0/3] amba-clcd: add device tree support
Message-Id: <1348070666-9153-1-git-send-email-ryan.harkin@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi all,

The first patch adds device tree support to the amba-clcd video driver.

The next two modify the Versatile Express platform to use device tree for CLCD.

I've tested this code on Versatile Express A5, A9, A15-TC1, A15-A7-TC2 Core
Tiles and on RTSM.

I'd appreciate it if users of this driver and vexpress could please review
these patches and provide feedback.  I'd like to get them into shape so that
I can upstream in a format suitable for all users of the driver.

Regards,
Ryan.

Ryan Harkin (3):
  amba-clcd: Add Device Tree support to amba-clcd driver
  ARM: vexpress: Add device tree support for CLCD driver
  ARM: vexpress: configure CLCD driver device tree support for A9
    CoreTile

 arch/arm/boot/dts/clcd-panels.dtsi      |   52 +++++++
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi |    8 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi     |    8 +-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts  |    6 +
 arch/arm/mach-vexpress/v2m.c            |   58 +++++++
 drivers/video/amba-clcd.c               |  253 +++++++++++++++++++++++++++++++
 6 files changed, 373 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/clcd-panels.dtsi

-- 
1.7.9.5

