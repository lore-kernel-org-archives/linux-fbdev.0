From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 23 Oct 2015 03:50:37 +0000
Subject: [PATCH v4 0/4] simplefb: Add regulator handling support
Message-Id: <1445572241-13259-1-git-send-email-wens@csie.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi everyone,

This is v4 of the simplefb regulator support series. This series adds
regulator claiming and enabling support for simplefb.

Changes since v4:
  - Fixed inverted logic when testing the property name.
  - Fixed regulator supply name string copy length off by 1.
  - Added real world user, MSI Primo 81 dts patches.

Changes since v3:
  - Dropped extra "if" which is always true, leftover from v1.
  - Updated commit message of patch 1

Sometimes the simplefb display output path consits of external conversion
chips and/or LCD drivers and backlights. These devices normally have
GPIOs to turn them on and/or bring them out of reset, and regulators
supplying power to them.

While the kernel does not touch unclaimed GPIOs, the regulator core
happily disables unused regulators. Thus we need simplefb to claim
and enable the regulators used throughout the display pipeline.

The binding supports any named regulator supplies under its device
node. The driver will look through its properties, and claim any
regulators by matching "*-supply", as Mark suggested.

I've not done a generic helper in the regulator core yet, instead doing
the regulator property handling in the simplefb code for now.


Patch 1 adds the regulator properties to the DT binding.

Patch 2 adds code to the simplefb driver to claim and enable regulators.
Hans, I dropped your Reviewed-by tag from this patch.

Patch 3 adds labels to the simplefb device nodes in sun6i-a31.dtsi
so we can reference them in the board dts files, like in the next
patch.

Patch 4 adds a dts file for MSI's Primo 81 tablet.


Regards
ChenYu

Chen-Yu Tsai (3):
  dt-bindings: simplefb: Support regulator supply properties
  simplefb: Claim and enable regulators
  ARM: dts: sun6i: Add simplefb node labels to reference at board level

Karsten Merker (1):
  ARM: dts: sun6i: Add dts file for MSI Primo81 tablet

 .../bindings/video/simple-framebuffer.txt          |  13 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   4 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           | 255 +++++++++++++++++++++
 drivers/video/fbdev/simplefb.c                     | 120 +++++++++-
 5 files changed, 386 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-primo81.dts

-- 
2.6.1

