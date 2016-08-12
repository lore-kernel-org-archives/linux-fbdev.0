From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Fri, 12 Aug 2016 14:14:21 +0000
Subject: [PATCH RFC 0/5] CEC drivers for iMX6 and TDA9950
Message-Id: <20160812141421.GB1041@n2100.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Hans Verkuil <hansverk@cisco.com>
Cc: linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org

This series adds CEC drivers for the dw-hdmi and TDA9950 devices.

dw-hdmi integrates a CEC engine in the same device as the video
and audio blocks, and so shares the IO space and IRQ with the
main video driver.

The TDA9950 is not only a separate CEC device in its own right,
but can also be found on the TDA998x family of HDMI encoders as
a separate I2C device from the main TDA998x device.

The drivers are placed along-side their HDMI encoder drivers to
keep the code for these drivers nearby.  However, if there's a
better location (eg, a CEC drivers subdirectory) then that would
probably be a better location for these.

Both sets of drivers rely on the hdmi-notifier code, hence why
they're part of the same patch series.

 drivers/gpu/drm/bridge/Kconfig            |   8 +
 drivers/gpu/drm/bridge/Makefile           |   1 +
 drivers/gpu/drm/bridge/dw-hdmi-cec.c      | 344 ++++++++++++++++++++
 drivers/gpu/drm/bridge/dw-hdmi.c          |  73 ++++-
 drivers/gpu/drm/bridge/dw-hdmi.h          |  45 ---
 drivers/gpu/drm/i2c/Kconfig               |   5 +
 drivers/gpu/drm/i2c/Makefile              |   1 +
 drivers/gpu/drm/i2c/tda9950.c             | 514 ++++++++++++++++++++++++++++++
 drivers/video/Kconfig                     |   3 +
 drivers/video/Makefile                    |   1 +
 drivers/video/hdmi-notifier.c             |  61 ++++
 include/linux/hdmi-notifier.h             |  44 +++
 include/linux/platform_data/dw_hdmi-cec.h |  16 +
 include/linux/platform_data/tda9950.h     |  15 +
 14 files changed, 1075 insertions(+), 56 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
