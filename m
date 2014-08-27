From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Aug 2014 16:40:57 +0000
Subject: [PATCH 00/16] R-Car Display Unit DT bindings
Message-Id: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-sh@vger.kernel.org

Hello,

This patch series documents and implements DT bindings support for the R-Car
Display Unit (DU).

Unlike the previous attempt that tried to create a new model for composite
display devices and failed to get any real traction from DRM developers, the
approach taken here focuses on DT bindings without requiring core changes
outside of the DU driver.

Aside of the usual boring core properties (compatible, reg, interrupts and
clocks), the proposed bindings use the OF graph bindings to model connections
between the DU output video ports and the on-board and off-board components.
As such they do not depend on any particular implementation or implementation
philosophy.

The series starts by documenting DT bindings for the devices present on the
Marzen, Lager and Koelsch boards not already supported in the mainline kernel
(01/16 to 05/16) and for the DU (06/16). It then reworks the rcar_du platform
data to ease implementation of the DT bindings (07/16). The next step is to
implement support for the DU DT bindings in the R-Car DU DRM driver (08/16).
Finally the remaining patches add the DU DT nodes for all supported SoCs
(09/16 to 11/16), remove DU platform data from the DT-based board files (12/16
and 13/16) and describe the on-board devices connected to the DU outputs for
the Marzen, Lager and Koelsch boards (14/16 to 16/16).

Cc: devicetree@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org

Laurent Pinchart (16):
  devicetree: Add vendor prefix "mitsubishi" to vendor-prefixes.txt
  devicetree: Add vendor prefix "thine" to vendor-prefixes.txt
  video: Add DT binding documentation for VGA connector
  video: Add ADV7123 DT bindings documentation
  video: Add THC63LVDM83D DT bindings documentation
  video: Add DT bindings for the R-Car Display Unit
  drm/rcar-du: Use struct videomode in platform data
  drm/rcar-du: Add OF support
  ARM: shmobile: r8a7779: Add DU node to device tree
  ARM: shmobile: r8a7790: Add DU node to device tree
  ARM: shmobile: r8a7791: Add DU node to device tree
  ARM: shmobile: lager-reference: Remove DU platform device
  ARM: shmobile: koelsch-reference: Remove DU platform device
  ARM: shmobile: marzen: Enable DU device in DT
  ARM: shmobile: lager: Enable DU device in DT
  ARM: shmobile: koelsch: Enable DU device in DT

 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 .../devicetree/bindings/video/adi,adv7123.txt      |  50 +++++
 .../devicetree/bindings/video/renesas,du.txt       |  84 ++++++++
 .../devicetree/bindings/video/thine,thc63lvdm83d   |  50 +++++
 .../devicetree/bindings/video/vga-connector.txt    |  28 +++
 arch/arm/boot/dts/r8a7779-marzen.dts               | 106 ++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                     |  24 +++
 arch/arm/boot/dts/r8a7790-lager.dts                |  78 ++++++-
 arch/arm/boot/dts/r8a7790.dtsi                     |  39 ++++
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  43 +++-
 arch/arm/boot/dts/r8a7791.dtsi                     |  30 +++
 arch/arm/mach-shmobile/board-koelsch-reference.c   |  74 -------
 arch/arm/mach-shmobile/board-koelsch.c             |  19 +-
 arch/arm/mach-shmobile/board-lager-reference.c     |  81 --------
 arch/arm/mach-shmobile/board-lager.c               |  19 +-
 arch/arm/mach-shmobile/board-marzen.c              |  19 +-
 drivers/gpu/drm/rcar-du/Kconfig                    |   1 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              | 170 ++++++++-------
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |   2 +
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |  11 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |   3 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              | 231 +++++++++++++++++++--
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c          |  43 ++--
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h          |   3 +-
 include/linux/platform_data/rcar-du.h              |   4 +-
 25 files changed, 904 insertions(+), 310 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/adi,adv7123.txt
 create mode 100644 Documentation/devicetree/bindings/video/renesas,du.txt
 create mode 100644 Documentation/devicetree/bindings/video/thine,thc63lvdm83d
 create mode 100644 Documentation/devicetree/bindings/video/vga-connector.txt

-- 
Regards,

Laurent Pinchart

