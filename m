From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 19 Sep 2010 07:33:47 +0000
Subject: [PATCH 06/12] viafb: enable I2C for CRT
Message-Id: <dd6b494198f83d33c7529b3602ae232d18c1227d.1284879532.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <171e0fb74a34b069c0c12aa90c56d5e5da5489c6.1284879532.git.FlorianSchandinat@gmx.de>
In-Reply-To: <171e0fb74a34b069c0c12aa90c56d5e5da5489c6.1284879532.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>, Jonathan Corbet <corbet@lwn.net>

viafb: enable I2C for CRT

This patch enables the I2C port to talk with the CRT. This allows adding
EDID reading and parsing capability for CRTs.
Just a small preparation, no notable changes in user experience yet.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/via-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index 66f4030..69101ab 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -20,7 +20,7 @@
  * The default port config.
  */
 static struct via_port_cfg adap_configs[] = {
-	[VIA_PORT_26]	= { VIA_PORT_I2C,  VIA_MODE_OFF, VIASR, 0x26 },
+	[VIA_PORT_26]	= { VIA_PORT_I2C,  VIA_MODE_I2C, VIASR, 0x26 },
 	[VIA_PORT_31]	= { VIA_PORT_I2C,  VIA_MODE_I2C, VIASR, 0x31 },
 	[VIA_PORT_25]	= { VIA_PORT_GPIO, VIA_MODE_GPIO, VIASR, 0x25 },
 	[VIA_PORT_2C]	= { VIA_PORT_GPIO, VIA_MODE_I2C, VIASR, 0x2c },
-- 
1.6.3.2

