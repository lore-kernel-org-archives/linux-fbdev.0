From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Date: Wed, 22 Apr 2015 23:14:36 +0000
Subject: [PATCH v3 0/3] USB PHY driver for Broadcom's Cygnus chipset
Message-Id: <1429744479-10410-1-git-send-email-arun.ramamurthy@broadcom.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Gabriel FERNANDEZ <gabriel.fernandez@st.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Arun Ramamurthy <arun.ramamurthy@broadcom.com>

This patchset adds the USB phy driver and documentation 
for Broadom's Cygnus chipset. The phy is configurable from device tree
and is capable of both device and host functions. It also provides
a clock and reset to the host controller

History:
v1:
    - Included Dmitry Torokhov's patch that addresed Kishon Vijay Abraham's 
    comments on multiple phy model
    - Inlucded Dmitry Torokhov's patch to use phy regulator
    - Addressed Arnd Bergmann's comments on usage of this phy driver by
    ehci-platform and ohci-platform driver in a separate patchset. 
v2:
    - Addressed Kishon's comments on documentation and function names
    - Dmitry Addressed Kishon's comments on per port phy regulators
v3:
    - Addressed Kishon's comments on error code in phy driver and multi level
    if else statements
    - Corrected documentation to use defines for constants
    - Corrected commit log for phy regulator patch

Arun Ramamurthy (3):
  phy: phy-core: allow specifying supply at port level
  Phy: DT binding documentation for Broadcom Cygnus USB PHY driver
  phy: cygnus-usbphy: Add Broadcom Cygnus USB phy driver

 .../bindings/phy/brcm,cygnus-usb-phy.txt           |  69 +++
 drivers/phy/Kconfig                                |  12 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-bcm-cygnus-usb.c                   | 504 +++++++++++++++++++++
 drivers/phy/phy-core.c                             |  23 +-
 include/dt-bindings/phy/phy.h                      |   2 +
 6 files changed, 598 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
 create mode 100644 drivers/phy/phy-bcm-cygnus-usb.c

-- 
2.3.4

