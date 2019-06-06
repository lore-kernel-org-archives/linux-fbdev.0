From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 06 Jun 2019 09:46:57 +0000
Subject: [PATCH 0/8] fix warnings for same module names
Message-Id: <20190606094657.23612-1-anders.roxell@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, marex@denx.de, stefan@agner.ch, airlied@linux.ie, daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de, b.zolnierkie@samsung.com, a.hajda@samsung.com, mchehab@kernel.org, p.zabel@pengutronix.de, hkallweit1@gmail.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>

Hi,

This patch set addresses warnings that module names are named the
same, this may lead to a problem that wrong module gets loaded or if one
of the two same-name modules exports a symbol, this can confuse the
dependency resolution. and the build may fail.


Patch "drivers: net: dsa: realtek: fix warning same module names" and
"drivers: net: phy: realtek: fix warning same module names" resolves the
name clatch realtek.ko.

warning: same module names found:
  drivers/net/phy/realtek.ko
  drivers/net/dsa/realtek.ko


Patch  "drivers: (video|gpu): fix warning same module names" resolves
the name clatch mxsfb.ko.

warning: same module names found:
  drivers/video/fbdev/mxsfb.ko
  drivers/gpu/drm/mxsfb/mxsfb.ko

Patch "drivers: media: i2c: fix warning same module names" resolves the
name clatch adv7511.ko however, it seams to refer to the same device
name in i2c_device_id, does anyone have any guidance how that should be
solved?

warning: same module names found:
  drivers/gpu/drm/bridge/adv7511/adv7511.ko
  drivers/media/i2c/adv7511.ko


Patch "drivers: media: coda: fix warning same module names" resolves the
name clatch coda.ko.

warning: same module names found:
  fs/coda/coda.ko
  drivers/media/platform/coda/coda.ko


Patch "drivers: net: phy: fix warning same module names" resolves the
name clatch asix.ko.

warning: same module names found:
  drivers/net/phy/asix.ko
  drivers/net/usb/asix.ko

Patch "drivers: mfd: 88pm800: fix warning same module names" and
"drivers: regulator: 88pm800: fix warning same module names" resolves
the name clatch 88pm800.ko.

warning: same module names found:
  drivers/regulator/88pm800.ko
  drivers/mfd/88pm800.ko


Cheers,
Anders

Anders Roxell (8):
  drivers: net: dsa: realtek: fix warning same module names
  drivers: net: phy: realtek: fix warning same module names
  drivers: (video|gpu): fix warning same module names
  drivers: media: i2c: fix warning same module names
  drivers: media: coda: fix warning same module names
  drivers: net: phy: fix warning same module names
  drivers: mfd: 88pm800: fix warning same module names
  drivers: regulator: 88pm800: fix warning same module names

 drivers/gpu/drm/bridge/adv7511/Makefile | 10 +++++-----
 drivers/gpu/drm/mxsfb/Makefile          |  4 ++--
 drivers/media/i2c/Makefile              |  3 ++-
 drivers/media/platform/coda/Makefile    |  4 ++--
 drivers/mfd/Makefile                    |  7 +++++--
 drivers/net/dsa/Makefile                |  4 ++--
 drivers/net/phy/Makefile                |  6 ++++--
 drivers/regulator/Makefile              |  3 ++-
 drivers/video/fbdev/Makefile            |  3 ++-
 9 files changed, 26 insertions(+), 18 deletions(-)

-- 
2.20.1
