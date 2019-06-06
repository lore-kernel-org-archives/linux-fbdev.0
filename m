From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 06 Jun 2019 09:47:07 +0000
Subject: [PATCH 1/8] drivers: net: dsa: realtek: fix warning same module names
Message-Id: <20190606094707.23664-1-anders.roxell@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, davem@davemloft.net
Cc: marex@denx.de, stefan@agner.ch, airlied@linux.ie, daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de, b.zolnierkie@samsung.com, a.hajda@samsung.com, mchehab@kernel.org, p.zabel@pengutronix.de, hkallweit1@gmail.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>

When building with CONFIG_NET_DSA_REALTEK_SMI and CONFIG_REALTEK_PHY
enabled as loadable modules, we see the following warning:

warning: same module names found:
  drivers/net/phy/realtek.ko
  drivers/net/dsa/realtek.ko

Rework so the names matches the config fragment.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/net/dsa/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index fefb6aaa82ba..dbe8352cf8a4 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -9,8 +9,8 @@ obj-$(CONFIG_NET_DSA_LANTIQ_GSWIP) += lantiq_gswip.o
 obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
 obj-$(CONFIG_NET_DSA_MV88E6060) += mv88e6060.o
 obj-$(CONFIG_NET_DSA_QCA8K)	+= qca8k.o
-obj-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek.o
-realtek-objs			:= realtek-smi.o rtl8366.o rtl8366rb.o
+obj-$(CONFIG_NET_DSA_REALTEK_SMI) += dsa-realtek-smi.o
+dsa-realtek-smi-objs			:= realtek-smi.o rtl8366.o rtl8366rb.o
 obj-$(CONFIG_NET_DSA_SMSC_LAN9303) += lan9303-core.o
 obj-$(CONFIG_NET_DSA_SMSC_LAN9303_I2C) += lan9303_i2c.o
 obj-$(CONFIG_NET_DSA_SMSC_LAN9303_MDIO) += lan9303_mdio.o
-- 
2.20.1
